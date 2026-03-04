# 💰 Expense Tracker 

A web-based **Expense Tracker** mini project built with pure Java — no frameworks, no fluff. Track your daily expenses by category and month using a clean dark fintech-style UI.

![Java](https://img.shields.io/badge/Java-17-orange?style=flat-square&logo=java)
![JSP](https://img.shields.io/badge/JSP-Servlet-blue?style=flat-square)
![MySQL](https://img.shields.io/badge/MySQL-8.0-blue?style=flat-square&logo=mysql)
![Tomcat](https://img.shields.io/badge/Apache%20Tomcat-10.1-red?style=flat-square)
![Maven](https://img.shields.io/badge/Maven-Build-purple?style=flat-square&logo=apachemaven)

---

## 📸 Features

- ✅ Add, Edit, Delete expenses (Full CRUD)
- ✅ Expenses grouped by **Month** with grand total per month
- ✅ Expenses grouped by **Category** within each month
- ✅ 6 default categories + ability to add **custom categories**
- ✅ Summary stats — Total Records, Grand Total Spent, Months Tracked
- ✅ Collapsible month sections
- ✅ Dark fintech-style UI with animated background

---

## 🛠️ Tech Stack

| Layer | Technology |
|---|---|
| Language | Java 17 |
| Frontend | JSP, HTML, CSS |
| Backend | Java Servlet |
| Database | MySQL 8 |
| DB Access | JDBC + PreparedStatement |
| Server | Apache Tomcat 10.1 |
| Build Tool | Maven |
| IDE | IntelliJ IDEA |

> No Spring. No Hibernate. No frameworks.

---

## 📁 Project Structure

```
ExpenseTracker/
├── src/
│   └── main/
│       ├── java/
│       │   └── com/expense/
│       │       ├── model/
│       │       │   └── Expense.java          # Entity class
│       │       ├── dao/
│       │       │   └── ExpenseDAO.java        # CRUD database operations
│       │       ├── util/
│       │       │   └── DBUtil.java            # JDBC connection utility
│       │       └── servlet/
│       │           └── ExpenseServlet.java    # Single servlet, handles all actions
│       └── webapp/
│           ├── WEB-INF/
│           │   └── web.xml
│           ├── index.jsp                      # Redirects to /expenses
│           ├── expense-list.jsp               # Lists all expenses grouped by month
│           └── expense-form.jsp               # Add / Edit form
└── pom.xml
```

---

## ⚙️ Prerequisites

Make sure you have the following installed before running:

| Tool | Version | Download |
|---|---|---|
| JDK | 17+ | https://adoptium.net |
| MySQL | 8.0+ | https://dev.mysql.com/downloads |
| Apache Tomcat | 10.1+ | https://tomcat.apache.org/download-10.cgi |
| IntelliJ IDEA | Any | https://www.jetbrains.com/idea/download |
| Maven | 3.8+ | Bundled with IntelliJ |

> You can also use **WAMP** instead of a standalone MySQL install — it's easier for Windows users.

---

## 🗄️ Database Setup

**Step 1** — Open MySQL Workbench (or phpMyAdmin if using WAMP)

**Step 2** — Run the following SQL:

```sql
CREATE DATABASE expense_tracker;
USE expense_tracker;

CREATE TABLE expense (
    id       INT AUTO_INCREMENT PRIMARY KEY,
    title    VARCHAR(100)   NOT NULL,
    amount   DECIMAL(10,2)  NOT NULL,
    category VARCHAR(50)    NOT NULL,
    date     DATE           NOT NULL
);
```

---



---

## 🚀 How to Run

### Step 1 — Clone the Repository

```bash
git clone https://github.com/your-username/ExpenseTracker.git
cd ExpenseTracker
```

### Step 2 — Open in IntelliJ IDEA

- Open IntelliJ → **File → Open** → select the `ExpenseTracker` folder
- Wait for Maven to download dependencies (look for the elephant icon)
- Click the elephant icon (**Load Maven Changes**) if prompted

### Step 3 — Configure Tomcat in IntelliJ

1. Top right → click **"Add Configuration"**
2. Click **`+`** → **Tomcat Server → Local**
3. Click **"Configure"** → browse to your Tomcat folder
4. Go to **Deployment tab** → click **`+`** → **Artifact** → select `ExpenseTracker:war exploded`
5. Set Application context to `/ExpenseTracker`
6. Click **OK**

### Step 4 — Run

Press the green **▶ Run** button in IntelliJ.

### Step 5 — Open in Browser

```
http://localhost:8080/ExpenseTracker/
```

> If port 8080 is in use, change Tomcat port to `8081` in `server.xml` and update IntelliJ config accordingly.

---




## 🗂️ Default Categories

The form includes 6 built-in categories:

| Emoji | Category |
|---|---|
| 🍔 | Food and Drinks |
| 🚗 | Transport |
| 🛒 | Groceries |
| 🎬 | Entertainment |
| 💪 | Health and Fitness |
| 💡 | Utilities |

You can also type your own **custom category** by selecting **"✏️ Add Custom Category..."** in the dropdown.

---

## 🔄 MVC Architecture

```
Browser Request
      ↓
ExpenseServlet.java   ← Controller (handles all actions: list, add, edit, delete)
      ↓
ExpenseDAO.java       ← Model (JDBC queries to MySQL)
      ↓
expense-list.jsp      ← View (displays grouped expenses)
expense-form.jsp      ← View (add/edit form)
```

---

## 🐛 Common Issues

| Problem | Fix |
|---|---|
| `Access denied for user 'root'` | Update password in `DBUtil.java` |
| `Communications link failure` | Start MySQL service — check via `services.msc` |
| `404 Not Found` | Make sure `index.jsp` is in `webapp/` not `WEB-INF/` |
| Port 8080 already in use | Change Tomcat port to `8081` in `conf/server.xml` |
| `ClassNotFoundException: Driver` | Click Maven elephant icon to reload dependencies |
| Changes not reflecting | For `.jsp` files: `Ctrl+Shift+R` — For `.java` files: `Ctrl+F5` |

---


## 🙋 Author

Built as a college mini project demonstrating full-stack Java web development using JSP, Servlet, JDBC, and MySQL — without any frameworks.

> Feel free to fork, modify, and use it for your own college projects! ⭐# ExpenseTracker


