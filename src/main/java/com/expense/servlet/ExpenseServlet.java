package com.expense.servlet;

import com.expense.dao.ExpenseDAO;
import com.expense.model.Expense;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.*;

@WebServlet("/expenses")
public class ExpenseServlet extends HttpServlet {

    private final ExpenseDAO dao = new ExpenseDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        if (action == null) action = "list";

        try {
            switch (action) {

                case "new":
                    req.getRequestDispatcher("/expense-form.jsp").forward(req, resp);
                    break;

                case "edit":
                    int id = Integer.parseInt(req.getParameter("id"));
                    req.setAttribute("expense", dao.findById(id));
                    req.getRequestDispatcher("/expense-form.jsp").forward(req, resp);
                    break;

                case "delete":
                    dao.delete(Integer.parseInt(req.getParameter("id")));
                    resp.sendRedirect("expenses");
                    break;

                default: // list
                    List<Expense> all = dao.findAll();

                    // Structure: Month -> Category -> List of Expenses
                    // LinkedHashMap keeps months in insertion (latest first) order
                    Map<String, Map<String, List<Expense>>> monthMap = new LinkedHashMap<>();

                    DateTimeFormatter fmt = DateTimeFormatter.ofPattern("MMMM yyyy");

                    for (Expense e : all) {
                        String month = e.getDate().format(fmt); // e.g. "March 2026"
                        String cat   = e.getCategory();

                        monthMap
                                .computeIfAbsent(month, k -> new LinkedHashMap<>())
                                .computeIfAbsent(cat,   k -> new ArrayList<>())
                                .add(e);
                    }

                    // Monthly totals map:  month -> grand total
                    Map<String, BigDecimal> monthTotals = new LinkedHashMap<>();
                    for (Map.Entry<String, Map<String, List<Expense>>> me : monthMap.entrySet()) {
                        BigDecimal total = BigDecimal.ZERO;
                        for (List<Expense> list : me.getValue().values()) {
                            for (Expense e : list) total = total.add(e.getAmount());
                        }
                        monthTotals.put(me.getKey(), total);
                    }

                    // Overall grand total
                    BigDecimal grandTotal = monthTotals.values().stream()
                            .reduce(BigDecimal.ZERO, BigDecimal::add);

                    req.setAttribute("monthMap",    monthMap);
                    req.setAttribute("monthTotals", monthTotals);
                    req.setAttribute("grandTotal",  grandTotal);
                    req.setAttribute("totalCount",  all.size());
                    req.getRequestDispatcher("/expense-list.jsp").forward(req, resp);
            }

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String idParam = req.getParameter("id");
        Expense e = new Expense();
        e.setTitle(req.getParameter("title"));
        e.setAmount(new BigDecimal(req.getParameter("amount")));
        e.setCategory(req.getParameter("category"));
        e.setDate(LocalDate.parse(req.getParameter("date")));

        try {
            if (idParam == null || idParam.isEmpty()) {
                dao.insert(e);
            } else {
                e.setId(Integer.parseInt(idParam));
                dao.update(e);
            }
            resp.sendRedirect("expenses");
        } catch (Exception ex) {
            throw new ServletException(ex);
        }
    }
}