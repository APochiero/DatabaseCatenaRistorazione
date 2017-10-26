DROP EVENT IF EXISTS MagazzinoIntelligenteEvent;
CREATE EVENT MagazzinoIntelligenteEvent
ON SCHEDULE EVERY 14 day
ON completion preserve

DO

CALL MagazzinoIntelligente ();