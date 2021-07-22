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
import java.util.ArrayList;
import java.util.List;
import javax.naming.NamingException;
import ncts.dto.HistoryDTO;
import ncts.dto.OrderDTO;
import ncts.utility.ConnectDatabase;

/**
 *
 * @author WIN 10
 */
public class HistoryDAO {

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

    public List<OrderDTO> getHistory(String username) throws NamingException, SQLException {
        List<OrderDTO> listOrder = null;

        try {
            con = ConnectDatabase.makeConnection();
            if (con != null) {
                String sql = "select idOrder, dateOrder ,totalMoney, methodPayment "
                        + "from orders "
                        + "where username = ?";
                ps = con.prepareStatement(sql);
                ps.setString(1, username);

                rs = ps.executeQuery();

                if (listOrder == null) {
                    listOrder = new ArrayList<>();
                }

                while (rs.next()) {
                    String idOrder = rs.getString("idOrder");
                    String dateOrder = rs.getString("dateOrder");
                    int totalMoney = rs.getInt("totalMoney");
                    String methodPayment = rs.getString("methodPayment");

                    OrderDTO order = new OrderDTO(idOrder, dateOrder, totalMoney, methodPayment);
                    listOrder.add(order);
                }
            }
        } finally {
            closeConnection();
        }
        return listOrder;
    }

    public List<OrderDTO> getHistoryByDate(String username, String searchDate) throws NamingException, SQLException {
        List<OrderDTO> listOrder = null;

        try {
            con = ConnectDatabase.makeConnection();
            if (con != null) {
                String sql = "select idOrder, dateOrder ,totalMoney, methodPayment "
                        + "from orders "
                        + "where username = ? and dateOrder = ?";
                ps = con.prepareStatement(sql);
                ps.setString(1, username);
                ps.setString(2, searchDate);

                rs = ps.executeQuery();

                if (listOrder == null) {
                    listOrder = new ArrayList<>();
                }

                while (rs.next()) {
                    String idOrder = rs.getString("idOrder");
                    String dateOrder = rs.getString("dateOrder");
                    int totalMoney = rs.getInt("totalMoney");
                    String methodPayment = rs.getString("methodPayment");

                    OrderDTO order = new OrderDTO(idOrder, dateOrder, totalMoney, methodPayment);
                    listOrder.add(order);
                }
            }
        } finally {
            closeConnection();
        }
        return listOrder;
    }

    public List<HistoryDTO> getHistoryDetail(String username, String idOrder) throws NamingException, SQLException {
        List<HistoryDTO> listDetail = null;

        try {
            con = ConnectDatabase.makeConnection();
            if (con != null) {
                String sql = "select b.title,ca.nameCategory,b.image,b.price,od.amount "
                        + "from orders o join orderDetail od on o.idOrder = od.idOrder "
                        + "join book b on od.idBook = b.idBook "
                        + "join category ca on b.idCategory = ca.idCategory "
                        + "where o.username = ? and o.idOrder = ?";
                ps = con.prepareStatement(sql);
                ps.setString(1, username);
                ps.setString(2, idOrder);

                rs = ps.executeQuery();

                if (listDetail == null) {
                    listDetail = new ArrayList<>();
                }

                while (rs.next()) {
                    String title = rs.getString("title");
                    String category = rs.getString("nameCategory");
                    String image = rs.getString("image");
                    int price = rs.getInt("price");
                    int amount = rs.getInt("amount");

                    HistoryDTO detail = new HistoryDTO(title, category, image, price, amount);
                    listDetail.add(detail);
                }
            }
        } finally {
            closeConnection();
        }
        return listDetail;
    }

}
