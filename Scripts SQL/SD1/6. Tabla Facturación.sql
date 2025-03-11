-- Creación de la tabla Facturación
CREATE TABLE facturacion (
    factura_id SERIAL PRIMARY KEY, -- Identificador único de la factura (clave primaria)
    contrato_id INT REFERENCES contrato_alquiler(contrato_id), -- Clave foránea: Relación con la tabla Contrato de Alquiler
    fecha_factura DATE NOT NULL, -- Fecha de emisión de la factura
    importe NUMERIC(10, 2) NOT NULL CHECK (importe >= 0), -- Importe total de la factura (no puede ser negativo)
    estado_factura VARCHAR(20) CHECK (estado_factura IN ('pagada', 'pendiente')) -- Estado de la factura (pagada o pendiente)
);

-- Índice para optimizar búsquedas por contrato
CREATE INDEX idx_facturacion_contrato ON facturacion(contrato_id);

-- Vista simplificada de la tabla Facturación
CREATE VIEW Vista_Facturas AS
SELECT
    factura_id,
    contrato_id,
    fecha_factura,
    importe,
    estado_factura
FROM
    facturacion;