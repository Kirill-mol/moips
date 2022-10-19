CREATE TABLE IF NOT EXISTS aggregated_spec
(
    id           SERIAL NOT NULL,
    id_class     INTEGER,
    name_class   TEXT,
    id_product   INTEGER,
    name_product TEXT,
    quantity     DOUBLE PRECISION,
    id_units     INTEGER,
    name_units   TEXT,
    level        INTEGER,
    PRIMARY KEY (id)
);

CREATE OR REPLACE FUNCTION public.aggregate_specification(
    id_prod INTEGER, /*изделие*/
    cur_level INTEGER
)
    RETURNS void
AS
$$
DECLARE
    inc_count1 INTEGER;
    rows_      RECORD;
BEGIN

    INSERT INTO aggregated_spec(id_class, name_class, id_product, name_product, quantity, id_units, name_units, level)
    SELECT pc.id, pc.name, p.id, p.name, quantity, pc.units_id, u.name, cur_level
    FROM public.product_specification ps1
             INNER JOIN product p on p.id = ps1.inc_product_id
             INNER JOIN public.product_classifier pc on pc.id = p.class_id
             INNER JOIN units u on u.id = pc.units_id
    WHERE spec_product_id = id_prod;

    SELECT COUNT(*)
    FROM public.product_specification ps /*проверка на наличие сост. элементов, иначе 0 0 */
    WHERE ps.spec_product_id = id_prod
    INTO inc_count1;

    IF (inc_count1 > 0) THEN
        FOR rows_ IN (SELECT ps1.inc_product_id, ps1.quantity AS new_quant
                      FROM public.product_specification ps1
                      WHERE ps1.spec_product_id = id_prod)
            LOOP
                BEGIN
                    PERFORM public.aggregate_specification(rows_.inc_product_id, cur_level + 1);
                END;

            END LOOP;
    END IF;
END;
$$ LANGUAGE 'plpgsql';