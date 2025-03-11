-- INICIO DE TRANSACCIÓN PARA GARANTIZAR ATOMICIDAD
BEGIN;

------------------------------- 1. INSERCIONES MASIVAS -------------------------------

-- Insertar datos en Cliente (5 registros)
INSERT INTO cliente(cliente_id, nombre, razon_social, cif_nif, direccion, telefono, email, tipo_cliente, historial_alquileres) 
VALUES 
(1, 'Juan Pérez', 'Constructora ABC', 'CIF12345678', 'Calle Falsa 123, Medellín', '123456789', 'juan.perez@example.com', 'empresa constructora', 'Excavadora - 2023-01-01'),
(2, 'María Gómez', NULL, 'NIF98765432', 'Avenida Siempre Viva 456, Bogotá', '987654321', 'maria.gomez@example.com', 'particular', 'Andamio - 2023-02-15'),
(3, 'Carlos López', 'Constructora XYZ', 'CIF23456789', 'Boulevard de los Sueños Rotos 789, Cali', '555555555', 'carlos.lopez@example.com', 'empresa constructora', 'Grúa - 2023-03-10'),
(4, 'Ana Martínez', NULL, 'NIF87654321', 'Calle del Sol 321, Barranquilla', '111111111', 'ana.martinez@example.com', 'particular', 'Herramientas manuales - 2023-04-20'),
(5, 'Luis Rodríguez', 'Constructora DEF', 'CIF34567890', 'Avenida de la Luna 654, Cartagena', '222222222', 'luis.rodriguez@example.com', 'empresa constructora', 'Excavadora - 2023-05-05');

-- Insertar datos en Equipo (5 registros)
INSERT INTO equipo(equipo_id, tipo, marca, modelo, año_fabricacion, numero_serie, estado, horas_uso, ubicacion_actual, historial_mantenimiento, certificaciones_seguridad) 
VALUES 
(1, 'Excavadora', 'Caterpillar', 'D6R', 2015, 'SERIE12345', 'disponible', 2000, 'Almacén Central', 'Mantenimiento preventivo - 2023-01-10', 'ISO 9001'),
(2, 'Grúa', 'Liebherr', 'LTM 1090', 2018, 'SERIE67890', 'alquilado', 1500, 'Obra Calle Mayor', 'Mantenimiento correctivo - 2023-02-15', 'ISO 9001'),
(3, 'Andamio', 'Scafom', 'X300', 2020, 'SERIE54321', 'disponible', 500, 'Almacén Norte', 'Mantenimiento preventivo - 2023-03-20', 'ISO 45001'),
(4, 'Herramientas manuales', 'Stanley', 'STHT72589', 2021, 'SERIE98765', 'en mantenimiento', 100, 'Taller Técnico', 'Reparación - 2023-04-01', 'ISO 9001'),
(5, 'Excavadora', 'Komatsu', 'PC200', 2017, 'SERIE11223', 'disponible', 2500, 'Almacén Sur', 'Mantenimiento preventivo - 2023-05-10', 'ISO 45001');

-- Insertar datos en Contrato de Alquiler (5 registros)
INSERT INTO contrato_alquiler(contrato_id, cliente_id, equipo_id, fecha_inicio, fecha_fin, lugar_entrega, lugar_recogida, precio_alquiler, condiciones_contrato, kilometraje_inicio, kilometraje_fin) 
VALUES 
(1, 1, 1, '2023-01-01', '2023-01-10', 'Almacén Central', 'Obra Calle Mayor', 1000.00, 'Contrato estándar', 2000, 2100),
(2, 2, 2, '2023-02-15', '2023-02-20', 'Almacén Norte', 'Obra Calle Mayor', 1500.00, 'Contrato premium', 1500, 1600),
(3, 3, 3, '2023-03-10', '2023-03-15', 'Almacén Central', 'Obra Calle Mayor', 500.00, 'Contrato básico', 500, 600),
(4, 4, 4, '2023-04-20', '2023-04-25', 'Almacén Sur', 'Obra Calle Mayor', 300.00, 'Contrato básico', 100, 200),
(5, 5, 5, '2023-05-05', '2023-05-10', 'Almacén Norte', 'Obra Calle Mayor', 1200.00, 'Contrato estándar', 2500, 2600);

-- Insertar datos en Mantenimiento (5 registros)
INSERT INTO mantenimiento(mantenimiento_id, equipo_id, tipo_mantenimiento, fecha_mantenimiento, taller_tecnico, descripcion_trabajo, costo_mantenimiento, proxima_fecha_mantenimiento) 
VALUES 
(1, 1, 'preventivo', '2023-01-10', 'Taller A', 'Revisión general', 200.00, '2023-07-10'),
(2, 2, 'correctivo', '2023-02-15', 'Taller B', 'Reparación motor', 500.00, '2023-08-15'),
(3, 3, 'preventivo', '2023-03-20', 'Taller C', 'Lubricación', 100.00, '2023-09-20'),
(4, 4, 'correctivo', '2023-04-01', 'Taller D', 'Reemplazo de piezas', 300.00, '2023-10-01'),
(5, 5, 'preventivo', '2023-05-10', 'Taller E', 'Inspección estructural', 150.00, '2023-11-10');

