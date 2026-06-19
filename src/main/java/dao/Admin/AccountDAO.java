package dao.Admin;

import model.entity.Account;
import utils.DBContext;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class AccountDAO {

    public List<Account> allCustomerAccountList() {
        List<Account> accountList = new ArrayList<>();
        String sql = "SELECT * FROM Account WHERE role LIKE 'CUSTOMER%'";

        // Sử dụng try-with-resources để tự động đóng Connection và PreparedStatement
        try (Connection con = DBContext.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Account account = new Account(
                        rs.getInt("accountId"),
                        rs.getString("username"),
                        rs.getString("passwordHash"),
                        rs.getString("role"),
                        rs.getBoolean("isActive"),
                        rs.getTimestamp("createdAt"),
                        rs.getString("email")
                );
                accountList.add(account);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return accountList;
    }

    public int numberAccountPro() {
        int total = 0;
        String sql = "SELECT COUNT(*) FROM UserSubscription WHERE planType = 'PRO'";

        try (Connection con = DBContext.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            if (rs.next()) {
                total = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return total;
    }
}
