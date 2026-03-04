package com.expense.model;

import java.math.BigDecimal;
import java.time.LocalDate;

public class Expense {
    private int id;
    private String title, category;
    private BigDecimal amount;
    private LocalDate date;

    public Expense() {}

    public Expense(int id, String title, BigDecimal amount, String category, LocalDate date) {
        this.id = id; this.title = title; this.amount = amount;
        this.category = category; this.date = date;
    }

    public int getId()                  { return id; }
    public void setId(int id)           { this.id = id; }
    public String getTitle()            { return title; }
    public void setTitle(String t)      { this.title = t; }
    public String getCategory()         { return category; }
    public void setCategory(String c)   { this.category = c; }
    public BigDecimal getAmount()       { return amount; }
    public void setAmount(BigDecimal a) { this.amount = a; }
    public LocalDate getDate()          { return date; }
    public void setDate(LocalDate d)    { this.date = d; }
}