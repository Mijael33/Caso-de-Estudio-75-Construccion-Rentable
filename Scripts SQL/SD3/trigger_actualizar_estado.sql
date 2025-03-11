CREATE OR REPLACE FUNCTION actualizar_estado_equipo() 
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.fecha_fin < CURRENT_DATE THEN
        UPDATE equipo SET estado = 'disponible' WHERE equipo_id = NEW.equipo_id;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_actualizar_estado_equipo
AFTER UPDATE ON contrato_alquiler
FOR EACH ROW EXECUTE FUNCTION actualizar_estado_equipo();