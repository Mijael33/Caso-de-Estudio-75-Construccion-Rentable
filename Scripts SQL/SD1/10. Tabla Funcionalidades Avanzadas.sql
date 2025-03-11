-- Creación de la tabla Funcionalidades Avanzadas
CREATE TABLE funcionalidades_avanzadas (
    funcionalidad_id SERIAL PRIMARY KEY, -- Identificador único de la funcionalidad (clave primaria)
    tipo_funcionalidad VARCHAR(50) NOT NULL CHECK (tipo_funcionalidad IN ('WMS', 'seguros', 'control de acceso', 'app móvil')), -- Tipo de funcionalidad (WMS, seguros, etc.)
    descripcion TEXT, -- Descripción de la funcionalidad
    configuracion JSONB, -- Configuración de la funcionalidad en formato JSON
    equipo_id INT REFERENCES equipo(equipo_id) -- Clave foránea: Relación con la tabla Equipo
);

-- Índice para optimizar búsquedas por equipo
CREATE INDEX idx_funcionalidades_equipo ON funcionalidades_avanzadas(equipo_id);

-- Vista simplificada de la tabla Funcionalidades Avanzadas
CREATE VIEW Vista_Funcionalidades_Avanzadas AS
SELECT
    funcionalidad_id,
    tipo_funcionalidad,
    descripcion,
    equipo_id
FROM
    funcionalidades_avanzadas;