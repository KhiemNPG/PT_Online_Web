package dao.User;

import model.entity.UserSubscription;
import utils.DBContext;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserSubscriptionDAO {

    public UserSubscription getByAccountId(int accountId) throws Exception {
        String sql = "SELECT TOP 1 * FROM UserSubscription WHERE accountId = ? ORDER BY id DESC";
        
        // Sử dụng try-with-resources để tự động đóng Connection, PreparedStatement và ResultSet
        try (Connection con = DBContext.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
             
            ps.setInt(1, accountId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    UserSubscription s = new UserSubscription();
                    s.setId(rs.getInt("id"));
                    s.setAccountId(rs.getInt("accountId"));
                    s.setPlanType(rs.getString("planType"));
                    s.setStartDate(rs.getTimestamp("startDate"));
                    s.setEndDate(rs.getTimestamp("endDate"));
                    return s;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw e; // Ném lại exception để tầng service xử lý
        }
        return null;
    }
}
