package ncts.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.naming.NamingException;
import ncts.dto.UserDTO;
import ncts.utility.ConnectDatabase;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 *
 * @author WIN 10
 */
public class UserDAO {

    private Connection con;
    private PreparedStatement ps;
    private ResultSet rs;

    private void closeConnection() throws SQLException {
        if (rs != null) {
            rs.close();
        }
        if (ps != null) {
            ps.close();
        }
        if (con != null) {
            con.close();
        }
    }

    public UserDTO checkLogin(String username, String password) throws NamingException, SQLException {
        UserDTO user = null;
        try {
            con = ConnectDatabase.makeConnection();
            if (con != null) {
                String sql = "select fullname,email,address,phone,idRole "
                        + "from registration "
                        + "where username = ? and password = ?";
                ps = con.prepareStatement(sql);
                ps.setString(1, username);
                ps.setString(2, password);

                rs = ps.executeQuery();

                if (rs.next()) {
                    String fullname = rs.getString("fullname");
                    String email = rs.getString("email");
                    String address = rs.getString("address");
                    String phone = rs.getString("phone");
                    String idRole = rs.getString("idRole");

                    user = new UserDTO(username, fullname, email, address, phone, idRole);
                }
            }

        } finally {
            closeConnection();
        }
        return user;
    }

    public boolean registerAccount(UserDTO dto) throws NamingException, SQLException {
        try {
            con = ConnectDatabase.makeConnection();
            if (con != null) {
                String sql = "Insert into registration "
                        + "values(?,?,?,?,?,?,?,?)";
                ps = con.prepareStatement(sql);
                ps.setString(1, dto.getUsername());
                ps.setString(2, dto.getPassword());
                ps.setString(3, dto.getFullname());
                ps.setString(4, dto.getEmail());
                ps.setString(5, dto.getAddress());
                ps.setString(6, dto.getPhone());
                ps.setString(7, dto.getRole());
                ps.setString(8, dto.getStatus());

                int affectedRow = ps.executeUpdate();
                if (affectedRow > 0) {
                    return true;
                }
            }
        } finally {
            closeConnection();
        }
        return false;
    }

    public String checkUsername(String username) throws NamingException, SQLException {
        try {
            con = ConnectDatabase.makeConnection();
            if (con != null) {
                String sql = "select username "
                        + "from registration "
                        + "where username = ?";
                ps = con.prepareStatement(sql);
                ps.setString(1, username);

                rs = ps.executeQuery();
                if (rs.next()) {
                    return rs.getString("username");
                }
            }
        } finally {
            closeConnection();
        }
        return null;
    }
}
