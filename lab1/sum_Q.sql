CREATE TABLE IF NOT EXISTS consolidated_norms (
	id 				SERIAL NOT NULL,
	id_class		INTEGER,
	name_class		TEXT,
	id_product		INTEGER,
	name_product	TEXT,
	quantity		DOUBLE PRECISION,
	id_units		INTEGER,
	name_units		TEXT,
	
	PRIMARY KEY (id)
);

CREATE OR REPLACE FUNCTION public.sum_quantity_prod ( /*определение составляющих изделий и их количества*/
	id_prod INTEGER, 				/*изделие*/
	quantity_prod DOUBLE PRECISION) /*количество изделий*/
	RETURNS void
	/*RETURNS SETOF INTEGER*/
		
AS $$
	DECLARE 									   /*параметры, используемые в программе*/
		id_inc_prod INTEGER; 				 		/*входящее изделие*/
		quantity_inc_prod DOUBLE PRECISION;  		/*количество входящего изделия*/
		inc_count1 INTEGER; 				 		/*количество составляющих id_prod*/
		inc_count2 INTEGER; 				 		/*количество составляющих 2 уровень*/
		rows_ RECORD; 						 		/*(id_inc_prod, quantity_inc_prod)*/
		quantity_inc_prod_lv2 DOUBLE PRECISION;  	/*количество входящего изделия 2 уровень*/

	BEGIN
		/*инициализация*/
		id_inc_prod = 0;
		quantity_inc_prod = 0;
		
		quantity_inc_prod_lv2 = 0;

		inc_count1 = 0;
		
		SELECT COUNT(*) FROM public.product_specification ps /*проверка на наличие сост. элементов, иначе 0 0 */
			WHERE ps.spec_product_id = id_prod
			INTO inc_count1;
		
		IF (inc_count1 > 0) THEN 								/*если составляющие элементы есть*/
																 /*получаем все входящие продукты и их количество*/
			FOR rows_ IN (SELECT ps1.inc_product_id, ps1.quantity * quantity_prod AS new_quant FROM public.product_specification ps1 
				WHERE ps1.spec_product_id = id_prod) LOOP
					BEGIN
						id_inc_prod = rows_.inc_product_id;
						quantity_inc_prod = rows_.new_quant;
				
					/*	RAISE NOTICE 'inc_product_id = %', id_inc_prod; 
						RAISE NOTICE 'quantity = %', quantity_inc_prod; */
				
						INSERT INTO public.consolidated_norms (id_class, name_class, id_product, name_product, quantity, id_units, name_units)
						VALUES (NULL, NULL, id_inc_prod, NULL, quantity_inc_prod, NULL, NULL);
						
						SELECT COUNT(*) FROM public.product_specification ps2 /*проверка на наличие сост. элементов, 2 уровень*/
							WHERE ps2.spec_product_id = id_inc_prod
							INTO inc_count2;
							RAISE NOTICE 'inc_count1 = %, inc_count2 = %', inc_count1, inc_count2;
							
							IF (inc_count2 > 0) THEN 
								BEGIN
									quantity_inc_prod_lv2 = quantity_inc_prod; /*на Q*1 изд. 1 lvl1 = Q*x единиц изд. lvl2*/
								    PERFORM sum_quantity_prod(id_inc_prod, quantity_inc_prod_lv2);
								END;
							END IF;
					END;
			END LOOP;

		ELSE /*если составляющих элементов нет*/ 
			BEGIN
				RAISE NOTICE 'Составляющих элементов нет'; /*ВРЕМЕННО*/
				id_inc_prod = 0;
				quantity_inc_prod = 0;

			END;
		END IF;
		/*RAISE NOTICE 'inc_count1 = %', inc_count1; /*ВРЕМЕННО*/*/
	END;
$$ LANGUAGE 'plpgsql';
		
/*ALTER FUNCTION public.sum_quantity_prod(INTEGER, DOUBLE PRECISION)
	OWNER TO postgres;*/
SELECT public.sum_quantity_prod(1, 2.0);


