-- Creación de la tabla Logística de Entrega y Recogida
CREATE TABLE logistica_entrega_recogida (
    logistica_id SERIAL PRIMARY KEY, -- Identificador único de la logística (clave primaria)
    contrato_id INT UNIQUE REFERENCES contrato_alquiler(contrato_id), -- Clave foránea: Relación con la tabla Contrato de Alquiler (única)
    equipo_id INT REFERENCES equipo(equipo_id), -- Clave foránea: Relación con la tabla Equipo
    direccion_entrega VARCHAR(100), -- Dirección de entrega del equipo
    fecha_hora_entrega TIMESTAMP, -- Fecha y hora de entrega
    direccion_recogida VARCHAR(100), -- Dirección de recogida del equipo
    fecha_hora_recogida TIMESTAMP CHECK (fecha_hora_recogida >= fecha_hora_entrega), -- Fecha y hora de recogida (debe ser mayor o igual a la de entrega)
    transportista_vehiculo VARCHAR(100) -- Transportista o vehículo utilizado
);

-- Índices para optimizar búsquedas por contrato y equipo
CREATE INDEX idx_logistica_contrato ON logistica_entrega_recogida(contrato_id);
CREATE INDEX idx_logistica_equipo ON logistica_entrega_recogida(equipo_id);

-- Vista simplificada de la tabla Logística de Entrega y Recogida
CREATE VIEW Vista_Logistica AS
SELECT
    logistica_id,
    contrato_id,
    equipo_id,
    direccion_entrega,
    fecha_hora_entrega,
    direccion_recogida,
    fecha_hora_recogida
FROM
    logistica_entrega_recogida;