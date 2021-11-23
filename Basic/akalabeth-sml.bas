0 ONERR  GOTO 40
1 REM AKALABETH BY RICHARD GARRIOTT
2 REM PORTED TO COMMANDER X16 BY JUSTIN BALDOCK
4 REM PR# 0: IN# 0
5 CLS: SCREEN($80)
7 GOSUB 60000
8 ZZ =  RND ( -  ABS (LN))
9 LEVEL = 0
100 CLS: VTAB=11: GOSUB 62000
120 PRINT "  WELCOME TO AKALABETH, WORLD OF DOOM!"
200 DIM DN%(10,10),TE%(20,20),XX%(10),YY%(10),PER%(10,3),LD%(10,5)
250 DIM CD%(10,3),FT%(10,5),LAD%(10,3)
290 REM RANDOMNIZE THE TERRAIN MAP
300 FOR X = 0 TO 20
310  TE%(X,0)=1: TE%(0,X)=1: TE%(X,20)=1: TE%(20,X)=1
320 NEXT X
350 VTAB=23: GOSUB 62000: PRINT "  (PLEASE WAIT)";
390 REM RANDOMIZE THE INSIDE OF 19 X 19 TERRAIN TILES
400 FOR X = 1 TO 19
401  FOR Y = 1 TO 19
402   TE%(X,Y) = INT (RND(1) ^ 5 * 4.5)
410   IF TE%(X,Y) = 3 AND  RND (1)>.5 THEN TE%(X,Y) = 0
420  NEXT Y:
421  PRINT ".";
430 NEXT X
490 REM PICK RANDOM PLACE LORD BRITISH CASTLE 
500 TE%(INT(RND(1)*19+1),INT(RND(1)*19+1))=5
501 REM PICK RANDOM PLACE FOR TOWN/SHOP
505 TX=INT(RND(1)*19+1):TY=INT(RND(1)*19+1):TE%(TX,TY)=3
510 XX%(0) = 139:YY%(0) = 79
520 FOR X = 2 TO 20 STEP 2
521  XX%(X / 2) =  INT ( ATN (1 / X) /  ATN (1) * 140 + .5)
522  YY%(X / 2) =  INT (XX%(X / 2) * 4 / 7)
530  PER%(X / 2,0) = 139 - XX%(X / 2):PER%(X / 2,1) = 139 + XX%(X / 2)
531  PER%(X / 2,2) = 79 - YY%(X / 2):PER%(X / 2,3) = 79 + YY%(X / 2)
532 NEXT X 
540 PER%(0,0) = 0:PER%(0,1) = 279:PER%(0,2) = 0:PE%(0,3) = 159
550 FOR X = 1 TO 10
551  CD%(X,0) = 139 - XX%(X) / 3:CD%(X,1) = 139 + XX%(X) / 3
552  CD%(X,2) = 79 - YY%(X) * .7:CD%(X,3) = 79 + YY%(X)
553 NEXT X
554 PRINT ".";
560 FOR X = 0 TO 9
561  LD%(X,0) = (PER%(X,0) * 2 + PER%(X + 1,0)) / 3
562  LD%(X,1) = (PER%(X,0) + 2 * PER%(X + 1,0)) / 3:W = LD%(X,0) - PE%(X,0)
570  LD%(X,2) = PE%(X,2) + W * 4 / 7:LD%(X,3) = PER%(X,2) + 2 * W * 4 / 7
571  LD%(X,4) = (PE%(X,3) * 2 + PE%(X + 1,3)) / 3
572  LD%(X,5) = (PE%(X,3) + 2 * PE%(X + 1,3)) / 3
580  LD%(X,2) = LD%(X,4) - (LD%(X,4) - LD%(X,2)) * .8
581  LD%(X,3) = LD%(X,5) - (LD%(X,5) - LD%(X,3)) * .8
582  IF LD%(X,3) = LD%(X,4) THEN LD%(X,3) = LD%(X,3) - 1
590 NEXT X 
600 FOR X = 0 TO 9
601  FT%(X,0) = 139 - XX%(X) / 3:FT%(X,1) = 139 + XX%(X) / 3
602  FT%(X,2) = 139 - XX%(X + 1) / 3:FT%(X,3) = 139 + XX%(X + 1) / 3
610  FT%(X,4) = 79 + (YY%(X) * 2 + YY%(X + 1)) / 3
611  FT%(X,5) = 79 + (YY%(X)+ 2 * YY%(X + 1)) / 3
612 NEXT X
620 FOR X = 0 TO 9
621  LAD%(X,0) = (FT%(X,0) * 2 + FT%(X,1)) / 3
622  LAD%(X,1) = (FT%(X,0) + 2 * FT%(X,1)) / 3:LAD%(X,3) = FT%(X,4)
623  LAD%(X,2) = 159 - LAD%(X,3)
624 NEXT X 
680 CLS: HC%=3: REM HC% = HCOLOR WHICH WAS FUNCTION USED IN APPLESOFT
690 PRINT CHR$($93)CHR$($13): REM CLEAR AND GO HOME 
700 GOSUB 1000: GOTO 10000: REM DRAW MAP AND GOTO COMMAND LOOP
900 FOR X = 0 TO 9
901  FOR Y = 0 TO 5
902   PRINT LD%(X,Y);" ";
903  NEXT Y
904  PRINT
905 NEXT X
906 INPUT Q$
1000 REM DRAW THE WORLD MAP
1010 GOSUB 23000
1020 FOR Y =  - 1 TO 1
1030  FOR X =  - 1 TO 1
1050   LINE 138,75,142,75,HC%: LINE 140,73,140,77,HC%
1100   ZZ = TER%(TX + X,TY + Y): X1=65+(X + 1)*50: Y1=(Y+1)*50
1200   IF ZZ = 2 THEN GOSUB 31000
1300   IF ZZ = 3 THEN GOSUB 31100
1400   IF ZZ = 4 THEN GOSUB 31200
1500   IF ZZ = 5 THEN GOSUB 31300
1600   IF ZZ = 1 THEN GOSUB 31400
1900  NEXT X
1910 NEXT Y
1920 GOSUB 24000: REM DRAW PLAYER STATUS ACROSS TOP OF SCREEN
1930 RETURN 
2000 GOSUB 23000: DIS = 0: HC%= 3: REM CLEAR THE SCREEN
2010 GOSUB 24000: REM DRAW PLAYER STATUS ACROSS TOP OF SCREEN
2020 CENT = DNG%(PX + DX * DIS,PY + DY * DIS)
2021 LEFT = DNG%(PX + DX * DIS + DY,PY + DY * DIS - DX)
2022 RIGH = DNG%(PX + DX * DIS - DY,PY + DY * DIS + DX)
2040 L1 = PER%(DIS,0):R1 = PER%(DIS,1):T1 = PER%(DIS,2)
2041 B1 = PER%(DIS,3):L2 = PER%(DIS+1,0):R2 = PER%(DIS+1,1)
2042 T2 = PER%(DIS+1,2):B2 = PER%(DIS + 1,3)
2050 CENT =  INT (CENT):LEFT =  INT (LEFT):RIGHT =  INT (RIGHT)
2060 MC =  INT (CENT / 10):CENT = CENT - MC * 10
2061 LEFT =  INT ((LEFT / 10 - INT (LEF / 10)) * 10 + .1)
2062 RIGH =  INT ((RIGH / 10 -  INT (RIG / 10)) * 10 + .1)
2080 IF DIS = 0 THEN 2160
2100 IF CENT = 1 OR CENT = 3 OR CENT = 4 THEN GOSUB 31500
2120 IF CENT = 1 OR CENT = 3 THEN EN = 1: GOTO 2600
2140 IF CENT = 4 THEN GOSUB 31600:EN = 1: GOTO 2600
2160 IF LEFT = 1 OR LEFT = 3 OR LEFT = 4 THEN GOSUB 31700
2180 IF RIGH = 1 OR RIGH = 3 OR RIGH = 4 THEN GOSUB 31800
2200 IF LEFT = 4 AND DIS > 0 THEN GOSUB 31900
2220 IF LEFT = 4 AND DIS = 0 THEN GOSUB 32000
2240 IF RIGH = 4 AND DIS > 0 THEN GOSUB 32100
2260 IF RIGH = 4 AND DIS = 0 THEN GOSUB 32200
2280 IF LEFT = 3 OR LEFT = 1 OR LEFT = 4 THEN 2340
2300 IF DIS <> 0 THEN LINE L1,T1,L1,B1,HC%
2320 LINE L1,T2,L2,T2,HC%: LINE L2,T2,L2,B2,HC%: LINE L2,B2,L1,B2,HC%
2340 IF RIGH = 3 OR RIGH = 1 OR RIGH = 4 THEN 2400
2360 IF DIS <> 0 THEN LINE R1,T1,R1,B1,HC%
2380 LINE R1,T2,R2,T2,HC%: LINE R2,T2,R2,B2,HC%: LINE R2,B2,R1,B2,HC%
2400 IF CENT = 7 OR CENT = 9 THEN GOSUB 32300
2420 IF CENT = 8 THEN GOSUB 32400
2440 IF CENT = 7 OR CENT = 8 THEN GOSUB 32500
2460 IF CENT = 7 OR CENT = 8 THEN GOSUB 32600
2480 IF DIS > 0 AND CENT = 5 THEN GOSUB 32700
2490 IF CENT = 5 AND DIS > 0 THEN PRINT "CHEST!"
2500 IF DIS > 0 AND CENT = 5 THEN GOSUB 32800
2520 IF DIS > 0 AND CENT = 5 THEN GOSUB 32900
2600 IF MC < 1 THEN 4900
2650 B = 79 + YY%(DIS):C = 139
2660 IF MC=8 THEN PRINT "CHEST!";: GOTO 2690: REM CALL  - 868: PRINT : NORMAL 
2670 PRINT M$(MC);: REM CALL  - 868: PRINT : NORMAL 
2690 IF DIS = 0 THEN 4900
2700 ON MC GOTO 3000,3100,3200,3300,3400,3500,3600,3700,3800,3900
2800 GOTO 4900

