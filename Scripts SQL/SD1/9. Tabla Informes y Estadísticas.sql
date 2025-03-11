-- Creación de la tabla Informes y Estadísticas
CREATE TABLE informes_estadisticas (
    informe_id SERIAL PRIMARY KEY, -- Identificador único del informe (clave primaria)
    tipo_informe VARCHAR(50) NOT NULL, -- Tipo de informe (alquileres, ingresos, etc.)
    fecha_generacion DATE NOT NULL CHECK (fecha_generacion <= CURRENT_DATE), -- Fecha de generación del informe (no puede ser futura)
    datos_informe JSONB, -- Datos del informe en formato JSON
    contrato_id INT REFERENCES contrato_alquiler(contrato_id) -- Clave foránea: Relación con la tabla Contrato de Alquiler
);

-- Índice para optimizar búsquedas por contrato
CREATE INDEX idx_informes_contrato ON informes_estadisticas(contrato_id);

-- Vista simplificada de la tabla Informes y Estadísticas
CREATE VIEW Vista_informes AS
SELECT
    informe_id,
    tipo_informe,
    fecha_generacion,
    contrato_id
FROM
    informes_estadisticas;