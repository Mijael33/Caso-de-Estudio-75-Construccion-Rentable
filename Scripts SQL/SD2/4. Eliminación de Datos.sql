-- INICIO DE TRANSACCIÓN PARA GARANTIZAR ATOMICIDAD
BEGIN;

------------------------------- 1. ELIMINACIÓN DE DATOS -------------------------------

-- 1. Eliminar registros en Funcionalidades Avanzadas vinculados a equipos sin contratos activos
DELETE FROM funcionalidades_avanzadas 
WHERE equipo_id NOT IN (
    SELECT DISTINCT equipo_id 
    FROM contrato_alquiler 
    WHERE fecha_fin > CURRENT_DATE
);

-- 2. Eliminar informes y estadísticas asociados a contratos finalizados
DELETE FROM informes_estadisticas 
WHERE contrato_id IN (
    SELECT contrato_id 
    FROM contrato_alquiler 
    WHERE fecha_fin < CURRENT_DATE
);

-- 3. Eliminar comunicaciones antiguas (más de 6 meses)
DELETE FROM comunicacion 
WHERE fecha_hora_comunicacion < CURRENT_DATE - INTERVAL '6 months';

-- 4. Eliminar seguimientos de ubicación de equipos desechados o eliminados
DELETE FROM seguimiento_ubicacion 
WHERE equipo_id IN (
    SELECT equipo_id 
    FROM equipo 
    WHERE estado = 'desechado'
);

-- 5. Eliminar facturas pendientes de más de 30 días
DELETE FROM facturacion 
WHERE estado_factura = 'pendiente' 
AND fecha_factura < CURRENT_DATE - INTERVAL '30 days';

-- 6. Eliminar registros de logística asociados a contratos cancelados
DELETE FROM logistica_entrega_recogida 
WHERE contrato_id IN (
    SELECT contrato_id 
    FROM contrato_alquiler 
    WHERE condiciones_contrato LIKE '%cancelado%'
);

-- 7. Eliminar mantenimientos programados para equipos desechados
DELETE FROM mantenimiento 
WHERE equipo_id IN (
    SELECT equipo_id 
    FROM equipo 
    WHERE estado = 'desechado'
);

-- 8. Eliminar contratos de alquiler finalizados hace más de un año
DELETE FROM contrato_alquiler 
WHERE fecha_fin < CURRENT_DATE - INTERVAL '1 year';

-- 9. Eliminar equipos marcados como desechados
DELETE FROM equipo 
WHERE estado = 'desechado';

-- 10. Eliminar clientes sin actividad reciente (sin contratos en los últimos 2 años)
DELETE FROM cliente 
WHERE cliente_id NOT IN (
    SELECT DISTINCT cliente_id 
    FROM contrato_alquiler 
    WHERE fecha_inicio > CURRENT_DATE - INTERVAL '2 years'
);

-- FINALIZAR TRANSACCIÓN
COMMIT;