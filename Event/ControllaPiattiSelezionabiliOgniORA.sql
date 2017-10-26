CREATE EVENT ControllaPiattiSelezionabili 
ON SCHEDULE EVERY 1 hour
ON COMPLETION PRESERVE
DO

CALL  ControllaPiattiMenu ();