3000 REM DRAW MONSTER SKELETON
3001LINEC-23/DIS,B,C-15/DIS,B,15:LINEC-15/DIS,B,C-15/DI,B-15/DI,15
3003LINEC-15/DI,B-15/DI,C-8/DI,B-30/DI,15
3004LINEC-8/DI,B-30/DI,C+8/DI,B-30/DI,15
3005LINEC+8/DI,B-30/DI,C+15/DI,B-15/DI,15
3006LINEC+15/DI,B-15/DI,C+15/DI,B,15:LINEC+15/DI,B,C+23/DI,B,15
3010LINEC,B-26/DI,C,B-65/DI,15:LINEC-2/DI+.5,B-38/DI,C+2/DI+.5,B-38/DI,15
3012LINEC-3/DI+.5,B-45/DI,C+3/DI+.5,B-45/DI,15
3013LINEC-5/DI+.5,B-53/DI,C+5/DI+.5,B-53/DI,15
3020LINEC-23/DI,B-56/DI,C-30/DI,B-53/DI,15
3021LINEC-30/DI,B-53/DI,C-23/DI,B-45/DI,15
3022LINEC-23/DI,B-45/DI,C-23/DI,B-53/DI,15
3023LINEC-23/DI,B-53/DI,C-8/DI,B-38/DI,15
3030LINEC-15/DI,B-45/DI,C-8/DI,B-60/DI,15
3031LINEC-8/DI,B-60/DI,C+8/DI,B-60/DI,15
3032LINEC+8/DI,B-60/DI,C+15/DI,B-45/DI,15
3033LINEC+15/DI,B-42/DI,C+15/DI,B-57/DI,15
3034LINEC+12/DI,B-45/DI,C+20/DI,B-45/DI,15
3040LINEC,B-75/DI,C-5/DI+.5,B-80/DI,15
3041LINEC-5/DI+.5,B-80/DI,C-8/DI,B-75/DI,15
3042LINEC-8/DI,B-75/DI,C-5/DI+.5,B-65/DI,15
3043LINEC-5/DI+.5,B-65/DI,C+5/DI+.5,B-65/DI,15
3044LINEC+5/DI+.5,B-65/DI,C+5/DI+.5,B-68/DI,15
3045LINEC+5/DI+.5,B-68/DI,C-5/DI+.5,B-68/DI,15
3046LINEC-5/DI+.5,B-68/DI,C-5/DI+.5,B-65/DI,15
3050LINEC-5/DI+.5,B-65/DI,C+5/DI+.5,B-65/DI,15
3051LINEC+5/DI+.5,B-65/DI,C+8/DI,B-75/DI,15
3052LINEC+8/DI,B-75/DI,C+5/DI+.5,B-80/DI,15
3053LINEC+5/DI+.5,B-80/DI,C-5/DI+.5,B-80/DI,15:PSETC-5/DI+.5,B-72/DI,10
3055PSETC+5/DI+.5,B-72/DI,10
3090 GOTO 4900

3100REM DRAW MONSTER THIEF
3101LINEC,B-56/DI,C,B-8/DI,HC%: LINEC,B-8/DI,C+10/DI,B,HC%
3103LINEC+10/DI,B,C+30/DI,B,HC%: LINEC+30/DI,B,C+30/DI,B-45/DI,HC%
3105LINEC+30/DI,B-45/DI,C+10/DI,B-64/DI,HC%: LINEC+10/DI,B-64/DI,C,B-56/DI,HC%
3110LINEC,B-56/DI,C-10/DI,B-64/DI,HC%: LINEC-10/DI,B-64/DI,C-30/DI,B-45/DI,HC%
3112LINEC-30/DI,B-45/DI,C-30/DI,B,HC%: LINEC-30/DI,B,C-10/DI,B,HC%
3114LINEC-10/DI,B,C,B-8/DI,HC%: LINEC-10/DI,B-64/DI,C-10/DI,B-75/DI,HC%
3121LINEC-10/DI,B-75/DI,C,B-83/DI,HC%: LINEC,B-83/DI,C+10/DI,B-75/DI,HC%
3123LINEC+10/DI,B-75/DI,C,B-79/DI,HC%:LINEC-10/DI,B-75/DI,C,B-79/DI,HC%
3125LINEC,B-79/DI,C-10/DI,B-75/DI,HC%:LINEC-10/DI,B-75/DI,C,B-60/DI,HC%
3127LINEC,B-60/DI,C+10/DI,B-75/DI,HC%:LINEC+10/DI,B-75/DI,C+10/DI,B-64/DI,HC%
3190GOTO4900

3200 REM DRAW MONSTER GIANT RAT
3201LINEC+5/DI,B-30/DI,C,B-25/DI,9: LINEC,B-25/DI,C-5/DI,B-30/DI,9
3203LINEC-5/DI,B-30/DI,C-15/DI,B-5/DI,9
3204LINEC-15/DI,B-5/DI,C-10/DI,B,9: LINEC-10/DI,B,C+10/DI,B,9
3206LINEC+10/DI,B,C+15/DI,B-5/DI,9:LINEC+15/DI,B-5/DI,C+20/DI,B-5/DI,9
3211LINEC+20/DI,B-5/DI,C+10/DI,B,9: LINEC+10/DI,B,C+15/DI,B-5/DI,9
3213LINEC+15/DI,B-5/DI,C+5/DI,B-30/DI,9
3214LINEC+5/DI,B-30/DI,C+10/DI,B-40/DI,9
3215LINEC+10/DI,B-40/DI,C+3/DI+.5,B-35/DI,9
3216LINEC+3/DI+.5,B-35/DI,C-3/DI+.5,B-35/DI,9
3217LINEC-3/DI+.5,B-35/DI,C-10/DI,B-40/DI,9
3218LINEC-10/DI,B-40/DI,C-5/DI,B-30/DI,9
3220LINEC-5/DI,B-33/DI,C-3/DI+.5,B-30/DI,9
3221LINEC+5/DI,B-33/DI,C+3/DI+.5,B-30/DI,9
3222LINEC-5/DI,B-20/DI,C-5/DI,B-15/DI,9:LINEC+5/DI,B-20/DI,C+5/DI,B-15/DI,9
3231LINEC-7/DI,B-20/DI,C-7/DI,B-15/DI,9:LINEC+7/DI,B-20/DI,C+7/DI,B-15/DI,9
3290GOTO4900

