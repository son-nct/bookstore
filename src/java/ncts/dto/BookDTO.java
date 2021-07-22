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
public class BookDTO implements Serializable {

    private String idBook;
    private String title;
    private String image;
    private int price;
    private int quantity;
    private String author;
    private String importDate;
    private String idCategory;
    private String nameCategory;
    private String status;
    private String description;

    public BookDTO() {
    }

    public BookDTO(String idBook, int quantity) {
        this.idBook = idBook;
        this.quantity = quantity;
    }

    
    
    public BookDTO(String idBook, String title, String image, int price, int quantity, String author, String importDate, String idCategory, String description) {
        this.idBook = idBook;
        this.title = title;
        this.image = image;
        this.price = price;
        this.quantity = quantity;
        this.author = author;
        this.importDate = importDate;
        this.idCategory = idCategory;
        this.description = description;
    }

    public BookDTO(String idBook, String title, String image, int price, int quantity, String author, String nameCategory, String description) {
        this.idBook = idBook;
        this.title = title;
        this.image = image;
        this.price = price;
        this.quantity = quantity;
        this.author = author;
        this.nameCategory = nameCategory;
        this.description = description;
    }

    public BookDTO(String idBook, String title, String image, int price, int quantity, String author, String importDate, String idCategory, String status, String description) {
        this.idBook = idBook;
        this.title = title;
        this.image = image;
        this.price = price;
        this.quantity = quantity;
        this.author = author;
        this.importDate = importDate;
        this.idCategory = idCategory;
        this.status = status;
        this.description = description;
    }

    public BookDTO(String idBook, String title, int price, int quantity, String image, String nameCategory) {
        this.idBook = idBook;
        this.title = title;
        this.price = price;
        this.quantity = quantity;
        this.image = image;
        this.nameCategory = nameCategory;
    }

    public String getIdBook() {
        return idBook;
    }

    public void setIdBook(String idBook) {
        this.idBook = idBook;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getImportDate() {
        return importDate;
    }

    public void setImportDate(String importDate) {
        this.importDate = importDate;
    }

    public String getIdCategory() {
        return idCategory;
    }

    public void setIdCategory(String idCategory) {
        this.idCategory = idCategory;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getNameCategory() {
        return nameCategory;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setNameCategory(String nameCategory) {
        this.nameCategory = nameCategory;
    }

}
