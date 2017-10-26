DROP EVENT IF EXISTS AggiornaAnalisiMultimedialeBusiness;
CREATE EVENT AggiornaAnalisiMultimedialeBusiness
ON SCHEDULE EVERY 7 DAY
ON completion PRESERVE
DO
CALL VenditeGlobaliPiatti ();