3300 REM DRAW MONSTER ORC
3301LINEC,B,C-15/DI,B,HC%: LINEC-15/DI,B,C-8/DI,B-8/DI,HC%
3303LINEC-8/DI,B-8/DI,C-8/DI,B-15/DI,HC%
3304LINEC-8/DI,B-15/DI,C-15/DI,B-23/DI,HC%
3305LINEC-15/DI,B-23/DI,C-15/DI,B-15/DI,HC%
3306LINEC-15/DI,B-15/DI,C-23/DI,B-23/DI,HC%
3310LINEC-23/DI,B-23/DI,C-23/DI,B-45/DI,HC%
3311LINEC-23/DI,B-45/DI,C-15/DI,B-53/DI,HC%
3312LINEC-15/DI,B-53/DI,C-8/DI,B-53/DI,HC%
3313LINEC-8/DI,B-53/DI,C-15/DI,B-68/DI,HC%
3314LINEC-15/DI,B-68/DI,C-8/DI,B-75/DI,HC%
3315LINEC-8/DI,B-75/DI,C,B-75/DI,HC%: LINEC,B,C+15/DI,B,HC%
3321LINEC+15/DI,B,C+8/DI,B-8/DI,HC%:LINEC+8/DI,B-8/DI,C+8/DI,B-15/DI,HC%
3323LINEC+8/DI,B-15/DI,C+15/DI,B-23/DI,HC%
3324LINEC+15/DI,B-23/DI,C+15/DI,B-15/DI,HC%
3325LINEC+15/DI,B-15/DI,C+23/DI,B-23/DI,HC%
3330LINEC+23/DI,B-23/DI,C+23/DI,B-45/DI,HC%
3331LINEC+23/DI,B-45/DI,C+15/DI,B-53/DI,HC%
3332LINEC+15/DI,B-53/DI,C+8/DI,B-53/DI,HC%
3333LINEC+8/DI,B-53/DI,C+15/DI,B-68/DI,HC%
3334LINEC+15/DI,B-68/DI,C+8/DI,B-75/DI,HC%:LINEC+8/DI,B-75/DI,C,B-75/DI,HC%
3340LINEC-15/DI,B-68/DI,C+15/DI,B-68/DI,HC%
3341LINEC-8/DI,B-53/DI,C+8/DI,B-53/DI,HC%
3342LINEC-23/DI,B-15/DI,C+8/DI,B-45/DI,HC%
3350LINEC-8/DI,B-68/DI,C,B-60/DI,HC%: LINEC,B-60/DI,C+8/DI,B-68/DI,HC%
3352LINEC+8/DI,B-68/DI,C+8/DI,B-60/DI,HC%:LINEC+8/DI,B-60/DI,C-8/DI,B-60/DI,HC%
3354LINEC-8/DI,B-60/DI,C-8/DI,B-68/DI,HC%:LINEC,B-38/DI,C-8/DI,B-38/DI,HC%
3361LINEC-8/DI,B-38/DI,C+8/DI,B-53/DI,HC%:LINEC+8/DI,B-53/DI,C+8/DI,B-45/DI,HC%
3363LINEC+8/DI,B-45/DI,C+15/DI,B-45/DI,HC%
3364LINEC+15/DI,B-45/DI,C,B-30/DI,HC%: LINEC,B-30/DI,C,B-38/DI,HC%
3390 GOTO 4900

3400 REM DRAW MONSTER VIPER
3401LINEC-10/DI,B-15/DI,C-10/DI,B-30/DI,5:LINEC-10/DI,B-30/DI,C-15/DI,B-20/DI,5
3403LINEC-15/DI,B-20/DI,C-15/DI,B-15/DI,5:LINEC-15/DI,B-15/DI,C-15/DI,B,5
3405LINEC-15/DI,B,C+15/DI,B,5:LINEC+15/DI,B,C+15/DI,B-15/DI,5
3407LINEC+15/DI,B-15/DI,C-15/DI,B-15/DI,5:LINEC-15/DI,B-10/DI,C+15/DI,B-10/DI,5
3411LINEC-15/DI,B-5/DI,C+15/DI,B-5/DI,5:LINEC,B-15/DI,C-5/DI,B-20/DI,5
3421LINEC-5/DI,B-20/DI,C-5/DI,B-35/DI,5:LINEC-5/DI,B-35/DI,C+5/DI,B-35/DI,5
3423LINEC+5/DI,B-35/DI,C+5/DI,B-20/DI,5:LINEC+5/DI,B-20/DI,C+10/DI,B-15/DI,5
3430LINEC-5/DI,B-20/DI,C+5/DI,B-20/DI,5:LINEC-5/DI,B-25/DI,C+5/DI,B-25/DI,5
3432LINEC-5/DI,B-30/DI,C+5/DI,B-30/DI,5:LINEC-10/DI,B-35/DI,C-10/DI,B-40/DI,5
3441LINEC-10/DI,B-40/DI,C-5/DI,B-45/DI,5:LINEC-5/DI,B-45/DI,C+5/DI,B-45/DI,5
3443LINEC+5/DI,B-45/DI,C+10/DI,B-40/DI,5:LINEC+10/DI,B-40/DI,C+10/DI,B-35/DI,5
3450LINEC-10/DI,B-40/DI,C,B-45/DI,5:LINEC,B-45/DI,C+10/DI,B-40/DI,5
3460LINEC-5/DI,B-40/DI,C+5/DI,B-40/DI,5:LINEC+5/DI,B-40/DI,C+15/DI,B-30/DI,5
3462LINEC+15/DI,B-30/DI,C,B-40/DI,5:LINEC,B-40/DI,C-15/DI,B-30/DI,5
3464LINEC-15/DI,B-30/DI,C-5/DI+.5,B-40/DI,5
3490 GOTO 4900

3500REM DRAW MONSTER CARRION CRAWLER
3501LINEC-20/DI,79-YY%(DIS),C-20/DI,B-88/DI,HC%
3502LINEC-20/DI,B-88/DI,C-10/DI,B-83/DI,HC%
3503LINEC-10/DI,B-83/DI,C+10/DI,B-83/DI,HC%
3504LINEC+10/DI,B-83/DI,C+20/DI,B-88/DI,HC%
3505LINEC+20/DI,B-88/DI,C+20/DI,79-YY%(DIS),HC%
3506LINEC+20/DI,79-YY%(DIS),C-20/DI,79-YY%(DI),HC%
3510LINEC-20/DI,B-88/DI,C-30/DI,B-83/DI,HC%
3511LINEC-30/DI,B-83/DI,C-30/DI,B-78/DI,HC%
3512LINEC+20/DI,B-88/DI,C+30/DI,B-83/DI,HC%
3513LINEC+30/DI,B-83/DI,C+40/DI,B-83/DI,HC%
3520LINEC-15/DI,B-86/DI,C-20/DI,B-83/DI,HC%
3521LINEC-20/DI,B-83/DI,C-20/DI,B-78/DI,HC%
3522LINEC-20/DI,B-78/DI,C-30/DI,B-73/DI,HC%
3523LINEC-30/DI,B-73/DI,C-30/DI,B-68/DI,HC%
3524LINEC-30/DI,B-68/DI,C-20/DI,B-63/DI,HC%
3530LINEC-10/DI,B-83/DI,C-10/DI,B-58/DI,HC%: LINEC-10/DI,B-58/DI,C,B-50/DI,HC%
3532LINEC+10/DI,B-83/DI,C,B-50/DI,HC%: LINEC+10/DI,B-83/DI,C+10/DI,B-78/DI,HC%
3534LINEC+10/DI,B-78/DI,C+20/DI,B-73/DI,HC%
3535LINEC+20/DI,B-73/DI,C+20/DI,B-40/DI,HC%
3540LINEC+15/DI,B-85/DI,C+20/DI,B-78/DI,HC%
3541LINEC+20/DI,B-78/DI,C+30/DI,B-76/DI,HC%
3542LINEC+30/DI,B-76/DI,C+30/DI,B-60/DI,HC%
3550LINEC,B-83/DI,C,B-73/DI,HC%: LINEC,B-73/DI,C+10/DI,B-68/DI,HC%
3552LINEC+10/DI,B-68/DI,C+10/DI,B-63/DI,HC%: LINEC+10/DI,B-63/DI,C,B-58/DI,HC%
3590GOTO4900

3600 CHAR 160,100,2, "GREMLIN": GOSUB 4000:RETURN

3700 REM DRAW MONSTER MIMIC
3701 LINE 139-10/DIS,PER%(DIS,3),139-10/DIS,PER%(DIS,3)-10/DIS,HCOLOR
3702 LINE 139-10/DIS,PER%(DIS,3)-10/DIS,139+10/DIS,PER%(DIS,3)-10/DIS,HCOLOR 
3703 LINE 139+10/DIS,PER%(DIS,3)-10/DIS,139+10/DIS,PER%(DIS,3),HCOLOR
3704 LINE 139+10/DIS,PER%(DIS,3),139-10/DIS,PER%(DIS,3),HCOLOR
3710 LINE 139-10/DIS,PER%(DIS,3)-10/DIS,139-5/DIS,PER%(DIS,3)-15/DIS,HCOLOR
3711 LINE 139-5/DIS,PER%(DIS,3)-15/DIS,139+15/DIS,PER%(DIS,3)-15/DIS,HCOLOR
3712 LINE 139+15/DIS,PER%(DIS,3)-15/DIS,139+15/DIS,PER%(DIS,3)-5/DIS,HCOLOR
3713 LINE 139+15/DIS,PER%(DIS,3)-5/DIS,139+10/DIS,PER%(DIS,3),HCOLOR
3720 LINE 139+10/DIS,PER%(DIS,3)-10/DIS,139+15/DIS,PER%(DIS,3)-15/DIS,HCOLOR
3730 GOTO 4900

3800 CHAR 160,100,2, "DAEMON": GOSUB 4000:RETURN
3900 CHAR 160,100,2, "BALROG": GOSUB 4000:RETURN

4000 REM FUNCTION DELAY
4010 FOR I = 1 TO 3000
4030 NEXT I
4040 RETURN

4800 REM FUNCTION ANY KEY
4810 PRINT TAB(5)"PRESS ANY KEY TO CONTINUE.";: INPUT Q$:
4820 IF Q$ = "" THEN GOTO 4820
4830 RETURN

