/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ncts.dto;

import java.io.Serializable;

/**
 *
 * @author WIN 10
 */
public class OrderDetailDTO implements Serializable{
    private String idDetail;
    private String idOrder;
    private String idBook;
    private int amount;

    public OrderDetailDTO() {
    }

    public OrderDetailDTO(String idDetail, String idOrder, String idBook, int amount) {
        this.idDetail = idDetail;
        this.idOrder = idOrder;
        this.idBook = idBook;
        this.amount = amount;
    }

    public String getIdDetail() {
        return idDetail;
    }

    public void setIdDetail(String idDetail) {
        this.idDetail = idDetail;
    }

    public String getIdOrder() {
        return idOrder;
    }

    public void setIdOrder(String idOrder) {
        this.idOrder = idOrder;
    }

    public String getIdBook() {
        return idBook;
    }

    public void setIdBook(String idBook) {
        this.idBook = idBook;
    }

    public int getAmount() {
        return amount;
    }

    public void setAmount(int amount) {
        this.amount = amount;
    }
    
}
