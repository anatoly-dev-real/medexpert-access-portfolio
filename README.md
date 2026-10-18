# MedExpert — Pharmacy Database Application

**Project type:** Educational desktop application (course practice project)
**Platform:** Microsoft Access
**Technologies:** Microsoft Access, SQL, QBE, VBA (AI-assisted development)

**Русская версия:** [README на русском](README_RU.md)

## Overview

MedExpert is an educational Microsoft Access application that models a pharmacy's workflows: a medicine catalog, a shopping cart, prescription entry, order tracking, component stock control, supplier requests, and a printable receipt. It combines a relational database (11 tables) with a form-based interface, SQL and QBE queries, and reports.

The pharmacy sells ready-made medicines and also prepares medicines on prescription from components, so the database tracks both finished products and the components they are made of.

This is a prototype built for learning, not a production pharmacy system. All sample customer and prescription data in the project is fictional.

## Database Design

**Entity-relationship diagram**

![ERD](docs/01-erd.png)

**Relationship diagram as built in Access**

![Database schema](docs/02-database-schema.png)

**Tables**

| Area | Tables |
|---|---|
| Products | `Лекарства` (medicines), `Компоненты` (components), `Состав_препарата` (medicine composition) |
| Sales | `Клиенты` (customers), `Заказы` (orders), `Состав_заказа` (order items), `Чеки` (receipt history), `Корзина` (temporary cart) |
| Prescriptions | `Рецепты` (prescriptions) |
| Supply | `Запросы поставщикам` (supplier requests), `Поставки` (deliveries) |

Table and field names are in Russian because the application itself is in Russian.

## Example Queries

The report documents 7 SQL queries and 6 QBE queries. The SQL versions are collected, with English comments, in [`queries.sql`](queries.sql). Examples:

- **Components of a medicine** (parameter query, three-table join) — [result](docs/query-results/drug-info.png)
- **Medicines needed for orders in production** (subquery) — [result](docs/query-results/drugs-in-production.png)
- **Component prices per medicine** — [result](docs/query-results/component-prices.png)
- **Top 10 most used medicines** (QBE) — [result](docs/query-results/top-10-medicines.png)
- **Components at or below the critical stock norm** (QBE) — [result](docs/query-results/critical-stock.png)

## Interface Preview

| | |
|---|---|
| ![Main menu](screenshots/01-main-menu.png) **Main menu** — choose the customer area or the staff area | ![Staff menu](screenshots/02-staff-roles.png) **Staff menu** — pharmacist-technologist, storekeeper, administrator |
| ![Catalog](screenshots/03-medicine-catalog.png) **Medicine catalog** — details, prescription flag, price, image | ![Cart](screenshots/04-shopping-cart.png) **Shopping cart** — items, quantity, line total, order total |

Application flow: [docs/03-app-flow.png](docs/03-app-flow.png)

## Main User Workflow

1. The user opens **For Customer** from the main menu.
2. The user browses the medicine catalog and adds a product to the cart.
3. For a prescription medicine, a prescription-entry form opens first.
4. The user reviews the items and order total in the cart.
5. The checkout button runs the checkout workflow described in the project report (receipt, order record, receipt history, stock check) and opens a receipt report.

The checkout button is labelled "Pay", but the project has no payment gateway and processes no real payments.

## Other Application Features (as documented in the project report)

- Reference forms for medicines, components, orders, deliveries and prescriptions.
- Stock control: components at or below a critical norm are listed in a report and flagged for supplier requests.
- Reports: sales history for a chosen period, components, low-stock items, prescriptions, customer receipt.
- Order statuses (for example "in production", "awaiting delivery", "not collected") used by queries to answer staff questions.

## My Contribution

- Created and configured the Access forms and user interface; navigation menus use Access's built-in switchboard feature.
- Designed the database structure and relationships with AI-assisted guidance, and documented it with IDEF0 and ERD diagrams.
- Worked with SQL and QBE queries using AI assistance, then reviewed and tested the results.
- Used AI-generated VBA code for application automation.
- Tested the main user scenarios and fixed issues found during testing.

## Known Limitations and Possible Improvements

- **No real access control.** The staff menu only provides role-oriented navigation; there is no authentication or permission system.
- **Receipts table is denormalized.** `Чеки` stores one row per item and repeats the medicine name and price; a better design would split receipt headers from receipt lines.
- **Prescriptions are linked only to medicines**, not to orders or customers.
- **Some fields use the text type** where numbers fit better (for example patient age and quantity in `Рецепты`).
- **Single shared cart.** `Корзина` is one temporary table, so the app is designed for one user at a time.
- **Windows and Microsoft Access only.**
- Use synthetic sample data only. Do not store real patient, prescription or customer information in this prototype.

## Status

Educational prototype. The source `.accdb` file is not included in this repository. Planned additions: screenshots of a populated cart and a generated receipt, and a demo copy of the database with synthetic data.