4900 IF EN = 1 THEN EN = 0: RETURN 
4910 DIS = DIS + 1: GOTO 2020

4999 REM CREATING DUNGEON
5000 ZZ =  RND ( -  ABS (LN) - TX * 10 - TY * 1000 + INOUT * 31.4)
5010 FOR X = 1 TO 9: FOR Y = 1 TO 9:DNG%(X,Y) = 0: NEXT Y: NEXT X 
5100 FOR X = 0 TO 10
5101 DNG%(X,0) = 1:DNG%(X,10) = 1:DNG%(0,X) = 1:DNG%(10,X) = 1
5102 NEXT X
5200 FOR X = 2 TO 8 STEP 2
5201 FOR Y = 1 TO 9
5202 DNG%(X,Y) = 1:DNG%(Y,X) = 1
5203 NEXT Y: NEXT X 
5300 FOR X = 2 TO 8 STEP 2: FOR Y = 1 TO 9 STEP 2
5400 IF RND (1) > .95 THEN DNG%(X,Y) = 2
5410 IF RND (1) > .95 THEN DNG%(Y,X) = 2
5420 IF RND (1) > .6 THEN DNG%(Y,X) = 3
5430 IF RND (1) > .6 THEN DNG%(X,Y) = 3
5440 IF RND (1) > .6 THEN DNG%(X,Y) = 4
5450 IF RND (1) > .6 THEN DNG%(Y,X) = 4
5460 IF RND (1) > .97 THEN DNG%(Y,X) = 9
5470 IF RND (1) > .97 THEN DNG%(X,Y) = 9
5480 IF RND (1) > .94 THEN DNG%(X,Y) = 5
5490 IF RND (1) > .94 THEN DNG%(Y,X) = 5
5680 NEXT Y: NEXT X 
5690 DNG%(2,1) = 0: IF INOUT/2=INT(INOUT/2) THEN DNG%(7,3) = 7:DNG%(3,7) = 8
5700 IF INOUT / 2 <  >  INT (INOUT / 2) THEN DNG%(7,3) = 8:DNG%(3,7) = 7 
5800 IF INOUT = 1 THEN DNG%(1,1) = 8:DNG%(7,3) = 0
5850 GOSUB 20000
5900 RETURN 
10000 PRINT CHR$($93)CHR$($13);
10002 VTAB=20: GOSUB 62000: PRINT "COMMAND (N/W/E/S/D/A/-/X)?";
10010 INPUT X$: IF X$="" THEN 10010
10020 REM Q =  FRE (0)
10100 REM POKE  - 16368,0
10200 REM KEYBOARD COMMANDS AVAIALBLE
10201 REM N = MOVE NORTH / FORWARD
10202 REM W = MOVE WEST / TURN LEFT
10203 REM E = MOVE EAST / TURN RIGHT
10204 REM S = MOVE SOUTH / TURN AROUND
10205 REM D = STATISTICS
10206 REM A = NA / ATTACK
10207 REM - = PASS / PASS
10208 REM X = CLIMB LADDER/ENTER TOWN/ENTER CASTLE/CLIMB DOWN
10209 REM P = PAUSE
10300 IF X$ = "N" THEN ON SGN (INOUT) + 1 GOTO 11000,11500
10400 IF X$ = "E" THEN ON SGN (INOUT) + 1 GOTO 12000,12500
10500 IF X$ = "W" THEN ON SGN (INOUT) + 1 GOTO 13000,13500
10600 IF X$ = "S" THEN ON SGN (INOUT) + 1 GOTO 14000,14500
10700 IF X$ = "D" THEN ON SGN (INOUT) + 1 GOTO 15000,15500
10800 IF X$ = "A" THEN ON SGN (INOUT) + 1 GOTO 16000,16500
10810 IF X$ = "-" THEN PRINT "PASS": GOTO 10900
10850 IF X$ = "X" THEN 17000
10860 IF X$ = "P" THEN IF PA = 1 THEN PA = 0: PRINT "PAUSE OFF": GOTO 10000
10870 IF X$ = "P" THEN IF PA = 0 THEN PA = 1: PRINT "PAUSE ON": GOTO 10000
10880 IF X$ = "Q" THEN END
10890 VTAB=20: GOSUB 62000: PRINT TAB(30)"HUH?": GOTO 10000
10900 PW(0) = PW(0) - 1 +  SGN (INOUT) * .9
10901 IF PW(0) < 0 THEN C(0) = 0: PRINT "YOU HAVE STARVED!!!!!": GOTO 10930
10920 PW(0) =  INT (PW(0) * 10) / 10
10930 IF C(0) <  = 0 THEN 56000
10950 IF IN > 0 THEN  GOSUB 40000: IF C(0) <  = 0 THEN 10930
10963 REM CALL  - 868: POKE 33,29: TAB (1)
10970 IF INOUT = 0 THEN  GOSUB 1000: GOTO 10000
10980 IF INOUT > 0 THEN  GOSUB 2000: GOTO 10000
11000 VTAB=20: GOSUB 62000: PRINT TAB(30)"NORTH"
11001 IF TER%(TX,TY-1)=1 THEN PRINT "YOU CAN'T PASS THE MOUNTAINS": GOTO 10900
11100 TY = TY - 1: GOTO 10900
11500 IF DNG%(PX+DX,PY+DY)<>1 AND DNG%(PX+DX,PY+DY)<10 THEN PX=PX+DX:PY=PY+DY
11550 VTAB=20: GOSUB 62000: PRINT TAB(30)"FORWARD"
11600 IF DNG%(PX,PY)=2 THEN GOSUB 26000: GOSUB 5000: GOTO 10900
11650 Z = 0
11700 IF DNG%(PX,PY)=5 THEN GOSUB 25000
11750 IF Z>0 THEN Z=INT(RND(1)*6): PRINT "AND A ";W$(Z): GOSUB 4800
11751 IF Z>0 THEN PW(Z) = PW(Z)+1: GOTO 10900
11900 GOTO 10900
12000 VTAB=20: GOSUB 62000: PRINT TAB(30)"EAST":
12001 IF TER%(TX+1,TY)=1 THEN PRINT "YOU CAN'T PASS THE MOUNTAINS": GOTO 10900
12100 TX = TX + 1: GOTO 10900
12500 VTAB=20: GOSUB 62000: PRINT TAB(30)"TURN RIGHT"
12550 IF DX <  > 0 THEN DY = DX:DX = 0: GOTO 10900
12600 DX =  - DY:DY = 0: GOTO 10900
13000 VTAB=20: GOSUB 62000: PRINT TAB(30)"WEST"
13001 IF TER%(TX-1,TY)=1 THEN PRINT "YOU CAN'T PASS THE MOUNTAINS": GOTO 10900
13100 TX = TX - 1: GOTO 10900
13500 VTAB=20: GOSUB 62000: PRINT TAB(30)"TURN LEFT"
13550 IF DX <  > 0 THEN DY =  - DX:DX = 0: GOTO 10900
13600 DX = DY:DY = 0: GOTO 10900
14000 VTAB=20: GOSUB 62000: PRINT TAB(30)"SOUTH"
14001 IF TER%(TX,TY+1)=1 THEN PRINT "YOU CAN'T PASS THE MOUNTAINS": GOTO 10900
14100 TY = TY + 1: GOTO 10900
14500 VTAB=20: GOSUB 62000: PRINT TAB(30)"TURN AROUND":DX=-DX:DY=-DY:GOTO 10900
15000 IF TE%(TX,TY)=3 THEN  GOSUB 60080: GOSUB 60200: GOTO 10900
15100 IF TE%(TX,TY)=4 AND INOUT = 0 THEN GOTO 21000
15150 IF TE%(TX,TY)=5 THEN 57000
15200 VTAB=20: GOSUB 62000: PRINT TAB(30)"HUH?": GOTO 10000
15500 IF DNG%(PX,PY) <  > 7 AND DNG%(PX,PY) <  > 9 THEN 15800
15550 PRINT "GO DOWN TO LEVEL ";INOUT + 1
15600 INOUT = INOUT + 1: GOSUB 5000:MR = 1: GOTO 10900
15800 IF DNG%(PX,PY) <  > 8 THEN  PRINT "HUH?": GOTO 10900
15810 IF IN = 1 THEN  PRINT "LEAVE DUNGEON":IN = 0: GOTO 15860
15840 PRINT "GO UP TO LEVEL ";INOUT - 1
15850 INOUT = INOUT - 1: GOSUB 5000:MR = 1
15860 IF IN = 0 THEN PRINT "THOU HAST GAINED"
15861 IF IN = 0 THEN PRINT LK;" HIT POINTS":C(0) = C(0) + LK:LK = 0
15870 GOTO 10900
16000 GOTO 10900
16500 MN=0:DAM=0: PRINT "ATTACK"
16505 PRINT "WHICH WEAPON (R/A/S/B/M) OR (H)ANDS?";: INPUT Q$
16510 IF Q$ = "R" THEN DAM = 10: PRINT "RAPIER"
16511 IF Q$ = "R" THEN IF PW(1)<1 THEN PRINT "NOT OWNED": GOTO 16500
16520 IF Q$ = "A" THEN DAM = 5: PRINT "AXE":
16521 IF Q$ = "A" THEN IF PW(2)<1 THEN PRINT "NOT OWNED": GOTO 16500
16530 IF Q$ = "S" THEN DAM = 1: PRINT "SHIELD"
16531 IF Q$ = "S" THEN IF PW(3)<1 THEN PRINT "NOT OWNED": GOTO 16500
16540 IF Q$ = "B" THEN DAM = 4: PRINT "BOW"
16541 IF Q$ = "B" THEN IF PW(4)<1 THEN PRINT "NOT OWNED": GOTO 16500
16550 IF Q$ = "M" THEN PRINT "MAGIC AMULET": GOTO 16800
16560 IF Q$ = "B" AND PT$="M" THEN PRINT "MAGES CAN'T USE BOWS!": GOTO 16500
16570 IF Q$ = "R" AND PT$="M" THEN PRINT "MAGES CAN'T USE RAPIERS!": GOTO 16500
16590 IF DAM = 0 THEN PRINT "HANDS"
16600 IF DAM = 5 OR DAM = 4 THEN 16700
16610 MN = DN%(PX + DX,PY + DY) / 10:MN =  INT (MN)
16620 IF MN<1 OR C(2)-RND(1)*25<MN+INOUT THEN PRINT "YOU MISSED": GOTO 16680
16630 PRINT "HIT!!! ":DAM=(RND(1)*DAM+C(1)/5)
16631 MZ%(MN,1)=MZ%(MN,1) - DAM
16640 PRINT M$(MN);"'S HIT POINTS=";MZ%(MN,1)
16650 IF MZ%(MN,1)<1 THEN PRINT "THOU HAST KILLED A ";M$(MN)
16651 IF MZ%(MN,1)<1 THEN PRINT "THOU SHALT RECEIVE"
16652 IF MZ%(MN,1)<1 THEN DA=INT(MN+IN): PRINT DA;" PIECES OF EIGHT"
16660 IF MZ%(MN,1)<1 THEN C(5)= INT(C(5)+DA):
16661 IF MZ%(MN,1)<1 THEN GOSUB 22000: GOSUB 4800
16670 LK = LK +  INT (MN * IN / 2): IF MN = TASK THEN TASK =  - TASK
16680 GOSUB 4800
16690 GOTO 10900
16700 IF DAM = 5 THEN PRINT "TO THROW OR SWING:";
16701 IF DAM = 5 THEN INPUT Q$: IF Q$ <  > "T" THEN  PRINT "SWING": GOTO 16610
16710 IF DAM = 5 THEN PRINT "THROW":PW(2) = PW(2) - 1
16720 FOR Y = 1 TO 5
16721  IF PX+DX*Y < 1 OR PX+DX*Y > 9 OR PY+DY*Y > 9 OR PY+DY*Y < 0 THEN 16620
16730  MN = DNG%(PX + DX * Y,PY + DY * Y):MN =  INT(MN/10): IF MN>0 THEN 16620
16740 NEXT Y: GOTO 16620
16800 IF PW(5) < 1 THEN PRINT "NONE OWNED": GOTO 16500
16810 IF PT$ = "F" THEN Q = INT ( RND (1) * 4 + 1): GOTO 16850
16820 PRINT "1-LADDER-UP","2-LADDER-DN": PRINT "3-KILL","4-BAD??"
16821 PRINT "CHOICE ";
16822 INPUT Q$:Q =  VAL (Q$): PRINT Q: IF Q < 1 OR Q > 4 THEN 16820
16830 IF RND (1)>.75 THEN  PRINT "LAST CHARGE ON THIS AMULET!":PW(5) = PW(5)-1
16850 ON Q GOTO 16860,16900,16910,16920
16860 PRINT "LADDER UP":DNG%(PX,PY) = 8: GOTO 10900
16900 PRINT "LADDER DOWN":DNG%(PX,PY) = 7: GOTO 10900
16910 PRINT "MAGIC ATTACK":DAM = 10 + INOUT: GOTO 16720
16920 ON  INT ( RND (1) * 3 + 1) GOTO 16930,16950,16970
16930 PRINT "YOU HAVE BEEN TURNED": PRINT "INTO A TOAD!"
16940 FOR Z2 = 1 TO 4:C(Z2) = 3: NEXT Z2: GOTO 10900
16950 PRINT "YOU HAVE BEEN TURNED": PRINT "INTO A LIZARD MAN"
16951 FOR Y = 0 TO 4:C(Y) =  INT (C(Y) * 2.5): NEXT Y: GOTO 10900
16970 PRINT "BACKFIRE":C(0) = C(0) / 2: GOTO 10900
17000 GOSUB 60080: PRINT CHR$($13)
17001 GOSUB 4800: CLS : GOTO 10900
20000 NM = 0
20010 FOR X = 1 TO 10
20050  MZ%(X,0) = 0:MZ%(X,1) = X + 3 + INOUT
20100  IF X - 2 > INO OR  RND (1) > .4 THEN 20900
20200  ML%(X,0) =  INT ( RND (1) * 9 + 1):ML%(X,1) =  INT ( RND (1) * 9 + 1)
20300  IF DNG%(ML%(X,0),ML%(X,1)) <  > 0 THEN 20200
20400  IF ML%(X,0) = PX AND ML%(X,1) = PY THEN 20200
20500  DNG%(ML%(X,0),ML%(X,1)) = X * 10
20510  MZ%(X,0) = 1
20520  NM = NM + 1
20550  MZ%(X,1) = X * 2 + IN * 2 * LP
20900 NEXT X
20910 RETURN 

