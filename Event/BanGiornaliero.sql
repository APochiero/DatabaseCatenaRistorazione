DROP EVENT IF EXISTS ControllaPresenza;

CREATE EVENT ControllaPresenza
ON SCHEDULE EVERY 1 DAY
STARTS '2015-09-04 04:00:00'
ON COMPLETION PRESERVE

DO

CALL ModificaBan();








