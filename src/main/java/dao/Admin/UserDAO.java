package dao.Admin;

import model.entity.User;
import utils.DBContext;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    public List<User> allCustomerList() {
        List<User> userList = new ArrayList<>();
        String sql = "SELECT u.* FROM [User] u " +
                     "LEFT JOIN Account a ON u.accountId = a.accountId " +
                     "WHERE a.role LIKE 'CUSTOMER%'";

        try (Connection con = DBContext.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                // Kiểm tra null bằng wasNull() để đảm bảo chính xác kiểu dữ liệu
                int age = rs.getInt("age");
                Integer ageVal = rs.wasNull() ? null : age;

                double height = rs.getDouble("height");
                Double heightVal = rs.wasNull() ? null : height;

                double weight = rs.getDouble("weight");
                Double weightVal = rs.wasNull() ? null : weight;

                User user = new User(
                        rs.getInt("userId"),
                        rs.getInt("accountId"),
                        rs.getString("name"),
                        ageVal,
                        rs.getString("gender"),
                        heightVal,
                        weightVal,
                        rs.getString("fitnessLevel"),
                        rs.getInt("remainingTokens")
                );
                userList.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return userList;
    }

    public List<Integer> allAccountIdPro() {
        List<Integer> accountIdList = new ArrayList<>();
        String sql = "SELECT DISTINCT accountId FROM UserSubscription";

        try (Connection con = DBContext.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                accountIdList.add(rs.getInt("accountId"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return accountIdList;
    }

    public int countTotalProUsers() {
        String sql = "SELECT COUNT(*) FROM UserSubscription WHERE planType = ?";
        try (Connection con = DBContext.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, "PRO");
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
}