21000 REM FUNCTION FOR LINE 15100
21010 PRINT "GO DUNGEON"
21020 PRINT "PLEASE WAIT "
21030 INOUT = 1
21040 GOSUB 5000
21050 DX=1:DY=0:PX=1:PY=1
21060 GOTO 10900

22000 REM COMPLEX MATHS FOR LINE 16661
22010 DNG%(ML%(MN,0),ML%(MN,1))=DNG%(ML%(MN,0),ML%(MN,1))-10*MN:MZ%(MN,0)=0
22020 RETURN

23000 REM FUNCTION - CLEAR GRAPHIC SCREEN
23010 RECT 0,0,319,199,1: REM WHITE OUT THE SCREEN
23030 RETURN

24000 REM FUNCTION - DRAW HP,GOLD,FOOD INFO
24010 RECT 0,0,319,10,1
24020 CHAR 10,10,14,"FOOD="+STR$(PW(0))
24030 CHAR 80,10,14,"HIT POINTS="+STR$(C(0))
24040 CHAR 180,10,14,"GOLD="+STR$(C(5))
24050 RETURN

25000 REM FUNCTION - FIND GOLD FOR LINE 11700
25010 PRINT "GOLD!!!!!"
25020 Z =  INT ( RND (1) * 5 * INOUT + INOUT)
25030 PRINT Z;"-PIECES OF EIGHT":C(5) = C(5) + Z
25040 DNG%(PX,PY) = 0
25050 RETURN

26000 REM FUNCTION - FIND TRAP FOR LINE 11600
26010 PRINT "AAARRRGGGHHH!!! A TRAP!"
26020 C(0)=C(0)-INT(RND(1)*INOUT+3): MR=1:INOUT=INOUT+1
26030 PRINT "FALLING TO LEVEL ";IN
26040 RETURN

30870 LINEC-28/DI,B-41/DI,C+30/DI,B-55/DI,HC%
30871 LINEC+28/DI,B-58/DI,C+22/DI,B-56/DI,HC%
30872 LINEC+22/DI,B-56/DI,C+22/DI,B-53/DI,HC%
30873 LINEC+22/DI,B-53/DI,C+28/DI,B-52/DI,HC%
30874 LINEC+28/DI,B-52/DI,C+34/DI,B-54/DI,HC%
30875 LINEC+20/DI,B-50/DI,C+26/DI,B-47/DI,HC%

30880 LINEC+10/DI,B-58/DI,C+10/DI,B-61/DI,HC%
30881 LINEC+10/DI,B-61/DI,C+4/DI,B-58/DI,HC%
30882 LINEC-10/DI,B-58/DI,C-10/DI,B-61/DI,HC%
30883 LINEC-10/DI,B-61/DI,C-4/DI,B-58/DI,HC%
30884 LINEC+40/DI,B-9/DI,C+50/DI,B-12/DI,HC%
30885 LINEC+50/DI,B-12/DI,C+40/DI,B-7/DI,HC%

