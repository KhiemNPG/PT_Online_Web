package dao.Admin;

import model.entity.User;
import utils.DBContext;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class UserDAO extends DBContext {

    public List<User> allCustomerList(){
        List<User> userList = new ArrayList<>();

        String sql = "SELECT * FROM [User] u " +
                "LEFT JOIN Account a ON u.accountId = a.accountId " +
                "WHERE a.role LIKE 'CUSTOMER%'";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    // 1. Lấy dữ liệu dạng Object (dùng rs.getObject) để giữ nguyên giá trị NULL từ DB
                    Integer ageVal = (rs.getObject("age") != null) ? rs.getInt("age") : null;
                    Double heightVal = (rs.getObject("height") != null) ? rs.getDouble("height") : null;
                    Double weightVal = (rs.getObject("weight") != null) ? rs.getDouble("weight") : null;

                    // 2. Truyền các biến đã check NULL này vào Constructor
                    User user = new User(
                            rs.getInt("userId"),
                            rs.getInt("accountId"),
                            rs.getString("name"),
                            ageVal,      // Trả về đúng Integer (có thể null)
                            rs.getString("gender"),
                            heightVal,   // Trả về đúng Double (có thể null)
                            weightVal,   // Trả về đúng Double (có thể null)
                            rs.getString("fitnessLevel"),
                            rs.getInt("remainingTokens")
                    );
                    userList.add(user);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return userList;
    }

    public List<Integer> allAccountIdPro() {
        List<Integer> accountIdList = new ArrayList<>();

        String sql = "SELECT DISTINCT accountId FROM UserSubscription";

        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                accountIdList.add(rs.getInt("accountId"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return accountIdList;
    }

    public int countTotalProUsers() {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM UserSubscription WHERE planType = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, "PRO"); // Chỉ đếm những người dùng có plan là 'PRO'

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    count = rs.getInt(1); // Lấy kết quả từ cột đầu tiên
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }
}
