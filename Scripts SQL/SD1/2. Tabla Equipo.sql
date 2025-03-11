-- Creación de la tabla Equipo
CREATE TABLE equipo (
    equipo_id SERIAL PRIMARY KEY, -- Identificador único del equipo (clave primaria)
    tipo VARCHAR(50) NOT NULL, -- Tipo de equipo (excavadora, grúa, etc.)
    marca VARCHAR(50) NOT NULL, -- Marca del equipo
    modelo VARCHAR(50) NOT NULL, -- Modelo del equipo
    año_fabricacion INT NOT NULL, -- Año de fabricación del equipo
    numero_serie VARCHAR(50) UNIQUE NOT NULL, -- Número de serie del equipo (único y obligatorio)
    estado VARCHAR(20) NOT NULL CHECK (estado IN ('disponible', 'alquilado', 'en mantenimiento')), -- Estado del equipo
    horas_uso INT CHECK (horas_uso >= 0), -- Horas de uso acumuladas (no puede ser negativo)
    ubicacion_actual VARCHAR(100), -- Ubicación actual del equipo
    historial_mantenimiento TEXT, -- Historial de mantenimientos realizados
    certificaciones_seguridad TEXT -- Certificaciones de seguridad del equipo
);

-- Índices para optimizar búsquedas por estado y número de serie
CREATE INDEX idx_equipo_estado ON equipo(estado);
CREATE INDEX idx_equipo_numero_serie ON equipo(numero_serie);

-- Vista simplificada de la tabla Equipo
CREATE VIEW Vista_Equipos AS
SELECT
    equipo_id,
    tipo,
    marca,
    modelo,
    estado,
    ubicacion_actual
FROM
    equipo;