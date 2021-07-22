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
import ncts.dto.BookDTO;
import ncts.utility.ConnectDatabase;

/**
 *
 * @author WIN 10
 */
public class BookDAO {

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

    public BookDTO getBookDetail(String idBook) throws NamingException, SQLException {
        BookDTO bookDetail = null;
        try {
            con = ConnectDatabase.makeConnection();
            if (con != null) {

                String sql = "select bo.idBook, bo.title,bo.description ,bo.image, bo.price,bo.quantity,bo.author,bo.idCategory,ca.nameCategory "
                        + "from category ca join book bo on ca.idCategory = bo.idCategory "
                        + "where  bo.idBook = ? and  bo.status != 'InActive'";
                ps = con.prepareStatement(sql);
                ps.setString(1, idBook);
                rs = ps.executeQuery();

                if (rs.next()) {
                    String title = rs.getString("title");
                    String image = rs.getString("image");
                    int price = rs.getInt("price");
                    int quantity = rs.getInt("quantity");
                    String author = rs.getString("author");
                    String nameCategory = rs.getString("nameCategory");
                    String description = rs.getString("description");

                    bookDetail = new BookDTO(idBook, title, image, price, quantity, author, nameCategory, description);

                }
            }
        } finally {
            closeConnection();
        }
        return bookDetail;
    }

    public List<BookDTO> getListBookInRange(String idCategory, String searchValue, int priceFrom, int priceTo) throws NamingException, SQLException {
        List<BookDTO> listBook = null;
        try {
            con = ConnectDatabase.makeConnection();
            if (con != null) {

                if (priceFrom == 100 && priceTo == 0) {
                    String sql = "select bo.idBook, bo.title,bo.price,bo.quantity,bo.image,ca.nameCategory "
                            + "from category ca join book bo on ca.idCategory = bo.idCategory "
                            + "where ca.idCategory like ? and bo.title like ? and price >= ? and  bo.status != 'InActive'";
                    ps = con.prepareStatement(sql);
                    ps.setString(1, '%' + idCategory + '%');
                    ps.setString(2, '%' + searchValue + '%');
                    ps.setInt(3, priceFrom);
                } else {
                    String sql = "select bo.idBook, bo.title, bo.price,bo.quantity,bo.image,ca.nameCategory "
                            + "from category ca join book bo on ca.idCategory = bo.idCategory "
                            + "where  ca.idCategory like ? and bo.title like ? and price between ? and ? and  bo.status != 'InActive'";
                    ps = con.prepareStatement(sql);
                    ps.setString(1, '%' + idCategory + '%');
                    ps.setString(2, '%' + searchValue + '%');
                    ps.setInt(3, priceFrom);
                    ps.setInt(4, priceTo);
                }

                rs = ps.executeQuery();

                if (listBook == null) {
                    listBook = new ArrayList<>();
                }

                while (rs.next()) {
                    String idBook = rs.getString("idBook");
                    String title = rs.getString("title");
                    int price = rs.getInt("price");
                    int quantity = rs.getInt("quantity");
                    String image = rs.getString("image");
                    String nameCategory = rs.getString("nameCategory");

                    BookDTO dto = new BookDTO(idBook, title, price, quantity, image, nameCategory);
                    listBook.add(dto);
                }
            }
        } finally {
            closeConnection();
        }
        return listBook;
    }

