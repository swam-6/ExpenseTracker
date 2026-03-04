<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Expense Tracker</title>
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;600;700;800;900&display=swap" rel="stylesheet"/>
    <style>
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

        :root {
            --bg:        #f4f6fb;
            --white:     #ffffff;
            --primary:   #2563eb;
            --primary-d: #1d4ed8;
            --green:     #16a34a;
            --red:       #dc2626;
            --text:      #1e293b;
            --muted:     #64748b;
            --border:    #e2e8f0;
            --month-bg:  #1e293b;
            --cat-bg:    #eff6ff;
        }

        body {
            font-family: 'Nunito', sans-serif;
            background: var(--bg);
            color: var(--text);
            font-size: 16px;
            min-height: 100vh;
            padding: 0 0 60px;
        }

        /* ── Top navbar ── */
        .navbar {
            background: var(--white);
            border-bottom: 2px solid var(--border);
            padding: 0 40px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            height: 70px;
            position: sticky;
            top: 0;
            z-index: 100;
            box-shadow: 0 2px 12px rgba(0,0,0,0.06);
        }

        .brand {
            display: flex;
            align-items: center;
            gap: 12px;
            font-size: 22px;
            font-weight: 900;
            color: var(--primary);
            letter-spacing: -0.5px;
        }

        .brand-icon {
            background: var(--primary);
            color: white;
            width: 42px;
            height: 42px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
        }

        .btn-add {
            background: var(--primary);
            color: white;
            padding: 12px 28px;
            border-radius: 10px;
            text-decoration: none;
            font-size: 16px;
            font-weight: 700;
            transition: background 0.2s, transform 0.1s;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .btn-add:hover {
            background: var(--primary-d);
            transform: translateY(-1px);
        }

        /* ── Page content ── */
        .container {
            max-width: 1000px;
            margin: 0 auto;
            padding: 36px 24px 0;
        }

        /* ── Summary cards ── */
        .summary {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
            margin-bottom: 36px;
        }

        .s-card {
            background: var(--white);
            border-radius: 16px;
            padding: 24px 28px;
            box-shadow: 0 2px 12px rgba(0,0,0,0.06);
            border-top: 4px solid var(--primary);
        }

        .s-card:nth-child(2) { border-top-color: var(--green); }
        .s-card:nth-child(3) { border-top-color: #f59e0b; }

        .s-label {
            font-size: 14px;
            font-weight: 600;
            color: var(--muted);
            text-transform: uppercase;
            letter-spacing: 0.06em;
            margin-bottom: 10px;
        }

        .s-value {
            font-size: 32px;
            font-weight: 900;
            color: var(--text);
            line-height: 1;
        }

        /* ── Month block ── */
        .month-block {
            margin-bottom: 28px;
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 4px 20px rgba(0,0,0,0.08);
        }

        .month-header {
            background: var(--month-bg);
            color: white;
            padding: 18px 28px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            cursor: pointer;
            user-select: none;
        }

        .month-header:hover { background: #273549; }

        .month-title {
            font-size: 20px;
            font-weight: 800;
            letter-spacing: -0.3px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .month-right {
            display: flex;
            align-items: center;
            gap: 16px;
        }

        .month-total {
            font-size: 18px;
            font-weight: 800;
            background: rgba(255,255,255,0.12);
            border: 1px solid rgba(255,255,255,0.2);
            padding: 6px 18px;
            border-radius: 30px;
        }

        .chevron {
            font-size: 18px;
            transition: transform 0.25s;
            opacity: 0.7;
        }

        .chevron.open { transform: rotate(180deg); }

        /* ── Month body ── */
        .month-body {
            background: var(--white);
        }

        /* ── Category group ── */
        .cat-group { border-top: 1px solid var(--border); }
        .cat-group:first-child { border-top: none; }

        .cat-header {
            background: var(--cat-bg);
            padding: 14px 28px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid #dbeafe;
        }

        .cat-name {
            font-size: 16px;
            font-weight: 800;
            color: var(--primary);
        }

        .cat-total {
            font-size: 16px;
            font-weight: 700;
            color: var(--green);
        }

        /* ── Table ── */
        table { width: 100%; border-collapse: collapse; }

        thead th {
            background: #f8fafc;
            padding: 12px 28px;
            text-align: left;
            font-size: 13px;
            font-weight: 700;
            color: var(--muted);
            text-transform: uppercase;
            letter-spacing: 0.07em;
            border-bottom: 1px solid var(--border);
        }

        tbody tr {
            border-bottom: 1px solid var(--border);
            transition: background 0.15s;
        }

        tbody tr:last-child { border-bottom: none; }
        tbody tr:hover { background: #f8fafc; }

        tbody td {
            padding: 16px 28px;
            font-size: 16px;
            color: var(--text);
            vertical-align: middle;
        }

        .title-cell { font-weight: 700; font-size: 17px; }
        .amount-cell { font-weight: 800; font-size: 18px; color: var(--green); }
        .date-cell   { font-size: 15px; color: var(--muted); font-weight: 600; }

        /* ── Action buttons ── */
        .actions { display: flex; gap: 8px; }

        .btn-edit, .btn-delete {
            padding: 8px 18px;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 700;
            text-decoration: none;
            transition: all 0.15s;
            font-family: 'Nunito', sans-serif;
        }

        .btn-edit {
            background: #eff6ff;
            color: var(--primary);
            border: 1px solid #bfdbfe;
        }

        .btn-edit:hover { background: #dbeafe; }

        .btn-delete {
            background: #fef2f2;
            color: var(--red);
            border: 1px solid #fecaca;
        }

        .btn-delete:hover { background: #fee2e2; }

        /* ── Empty state ── */
        .empty {
            text-align: center;
            padding: 80px 24px;
            background: var(--white);
            border-radius: 16px;
            box-shadow: 0 2px 12px rgba(0,0,0,0.06);
        }

        .empty-icon { font-size: 56px; margin-bottom: 16px; }

        .empty h3 {
            font-size: 22px;
            font-weight: 800;
            color: var(--text);
            margin-bottom: 8px;
        }

        .empty p { font-size: 16px; color: var(--muted); }

        @media (max-width: 640px) {
            .summary { grid-template-columns: 1fr; }
            .navbar { padding: 0 16px; }
            .container { padding: 20px 12px 0; }
            tbody td, thead th { padding: 12px 14px; }
        }
    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar">
    <div class="brand">
        <div class="brand-icon">+</div>
        Expense Tracker
    </div>
    <a href="expenses?action=new" class="btn-add">＋ Add Expense</a>
</nav>

<div class="container">

    <c:choose>
        <c:when test="${not empty monthMap}">

            <!-- Summary cards -->
            <div class="summary">
                <div class="s-card">
                    <div class="s-label">Total Records</div>
                    <div class="s-value">${totalCount}</div>
                </div>
                <div class="s-card">
                    <div class="s-label">Grand Total Spent</div>
                    <div class="s-value" style="color:var(--green)">₹${grandTotal}</div>
                </div>
                <div class="s-card">
                    <div class="s-label">Months Tracked</div>
                    <div class="s-value" style="color:#f59e0b">${monthMap.size()}</div>
                </div>
            </div>

            <!-- Month blocks -->
            <c:forEach var="monthEntry" items="${monthMap}" varStatus="ms">
                <div class="month-block">

                    <div class="month-header" onclick="toggleMonth('m${ms.index}', this)">
                        <span class="month-title">📅 ${monthEntry.key}</span>
                        <div class="month-right">
                            <span class="month-total">₹${monthTotals[monthEntry.key]}</span>
                            <span class="chevron open">▼</span>
                        </div>
                    </div>

                    <div class="month-body" id="m${ms.index}">
                        <c:forEach var="catEntry" items="${monthEntry.value}">
                            <div class="cat-group">

                                <div class="cat-header">
                                    <span class="cat-name">${catEntry.key}</span>
                                    <span class="cat-total">
                        ₹<c:set var="ct" value="0"/>
                        <c:forEach var="e" items="${catEntry.value}">
                            <c:set var="ct" value="${ct + e.amount}"/>
                        </c:forEach>${ct}
                    </span>
                                </div>

                                <table>
                                    <thead>
                                    <tr>
                                        <th>Title</th>
                                        <th>Amount</th>
                                        <th>Date</th>
                                        <th>Actions</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="e" items="${catEntry.value}">
                                        <tr>
                                            <td class="title-cell">${e.title}</td>
                                            <td class="amount-cell">₹${e.amount}</td>
                                            <td class="date-cell">${e.date}</td>
                                            <td>
                                                <div class="actions">
                                                    <a href="expenses?action=edit&id=${e.id}" class="btn-edit">✏ Edit</a>
                                                    <a href="expenses?action=delete&id=${e.id}" class="btn-delete"
                                                       onclick="return confirm('Delete this expense?')">🗑 Delete</a>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>

                            </div>
                        </c:forEach>
                    </div>

                </div>
            </c:forEach>

        </c:when>
        <c:otherwise>
            <div class="empty">
                <div class="empty-icon">💸</div>
                <h3>No expenses recorded yet</h3>
                <p>Click "Add Expense" above to record your first entry.</p>
            </div>
        </c:otherwise>
    </c:choose>

</div>

<script>
    function toggleMonth(id, header) {
        var body = document.getElementById(id);
        var icon = header.querySelector('.chevron');
        var hidden = body.style.display === 'none';
        body.style.display = hidden ? 'block' : 'none';
        icon.classList.toggle('open', hidden);
    }
</script>

</body>
</html>
