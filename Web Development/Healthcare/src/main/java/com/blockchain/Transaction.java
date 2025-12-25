package com.blockchain;


import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

public class Transaction {

    private Long patientid;
    private Long drugid;
    private Date date;
    private Long quantity;


    public Long getPatientid() {
        return patientid;
    }

    public void setPatientid(Long patientid) {
        this.patientid = patientid;
    }

    public Long getDrugid() {
        return drugid;
    }

    public void setDrugid(Long drugid) {
        this.drugid = drugid;
    }

    public Date getDate() {
        return date;
    }

    public void setDate() {
        Date date = new Date();  
        this.date = date;
    }

    public Long getQuantity() {
        return quantity;
    }

    public void setQuantity(Long quantity) {
        this.quantity = quantity;
    }

    public Transaction(Long patientid, Long drugid, Long quantity) {
        Date date = new Date();
    	this.patientid = patientid;
        this.drugid = drugid;
        this.date = date;
        this.quantity=quantity;
    }
    
    public Transaction(Long patientid, Long drugid, String date, Long quantity) {
    	SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss", Locale.ENGLISH);
    	Date d = null;
		try {
			d = formatter.parse(date);
		} catch (ParseException e) {}
    	this.patientid = patientid;
        this.drugid = drugid;
        this.date = d;
        this.quantity=quantity;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Transaction that = (Transaction) o;

        if (date != null ? !date.equals(that.date) : that.date != null) return false;
        if (drugid != null ? !drugid.equals(that.drugid) : that.drugid != null) return false;
        if (quantity != null ? !quantity.equals(that.quantity) : that.quantity != null) 
            return false;
        return patientid != null ? patientid.equals(that.patientid) : that.patientid == null;
    }

    @Override
    public int hashCode() {
        int result = date != null ? date.hashCode() : 0;
        result = 31 * result + (patientid != null ? patientid.hashCode() : 0);
        result = 31 * result + (drugid != null ? drugid.hashCode() : 0);
        result = 31 * result + (quantity != null ? quantity.hashCode() : 0);
        return result;
    }
}