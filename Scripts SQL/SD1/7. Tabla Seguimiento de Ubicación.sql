-- Creación de la tabla Seguimiento de Ubicación
CREATE TABLE seguimiento_ubicacion (
    seguimiento_id SERIAL PRIMARY KEY, -- Identificador único del seguimiento (clave primaria)
    equipo_id INT REFERENCES equipo(equipo_id), -- Clave foránea: Relación con la tabla Equipo
    ubicacion_actual VARCHAR(100), -- Ubicación actual del equipo
    fecha_hora_actualizacion TIMESTAMP CHECK (fecha_hora_actualizacion <= CURRENT_TIMESTAMP) -- Fecha y hora de la última actualización (no puede ser futura)
);

-- Índice para optimizar búsquedas por equipo
CREATE INDEX idx_seguimiento_equipo ON seguimiento_ubicacion(equipo_id);

-- Vista simplificada de la tabla Seguimiento de Ubicación
CREATE VIEW Vista_Seguimiento_Ubicacion AS
SELECT
    seguimiento_id,
    equipo_id,
    ubicacion_actual,
    fecha_hora_actualizacion
FROM
    seguimiento_ubicacion;