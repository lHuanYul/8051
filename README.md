# 大二下微處理機專題8051
##	操作說明(UTF-8)
### Controller
#### In any mode
* If you want to RETURN to last just press '*'
* Press 'A' to swich NORMAL/ALL LIGHT/ALL DARK
* Press 'D' to STOP the RING
```
-Layer like-
Start
	1.Row1
		1.Ring
		3.Door
		4.Window
		7.Clock
			1.Month&Date
			2.Hour&Minute
		8.Alarm
			1.Alarm1
			2.Alarm2
			3.Alarm3
			4.Alarm4
	2.Row2
	3.Row3
	4.Row4
```
#### 1. Start
``` 	
-LED display like-
   12345678
1 ●●●●●●●●●
2 ●●●●●●●●●
  ○             
3 ●●●●●●●●●
4 ●●●●●●●●●
```

#### 2. Select Row
```
ex. Press 1
-LED display like-
   12345678
1 ○●●●●●●●●
2 ●●●●●●●●●
  ●             
3 ●●●●●●●●●
4 ●●●●●●●●●
```

#### 3. Select Mode 
> 1.Ring, 3.Door, 4.Window, 7.Clock, 8.Alarm
```
ex. Press 3
-LED display like-
   12345678
1 ●●●○●●●●●
2 ●●●●●●●●●
  ●             
3 ●●●●●●●●●
4 ●●●●●●●●●
```
#### 4. In mode
*	1.Ring
	*	Press '01-04'(2 number)+'#' to select MUSIC

*	3.Door
	*	Press '0' to swich LOCK;
	*	'1' to swich LIGHT

*	4.Window
	*	Press '0' to STOP;
	*	'1' to CLOSE;
	*	'2' to HALF open; 
	*	'3' to OPEN

*	7.Clock
	*	Press '1' to set MONTH and DATE;
	*	'2' to set HOUR and MINUTE
	*	('0' to swich mode if the DOT on clock don't DISAPPEAR when you EXIT)
	*	Than press like '0619'(4 number)+'#' to SET time

*	8.Alarm
	*	Press 1-4 to CHOSE alarm
	*	Than press like '1230'(4 number)+'#' to SET alarm

### Door
*	Press 0-9 to KEY IN password (password is 123456)
*	Press '*' to CLEAR input
*	Press 'D' to RING the doorbell


