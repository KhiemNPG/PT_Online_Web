package dao;

import model.entity.SavedMeal;
import utils.DBContext;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SavedMealDAO extends DBContext {

    public List<SavedMeal> getAllByAccountId(int accountId) throws Exception {
        List<SavedMeal> list = new ArrayList<>();
        String sql = "SELECT * FROM SavedMeal WHERE accountId = ? ORDER BY createdAt DESC";
        
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setInt(1, accountId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                SavedMeal m = new SavedMeal();
                m.setId(rs.getInt("id"));
                m.setAccountId(rs.getInt("accountId"));
                m.setMealName(rs.getString("mealName"));
                m.setCalories(rs.getFloat("calories"));
                m.setRecipe(rs.getString("recipe"));
                m.setImgSrc(rs.getString("imgSrc"));
                m.setSuggestIdx(rs.getObject("suggestIdx") != null ? rs.getInt("suggestIdx") : null);
                m.setCreatedAt(rs.getTimestamp("createdAt"));
                list.add(m);
            }
        }
        return list;
    }

    public SavedMeal insert(SavedMeal m) throws Exception {
        String sql = "INSERT INTO SavedMeal (accountId, mealName, calories, recipe, imgSrc, suggestIdx) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            ps.setInt(1, m.getAccountId());
            ps.setString(2, m.getMealName());
            ps.setFloat(3, m.getCalories());
            ps.setString(4, m.getRecipe());
            ps.setString(5, m.getImgSrc());
            if (m.getSuggestIdx() != null) {
                ps.setInt(6, m.getSuggestIdx());
            } else {
                ps.setNull(6, Types.INTEGER);
            }
            
            ps.executeUpdate();
            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                m.setId(rs.getInt(1));
            }
        }
        return m;
    }

    public boolean delete(int id, int accountId) throws Exception {
        String sql = "DELETE FROM SavedMeal WHERE id = ? AND accountId = ?";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.setInt(2, accountId);
            return ps.executeUpdate() > 0;
        }
    }
}
