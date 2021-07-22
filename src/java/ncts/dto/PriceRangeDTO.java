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
public class PriceRangeDTO implements Serializable {

    private String idRange;
    private String value;

    public PriceRangeDTO() {
    }

    public PriceRangeDTO(String idRange, String value) {
        this.idRange = idRange;
        this.value = value;
    }

    public String getIdRange() {
        return idRange;
    }

    public void setIdRange(String idRange) {
        this.idRange = idRange;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

}
