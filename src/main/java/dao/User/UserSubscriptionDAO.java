package dao.User;

import model.entity.UserSubscription;
import utils.DBContext;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserSubscriptionDAO extends DBContext {

    public UserSubscription getByAccountId(int accountId) throws Exception {
        String sql = "SELECT TOP 1 * FROM UserSubscription WHERE accountId = ? ORDER BY id DESC";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
             
            ps.setInt(1, accountId);
            ResultSet rs = ps.executeQuery();
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
        return null;
    }
}
