INSERT INTO units(name, symbol, code)
VALUES ('Килограмм', 'кг', 166), 
       ('Штука', 'шт', 796), 
       ('Тонна', 'Т', 168);
     
INSERT INTO product_classifier(id, name, units_id, parents_id)
VALUES (1, 'Продукция', NULL, NULL),
       (2, 'Материалы', NULL, 1),
       (3, 'Жидкости', 1, 2),
       (4, 'Прокатная сталь', NULL, 2),
       (5, 'Проволка', 1, 4),
       (6, 'Листовой прокат', 3, 4),
       (7, 'Круг', 3, 4),
       (8, 'Электроды', 1, 2),
       (9, 'Детали', 2, 1),
       (10, 'Стенки', 2, 9),
       (11, 'Связи', 2, 9),
       (12, 'Проушины', 2, 9),
       (13, 'Другое', 2, 9),
       (14, 'Узлы', 2, 1),
       (15, 'Боковины', 2, 14),
       (16, 'Проушины', 2, 14);
       
INSERT INTO product(id, name, symbol, class_id)
VALUES (1, 'КОРПУС', 'КП25.00.00.450', 1), 
       (2, 'ПРОВОЛКА 1,6 СВ-08Г2С', NULL, 5), 
       (3, 'ЭЛЕКТРОД УОНИ 13/45 Ф4 ГОСТ 9467-75', NULL, 8), 
       (4, 'ДВУОКИСЬ УГЛЕРОДА ЖИДКОГО ГОСТ 8050-85', NULL, 3), 
       (5, 'СТЕНКА', 'КП25.00.00.456-01', 10),
       (6, 'СТЕНКА', 'КП25.00.00.456', 10), 
       (7, 'СТЕНКА Б/Ч', 'КП25.00.00.455', 10), 
       (8, 'РАСПОРКА', 'КП25.00.00.454', 13), 
       (9, 'СВЯЗЬ', 'КП25.00.00.453-03', 11),
       (10, 'СВЯЗЬ', 'КП25.00.00.453-02', 11), 
       (11, 'СВЯЗЬ', 'КП25.00.00.453-01', 11), 
       (12, 'СВЯЗЬ', 'КП25.00.00.453', 11), 
       (13, 'ПРОУШИНА', 'КП25.00.00.452', 12),
       (14, 'ПРОУШИНА', 'КП25.00.00.451', 12), 
       (15, 'БОКОВИНА', 'КП25.00.00.480-01', 15), 
       (16, 'БОКОВИНА', 'КП25.00.00.480', 15), 
       (17, 'ПРОУШИНА', 'КП25.00.00.470-01', 16),
       (18, 'ПРОУШИНА', 'КП25.00.00.470', 16), 
       (19, 'ЛИСТ 20-Б-ПН-О СТ 3 КП2', NULL, 6), 
       (20, 'ЛИСТ 10-Б-ПН-О СТ 3 КП2', NULL, 6), 
       (21, 'ЛИСТ 16-Б-ПН-О СТ 3 КП2', NULL, 6),
       (22, 'БОБЫШКА', 'КП25.00.00.472', 13), 
       (23, 'ПРОУШИНА', 'КП25.00.00.471', 12), 
       (24, 'СТЕНКА', 'КП25.00.00.481', 10), 
       (25, 'КРУГ 40-В-I СТ 5ПС2-III', NULL, 7);

INSERT INTO product_specification(id, pos_numb, spec_product_id, inc_product_id, quantity)       
VALUES (1, 1, 1, 2, 3.06),
       (2, 2, 1, 3, 0.4),
       (3, 3, 1, 4, 3.7),
       (4, 4, 1, 5, 2),
       (5, 5, 1, 6, 2),
       (6, 6, 1, 7, 2),
       (7, 7, 1, 8, 2),
       (8, 8, 1, 9, 1),
       (9, 9, 1, 10, 1),
       (10, 10, 1, 11, 1),
       (11, 11, 1, 12, 1),
       (12, 12, 1, 13, 2),
       (13, 13, 1, 14, 2),
       (14, 14, 1, 15, 1),
       (15, 15, 1, 16, 1),
       (16, 16, 1, 17, 1),
       (17, 17, 1, 18, 1),
       (18, 1, 14, 19, 0.0154),
       (19, 1, 13, 19, 0.004),
       (20, 1, 12, 20, 0.0075),
       (21, 1, 11, 20, 0.0075),
       (22, 1, 10, 20, 0.0094),
       (23, 1, 9, 20, 0.0094),
       (24, 1, 8, 20, 0.0127),
       (25, 1, 7, 21, 0.00154),
       (26, 1, 6, 20, 0.0004),
       (27, 1, 5, 20, 0.0005),
       (28, 1, 18, 2, 0.04),
       (29, 2, 18, 3, 0.01),
       (30, 3, 18, 4, 0.05),
       (31, 4, 18, 22, 1),
       (32, 5, 18, 23, 1),
       (33, 1, 17, 2, 0.04),
       (34, 2, 17, 3, 0.01),
       (35, 3, 17, 4, 0.05),
       (36, 4, 17, 22, 1),
       (37, 5, 17, 23, 1),
       (38, 1, 16, 2, 0.03),
       (39, 2, 16, 3, 0.01),
       (40, 3, 16, 4, 0.04),
       (41, 4, 16, 24, 1), 
       (42, 5, 16, 22, 1),
       (43, 1, 15, 2, 0.03),
       (44, 2, 15, 3, 0.01),
       (45, 3, 15, 4, 0.04),
       (46, 4, 15, 24, 1),
       (47, 5, 15, 22, 1),
       (48, 1, 23, 19, 0.002),
       (49, 1, 22, 25, 0.0003),
       (50, 1, 24, 19, 0.0125);