30890 LINEC-8/DI,B-25/DI,C+6/DI,B-7/DI,HC%
30891 LINEC+6/DI,B-7/DI,C+28/DI,B-7/DI,HC%
30892 LINEC+28/DI,B-7/DI,C+28/DI,B-9/DI,HC%
30893 LINEC+28/DI,B-9/DI,C+20/DI,B-9/DI,HC%
30894 LINEC+20/DI,B-9/DI,C+6/DI,B-25/DI,HC%
30895 GOTO4900

31000 REM DRAW SMALL BOX - LINES FROM 1200
31010 LINE X1+20,Y1+20,X1+30,Y1+20,HC%
31011 LINE X1+30,Y1+20,X1+30,Y1+30,HC%
31012 LINE X1+30,Y1+30,X1+20,Y1+30,HC%
31013 LINE X1+20,Y1+30,X1+20,Y1+20,HC%
31014 RETURN

31100 REM DRAW CITY - LINES FROM 1300
31101 LINE X1+10,Y1+10,X1+20,Y1+10,HC%
31102 LINE X1+20,Y1+10,X1+20,Y1+40,HC%
31103 LINE X1+20,Y1+40,X1+10,Y1+40,HC%
31104 LINE X1+10,Y1+40,X1+10,Y1+30,HC%
31105 LINE X1+10,Y1+30,X1+40,Y1+30,HC%
31106 LINE X1+40,Y1+30,X1+40,Y1+40,HC%
31107 LINE X1+40,Y1+40,X1+30,Y1+40,HC% 
31108 LINE X1+30,Y1+40,X1+30,Y1+10,HC%
31109 LINE X1+30,Y1+10,X1+40,Y1+10,HC%
31110 LINE X1+40,Y1+10,X1+40,Y1+20,HC% 
31111 LINE X1+40,Y1+20,X1+10,Y1+20,HC%
31112 LINE X1+10,Y1+20,X1+10,Y1+10,HC%
31113 RETURN

31200 REM DRAW PLAYER X - LINES FROM 1400
31201 LINEX1+20,Y1+20,X1+30,Y1+30,HC%
31202 LINEX1+20,Y1+30,X1+30,Y1+20,HC%
31203 RETURN

31300 REM DRAW CASTLE - LINES FROM 1500
31301 LINEX1,Y1,X1+50,Y1,HC%: LINE X1+50,Y1,X1+50,Y1+50,HC%
31303 LINEX1+50,Y1+50,X1,Y1+50,HC%: LINE X1,Y1+50,X1,Y1,HC%
31305 LINEX1+10,Y1+10,X1+10,Y1+40,HC%: LINE X1+10,Y1+40,X1+40,Y1+40,HC%
31307 LINEX1+40,Y1+40,X1+40,Y1+10,HC%: LINE X1+40,Y1+10,X1+10,Y1+10,HC%
31309 LINEX1+10,Y1+10,X1+40,Y1+40,HC%: LINE X1+10,Y1+40,X1+40,Y1+10,HC%
31311 RETURN

31400 REM DRAW MOUNTAIN - LINES FROM 1600
31401 LINEX1+10,Y1+50,X1+10,Y1+40,HC%
31402 LINEX1+10,Y1+40,X1+20,Y1+30,HC%
31403 LINEX1+20,Y1+30,X1+40,Y1+30,HC%
31404 LINEX1+40,Y1+30,X1+40,Y1+50,HC%
31405 LINEX1,Y1+10,X1+10,Y1+10,HC%
31406 LINEX1+50,Y1+10,X1+40,Y1+10,HC%
31407 LINEX1,Y1+40,X1+10,Y1+40,HC%
31408 LINEX1+40,Y1+40,X1+50,Y1+40,HC%
31409 LINEX1+10,Y1,X1+10,Y1+20,HC%
31410 LINEX1+10,Y1+20,X1+20,Y1+20,HC%
31411 LINEX1+20,Y1+20,X1+20,Y1+30,HC%
31412 LINEX1+20,Y1+30,X1+30,Y1+30,HC%
31413 LINEX1+30,Y1+30,X1+30,Y1+10,HC%
31414 LINEX1+30,Y1+10,X1+40,Y1+10,HC%
31415 LINEX1+40,Y1+10,X1+40,Y1,HC%
31416 RETURN

31500 REM DRAW WALL - LINES FROM 2100
31501 LINE L1,T1,R1,T1,HC%
31502 LINE R1,T1,R1,B1,HC%
31503 LINE R1,B1,L1,B1,HC%
31504 LINE L1,B1,L1,T1,HC%
31505 RETURN

31600 REM DRAW DOOR - LINES FROM 2140 
31601 LINE CD%(DIS,0),CD%(DIS,3),CD%(DIS,0),CD%(DIS,2),HC% 
31602 LINE CD%(DIS,0),CD%(DIS,2),CD%(DIS,1),CD%(DIS,2),HC%
31603 LINE CD%(DIS,1),CD%(DIS,2),CD%(DIS,1),CD%(DIS,3),HC%
31604 RETURN

31700 REM DRAW LEFT SIDE WALL - LINES FROM 2160
31701 LINE L1,T1,L2,T2,HC%
31702 LINE L1,B1,L2,B2,HC%
31703 RETURN

31800 REM DRAW RIGHT SIDE WALL - LINES FROM 2180
31801 LINE R1,T1,R2,T2,HC%
31802 LINE R1,B1,R2,B2,HC%
31803 RETURN

31900 REM DRAW LEFT SIDE DOOR - LINES FROM 2200
31901 LINE LD%(DIS,0),LD%(DIS,4),LD%(DIS,0),LD%(DIS,2),HC%
31902 LINE LD%(DIS,0),LD%(DIS,2),LD%(DIS,1),LD%(DIS,3),HC%
31903 LINE LD%(DIS,1),LD%(DIS,3),LD%(DIS,1),LD%(DIS,5),HC%
31904 RETURN

32000 REM DRAW LEFT ??? - LINES FROM 2220
32001 LINE 0,LD%(DIS,2)-3,LD%(DIS,1),LD%(DIS,3),HC%
32002 LINE LD%(DIS,1),LD%(DIS,3),LD%(DIS,1),LD%(DIS,5),HC%
32003 RETURN

32100 REM DRAW RIGHT SIDE DOOR - LINES FROM 2240
32101 LINE 279-LD%(DIS,0),LD%(DIS,4),279-LD%(DIS,0),LD%(DIS,2),HC%
32102 LINE 279-LD%(DIS,0),LD%(DIS,2),279-LD%(DIS,1),LD%(DIS,3),HC% 
32103 LINE 279-LD%(DIS,1),LD%(DIS,3),279-LD%(DIS,1),LD%(DIS,5),HC%
32104 RETURN

32200 REM DRAW RIGHT ??? - LINES FROM 2260
32201 LINE 279,LD%(DIS,2) - 3,279 - LD%(DIS,1),LD%(DIS,3),HC%
32202 LINE 279 - LD%(DIS,1),LD%(DIS,3),279 - LD%(DIS,1),LD%(DIS,5),HC%
32203 RETURN

32300 REM DRAW TRAP DOOR ON FLOOR - LINES FROM 2400
32301 LINE FT%(DIS,0),FT%(DIS,4), FT%(DIS,2),FT%(DIS,5),HC% 
32302 LINE FT%(DIS,2),FT%(DIS,5), FT%(DIS,3),FT%(DIS,5),HC%
32303 LINE FT%(DIS,3),FT%(DIS,5), FT%(DIS,1),FT%(DIS,4),HC%
32304 LINE FT%(DIS,1),FT%(DIS,4), FT%(DIS,0),FT%(DIS,4),HC%
32305 RETURN

32400 REM DRAW TRAP DOOR ON CEILING - LINES FROM 2420
32401 LINE FT%(DIS,0),158 - FT%(DIS,4), FT%(DIS,2),158 - FT%(DIS,5),HC%
32402 LINE FT%(DIS,2),158 - FT%(DIS,5), FT%(DIS,3),158 - FT%(DIS,5),HC%
32403 LINE FT%(DIS,3),158 - FT%(DIS,5), FT%(DIS,1),158 - FT%(DIS,4),HC%
32404 LINE FT%(DIS,1),158 - FT%(DIS,4), FT%(DIS,0),158 - FT%(DIS,4),HC%
32405 RETURN

32500 REM SET VARIABLES AND DRAW TWO VERTICAL LINES - LINES FROM 2440
32501 BASE=LAD%(DIS,3): TP=LAD%(DIS,2): LX=LAD%(DIS,0): RX=LAD%(DIS,1)
32503 LINE LX,BA,LX,TP,HC%: LINE RX,TP,RX,BA,HC%
32505 RETURN

32600 REM SET VARIABLES AND DRAW 4 HOZITONAL LINES - LINES FROM 2460
32601 Y1=(BA*4+TP)/5: Y2=(BA*3+TP*2)/5: Y3=(BA*2+TP*3)/5: Y4=(BA+TP*4)/5
32603 LINE LX,Y1,RX,Y1,HC%: LINE LX,Y2,RX,Y2,HC%
32605 LINE LX,Y3,RX,Y3,HC%: LINE LX,Y4,RX,Y4,HC%
32607 RETURN

