DROP EVENT IF EXISTS AggiornaMV_FornituraAutoMagazzino;
CREATE EVENT AggiornaMV_FornituraAutoMagazzino
ON SCHEDULE EVERY 7 DAY
ON completion PRESERVE
DO
CALL AggiornaOrdinativi();

