package controller.customer;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import dao.User.MealHistoryDAO;
import dao.User.SavedMealDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.entity.MealHistory;
import model.entity.SavedMeal;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "NutritionDataServlet", urlPatterns = {"/nutrition-data"})
@jakarta.servlet.annotation.MultipartConfig
public class NutritionDataServlet extends HttpServlet {

    private final MealHistoryDAO mealHistoryDAO = new MealHistoryDAO();
    private final SavedMealDAO savedMealDAO = new SavedMealDAO();
    private final Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        Integer accountId = (Integer) request.getSession().getAttribute("accountId");
        if (accountId == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        String type = request.getParameter("type");
        try (PrintWriter out = response.getWriter()) {
            Map<String, Object> result = new HashMap<>();
            if ("history".equals(type)) {
                List<MealHistory> list = mealHistoryDAO.getTodayHistory(accountId);
                result.put("status", "success");
                result.put("data", list);
            } else if ("saved".equals(type)) {
                List<SavedMeal> list = savedMealDAO.getAllByAccountId(accountId);
                result.put("status", "success");
                result.put("data", list);
            } else {
                result.put("status", "error");
                result.put("message", "Invalid type");
            }
            out.print(gson.toJson(result));
            out.flush();
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        Integer accountId = (Integer) request.getSession().getAttribute("accountId");
        if (accountId == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        String action = request.getParameter("action");
        try (PrintWriter out = response.getWriter()) {
            Map<String, Object> result = new HashMap<>();
            
            if ("addHistory".equals(action)) {
                MealHistory m = new MealHistory();
                m.setAccountId(accountId);
                m.setMealName(request.getParameter("mealName"));
                m.setCalories(Float.parseFloat(request.getParameter("calories")));
                m.setMealTime(request.getParameter("mealTime"));
                
                String suggestIdxStr = request.getParameter("suggestIdx");
                if (suggestIdxStr != null && !suggestIdxStr.isEmpty() && !"null".equals(suggestIdxStr)) {
                    m.setSuggestIdx(Integer.parseInt(suggestIdxStr));
                }
                
                m = mealHistoryDAO.insert(m);
                result.put("status", "success");
                result.put("data", m);
                
            } else if ("addSaved".equals(action)) {
                SavedMeal s = new SavedMeal();
                s.setAccountId(accountId);
                s.setMealName(request.getParameter("mealName"));
                s.setCalories(Float.parseFloat(request.getParameter("calories")));
                s.setRecipe(request.getParameter("recipe"));
                s.setImgSrc(request.getParameter("imgSrc"));
                
                String suggestIdxStr = request.getParameter("suggestIdx");
                if (suggestIdxStr != null && !suggestIdxStr.isEmpty() && !"null".equals(suggestIdxStr)) {
                    s.setSuggestIdx(Integer.parseInt(suggestIdxStr));
                }
                
                s = savedMealDAO.insert(s);
                result.put("status", "success");
                result.put("data", s);
                
            } else if ("deleteHistory".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                boolean success = mealHistoryDAO.delete(id, accountId);
                result.put("status", success ? "success" : "error");
                
            } else if ("deleteSaved".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                boolean success = savedMealDAO.delete(id, accountId);
                result.put("status", success ? "success" : "error");
                
            } else {
                result.put("status", "error");
                result.put("message", "Invalid action");
            }
            
            out.print(gson.toJson(result));
            out.flush();
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}
