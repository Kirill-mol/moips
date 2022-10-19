CREATE TABLE IF NOT EXISTS units /* ЕИ */
(
    id      SERIAL NOT NULL,
    name    TEXT NOT NULL,
    symbol  TEXT NOT NULL,
    code    INTEGER NOT NULL,
    
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS product_classifier /* классификатор - типы продукции */
(
    id              SERIAL NOT NULL,
    name            TEXT NOT NULL,
    units_id        INTEGER,
    parents_id      INTEGER,
    
    PRIMARY KEY (id),
    
    CONSTRAINT fk_units 
        FOREIGN KEY (units_id)
            REFERENCES units (id),
    
    CONSTRAINT fk_parents 
        FOREIGN KEY (parents_id)
            REFERENCES product_classifier (id)
);

CREATE TABLE IF NOT EXISTS product /* продукция */
(
    id          SERIAL NOT NULL,
    name        TEXT NOT NULL,
    symbol      TEXT,
    class_id    INTEGER NOT NULL,
    
    PRIMARY KEY (id),
    
    CONSTRAINT fk_class 
        FOREIGN KEY (class_id)
            REFERENCES product_classifier (id)
);

CREATE TABLE IF NOT EXISTS product_specification /* спецификация */
(
    id                  SERIAL NOT NULL,
    pos_numb            INTEGER NOT NULL,
    spec_product_id     INTEGER NOT NULL,   /* ID продукта для которого пишем спецификацию */
    inc_product_id      INTEGER NOT NULL,   /* ID продукта, который входит в спецификацию */
    quantity            FLOAT NOT NULL,
    
    PRIMARY KEY (id),
    
    CONSTRAINT fk_spec_product 
        FOREIGN KEY (spec_product_id)
            REFERENCES product (id),
            
    CONSTRAINT fk_inc_product
        FOREIGN KEY (inc_product_id)
            REFERENCES product (id)
);