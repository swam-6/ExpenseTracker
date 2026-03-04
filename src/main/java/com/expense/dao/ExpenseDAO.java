package com.expense.dao;

import com.expense.model.Expense;
import com.expense.util.DBUtil;

import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ExpenseDAO {

    public List<Expense> findAll() throws SQLException {
        List<Expense> list = new ArrayList<>();
        try (Connection c = DBUtil.getConnection();
             Statement st = c.createStatement();
             ResultSet rs = st.executeQuery("SELECT * FROM expense ORDER BY date DESC")) {
            while (rs.next()) list.add(map(rs));
        }
        return list;
    }

    public Expense findById(int id) throws SQLException {
        try (Connection c = DBUtil.getConnection();
             PreparedStatement ps = c.prepareStatement("SELECT * FROM expense WHERE id=?")) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            return rs.next() ? map(rs) : null;
        }
    }

    public void insert(Expense e) throws SQLException {
        try (Connection c = DBUtil.getConnection();
             PreparedStatement ps = c.prepareStatement(
                     "INSERT INTO expense(title,amount,category,date) VALUES(?,?,?,?)")) {
            ps.setString(1, e.getTitle());
            ps.setBigDecimal(2, e.getAmount());
            ps.setString(3, e.getCategory());
            ps.setDate(4, Date.valueOf(e.getDate()));
            ps.executeUpdate();
        }
    }

    public void update(Expense e) throws SQLException {
        try (Connection c = DBUtil.getConnection();
             PreparedStatement ps = c.prepareStatement(
                     "UPDATE expense SET title=?,amount=?,category=?,date=? WHERE id=?")) {
            ps.setString(1, e.getTitle());
            ps.setBigDecimal(2, e.getAmount());
            ps.setString(3, e.getCategory());
            ps.setDate(4, Date.valueOf(e.getDate()));
            ps.setInt(5, e.getId());
            ps.executeUpdate();
        }
    }

    public void delete(int id) throws SQLException {
        try (Connection c = DBUtil.getConnection();
             PreparedStatement ps = c.prepareStatement("DELETE FROM expense WHERE id=?")) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }

    private Expense map(ResultSet rs) throws SQLException {
        return new Expense(
                rs.getInt("id"),
                rs.getString("title"),
                rs.getBigDecimal("amount"),
                rs.getString("category"),
                rs.getDate("date").toLocalDate()
        );
    }
}