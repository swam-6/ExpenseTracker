<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>${expense == null ? 'Add' : 'Edit'} Expense</title>
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;600;700;800;900&display=swap" rel="stylesheet"/>
    <style>
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

        :root {
            --bg:        #f4f6fb;
            --white:     #ffffff;
            --primary:   #2563eb;
            --primary-d: #1d4ed8;
            --text:      #1e293b;
            --muted:     #64748b;
            --border:    #e2e8f0;
        }

        body {
            font-family: 'Nunito', sans-serif;
            background: var(--bg);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        /* ── Navbar ── */
        .navbar {
            background: var(--white);
            border-bottom: 2px solid var(--border);
            padding: 0 40px;
            display: flex;
            align-items: center;
            height: 70px;
            box-shadow: 0 2px 12px rgba(0,0,0,0.06);
        }

        .brand {
            display: flex;
            align-items: center;
            gap: 12px;
            font-size: 22px;
            font-weight: 900;
            color: var(--primary);
            text-decoration: none;
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

        /* ── Card ── */
        .page {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 40px 24px;
        }

        .card {
            background: var(--white);
            border-radius: 20px;
            box-shadow: 0 8px 32px rgba(0,0,0,0.10);
            width: 100%;
            max-width: 520px;
            padding: 44px 48px;
        }

        .card-title {
            font-size: 26px;
            font-weight: 900;
            color: var(--text);
            margin-bottom: 32px;
            padding-bottom: 18px;
            border-bottom: 2px solid var(--border);
            display: flex;
            align-items: center;
            gap: 10px;
        }

        /* ── Form layout ── */
        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        .form-group {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .form-group.full { grid-column: 1 / -1; }

        label {
            font-size: 14px;
            font-weight: 800;
            color: var(--muted);
            text-transform: uppercase;
            letter-spacing: 0.06em;
        }

        input, select {
            padding: 14px 16px;
            border: 2px solid var(--border);
            border-radius: 10px;
            font-size: 16px;
            font-family: 'Nunito', sans-serif;
            font-weight: 600;
            color: var(--text);
            background: var(--white);
            outline: none;
            transition: border-color 0.2s, box-shadow 0.2s;
        }

        input:focus, select:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 4px rgba(37,99,235,0.10);
        }

        input::placeholder { color: #cbd5e1; font-weight: 500; }

        /* ── Custom category ── */
        #customCategoryBox {
            display: none;
            flex-direction: column;
            gap: 8px;
            margin-top: 10px;
        }

        #customCategoryBox input {
            border: 2px dashed var(--primary);
            background: #eff6ff;
        }

        .hint {
            font-size: 13px;
            color: var(--muted);
            font-weight: 600;
        }

        /* ── Buttons ── */
        .btn-row {
            display: flex;
            gap: 12px;
            margin-top: 10px;
            grid-column: 1 / -1;
        }

        .btn-submit {
            flex: 1;
            padding: 16px;
            background: var(--primary);
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 17px;
            font-family: 'Nunito', sans-serif;
            font-weight: 800;
            cursor: pointer;
            transition: background 0.2s, transform 0.1s;
        }

        .btn-submit:hover {
            background: var(--primary-d);
            transform: translateY(-1px);
        }

        .btn-cancel {
            padding: 16px 24px;
            background: #f1f5f9;
            color: var(--muted);
            border: 2px solid var(--border);
            border-radius: 10px;
            font-size: 16px;
            font-family: 'Nunito', sans-serif;
            font-weight: 700;
            text-decoration: none;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all 0.2s;
        }

        .btn-cancel:hover {
            background: #e2e8f0;
            color: var(--text);
        }

        @media (max-width: 520px) {
            .card { padding: 28px 20px; }
            .form-grid { grid-template-columns: 1fr; }
            .form-group.full { grid-column: 1; }
            .btn-row { grid-column: 1; }
        }
    </style>
</head>
<body>

<nav class="navbar">
    <a href="expenses" class="brand">
        <div class="brand-icon">💰</div>
        Expense Tracker
    </a>
</nav>

<div class="page">
    <div class="card">
        <div class="card-title">
            ${expense == null ? '➕ Add New Expense' : '✏️ Edit Expense'}
        </div>

        <form method="post" action="expenses">
            <input type="hidden" name="id" value="${expense.id}"/>
            <input type="hidden" name="category" id="finalCategory"/>

            <div class="form-grid">

                <div class="form-group full">
                    <label>Title</label>
                    <input type="text" name="title" value="${expense.title}"
                           placeholder="e.g. Lunch, Uber, Netflix" required/>
                </div>

                <div class="form-group">
                    <label>Amount (₹)</label>
                    <input type="number" name="amount" value="${expense.amount}"
                           placeholder="0.00" step="0.01" min="0" required/>
                </div>

                <div class="form-group">
                    <label>Date</label>
                    <input type="date" name="date" value="${expense.date}" required/>
                </div>

                <div class="form-group full">
                    <label>Category</label>
                    <select id="categorySelect" onchange="handleCategoryChange(this.value)">
                        <option value="">-- Select a Category --</option>
                        <option value="Food and Drinks"     ${expense.category == 'Food and Drinks'     ? 'selected' : ''}>🍔 Food and Drinks</option>
                        <option value="Transport"           ${expense.category == 'Transport'           ? 'selected' : ''}>🚗 Transport</option>
                        <option value="Groceries"           ${expense.category == 'Groceries'           ? 'selected' : ''}>🛒 Groceries</option>
                        <option value="Entertainment"       ${expense.category == 'Entertainment'       ? 'selected' : ''}>🎬 Entertainment</option>
                        <option value="Health and Fitness"  ${expense.category == 'Health and Fitness'  ? 'selected' : ''}>💪 Health and Fitness</option>
                        <option value="Utilities"           ${expense.category == 'Utilities'           ? 'selected' : ''}>💡 Utilities</option>
                        <option value="custom">✏️ Add Custom Category...</option>
                    </select>

                    <div id="customCategoryBox">
                        <input type="text" id="customCategoryInput" placeholder="Type your custom category"/>
                        <span class="hint">💡 This will be saved as your category name.</span>
                    </div>
                </div>

                <div class="btn-row">
                    <button type="submit" class="btn-submit" onclick="return prepareSubmit()">
                        ${expense == null ? '➕ Add Expense' : '✅ Update Expense'}
                    </button>
                    <a href="expenses" class="btn-cancel">Cancel</a>
                </div>

            </div>
        </form>
    </div>
</div>

<script>
    window.onload = function () {
        var saved = "${expense.category}";
        var defaults = ["Food and Drinks","Transport","Groceries",
            "Entertainment","Health and Fitness","Utilities",""];
        if (saved && !defaults.includes(saved)) {
            document.getElementById("categorySelect").value = "custom";
            document.getElementById("customCategoryBox").style.display = "flex";
            document.getElementById("customCategoryInput").value = saved;
        }
    };

    function handleCategoryChange(val) {
        var box = document.getElementById("customCategoryBox");
        box.style.display = (val === "custom") ? "flex" : "none";
        if (val === "custom") document.getElementById("customCategoryInput").focus();
    }

    function prepareSubmit() {
        var select = document.getElementById("categorySelect");
        var custom = document.getElementById("customCategoryInput");
        var final  = document.getElementById("finalCategory");
        if (select.value === "custom") {
            if (custom.value.trim() === "") { alert("Please enter a custom category."); return false; }
            final.value = custom.value.trim();
        } else if (select.value === "") {
            alert("Please select a category.");
            return false;
        } else {
            final.value = select.value;
        }
        return true;
    }
</script>

</body>
</html>
