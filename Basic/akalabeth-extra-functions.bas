
62400 REM FUNCTION DEBUG - DISPLAY TERRAIN
62410 FOR X = 1 TO 19
62420  FOR Y = 1 TO 19
62430   PRINT TE%(X,Y);
62440  NEXT Y:
62450  PRINT
62460 NEXT X
62470 RETURN

62500 REM FUCNTION DEBUG - DISPLAY DUNGEON
62501 REM DUNGEON USABLE IS 1 TO 9. WALLS ARE 0 AND 10
62510 FOR X = 0 TO 10
62520  FOR Y = 0 TO 10
62530   PRINT DNG%(X,Y);
62540  NEXT Y
62550  PRINT
62560 NEXT X
62570 RETURN 
