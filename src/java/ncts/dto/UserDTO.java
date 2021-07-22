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
public class UserDTO implements Serializable {

    private String username;
    private String password;
    private String fullname;
    private String email;
    private String address;
    private String phone;
    private String role;
    private String status;

    public UserDTO() {
    }

    public UserDTO(String username, String password, String fullname, String email, String address, String phone, String role, String status) {
        this.username = username;
        this.password = password;
        this.fullname = fullname;
        this.email = email;
        this.address = address;
        this.phone = phone;
        this.role = role;
        this.status = status;
    }

    public UserDTO(String username, String fullname, String email, String address, String phone, String role) {
        this.username = username;
        this.fullname = fullname;
        this.email = email;
        this.address = address;
        this.phone = phone;
        this.role = role;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

}
