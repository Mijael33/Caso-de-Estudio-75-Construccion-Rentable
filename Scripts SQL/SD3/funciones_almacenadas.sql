CREATE OR REPLACE FUNCTION obtener_total_alquileres(cliente_id INT) 
RETURNS INT AS $$
DECLARE
    total INT;
BEGIN
    SELECT COUNT(*) INTO total FROM contrato_alquiler WHERE contrato_alquiler.cliente_id = cliente_id;
    RETURN total;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION obtener_costo_total_alquiler(cliente_id INT) 
RETURNS NUMERIC AS $$
DECLARE
    total NUMERIC;
BEGIN
    SELECT SUM(precio_alquiler) INTO total FROM contrato_alquiler WHERE contrato_alquiler.cliente_id = cliente_id;
    RETURN total;
END;
$$ LANGUAGE plpgsql;