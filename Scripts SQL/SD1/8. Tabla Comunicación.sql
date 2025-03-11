-- Creación de la tabla Comunicación
CREATE TABLE comunicacion (
    comunicacion_id SERIAL PRIMARY KEY, -- Identificador único de la comunicación (clave primaria)
    cliente_id INT REFERENCES cliente(cliente_id), -- Clave foránea: Relación con la tabla Cliente
    tipo_comunicacion VARCHAR(50) CHECK (tipo_comunicacion IN ('email', 'SMS', 'llamada')), -- Tipo de comunicación (email, SMS o llamada)
    fecha_hora_comunicacion TIMESTAMP CHECK (fecha_hora_comunicacion <= CURRENT_TIMESTAMP), -- Fecha y hora de la comunicación (no puede ser futura)
    mensaje TEXT -- Contenido del mensaje
);

-- Índice para optimizar búsquedas por cliente
CREATE INDEX idx_comunicacion_cliente ON comunicacion(cliente_id);

-- Vista simplificada de la tabla Comunicación
CREATE VIEW Vista_Comunicaciones AS
SELECT
    comunicacion_id,
    cliente_id,
    tipo_comunicacion,
    fecha_hora_comunicacion,
    mensaje
FROM
    comunicacion;