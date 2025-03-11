-- Creación de la tabla Mantenimiento
CREATE TABLE mantenimiento (
    mantenimiento_id SERIAL PRIMARY KEY, -- Identificador único del mantenimiento (clave primaria)
    equipo_id INT REFERENCES equipo(equipo_id), -- Clave foránea: Relación con la tabla Equipo
    tipo_mantenimiento VARCHAR(50) NOT NULL CHECK (tipo_mantenimiento IN ('preventivo', 'correctivo')), -- Tipo de mantenimiento (preventivo o correctivo)
    fecha_mantenimiento DATE NOT NULL, -- Fecha del mantenimiento
    taller_tecnico VARCHAR(100), -- Taller o técnico responsable
    descripcion_trabajo TEXT, -- Descripción del trabajo realizado
    costo_mantenimiento NUMERIC(10, 2) CHECK (costo_mantenimiento >= 0), -- Costo del mantenimiento (no puede ser negativo)
    proxima_fecha_mantenimiento DATE -- Fecha estimada del próximo mantenimiento
);

-- Índice para optimizar búsquedas por equipo
CREATE INDEX idx_mantenimiento_equipo ON mantenimiento(equipo_id);

-- Vista simplificada de la tabla Mantenimiento
CREATE VIEW Vista_Mantenimientos AS
SELECT
    mantenimiento_id,
    equipo_id,
    tipo_mantenimiento,
    fecha_mantenimiento,
    costo_mantenimiento
FROM
    mantenimiento;