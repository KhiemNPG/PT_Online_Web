package dao.Admin;

import model.entity.Account;
import model.entity.User;
import model.tracking.UserSchedule;
import utils.DBContext;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class AccountDAO extends DBContext {

    public List<Account> allCustomerAccountList(){
        List<Account> accountList = new ArrayList<>();

        String sql = "SELECT * FROM Account WHERE role LIKE 'CUSTOMER%'";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            try (ResultSet rs = ps.executeQuery()) {
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
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return accountList;
    }

    public int numberAccountPro(){
        int total = 0;
        String sql = "SELECT COUNT(*) FROM UserSubscription where planType = 'PRO'";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    total = rs.getInt(1);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return total;
    }

}
