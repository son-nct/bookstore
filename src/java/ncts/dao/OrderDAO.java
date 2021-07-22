/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ncts.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.naming.NamingException;
import ncts.dto.OrderDTO;
import ncts.dto.OrderDetailDTO;
import ncts.utility.ConnectDatabase;

/**
 *
 * @author WIN 10
 */
public class OrderDAO {

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

    public boolean createOrder(OrderDTO dto) throws NamingException, SQLException {
        try {
            con = ConnectDatabase.makeConnection();
            if(con != null) {
                String sql = "Insert into orders "
                        + "values(?,?,?,?,?)";
                ps = con.prepareStatement(sql);
                ps.setString(1, dto.getIdOrder());
                ps.setString(2, dto.getUsername());
                ps.setString(3, dto.getDateOrder());
                ps.setInt(4, dto.getTotalMoney());
                ps.setString(5, dto.getMethodPayment());
                
                int affectedRow = ps.executeUpdate();
                if(affectedRow > 0) {
                    return true;
                }
            }
        } finally {

        }
        return false;
    }
    
    public boolean createOrderDetail(OrderDetailDTO dto) throws NamingException, SQLException {
        try {
            con = ConnectDatabase.makeConnection();
            if(con != null) {
                String sql = "Insert into orderDetail "
                        + "values(?,?,?,?)";
                ps = con.prepareStatement(sql);
                ps.setString(1, dto.getIdDetail());
                ps.setString(2, dto.getIdOrder());
                ps.setString(3, dto.getIdBook());
                ps.setInt(4, dto.getAmount());
                
                int affectedRow = ps.executeUpdate();
                if(affectedRow > 0) {
                    return true;
                }
            }
        } finally {

        }
        return false;
    }
}
