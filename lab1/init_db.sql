CREATE TABLE IF NOT EXISTS unit
(
    id     SERIAL NOT NULL,
    name   TEXT NOT NULL,
    symbol TEXT NOT NULL,
    code   TEXT,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS product_classifier
(
    id      SERIAL NOT NULL,
    name    TEXT NOT NULL,
    symbol  TEXT NOT NULL,
    unit_id INTEGER NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT fk_unit
        FOREIGN KEY (unit_id)
            REFERENCES unit (id)
);

CREATE TABLE IF NOT EXISTS product
(
    id   SERIAL NOT NULL,
    quantity FLOAT NOT NULL,
    classifier_id INTEGER NOT NULL,
    position INT NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT fk_classifier
        FOREIGN KEY (classifier_id)
            REFERENCES product_classifier (id)
);

CREATE TABLE IF NOT EXISTS product_specification
(
    id   SERIAL NOT NULL,
    product_id INTEGER NOT NULL,
    child_id INTEGER UNIQUE NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT fk_child
        FOREIGN KEY (child_id)
            REFERENCES product (id),
    CONSTRAINT fk_product
        FOREIGN KEY (product_id)
            REFERENCES product (id)
);
