-- 1. Recuperar todos los clientes que pertenecen a una empresa constructora
SELECT cliente_id, nombre, razon_social, cif_nif, email 
FROM cliente 
WHERE tipo_cliente = 'empresa constructora';

-- 2. Ordenar equipos por marca y modelo
SELECT equipo_id, tipo, marca, modelo, estado, ubicacion_actual 
FROM equipo 
ORDER BY marca ASC, modelo ASC;

-- 3. Contar el número de contratos por cliente
SELECT cliente_id, COUNT(contrato_id) AS total_contratos 
FROM contrato_alquiler 
GROUP BY cliente_id;

-- 4. Sumar el total de ingresos generados por alquileres
SELECT SUM(precio_alquiler) AS ingresos_totales 
FROM contrato_alquiler;

-- 5. Clientes con más de un contrato (usando HAVING)
SELECT cliente_id, COUNT(contrato_id) AS total_contratos 
FROM contrato_alquiler 
GROUP BY cliente_id 
HAVING COUNT(contrato_id) > 1;

-- 6. Número total de equipos disponibles
SELECT COUNT(equipo_id) AS equipos_disponibles 
FROM equipo 
WHERE estado = 'disponible';

-- 7. Equipos con más de 1000 horas de uso
SELECT equipo_id, tipo, marca, modelo, horas_uso 
FROM equipo 
WHERE horas_uso > 1000;

-- 8. Promedio de costo de mantenimiento por tipo de mantenimiento
SELECT tipo_mantenimiento, AVG(costo_mantenimiento) AS costo_promedio 
FROM mantenimiento 
GROUP BY tipo_mantenimiento;

-- 9. Facturas pendientes de pago
SELECT factura_id, contrato_id, fecha_factura, importe 
FROM facturacion 
WHERE estado_factura = 'pendiente';

-- 10. Equipos entregados en una dirección específica
SELECT logistica_id, equipo_id, direccion_entrega, fecha_hora_entrega 
FROM logistica_entrega_recogida 
WHERE direccion_entrega = 'Calle Principal 123';

-- 11. Comunicaciones enviadas a un cliente específico
SELECT comunicacion_id, tipo_comunicacion, fecha_hora_comunicacion, mensaje 
FROM comunicacion 
WHERE cliente_id = 1;

-- 12. Informes generados en un mes específico
SELECT informe_id, tipo_informe, fecha_generacion, datos_informe 
FROM informes_estadisticas 
WHERE EXTRACT(MONTH FROM fecha_generacion) = 10;

-- 13. Máximo y mínimo de horas de uso de los equipos
SELECT MAX(horas_uso) AS horas_maximas, MIN(horas_uso) AS horas_minimas 
FROM equipo;

-- 14. Equipos con certificaciones de seguridad específicas
SELECT equipo_id, tipo, marca, modelo, certificaciones_seguridad 
FROM equipo 
WHERE certificaciones_seguridad LIKE '%ISO 9001%';

-- 15. Funcionalidades avanzadas asociadas a un equipo específico
SELECT funcionalidad_id, tipo_funcionalidad, descripcion, configuracion 
FROM funcionalidades_avanzadas 
WHERE equipo_id = 5;