-- 1. CONSULTAS CON UNIONES (JOIN)

-- 1.1 INNER JOIN: Clientes con sus contratos de alquiler
SELECT 
    c.cliente_id,
    c.nombre AS nombre_cliente,
    c.razon_social,
    ca.contrato_id,
    ca.fecha_inicio,
    ca.fecha_fin,
    ca.precio_alquiler
FROM 
    cliente c
INNER JOIN 
    contrato_alquiler ca 
ON 
    c.cliente_id = ca.cliente_id;

-- 1.2 LEFT JOIN: Equipos con su historial de mantenimiento
SELECT 
    e.equipo_id,
    e.tipo AS tipo_equipo,
    e.marca,
    e.modelo,
    m.mantenimiento_id,
    m.fecha_mantenimiento,
    m.tipo_mantenimiento,
    m.costo_mantenimiento
FROM 
    equipo e
LEFT JOIN 
    mantenimiento m 
ON 
    e.equipo_id = m.equipo_id;

-- 1.3 RIGHT JOIN: Proveedores con materiales (incluyendo materiales sin proveedor)
SELECT 
    m.material_id,
    m.nombre AS material,
    p.proveedor_id,
    p.nombre AS proveedor
FROM 
    materiales m
RIGHT JOIN 
    proveedores p 
ON 
    m.material_id = p.material_id;

-- 1.4 INNER JOIN + Agregación: Total gastado por cliente en alquileres
SELECT 
    c.cliente_id,
    c.nombre,
    c.razon_social,
    SUM(ca.precio_alquiler) AS total_gastado
FROM 
    cliente c
INNER JOIN 
    contrato_alquiler ca 
ON 
    c.cliente_id = ca.cliente_id
GROUP BY 
    c.cliente_id;

-- 2. CONSULTAS CON SUBCONSULTAS

-- 2.1 Subconsulta WHERE: Clientes con más contratos que el promedio
SELECT 
    cliente_id,
    nombre,
    razon_social
FROM 
    cliente
WHERE 
    cliente_id IN (
        SELECT 
            cliente_id
        FROM 
            contrato_alquiler
        GROUP BY 
            cliente_id
        HAVING 
            COUNT(*) > (
                SELECT 
                    AVG(total_contratos)
                FROM (
                    SELECT 
                        COUNT(*) AS total_contratos
                    FROM 
                        contrato_alquiler
                    GROUP BY 
                        cliente_id
                ) AS avg_contratos
            )
    );

-- 2.2 Subconsulta FROM + JOIN: Equipos con mantenimientos costosos
SELECT 
    e.equipo_id,
    e.tipo,
    e.marca,
    m.costo_mantenimiento
FROM 
    equipo e
INNER JOIN (
    SELECT 
        equipo_id,
        costo_mantenimiento
    FROM 
        mantenimiento
    WHERE 
        costo_mantenimiento > 500
) m 
ON 
    e.equipo_id = m.equipo_id;

-- 2.3 Expresión correlacionada: Equipos con seguimiento reciente
SELECT 
    e.equipo_id,
    e.tipo,
    e.marca
FROM 
    equipo e
WHERE 
    EXISTS (
        SELECT 
            1
        FROM 
            seguimiento_ubicacion su
        WHERE 
            su.equipo_id = e.equipo_id
            AND su.fecha_hora_actualizacion > NOW() - INTERVAL '7 days'
    );

-- 3. VISTAS MATERIALIZADAS

-- 3.1 Vista de clientes con contratos activos
CREATE MATERIALIZED VIEW vista_clientes_activos AS
SELECT 
    c.cliente_id,
    c.nombre,
    c.razon_social,
    COUNT(ca.contrato_id) AS total_contratos_activos
FROM 
    cliente c
LEFT JOIN 
    contrato_alquiler ca 
ON 
    c.cliente_id = ca.cliente_id
WHERE 
    ca.fecha_fin > CURRENT_DATE
GROUP BY 
    c.cliente_id;

-- 3.2 Vista de equipos con mantenimientos programados
CREATE MATERIALIZED VIEW vista_equipos_mantenimiento AS
SELECT 
    e.equipo_id,
    e.tipo,
    e.marca,
    e.modelo,
    m.proxima_fecha_mantenimiento
FROM 
    equipo e
INNER JOIN 
    mantenimiento m 
ON 
    e.equipo_id = m.equipo_id
WHERE 
    m.proxima_fecha_mantenimiento > CURRENT_DATE;

-- 3.3 Vista de facturación pendiente por contrato
CREATE MATERIALIZED VIEW vista_facturacion_pendiente AS
SELECT 
    f.factura_id,
    f.contrato_id,
    f.importe,
    f.estado_factura
FROM 
    facturacion f
WHERE 
    f.estado_factura = 'pendiente';