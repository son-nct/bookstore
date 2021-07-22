/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ncts.dao;

import java.util.HashMap;
import java.util.Map;
import ncts.dto.BookDTO;

/**
 *
 * @author WIN 10
 */
public class CartObject {

    private Map<BookDTO, Integer> items;

    public Map<BookDTO, Integer> getItems() {
        return items;
    }

    public boolean checkBookInCart(String idBook) {
        for (BookDTO bookDTO : items.keySet()) {
            if (bookDTO.getIdBook().equalsIgnoreCase(idBook)) {
                return true;
            }
        }
        return false;
    }

    public void addToCartWithAmount(BookDTO book, int amount) {
        if (this.items == null) {
            items = new HashMap<>();
        }

        boolean checkExist = checkBookInCart(book.getIdBook());
        if (checkExist) {
            for (BookDTO bookDTO : items.keySet()) {
                if(bookDTO.getIdBook().equals(book.getIdBook())) {
                    int quantity = this.items.get(bookDTO) + amount;
                    items.replace(bookDTO, quantity);
                    break;
                }
            }
        }else {
            items.put(book, amount);
        }
    }

    public void addToCart(BookDTO book) {
        if (this.items == null) {
            items = new HashMap<>();
        }

        int quantity = 1;
        for (BookDTO bookDTO : items.keySet()) {
            if (bookDTO.getIdBook().equalsIgnoreCase(book.getIdBook())) {
                quantity = this.items.get(bookDTO) + 1;
                items.remove(bookDTO);
                break;
            }
        }

        items.put(book, quantity);
    }

    public void removeBookInCart(String idBook) {
        if (items == null) {
            return;
        }

        for (BookDTO bookDTO : items.keySet()) {
            if (bookDTO.getIdBook().equals(idBook)) {
                items.remove(bookDTO);
                break;
            }
        }
    }
}