    public List<BookDTO> getListBookWithoutRange(String idCategory, String searchValue) throws NamingException, SQLException {
        List<BookDTO> listBook = null;
        try {
            con = ConnectDatabase.makeConnection();
            if (con != null) {
                String sql = "select bo.idBook, bo.title, bo.price,bo.quantity,bo.image,ca.nameCategory "
                        + "from category ca join book bo on ca.idCategory = bo.idCategory "
                        + "where  ca.idCategory like ? and bo.title like ? and  bo.status != 'InActive'";

                ps = con.prepareStatement(sql);
                ps.setString(1, '%' + idCategory + '%');
                ps.setString(2, '%' + searchValue + '%');

                rs = ps.executeQuery();

                if (listBook == null) {
                    listBook = new ArrayList<>();
                }

                while (rs.next()) {
                    String idBook = rs.getString("idBook");
                    String title = rs.getString("title");
                    int price = rs.getInt("price");
                    int quantity = rs.getInt("quantity");
                    String image = rs.getString("image");
                    String nameCategory = rs.getString("nameCategory");

                    BookDTO dto = new BookDTO(idBook, title, price, quantity, image, nameCategory);
                    listBook.add(dto);
                }
            }
        } finally {
            closeConnection();
        }
        return listBook;
    }

    public boolean updateBook(BookDTO dto) throws NamingException, SQLException {
        try {
            con = ConnectDatabase.makeConnection();
            if (con != null) {
                String sql = "Update book "
                        + "set title = ?, image = ?, price = ?, quantity = ?, author = ?, importDate = ?, idCategory = ?, description = ? "
                        + "where idBook = ?";
                ps = con.prepareStatement(sql);
                ps.setString(1, dto.getTitle());
                ps.setString(2, dto.getImage());
                ps.setInt(3, dto.getPrice());
                ps.setInt(4, dto.getQuantity());
                ps.setString(5, dto.getAuthor());
                ps.setString(6, dto.getImportDate());
                ps.setString(7, dto.getIdCategory());
                ps.setString(8, dto.getDescription());
                ps.setString(9, dto.getIdBook());

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

    public boolean deleteBook(String idBook) throws NamingException, SQLException {
        try {
            con = ConnectDatabase.makeConnection();
            if (con != null) {
                String sql = "Update book "
                        + "set status = 'inactive' "
                        + "where idBook = ?";
                ps = con.prepareStatement(sql);

                ps.setString(1, idBook);

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

    public boolean createBook(BookDTO dto) throws NamingException, SQLException {
        try {
            con = ConnectDatabase.makeConnection();
            if (con != null) {
                String sql = "Insert into Book "
                        + "values(?,?,?,?,?,?,?,?,?,?)";
                ps = con.prepareStatement(sql);
                ps.setString(1, dto.getIdBook());
                ps.setString(2, dto.getTitle());
                ps.setString(3, dto.getImage());
                ps.setInt(4, dto.getPrice());
                ps.setInt(5, dto.getQuantity());
                ps.setString(6, dto.getAuthor());
                ps.setString(7, dto.getImportDate());
                ps.setString(8, dto.getIdCategory());
                ps.setString(9, dto.getStatus());
                ps.setString(10, dto.getDescription());

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
    
     public BookDTO checkQuantity(String idBook, int amount) throws NamingException, SQLException {
        try {
            con = ConnectDatabase.makeConnection();
            if (con != null) {
                String sql = " select quantity, (quantity - ?) as CheckQuantity "
                        + "from book "
                        + "where idBook = ?";
                ps = con.prepareStatement(sql);
                ps.setInt(1, amount);
                ps.setString(2, idBook);
               
                rs = ps.executeQuery();
                if(rs.next()) {
                    int remaining = rs.getInt("CheckQuantity");
                    int quantity = rs.getInt("quantity");
                    if(remaining < 0) {
                        BookDTO dto = new BookDTO(idBook, quantity);
                        return dto;
                    }
                }
            }
        } finally {
            closeConnection();
        }
        return null;
    }
     
    public boolean updateQuantity(String idBook, int remainingQuantity) throws NamingException,SQLException {
        try {
            con = ConnectDatabase.makeConnection();
            if(con != null) {
                String sql = "Update book "
                        + "set quantity = ? "
                        + "where idBook = ?";
                ps = con.prepareStatement(sql);
                ps.setInt(1, remainingQuantity);
                ps.setString(2, idBook);
                
                int affectedRow = ps.executeUpdate();
                if(affectedRow > 0) {
                    return true;
                }
            }
        }finally{
            closeConnection();
        }
        return false;
    }

}
