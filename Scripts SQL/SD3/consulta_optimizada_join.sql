EXPLAIN ANALYZE
SELECT cl.nombre, co.contrato_id, eq.tipo, co.fecha_inicio, co.fecha_fin
FROM cliente cl
JOIN contrato_alquiler co ON cl.cliente_id = co.cliente_id
JOIN equipo eq ON co.equipo_id = eq.equipo_id
WHERE co.fecha_inicio >= '2024-01-01';