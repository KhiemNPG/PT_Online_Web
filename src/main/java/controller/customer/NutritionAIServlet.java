package controller.customer;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import utils.GeminiAIService;
import dao.UserDAO;
import dao.TrainingRequirementDAO;
import model.entity.User;
import model.entity.TrainingRequirement;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.Base64;

@WebServlet(name = "NutritionAIServlet", urlPatterns = {"/nutrition-ai"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2,  // 2MB
        maxFileSize = 1024 * 1024 * 10,       // 10MB
        maxRequestSize = 1024 * 1024 * 50     // 50MB
)
public class NutritionAIServlet extends HttpServlet {

    private final GeminiAIService geminiService = new GeminiAIService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        Integer accountId = (Integer) request.getSession().getAttribute("accountId");
        int targetCalories = 2400; // Default

        if (accountId != null) {
            try {
                UserDAO userDAO = new UserDAO();
                User user = userDAO.findByAccountId(accountId);
                if (user != null && user.getWeight() != null && user.getHeight() != null && user.getAge() != null) {
                    double weight = user.getWeight();
                    double height = user.getHeight();
                    int age = user.getAge();
                    String gender = user.getGender();

                    double bmr;
                    if ("Nam".equalsIgnoreCase(gender) || "Male".equalsIgnoreCase(gender)) {
                        bmr = (10 * weight) + (6.25 * height) - (5 * age) + 5;
                    } else {
                        bmr = (10 * weight) + (6.25 * height) - (5 * age) - 161;
                    }

                    double multiplier = 1.375;
                    String fitness = user.getFitnessLevel();
                    if (fitness != null) {
                        if (fitness.toLowerCase().contains("vận động nhiều") || fitness.toLowerCase().contains("heavy")) multiplier = 1.725;
                        else if (fitness.toLowerCase().contains("vừa") || fitness.toLowerCase().contains("moderate")) multiplier = 1.55;
                        else if (fitness.toLowerCase().contains("ít") || fitness.toLowerCase().contains("sedentary")) multiplier = 1.2;
                    }
                    
                    targetCalories = (int) Math.round(bmr * multiplier);

                    TrainingRequirementDAO trDAO = new TrainingRequirementDAO();
                    TrainingRequirement tr = trDAO.getTrainingRequirementByUserId(user.getUserId());
                    if (tr != null && tr.getGoal() != null) {
                        String goal = tr.getGoal().toLowerCase();
                        if (goal.contains("giảm cân") || goal.contains("giảm mỡ") || goal.contains("lose")) {
                            targetCalories -= 500;
                        } else if (goal.contains("tăng cân") || goal.contains("tăng cơ") || goal.contains("gain")) {
                            targetCalories += 500;
                        }
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            
            boolean isPro = false;
            try {
                dao.UserSubscriptionDAO subDAO = new dao.UserSubscriptionDAO();
                model.entity.UserSubscription sub = subDAO.getByAccountId(accountId);
                if (sub != null && "PRO".equalsIgnoreCase(sub.getPlanType())) {
                    isPro = true;
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            request.setAttribute("isPro", isPro);
        }

        request.setAttribute("targetCalories", targetCalories);

        String jspPath = "/WEB-INF/View/customer/nutrition/index.jsp";
        request.getRequestDispatcher(jspPath).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        String userContext = buildUserContext(request);

        if ("suggest".equals(action)) {
            String remainingCal = request.getParameter("remainingCalories");
            if (remainingCal != null && !remainingCal.trim().isEmpty()) {
                if (userContext == null) userContext = "";
                userContext += " User has a remaining limit of " + remainingCal + " kcal for today.";
            }
            
            String jsonResult = geminiService.suggestMeal(userContext);
            try (PrintWriter out = response.getWriter()) {
                out.print(jsonResult);
                out.flush();
            }
            return;
        }

        String textPrompt = request.getParameter("textPrompt");
        if (textPrompt == null || textPrompt.trim().isEmpty()) {
            textPrompt = "Phân tích hình ảnh món ăn này";
        }

        String base64Image = null;
        try {
            Part filePart = request.getPart("image");
            if (filePart != null && filePart.getSize() > 0) {
                InputStream fileContent = filePart.getInputStream();
                ByteArrayOutputStream buffer = new ByteArrayOutputStream();
                int nRead;
                byte[] data = new byte[1024];
                while ((nRead = fileContent.read(data, 0, data.length)) != -1) {
                    buffer.write(data, 0, nRead);
                }
                buffer.flush();
                byte[] fileBytes = buffer.toByteArray();
                
                String mimeType = filePart.getContentType();
                String base64Data = Base64.getEncoder().encodeToString(fileBytes);
                base64Image = "data:" + mimeType + ";base64," + base64Data;
            }
        } catch (Exception e) {
            System.out.println("No image uploaded or error parsing part.");
        }

        String jsonResult = geminiService.analyzeNutrition(textPrompt, base64Image, userContext);

        try (PrintWriter out = response.getWriter()) {
            out.print(jsonResult);
            out.flush();
        }
    }

    private String buildUserContext(HttpServletRequest request) {
        Integer accountId = (Integer) request.getSession().getAttribute("accountId");
        if (accountId == null) return null;

        try {
            UserDAO userDAO = new UserDAO();
            User user = userDAO.findByAccountId(accountId);
            if (user == null) return null;

            TrainingRequirementDAO trDAO = new TrainingRequirementDAO();
            TrainingRequirement tr = trDAO.getTrainingRequirementByUserId(user.getUserId());

            StringBuilder ctx = new StringBuilder();
            ctx.append("User's name is ").append(user.getName() != null ? user.getName() : "bạn").append(" (Address them by this name in Vietnamese). ")
               .append("Gender: ").append(user.getGender() != null ? user.getGender() : "unknown")
               .append(", age: ").append(user.getAge() != null ? user.getAge() : "unknown")
               .append(", weight: ").append(user.getWeight() != null ? user.getWeight() : "unknown").append("kg")
               .append(", height: ").append(user.getHeight() != null ? user.getHeight() : "unknown").append("cm. ");
            
            if (user.getFitnessLevel() != null) {
                ctx.append("Fitness level: ").append(user.getFitnessLevel()).append(". ");
            }

            if (tr != null && tr.getGoal() != null) {
                ctx.append("Primary Fitness Goal: ").append(tr.getGoal()).append(".");
            }

            return ctx.toString();

        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
