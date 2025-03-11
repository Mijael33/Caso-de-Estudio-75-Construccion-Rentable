-- INICIO DE TRANSACCIÓN PARA GARANTIZAR ATOMICIDAD
BEGIN;

------------------------------- 1. ACTUALIZACIÓN DE DATOS -------------------------------

-- 1. Actualizar el correo electrónico de un cliente específico
UPDATE cliente 
SET email = 'nuevo.juan.perez@example.com' 
WHERE cliente_id = 1;

-- 2. Actualizar el estado de un equipo a "alquilado"
UPDATE equipo 
SET estado = 'alquilado' 
WHERE equipo_id = 3;

-- 3. Actualizar el precio de alquiler de un contrato específico
UPDATE contrato_alquiler 
SET precio_alquiler = 1200.00 
WHERE contrato_id = 2;

-- 4. Actualizar la descripción de un mantenimiento realizado
UPDATE mantenimiento 
SET descripcion_trabajo = 'Revisión completa del motor y sistema hidráulico' 
WHERE mantenimiento_id = 2;

-- 5. Actualizar la dirección de entrega de una logística
UPDATE logistica_entrega_recogida 
SET direccion_entrega = 'Nueva Dirección de Entrega, Calle Nueva 123' 
WHERE logistica_id = 4;

-- 6. Marcar una factura como pagada
UPDATE facturacion 
SET estado_factura = 'pagada' 
WHERE factura_id = 4;

-- 7. Actualizar la ubicación actual de un equipo en seguimiento
UPDATE seguimiento_ubicacion 
SET ubicacion_actual = 'Obra Nueva', fecha_hora_actualizacion = CURRENT_TIMESTAMP 
WHERE seguimiento_id = 5;

-- 8. Actualizar el mensaje de una comunicación
UPDATE comunicacion 
SET mensaje = 'Estimado cliente, su equipo ha sido entregado exitosamente.' 
WHERE comunicacion_id = 2;

-- 9. Actualizar los datos de un informe estadístico
UPDATE informes_estadisticas 
SET datos_informe = '{"mes": "Mayo", "ingresos_totales": 8000, "gastos_totales": 3000}'::jsonb 
WHERE informe_id = 2;

-- 10. Actualizar la configuración de una funcionalidad avanzada
UPDATE funcionalidades_avanzadas 
SET configuracion = '{"almacen_principal": "Almacén Norte", "capacidad_maxima": 75}'::jsonb 
WHERE funcionalidad_id = 1;

----------------------------------------- 2. VALIDACIÓN DE DATOS POST-ACTUALIZACIÓN -----------------------------------------

-- Verificar que los emails siguen siendo únicos (evitar duplicados)
SELECT email, COUNT(*) AS duplicados 
FROM cliente 
GROUP BY email 
HAVING COUNT(*) > 1;

-- Verificar que los estados de los equipos son válidos
SELECT equipo_id, estado 
FROM equipo 
WHERE estado NOT IN ('disponible', 'alquilado', 'en mantenimiento');

-- Verificar que los precios de alquiler son positivos
SELECT contrato_id, precio_alquiler 
FROM contrato_alquiler 
WHERE precio_alquiler <= 0;

-- Verificar que las fechas de facturación son coherentes
SELECT factura_id, fecha_factura 
FROM facturacion 
WHERE fecha_factura > CURRENT_DATE;

-- Verificar que las ubicaciones de seguimiento no están vacías
SELECT seguimiento_id, ubicacion_actual 
FROM seguimiento_ubicacion 
WHERE ubicacion_actual IS NULL OR ubicacion_actual = '';

-- Finalizar transacción
COMMIT;