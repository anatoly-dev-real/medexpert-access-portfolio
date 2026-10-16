# MedExpert — Pharmacy Database Application

**Project type:** Educational desktop application  
**Platform:** Microsoft Access  
**Technologies:** Microsoft Access, SQL, QBE, VBA (AI-assisted development)

**Русская версия:** [README на русском](README_RU.md)

## Overview

MedExpert is an educational Microsoft Access application that models selected pharmacy workflows. It combines a custom form-based interface with a relational database, product catalog, shopping cart, prescription data entry, and receipt/report generation.

The project was created for educational purposes. It is a prototype, not a production pharmacy system.

## Interface Preview

### Main menu

The start screen lets the user choose the customer area or the staff area.

![MedExpert main menu](01-main-menu.png)

### Staff navigation

The staff menu provides navigation to the pharmacist-technologist, storekeeper, and administrator sections.

![Staff role menu](02-staff-roles.png)

### Medicine catalog

The catalog form displays medicine details such as name, type, prescription requirement, price, and product image. It also provides controls to add an item to the cart or open the cart.

![Medicine catalog form](03-medicine-catalog.png)

### Shopping cart

The cart form contains fields for the selected medicine, quantity, unit price, line total, prescription requirement, and order total. The screenshot currently shows the form layout; a populated-cart screenshot is a useful next improvement.

![Shopping cart form](04-shopping-cart.png)

## Main User Workflow

1. The user opens **For Customer** from the main menu.
2. The user opens the medicine catalog and selects a product.
3. For a prescription medicine, the application opens a prescription-entry form. After the prescription details are entered, the medicine can be added to the cart.
4. The user reviews the items and order total in the cart.
5. The user clicks the checkout/payment button. The application opens a receipt/report containing the order items, total, date, and seller information.

**Payment note:** The button labeled “Pay” triggers the application's checkout and receipt workflow. The project does not integrate with an external payment gateway or process real payments.

## Database and Queries

The accompanying practice report documents a relational database with tables for:

- customers and medicines;
- components and medicine composition;
- orders and order items;
- prescriptions;
- supplier requests and deliveries;
- sales receipts/history;
- the temporary shopping cart.

The report also documents SQL selection queries and QBE queries for tasks such as finding orders in production, displaying medicine/component information, analysing stock levels, and producing summaries for selected periods.

These are educational examples and should not be interpreted as proof of production readiness or suitability for real medical data.

## My Contribution

- Created and configured the Access forms and user interface independently.
- Designed the database structure and relationships with AI-assisted guidance.
- Worked with SQL and QBE queries using AI assistance, then reviewed and tested the results.
- Used AI-generated VBA code for application automation.
- Tested the main user scenarios and fixed issues encountered during testing.

## Scope and Limitations

- Educational prototype built with Microsoft Access.
- No integration with a real payment gateway.
- The staff menu demonstrates role-oriented navigation; this project is not presented as a production-grade authentication or authorization system.
- Use synthetic sample data only. Do not use this prototype to store real patient, prescription, or customer information.

## Technologies

- Microsoft Access — tables, relationships, forms, and reports.
- SQL — database selection queries.
- QBE — query design in Access.
- VBA — workflow automation using AI-generated code, followed by manual testing.

## Status

Educational prototype. The current repository presents the project overview and selected interface screenshots. Further improvements may include a database-relationship diagram, examples of SQL/QBE queries, a populated-cart scenario, and a generated receipt.
