-- Creación de la tabla Cliente
CREATE TABLE cliente (
    cliente_id SERIAL PRIMARY KEY, -- Identificador único del cliente (clave primaria)
    nombre VARCHAR(100) NOT NULL, -- Nombre del cliente
    razon_social VARCHAR(100), -- Razón social (en caso de ser una empresa)
    cif_nif VARCHAR(20) UNIQUE NOT NULL, -- CIF/NIF del cliente (único y obligatorio)
    direccion VARCHAR(200), -- Dirección del cliente
    telefono VARCHAR(15), -- Teléfono de contacto
    email VARCHAR(100), -- Correo electrónico
    tipo_cliente VARCHAR(50) CHECK (tipo_cliente IN ('empresa constructora', 'particular')), -- Tipo de cliente (empresa o particular)
    historial_alquileres TEXT -- Historial de alquileres del cliente
);

-- Índice para optimizar búsquedas por CIF/NIF
CREATE INDEX idx_cliente_cif_nif ON cliente(cif_nif);

-- Vista simplificada de la tabla Cliente
CREATE VIEW Vista_Clientes AS
SELECT
    cliente_id,
    nombre,
    razon_social,
    cif_nif,
    email,
    tipo_cliente
FROM
    cliente;