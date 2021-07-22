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
public class OrderDTO implements Serializable{
    private String idOrder;
    private String username;
    private String dateOrder;
    private int totalMoney;
    private String methodPayment;

    public OrderDTO() {
    }

    public OrderDTO(String idOrder, String username, String dateOrder, int totalMoney, String methodPayment) {
        this.idOrder = idOrder;
        this.username = username;
        this.dateOrder = dateOrder;
        this.totalMoney = totalMoney;
        this.methodPayment = methodPayment;
    }

    public OrderDTO(String idOrder, String dateOrder, int totalMoney, String methodPayment) {
        this.idOrder = idOrder;
        this.dateOrder = dateOrder;
        this.totalMoney = totalMoney;
        this.methodPayment = methodPayment;
    }
    
    


    public String getIdOrder() {
        return idOrder;
    }

    public void setIdOrder(String idOrder) {
        this.idOrder = idOrder;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getDateOrder() {
        return dateOrder;
    }

    public void setDateOrder(String dateOrder) {
        this.dateOrder = dateOrder;
    }

    public int getTotalMoney() {
        return totalMoney;
    }

    public void setTotalMoney(int totalMoney) {
        this.totalMoney = totalMoney;
    }

    public String getMethodPayment() {
        return methodPayment;
    }

    public void setMethodPayment(String methodPayment) {
        this.methodPayment = methodPayment;
    }
    
    
}