32700 REM DRAW LINES FROM 2480
32701 LINE 139-10/DIS,PER%(DIS,3),139-10/DIS,PER%(DIS,3)-10/DIS,HC%
32702 LINE 139-10/DIS,PER%(DIS,3)-10/DIS,139+10/DIS,PER%(DIS,3)-10/DIS,HC% 
32703 LINE 139+10/DIS,PER%(DIS,3)-10/DIS,139+10/DIS,PER%(DIS,3),HC%
32704 LINE 139+10/DIS,PER%(DIS,3),139-10/DIS,PER%(DIS,3),HC%
32705 RETURN

32800 REM DRAW LINES FROM 2500
32801 LINE 139-10/DIS,PER%(DIS,3)-10/DIS,139-5/DIS,PER%(DIS,3)-15/DIS,HC%
32802 LINE 139-5/DIS,PER%(DIS,3)-15 /DIS,139+15/DIS,PER%(DIS,3)-15/DIS,HC% 
32803 LINE 139+15/DIS,PER%(DIS,3)-15/DIS,139+15/DIS,PER%(DIS,3)-5/DIS,HC% 
32804 LINE 139+15/DIS,PER%(DIS,3)-5/DIS,139+10/DIS,PER%(DIS,3),HC%
32805 RETURN

32900 REM DRAW LINES FROM 2520
32901 LINE 139+10/DIS,PER%(DIS,3)-10/DIS,139+15/DIS,PER%(DIS,3)-15/DIS,HC%
32902 RETURN 

40000 REM FUNCTION MONSTER MOVEMENT AND ATTACK
40010 REM CHECK EACH TYPE OF MONSTER IF IN LEVEL
40020 FOR MM = 1 TO 10
40030  IF MZ%(MM,0) = 0 THEN 49980: REM MONSTER TYPE NOT HERE SO NEXT MONSTER 
40100  RA =  SQR ((PX - ML%(MM,0)) ^ 2 + (PY - ML%(MM,1)) ^ 2)
40110  IF MZ%(MM,1) < IN * LP THEN 40300
40200  IF RA < 1.3 THEN 45000: REM IF MONSTER NEXT TO PLAYER, ATTACK
40240  REM IF MONSTER IS MIMIC AND CLOSER THAN 3 SKIP TO NEXT MONSTER
40250  IF MM = 8 AND RA < 3 THEN 49980
40290  REM CALCULATE DIRECTION TO PLAYER
40300  X1 =  SGN (PX - ML%(MM,0)):Y1 =  SGN (PY - ML%(MM,1))
40310  REM IF MONSTER IS WEAK, MOVE AWAY FROM PLAYER
40320  IF MZ%(MM,1) < IN * LP THEN X1 =  - X1:Y1 =  - Y1
40350  IF Y1 = 0 THEN 40450
40400  D = DNG%(ML%(MM,0),(ML%(MM,1) + Y1 + .5))
40401  IF D = 1 OR D > 9 OR D = 2 THEN 40450
40420  X1 = 0: GOTO 40500
40450  Y1 = 0: IF X1 = 0 THEN 40500
40460  D = DN%((ML%(MM,0) + X1 + .5),ML%(MM,1))
40461  IF D = 1 OR D > 9 OR D = 2 THEN X1 = 0: GOTO 40810
40500  DNG%(ML%(MM,0),ML%(MM,1)) = DNG%(ML%(MM,0),ML%(MM,1)) - 10 * MM
40540  REM MOVE WOULD PLACE MONSTER ON PLAYER THEN NEXT MONSTER
40550  IF ML%(MM,0) + X1 = PX AND ML%(MM,1) + Y1 = PY THEN 49980
40600  REM MOVE THE MONSTER
40610  ML%(MM,0) = ML%(MM,0) + X1:ML%(MM,1) = ML%(MM,1) + Y1
40800  DNG%(ML%(MM,0),ML%(MM,1)) = (DNG%(ML%(MM,0),ML%(MM,1)) + 10 * MM + .5)
40810  IF X1 <  > 0 OR Y1 <  > 0 THEN 49990
40820  IF MZ%(MM,1) < IN * LP AND RA < 1.3 THEN 45000
40830  REM IF MONSTER HP LESS THAN LEVEL THEN HEAL THE MONSTER
40840  IF MZ%(MM,1) < IN * LP THEN MZ%(MM,1) = MZ%(MM,1) + MM + IN
44990  GOTO 49980: REM NEXT MONSTER
45000  REM MONSTER ATTACK
45010  IF MM = 2 OR MM = 7 THEN 46000: IF MONSTER IS THIEF OR GREMLIN
45090  PRINT "YOU ARE BEING ATTACKED": PRINT "BY A ";M$(MM)
45100  IF RND(1)*20-SGN(PW(3))-C(3)+MM+IN < 0 THEN PRINT "MISSED": GOTO 45250
45200  PRINT "HIT":C(0) = C(0) -  INT ( RND (1) * MM + IN)
45250  IF PA = 1 THEN  PRINT "RETURN TO CONT. ";: INPUT Q$
45300  GOTO 49980
46000  REM CHECK MONSTER THEFT
46010  REM 50% CHANCE WILL NO STEAL BUT WILL ATTACK
46020  IF RND (1) < .5 THEN 45090
46100  IF MM=7 THEN PW(0)=INT(PW(0)/2)
46101  IF MM=7 THEN PRINT "A GREMLIN STOLE SOME FOOD": GOTO 45250
46200  ZZ =  INT ( RND (1) * 6): IF PW(ZZ) < 1 THEN 46200
46300  PRINT "A THIEF STOLE A ";W$(ZZ):PW(ZZ) = PW(ZZ) - 1: GOTO 45250
49980 NEXT MM
49990 RETURN 

56000 CLS: PRINT : PRINT : PRINT "    WE MOURN THE PASSING OF "
56005 IF LEN (PN$) > 22 THEN PN$ = ""
56010 IF PN$ = "" THEN PN$ = "THE PEASANT"
56020 PN$ = PN$ + " AND HIS COMPUTER"
56030 PRINT TAB(20 -  INT ( LEN (PN$) / 2)): PRINT PN$
56035 PRINT "  TO INVOKE A MIRACLE OF RESSURECTION"
56040 PRINT "             <PRESS R KEY>":
56044 PRINT "  TO LET THE DARKENSS CLAIM YOUR SOUL"
56045 PRINT "             <PRESS Q KEY>";
56046 INPUT K$: IF K$="" THEN GOTO 56046
56050 IF K$ = "R" THEN GOTO 10
56055 IF K$ = "Q" THEN END
56060 GOTO 56046

57000 REM FUNCTION VISIT LORD BRITISH 
57001 GOSUB 23000: CLS: REM WHITE OUT SCREEN AND CLEAR TEXT
57010 IF PN$ <> "" THEN 57500
57020 PRINT : PRINT
57021 PRINT "WELCOME PEASANT INTO THE HALLS OF THE":PRINT"MIGHTY LORD BRITISH."
57022 PRINT "HEREIN THOU MAY CHOOSE TO DARE BATTLE":PRINT"WITH THE EVIL"
57024 PRINT "CREATURES OF THE DEPTHS, FOR GREAT": PRINT "REWARD!"
57030 PRINT : PRINT "WHAT IS THY NAME PEASANT ";: INPUT PN$
57040 PRINT "DO THOU WISH FOR GRAND ADVENTURE Y/N";: INPUT Q$:
57041 IF Q$<>"Y" THEN PRINT : PRINT "THEN LEAVE AND BEGONE!":PN$ = "":PRINT
57042 IF Q$<>"Y" THEN GOSUB 4800: GOTO 10900
57050 PRINT : PRINT "GOOD! THOU SHALT TRY TO BECOME A ":PRINT "KNIGHT!!!"
57051 PRINT : PRINT "THY FIRST TASK IS TO GO INTO THE"
57052 PRINT "DUNGEONS AND TO RETURN ONLY AFTER": PRINT "KILLING A ";
57053 TASK =  INT (C(4) / 3): PRINT M$(TASK)
57060 PRINT : PRINT "GO NOW UPON THIS QUEST, AND MAY":
57061 PRINT "LADY LUCK BE FAIR UNTO YOU.....":
57062 PRINT ".....ALSO I, BRITISH, HAVE INCREASED"
57063 PRINT "EACH OF THY ATTRIBUTES BY ONE!"
57070 PRINT : GOSUB 4800
57071 FOR X = 0 TO 5:C(X) = C(X) + 1: NEXT : CLS : GOTO 10900
57500 IF TASK > 0 THEN GOSUB 58000: CLS : GOTO 10900: REM DISPLAY MSG, LEAVE
57510 PRINT : PRINT : PRINT : PRINT "AAHH!!.....";PN$: PRINT
57511 PRINT "THOU HAST ACOMPLISHED THY QUEST!": IF  ABS (TASK) = 10 THEN 57900
57520 PRINT "UNFORTUNATELY, THIS IS NOT ENOUGH TO"
57521 PRINT "BECOME A KNIGHT.":TASK =  ABS (TASK) + 1:
57522 PRINT : PRINT "NOW THOU MUST KILL A(N) ";M$(TASK)
57530 GOTO 57060
57900 CLS : PRINT : PRINT
57901 PRINT :PN$ = "LORD " + PN$: PRINT " ";PN$;","
57910 PRINT "       THOU HAST PROVED THYSELF WORTHY"
57911 PRINT "OF KNIGHTHOOD, CONTINUE PLAY IF THOU"
57912 PRINT "DOTH WISH, BUT THOU HAST ACOMPLISHED"
57913 PRINT "THE MAIN OBJECTIVE OF THIS GAME..."
57920 IF LP = 10 THEN 57950
57930 PRINT : PRINT "   NOW MAYBE THOU ART FOOLHEARTY"
57931 PRINT "ENOUGH TO TRY DIFFICULTY LEVEL ";LP + 1
57940 GOTO 57070
57950 PRINT : PRINT "...CALL CALIFORNIA PACIFIC COMPUTER"
57951 PRINT "AT (415)-569-9126 TO REPORT THIS": PRINT "AMAZING FEAT!"
57990 GOTO 57070

