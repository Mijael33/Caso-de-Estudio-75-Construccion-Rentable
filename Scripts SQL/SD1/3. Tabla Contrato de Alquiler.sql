-- Creación de la tabla Contrato de Alquiler
CREATE TABLE contrato_alquiler (
    contrato_id SERIAL PRIMARY KEY, -- Identificador único del contrato (clave primaria)
    cliente_id INT REFERENCES cliente(cliente_id), -- Clave foránea: Relación con la tabla Cliente
    equipo_id INT REFERENCES equipo(equipo_id), -- Clave foránea: Relación con la tabla Equipo
    fecha_inicio DATE NOT NULL, -- Fecha de inicio del alquiler
    fecha_fin DATE NOT NULL CHECK (fecha_fin >= fecha_inicio), -- Fecha de fin del alquiler (debe ser mayor o igual a la fecha de inicio)
    lugar_entrega VARCHAR(100), -- Lugar de entrega del equipo
    lugar_recogida VARCHAR(100), -- Lugar de recogida del equipo
    precio_alquiler NUMERIC(10, 2) NOT NULL CHECK (precio_alquiler >= 0), -- Precio del alquiler (no puede ser negativo)
    condiciones_contrato TEXT, -- Condiciones específicas del contrato
    kilometraje_inicio INT CHECK (kilometraje_inicio >= 0), -- Kilometraje/horas de uso al inicio del alquiler (no puede ser negativo)
    kilometraje_fin INT CHECK (kilometraje_fin >= kilometraje_inicio) -- Kilometraje/horas de uso al final del alquiler (debe ser mayor o igual al inicial)
);

-- Índices para optimizar búsquedas por cliente y equipo
CREATE INDEX idx_contrato_cliente ON contrato_alquiler(cliente_id);
CREATE INDEX idx_contrato_equipo ON contrato_alquiler(equipo_id);

-- Vista simplificada de la tabla Contrato de Alquiler
CREATE VIEW Vista_Contratos AS
SELECT
    contrato_id,
    cliente_id,
    equipo_id,
    fecha_inicio,
    fecha_fin,
    precio_alquiler
FROM
    contrato_alquiler;