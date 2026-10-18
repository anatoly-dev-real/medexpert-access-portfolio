-- ============================================================================
-- MedExpert (Microsoft Access) - selected SQL queries
-- ----------------------------------------------------------------------------
-- Dialect: Microsoft Access (ACE/Jet SQL). Square brackets are used for names
-- with spaces and for parameters; PARAMETERS and TOP are Access syntax.
-- Table and column names are in Russian because the database itself is in
-- Russian. English comments explain what each query does.
-- Queries 1-7 are the SQL queries documented in the project report;
-- query 8 is a stock-control query from the database file.
-- ============================================================================


-- 1. In production ("В производстве")
-- Orders whose status is "in production", newest first, with the customer's
-- name and phone.
-- Note: the Всего_заказов column counts ALL orders in production, so it shows
-- the same number in every row.
SELECT Заказы.Код_заказа, Заказы.Дата_оформления, Заказы.Общая_стоимость,
       Клиенты.ФИО AS Клиент, Клиенты.Телефон,
       (SELECT COUNT(*) FROM Заказы WHERE [Статус заказа] = 'В производстве') AS Всего_заказов
FROM Заказы INNER JOIN Клиенты ON Заказы.Код_клиента = Клиенты.Код_клиента
WHERE Заказы.[Статус заказа] = 'В производстве'
ORDER BY Заказы.Дата_оформления DESC;


-- 2. Medicine information ("ИнфоПрепарата")
-- Parameter query: asks for a medicine name and lists its components with the
-- current stock of each component (three-table join).
SELECT Лекарства.Название, Лекарства.Тип_лекарства, Лекарства.Способ_приготовления,
       Компоненты.Название AS Компонент, Компоненты.Количество_на_складе
FROM (Лекарства INNER JOIN Состав_препарата
        ON Лекарства.Код_лекарства = Состав_препарата.Код_лекарства)
     INNER JOIN Компоненты
        ON Состав_препарата.Код_компонента = Компоненты.Код_компонента
WHERE Лекарства.Название = [Введите название лекарства];


-- 3. Medicines needed for orders in production ("ЛекарстваВПроизводстве")
-- For every order in production: which medicine and how many packs, plus the
-- total number of packs needed across all orders in production (subquery).
SELECT Заказы.Код_заказа, Лекарства.Название AS Препарат,
       Состав_заказа.Количество AS Требуется_упаковок,
       (SELECT SUM(Состав_заказа.Количество)
          FROM Состав_заказа INNER JOIN Заказы
            ON Состав_заказа.Код_заказа = Заказы.Код_заказа
         WHERE Заказы.[Статус заказа] = 'В производстве') AS Всего_упаковок_на_все_заказы
FROM (Заказы INNER JOIN Состав_заказа ON Заказы.Код_заказа = Состав_заказа.Код_заказа)
     INNER JOIN Лекарства ON Состав_заказа.Код_лекарства = Лекарства.Код_лекарства
WHERE Заказы.[Статус заказа] = 'В производстве'
ORDER BY Заказы.Код_заказа, Лекарства.Название;


-- 4. Minimum stock ("МинЗапас")
-- The component(s) with the lowest quantity in stock (subquery with MIN).
SELECT Компоненты.*
FROM Компоненты
WHERE Количество_на_складе = (SELECT Min(Количество_на_складе) FROM Компоненты);


-- 5. Preparation technology ("ТехнологииПриготовления")
-- Parameter query: for a chosen medicine type, shows how the medicines in
-- production are prepared and how long preparation takes.
PARAMETERS [Введите тип лекарства] Text ( 255 );
SELECT Лекарства.Тип_лекарства, Лекарства.Название AS Препарат,
       Лекарства.Способ_приготовления, Лекарства.Время_приготовления_мин,
       Заказы.Код_заказа, Заказы.[Статус заказа], Состав_заказа.Количество AS Количество_упаковок
FROM Лекарства INNER JOIN (Заказы INNER JOIN Состав_заказа
        ON Заказы.Код_заказа = Состав_заказа.Код_заказа)
     ON Лекарства.Код_лекарства = Состав_заказа.Код_лекарства
WHERE (((Лекарства.Тип_лекарства) = [Введите тип лекарства])
       AND ((Заказы.[Статус заказа]) = 'В производстве'))
ORDER BY Заказы.Код_заказа, Лекарства.Название;


-- 6. Component prices per medicine ("ЦеныНаПрепарат")
-- Each medicine with its components, the amount of each component needed and
-- the component's unit price.
SELECT Лекарства.Название, Компоненты.Название AS Компонент,
       Состав_препарата.Количество_компонента, Компоненты.Цена
FROM Лекарства INNER JOIN (Компоненты INNER JOIN Состав_препарата
        ON Компоненты.Код_компонента = Состав_препарата.Код_компонента)
     ON Лекарства.Код_лекарства = Состав_препарата.Код_лекарства;


-- 7. Frequent customers by medicine type ("ЧастыеПокупателиТипЛек")
-- Parameter query: top 10 customers who buy a chosen type of medicine most
-- often (GROUP BY with COUNT and SUM across four tables).
PARAMETERS [Введите тип лекарства] Text ( 255 );
SELECT TOP 10 Клиенты.ФИО, Клиенты.Телефон, Лекарства.Тип_лекарства,
       COUNT(Заказы.Код_заказа) AS Количество_заказов,
       SUM(Состав_заказа.Количество) AS Всего_упаковок
FROM ((Клиенты INNER JOIN Заказы ON Клиенты.Код_клиента = Заказы.Код_клиента)
      INNER JOIN Состав_заказа ON Заказы.Код_заказа = Состав_заказа.Код_заказа)
     INNER JOIN Лекарства ON Состав_заказа.Код_лекарства = Лекарства.Код_лекарства
WHERE Лекарства.Тип_лекарства = [Введите тип лекарства]
GROUP BY Клиенты.ФИО, Клиенты.Телефон, Лекарства.Тип_лекарства
ORDER BY COUNT(Заказы.Код_заказа) DESC;


-- 8. Critical stock ("КритНорма")
-- Components whose stock has fallen to or below the critical norm.
-- Val() converts the stored values to numbers before comparing.
SELECT Компоненты.Название, Val(Количество_на_складе) AS Колво,
       Val(Критическая_норма) AS Норма, Компоненты.Единица_измерения,
       Компоненты.Код_компонента
FROM Компоненты
WHERE (((Val([Количество_на_складе])) <= Val([Критическая_норма])));