58000 REM FUNCTION DISPLAY NOT COMPLETE TASK 
58010 PRINT : PRINT : PRINT PN$;" WHY HAST THOU RETURNED?"
58020 PRINT "THOU MUST KILL A(N) ";M$(TASK)
58030 PRINT "GO NOW AND COMPLETE THY QUEST!": PRINT
58040 GOSUB 4800
58050 RETURN
 
60000 REM CHARACTER CREATION
60001 CLS: PRINT TAB(5)"WELCOME, FOOLISH MORTAL": PRINT TAB(10)"INTO THE WORLD"
60002 PRINT TAB(10)"AKALABETH!":PRINT TAB(5)"HERE THOU SHALF FIND GRAND"
60003 PRINT TAB(10)"ADVENTURE!"
60004 VTAB=10: GOSUB 62000
60005 INPUT "TYPE THY LUCKY NUMBER.....";Q$:LN = VAL(Q$)
60006 INPUT "LEVEL OF PLAY (1-10)......";Q$:LP = INT(VAL(Q$))
60007 IF LP < 1 OR LP > 10 THEN 60005
60010 ZZ =  RND ( -  ABS (LN))
60025 DIM PW(5)
60030 DIM C$(5): FOR X = 0 TO 5: READ C$(X): NEXT 
60040 DIM C(5)
60041 DIM M$(10),ML%(10,1),MZ%(10,1)
60044 FOR X = 1 TO 10: READ M$(X): NEXT 
60050 FOR X = 0 TO 5:C(X) =  INT ( SQR ( RND (1)) * 21 + 4): NEXT X
60052 CLS: VTAB=6: GOSUB 62000
60054 FOR X = 0 TO 5: PRINT C$(X),C(X): NEXT : PRINT :
60058 PRINT "SHALT THOU PLAY WITH THESE QUALITIES?": PRINT TAB(10):
60060 INPUT "(Y/N)";Q$: IF Q$<>"Y" THEN 60050
60061 VTAB=16: GOSUB 62000
60062 PRINT "AND THOU ARE A (F)IGHTER OR A (M)AGE?" 
60063 PRINT TAB(10):INPUT "(F/M)";PT$
60064 IF PT$ = "M" OR PT$ = "F" THEN 60070
60065 GOTO 60061
60069 REM ITEM NAME SETUP
60070 DIM W$(5):
60072 FOR X = 0 TO 5: READ W$(X): NEXT 
60075 GOSUB 60080: GOSUB 60200: RETURN 

60080 REM FUNCTION DISPLAY PLAYER INFO
60081 GOSUB 23000: CLS: VTAB=3: GOSUB 62000
60082 PRINT "     STAT'S             WEAPONS": PRINT :
60083 FOR X = 0 TO 5: PRINT C$(X);C(X);TAB(23);"0-";W$(X): NEXT
60086 IF PW(0) > 0 THEN :REM CALL 62450 :REM *TODO* WHAT IS THIS DOING?
60087 FOR Z = 0 TO 5
60088 VTAB=(5+Z): GOSUB 62000
60089 PRINT TAB(24-LEN(STR$(PW(Z))))PW(Z): NEXT Z
60090 VTAB=17:GOSUB 62000: PRINT TAB(5);"PRICE";
60091 PRINT TAB(15);"DAMAGE";
60092 PRINT TAB(25);"ITEM"
60100 FOR X = 0 TO 5
60101  VTAB=(19+X): GOSUB 62000
60102  PRINT TAB(25)W$(X)
60103 NEXT X
60110 VTAB=18: GOSUB 62000 
60111 PRINT TAB(5);"1 FOR 10";TAB(15)"N/A"
60112 VTAB=19: GOSUB 62000
60113 PRINT TAB(5);"8";TAB(15);"1-10"
60114 VTAB=20: GOSUB 62000
60115 PRINT TAB(5);"5";TAB(15);"1-5"
60120 VTAB=21: GOSUB 62000
60121 PRINT TAB(5);"6";TAB(15);"1"
60122 VTAB=22: GOSUB 62000
60123 PRINT TAB(5);"3";TAB(15);"1-4"
60124 VTAB=23: GOSUB 62000
60125 PRINT TAB(5);"15";TAB(15);"????" 
60130 RETURN
 
60200 REM FUNCTION ADVENTURE SHOP 
60201 VTAB=11: GOSUB 62000
60205 PRINT "WELCOME TO THE ADVENTURE SHOP"
60210 PRINT "WHICH ITEM SHALT THOU BUY"
60211 PRINT "(F/R/A/S/B/M/QUIT)";: INPUT Q$:
60212 IF Q$ = "Q" THEN PRINT "BYE": RETURN 
60215 Z =  - 1
60220 IF Q$ = "F" THEN PRINT "FOOD":Z = 0:P = 1
60221 IF Q$ = "R" THEN PRINT "RAPIER":Z = 1:P = 8
60222 IF Q$ = "A" THEN PRINT "AXE":Z = 2:P = 5
60223 IF Q$ = "S" THEN PRINT "SHIELD":Z = 3:P = 6
60224 IF Q$ = "B" THEN PRINT "BOW":Z = 4:P = 3
60225 IF Q$ = "M" THEN PRINT "AMULET":Z = 5:P = 15
60226 IF Z = -1 THEN PRINT Q$: PRINT "I'M SORRY WE DON'T HAVE THAT."
60227 IF Z = -1 THEN GOTO 60200
60228 IF Q$="R" AND PT$="M" THEN PRINT "I'M SORRY MAGES,CAN'T USE!": GOTO 60200
60229 IF Q$="B" AND PT$="M" THEN PRINT "I'M SORRY MAGES,CAN'T USE!": GOTO 60200
60230 IF C(5)-P<0 THEN PRINT CHR$($91)"THOU CAN NOT AFFORD IT.": GOTO 60200
60235 IF Z = 0 THEN PW(Z) = PW(Z) + 9
60236 PW(Z) = PW(Z) + 1:C(5) = C(5) - P
60237 VTAB=9: GOSUB 62000: PRINT TAB(15)"     "
60238 VTAB=9: GOSUB 62000: PRINT TAB(15)C(5)
60240 VTAB=(4+Z): GOSUB 62000
60241 PRINT TAB(24 -  LEN ( STR$ (PW(Z))));PW(Z);TAB(1)
60242 VTAB=14: GOSUB 62000: PRINT
60250 GOTO 60200

62000 REM FUNCTION VTAB
62001 REM APPLSOFT HAS A VERTICAL TAB COMMAND
62002 REM CREATING MY OWN, VARIABLE USED IS CALLED VTAB
62010 POKE $030D,VTAB: REM SET THE CURSOR Y LOCATION
62020 SYS $FFF0: REM CALL KERNAL PLOT COMMAND
62050 RETURN

63000 REM ALL DATA IS HERE
63001 REM THE ORDER IN WHICH THE DATA IS SORTED HERE AFFECTS HOW IT IS READ
63020 REM DATA FOR FUNCTION 60000, LINE 60030
63021 DATA "HIT POINTS.....","STRENGTH.......","DEXTERITY......"
63022 DATA "STAMINA........","WISDOM.........","GOLD..........."
63030 REM DATA FOR FUNCTION 60000, LINE 60044
63031 DATA "SKELETON","THIEF","GIANT RAT","ORC","VIPER"
63032 DATA "CARRION CRAWLER","GREMLIN","MIMIC","DAEMON","BALROG"
63040 REM DATA FOR FUNCTION 60000, LINE 60072
63041 DATA "FOOD","RAPIER","AXE","SHIELD","BOW AND ARROWS","MAGIC AMULET"
