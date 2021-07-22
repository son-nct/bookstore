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
import ncts.dto.CategoryDTO;
import ncts.dto.PriceRangeDTO;
import ncts.utility.ConnectDatabase;

/**
 *
 * @author WIN 10
 */
public class CategoryDAO {

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

    public List<CategoryDTO> getListCategory() throws NamingException, SQLException {
        List<CategoryDTO> listCategory = null;
        try {
            con = ConnectDatabase.makeConnection();
            if (con != null) {

                String sql = "select idCategory , nameCategory "
                        + "from category";
                ps = con.prepareStatement(sql);
                rs = ps.executeQuery();

                if (listCategory == null) {
                    listCategory = new ArrayList<>();
                }

                while (rs.next()) {
                    String idCategory = rs.getString("idCategory");
                    String nameCategory = rs.getString("nameCategory");

                    CategoryDTO dto = new CategoryDTO(idCategory, nameCategory);
                    listCategory.add(dto);
                }
            }
        } finally {
            closeConnection();
        }
        return listCategory;
    }

    public List<PriceRangeDTO> getListRange() throws NamingException, SQLException {
        List<PriceRangeDTO> listRange = null;
        try {
            con = ConnectDatabase.makeConnection();
            if (con != null) {

                String sql = "select idRange, value "
                        + "from priceRange";
                ps = con.prepareStatement(sql);
                rs = ps.executeQuery();

                if (listRange == null) {
                    listRange = new ArrayList<>();
                }

                while (rs.next()) {
                    String idRange = rs.getString("idRange");
                    String value = rs.getString("value");

                    PriceRangeDTO dto = new PriceRangeDTO(idRange, value);
                    listRange.add(dto);
                }
            }
        } finally {
            closeConnection();
        }
        return listRange;
    }
}
