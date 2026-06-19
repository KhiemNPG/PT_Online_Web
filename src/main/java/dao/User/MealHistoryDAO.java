package dao.User;

import model.entity.MealHistory;
import utils.DBContext;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MealHistoryDAO {

    public List<MealHistory> getTodayHistory(int accountId) throws Exception {
        List<MealHistory> list = new ArrayList<>();
        String sql = "SELECT * FROM MealHistory WHERE accountId = ? AND CAST(createdAt AS DATE) = CAST(GETDATE() AS DATE)";
        
        Connection con = DBContext.getConnection();
        if (con == null) return list;
        
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, accountId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    MealHistory m = new MealHistory();
                    m.setId(rs.getInt("id"));
                    m.setAccountId(rs.getInt("accountId"));
                    m.setMealName(rs.getString("mealName"));
                    m.setCalories(rs.getFloat("calories"));
                    m.setMealTime(rs.getString("mealTime"));
                    m.setSuggestIdx(rs.getObject("suggestIdx") != null ? rs.getInt("suggestIdx") : null);
                    m.setCreatedAt(rs.getTimestamp("createdAt"));
                    list.add(m);
                }
            }
        } finally {
            if (con != null) con.close();
        }
        return list;
    }

    public MealHistory insert(MealHistory m) throws Exception {
        String sql = "INSERT INTO MealHistory (accountId, mealName, calories, mealTime, suggestIdx) VALUES (?, ?, ?, ?, ?)";
        
        Connection con = DBContext.getConnection();
        if (con == null) return m; // Hoặc ném Exception tùy ý đồ của bro
        
        try (PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, m.getAccountId());
            ps.setString(2, m.getMealName());
            ps.setFloat(3, m.getCalories());
            ps.setString(4, m.getMealTime());
            if (m.getSuggestIdx() != null) {
                ps.setInt(5, m.getSuggestIdx());
            } else {
                ps.setNull(5, Types.INTEGER);
            }
            
            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    m.setId(rs.getInt(1));
                }
            }
        } finally {
            if (con != null) con.close();
        }
        return m;
    }

    public boolean delete(int id, int accountId) throws Exception {
        String sql = "DELETE FROM MealHistory WHERE id = ? AND accountId = ?";
        
        Connection con = DBContext.getConnection();
        if (con == null) return false;
        
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.setInt(2, accountId);
            return ps.executeUpdate() > 0;
        } finally {
            if (con != null) con.close();
        }
    }
}