-- Insertar datos en Logística de Entrega y Recogida (5 registros)
INSERT INTO logistica_entrega_recogida(logistica_id, contrato_id, equipo_id, direccion_entrega, fecha_hora_entrega, direccion_recogida, fecha_hora_recogida, transportista_vehiculo) 
VALUES 
(1, 1, 1, 'Almacén Central', '2023-01-01 08:00:00', 'Obra Calle Mayor', '2023-01-10 18:00:00', 'Transportista A - Camión 1'),
(2, 2, 2, 'Almacén Norte', '2023-02-15 09:00:00', 'Obra Calle Mayor', '2023-02-20 17:00:00', 'Transportista B - Camión 2'),
(3, 3, 3, 'Almacén Central', '2023-03-10 10:00:00', 'Obra Calle Mayor', '2023-03-15 16:00:00', 'Transportista C - Camión 3'),
(4, 4, 4, 'Almacén Sur', '2023-04-20 11:00:00', 'Obra Calle Mayor', '2023-04-25 15:00:00', 'Transportista D - Camión 4'),
(5, 5, 5, 'Almacén Norte', '2023-05-05 12:00:00', 'Obra Calle Mayor', '2023-05-10 14:00:00', 'Transportista E - Camión 5');

-- Insertar datos en Facturación (5 registros)
INSERT INTO facturacion(factura_id, contrato_id, fecha_factura, importe, estado_factura) 
VALUES 
(1, 1, '2023-01-01', 1000.00, 'pagada'),
(2, 2, '2023-02-15', 1500.00, 'pendiente'),
(3, 3, '2023-03-10', 500.00, 'pagada'),
(4, 4, '2023-04-20', 300.00, 'pendiente'),
(5, 5, '2023-05-05', 1200.00, 'pagada');

-- Insertar datos en Seguimiento de Ubicación (5 registros)
INSERT INTO seguimiento_ubicacion(seguimiento_id, equipo_id, ubicacion_actual, fecha_hora_actualizacion) 
VALUES 
(1, 1, 'Almacén Central', '2023-01-01 08:00:00'),
(2, 2, 'Obra Calle Mayor', '2023-02-15 09:00:00'),
(3, 3, 'Almacén Norte', '2023-03-10 10:00:00'),
(4, 4, 'Taller Técnico', '2023-04-01 11:00:00'),
(5, 5, 'Almacén Sur', '2023-05-05 12:00:00');

-- Insertar datos en Comunicación (5 registros)
INSERT INTO comunicacion(comunicacion_id, cliente_id, tipo_comunicacion, fecha_hora_comunicacion, mensaje) 
VALUES 
(1, 1, 'email', '2023-01-01 10:00:00', 'Estimado cliente, su contrato de alquiler ha sido generado exitosamente.'),
(2, 2, 'SMS', '2023-02-15 11:00:00', 'Recordatorio: Su equipo será entregado mañana a las 8:00 AM.'),
(3, 3, 'llamada', '2023-03-10 14:00:00', 'Llamada realizada para confirmar la recogida del equipo.'),
(4, 4, 'email', '2023-04-20 09:30:00', 'Notificación: El mantenimiento de su equipo ha sido programado para la próxima semana.'),
(5, 5, 'SMS', '2023-05-05 16:00:00', 'Su factura está pendiente de pago. Por favor, regularice su situación.');

-- Insertar datos en Informes y Estadísticas (5 registros)
INSERT INTO informes_estadisticas(informe_id, tipo_informe, fecha_generacion, datos_informe, contrato_id) 
VALUES 
(1, 'alquileres por equipo', '2023-01-10', '{"equipo": "Excavadora", "total_alquileres": 5, "ingresos_totales": 5000}', 1),
(2, 'ingresos', '2023-02-20', '{"mes": "Febrero", "ingresos_totales": 7500, "gastos_totales": 2000}', 2),
(3, 'mantenimiento', '2023-03-15', '{"equipo": "Grúa", "costo_mantenimiento": 500, "fecha_ultimo_mantenimiento": "2023-03-10"}', 3),
(4, 'disponibilidad', '2023-04-25', '{"equipos_disponibles": 10, "equipos_alquilados": 5, "equipos_en_mantenimiento": 2}', NULL),
(5, 'alquileres por cliente', '2023-05-10', '{"cliente": "Constructora ABC", "total_alquileres": 3, "ingresos_totales": 3000}', 5);

-- Insertar datos en Funcionalidades Avanzadas (5 registros)
INSERT INTO funcionalidades_avanzadas(funcionalidad_id, tipo_funcionalidad, descripcion, configuracion, equipo_id) 
VALUES 
(1, 'WMS', 'Integración con sistema de gestión de almacenes', '{"almacen_principal": "Almacén Central", "capacidad_maxima": 50}', 1),
(2, 'seguros', 'Gestión de seguros para equipos', '{"poliza": "Poliza123", "vigencia": "2023-12-31"}', 2),
(3, 'control de acceso', 'Control de acceso mediante tarjetas RFID', '{"tarjeta_rfid": "RFID456", "usuario_autorizado": "Juan Pérez"}', 3),
(4, 'app móvil', 'Aplicación móvil para clientes', '{"version": "1.0", "funcionalidades": ["reserva", "seguimiento"]}', 4),
(5, 'plataforma de pago', 'Integración con plataforma de pago online', '{"proveedor": "PayPal", "comision": 2.5}', 5);

-- Finalizar transacción
COMMIT;