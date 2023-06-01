CREATE DATABASE IPL
USE IPL

SELECT * FROM IPL_Matches_2008_2022
SELECT * FROM IPL_Ball_by_Ball_2008_2022

SELECT DISTINCT(Team1) FROM IPL_Matches_2008_2022

--UPDATING TEAM NAMES IN BOTH TABLES:
-- DELHI DAREDEVILS TO DELHI CAPITALS
UPDATE IPL_Matches_2008_2022
SET Team1 = 'Delhi Capitals'
WHERE Team1 = 'Delhi Daredevils'

UPDATE IPL_Matches_2008_2022
SET Team2 = 'Delhi Capitals'
WHERE Team2 = 'Delhi Daredevils'

UPDATE IPL_Matches_2008_2022
SET WinningTeam = 'Delhi Capitals'
WHERE WinningTeam = 'Delhi Daredevils'

UPDATE IPL_Matches_2008_2022
SET TossWinner = 'Delhi Capitals'
WHERE TossWinner = 'Delhi Daredevils'

UPDATE IPL_Ball_by_Ball_2008_2022
SET BattingTeam = 'Delhi Capitals'
WHERE BattingTeam = 'Delhi Daredevils'

-- DECCAN CHARGERS TO SUNRISERS HYDERABAD
UPDATE IPL_Matches_2008_2022
SET Team1 = 'Sunrisers Hyderabad'
WHERE Team1 = 'Deccan Chargers'

UPDATE IPL_Matches_2008_2022
SET Team2 = 'Sunrisers Hyderabad'
WHERE Team2 = 'Deccan Chargers'

UPDATE IPL_Matches_2008_2022
SET WinningTeam = 'Sunrisers Hyderabad'
WHERE WinningTeam = 'Deccan Chargers'

UPDATE IPL_Matches_2008_2022
SET TossWinner = 'Sunrisers Hyderabad'
WHERE TossWinner = 'Deccan Chargers'

UPDATE IPL_Ball_by_Ball_2008_2022
SET BattingTeam = 'Sunrisers Hyderabad'
WHERE BattingTeam = 'Deccan Chargers'

-- Rising Pune Supergiant to Pune Warriors
UPDATE IPL_Matches_2008_2022
SET Team1 = 'Pune Warriors'
WHERE Team1 = 'Rising Pune Supergiant'

UPDATE IPL_Matches_2008_2022
SET Team2 = 'Pune Warriors'
WHERE Team2 = 'Rising Pune Supergiant'

UPDATE IPL_Matches_2008_2022
SET WinningTeam = 'Pune Warriors'
WHERE WinningTeam = 'Rising Pune Supergiant'

UPDATE IPL_Matches_2008_2022
SET TossWinner = 'Pune Warriors'
WHERE TossWinner = 'Rising Pune Supergiant'

UPDATE IPL_Ball_by_Ball_2008_2022
SET BattingTeam = 'Pune Warriors'
WHERE BattingTeam = 'Rising Pune Supergiant'

--Rising Pune Supergiants to Pune Warriors
UPDATE IPL_Matches_2008_2022
SET Team1 = 'Pune Warriors'
WHERE Team1 = 'Rising Pune Supergiants'

UPDATE IPL_Matches_2008_2022
SET Team2 = 'Pune Warriors'
WHERE Team2 = 'Rising Pune Supergiants'

UPDATE IPL_Matches_2008_2022
SET WinningTeam = 'Pune Warriors'
WHERE WinningTeam = 'Rising Pune Supergiants'

UPDATE IPL_Matches_2008_2022
SET TossWinner = 'Pune Warriors'
WHERE TossWinner = 'Rising Pune Supergiants'

UPDATE IPL_Ball_by_Ball_2008_2022
SET BattingTeam = 'Pune Warriors'
WHERE BattingTeam = 'Rising Pune Supergiants'

--Gujarat Lions to Gujarat Titans
UPDATE IPL_Matches_2008_2022
SET Team1 = 'Gujarat Titans'
WHERE Team1 = 'Gujarat Lions'

UPDATE IPL_Matches_2008_2022
SET Team2 = 'Gujarat Titans'
WHERE Team2 = 'Gujarat Lions'

UPDATE IPL_Matches_2008_2022
SET WinningTeam = 'Gujarat Titans'
WHERE WinningTeam = 'Gujarat Lions'

UPDATE IPL_Matches_2008_2022
SET TossWinner = 'Gujarat Titans'
WHERE TossWinner = 'Gujarat Lions'

UPDATE IPL_Ball_by_Ball_2008_2022
SET BattingTeam = 'Gujarat Titans'
WHERE BattingTeam = 'Gujarat Lions'

--Kings XI Punjab to Punjab Kings
UPDATE IPL_Matches_2008_2022
SET Team1 = 'Punjab Kings'
WHERE Team1 = 'Kings XI Punjab'

UPDATE IPL_Matches_2008_2022
SET Team2 = 'Punjab Kings'
WHERE Team2 = 'Kings XI Punjab'

UPDATE IPL_Matches_2008_2022
SET WinningTeam = 'Punjab Kings'
WHERE WinningTeam = 'Kings XI Punjab'

UPDATE IPL_Matches_2008_2022
SET TossWinner = 'Punjab Kings'
WHERE TossWinner = 'Kings XI Punjab'

UPDATE IPL_Ball_by_Ball_2008_2022
SET BattingTeam = 'Punjab Kings'
WHERE BattingTeam = 'Kings XI Punjab'

SELECT DISTINCT(Team2) FROM IPL_Matches_2008_2022

-------- ANALYSING THE DATA --------

--1.	What are the total number of matches played in the IPL dataset?
SELECT COUNT(*) FROM IPL_Matches_2008_2022

--2.	Which team has won the maximum number of matches in the IPL dataset?
SELECT WinningTeam,COUNT(*) FROM IPL_Matches_2008_2022
GROUP BY WinningTeam
ORDER BY COUNT(*) DESC
OFFSET 0 ROWS
FETCH NEXT 1 ROWS ONLY

--3.	Which team has lost the maximum number of matches in the IPL dataset?
WITH CTE(Team1,Loss) AS (SELECT Team1,COUNT(*) AS 'Loss' FROM IPL_Matches_2008_2022
WHERE Team1 != WinningTeam
GROUP BY Team1
UNION ALL
SELECT Team2,COUNT(*) AS 'Loss' FROM IPL_Matches_2008_2022
WHERE Team2 != WinningTeam
GROUP BY Team2) 
SELECT TOP 1 Team1,SUM(Loss) AS 'No. of Losses' FROM CTE
GROUP BY Team1
ORDER BY 'No. of Losses' DESC

--4.	Which player has taken the maximum number of wickets in the IPL dataset?
SELECT TOP 1 bowler,COUNT(*) as Wickets FROM IPL_Ball_by_Ball_2008_2022
WHERE IsWicketDelivery = 1
GROUP BY bowler
ORDER BY Wickets DESC

--5.	Which player has scored the maximum number of runs in the IPL dataset?
SELECT TOP 1 batter,SUM(batsman_run) AS total_runs FROM IPL_Ball_by_Ball_2008_2022
GROUP BY batter
ORDER BY total_runs DESC

--6.	Which team has won the most number of matches in a particular season?
SELECT * FROM (SELECT Season,WinningTeam,COUNT(*) AS 'No of Matches Won',
				RANK() OVER(PARTITION BY Season ORDER BY COUNT(*) DESC) AS match_rank
				FROM IPL_Matches_2008_2022
				GROUP BY Season,WinningTeam) T
WHERE T.match_rank < 2
ORDER BY Season

--7.	What is the total number of sixes hit by a particular player?
SELECT batter,COUNT(batsman_run) AS 'No of Sixes' FROM IPL_Ball_by_Ball_2008_2022
WHERE batsman_run = 6
GROUP BY batter
ORDER BY 'No of Sixes' DESC

--8.	Which team has won the maximum number of matches while batting first?
SELECT TOP 1 WinningTeam,COUNT(*) AS 'WON' FROM IPL_Matches_2008_2022 A
JOIN (
SELECT ID,BattingTeam FROM IPL_Ball_by_Ball_2008_2022
WHERE innings = 1
GROUP BY ID,BattingTeam) AS T
ON T.ID=A.ID
WHERE T.BattingTeam = A.WinningTeam
GROUP BY WinningTeam
ORDER BY 'WON' DESC

--9.	Which team has won the maximum number of matches while chasing a target?
SELECT TOP 1 WinningTeam,COUNT(*) AS 'WON' FROM IPL_Matches_2008_2022 A 
JOIN (SELECT ID,BattingTeam FROM IPL_Ball_by_Ball_2008_2022
WHERE innings = 2
GROUP BY ID,BattingTeam) AS T
ON T.ID = A.ID
WHERE T.BattingTeam = A.WinningTeam
GROUP BY WinningTeam
ORDER BY 'WON' DESC

--10.	What is the highest individual score in the IPL dataset and who has achieved it?
SELECT TOP 1 batter,SUM(batsman_run) AS 'Individual Score' FROM IPL_Ball_by_Ball_2008_2022
GROUP BY batter
ORDER BY 'Individual Score' DESC

--11.	Which team has won the maximum number of matches at their home ground?
SELECT TOP 1 WinningTeam,City,Count(*) AS 'WINS' FROM IPL_Matches_2008_2022
GROUP BY WinningTeam,City
ORDER BY 'WINS' DESC

--12.	Which team has won the maximum number of matches at a particular venue?
SELECT TOP 1 WinningTeam,Venue,COUNT(*) AS 'WINS' FROM IPL_Matches_2008_2022
GROUP BY WinningTeam,Venue
ORDER BY 'WINS' DESC

--13.	Which player has scored the maximum number of centuries in the IPL dataset?
SELECT TOP 1 batter,COUNT(*) AS 'No of Centuries' 
FROM (SELECT ID,batter,SUM(batsman_run) AS 'RUNS' FROM IPL_Ball_by_Ball_2008_2022
GROUP BY ID,batter
HAVING SUM(batsman_run) > 99) T
GROUP BY batter
ORDER BY 'No of Centuries' DESC

--14.	Which player has scored the maximum number of half-centuries in the IPL dataset?
SELECT TOP 1 batter,COUNT(*) AS 'NO OF HALF CENTURIES' 
FROM (SELECT ID,batter,SUM(batsman_run) AS 'RUNS' FROM IPL_Ball_by_Ball_2008_2022
GROUP BY ID,batter
HAVING SUM(batsman_run) BETWEEN 50 AND 99) T
GROUP BY batter
ORDER BY 'NO OF HALF CENTURIES' DESC

--15.	What is the average score of a team in the IPL dataset?
SELECT BattingTeam,AVG(T.RUNS) AS 'AVG SCORE' 
FROM (SELECT ID,BattingTeam,SUM(batsman_run) AS 'RUNS' FROM IPL_Ball_by_Ball_2008_2022
GROUP BY ID,BattingTeam) T
GROUP BY BattingTeam
ORDER BY 'AVG SCORE' DESC

--16.	Which team has the highest win percentage in the IPL dataset?
SELECT TOP 1 BattingTeam,ROUND((((1.0*T4.WINS)/(1.0*T3.[NO OF MATCHES]))*100),2) AS 'WIN %' 
FROM (SELECT BattingTeam,COUNT(*) AS 'NO OF MATCHES'
FROM (SELECT ID,BattingTeam FROM IPL_Ball_by_Ball_2008_2022
GROUP BY ID,BattingTeam) T2
GROUP BY BattingTeam) T3
JOIN (SELECT WinningTeam,COUNT(*) AS 'WINS' FROM IPL_Matches_2008_2022
GROUP BY WinningTeam)T4
ON T4.WinningTeam = T3.BattingTeam
ORDER BY 'WIN %' DESC

--17.	Which team has the lowest win percentage in the IPL dataset?
SELECT TOP 1 BattingTeam,ROUND((((1.0*T4.WINS)/(1.0*T3.[NO OF MATCHES]))*100),2) AS 'WIN %' 
FROM (SELECT BattingTeam,COUNT(*) AS 'NO OF MATCHES'
FROM (SELECT ID,BattingTeam FROM IPL_Ball_by_Ball_2008_2022
GROUP BY ID,BattingTeam) T2
GROUP BY BattingTeam) T3
JOIN (SELECT WinningTeam,COUNT(*) AS 'WINS' FROM IPL_Matches_2008_2022
GROUP BY WinningTeam)T4
ON T4.WinningTeam = T3.BattingTeam
ORDER BY 'WIN %' 

--18. 	Which team has won the IPL title the most number of times?
SELECT TOP 1 WinningTeam,COUNT(*) AS 'WINS' FROM IPL_Matches_2008_2022
WHERE MatchNumber = 'Final'
GROUP BY WinningTeam
ORDER BY 'WINS' DESC

--19.	Which player has won the maximum number of Man of the Match awards in the IPL dataset?
SELECT TOP 1 Player_of_Match,COUNT(*) AS 'MAX P.O.M WINS' FROM IPL_Matches_2008_2022
GROUP BY Player_of_Match
ORDER BY [MAX P.O.M WINS] DESC

--20.	Which team has won the maximum number of matches by 
--the biggest margin in terms of runs in the IPL dataset?
SELECT TOP 1 T1.BattingTeam,SUM([TOTAL RUNS]-[TOTAL RUNS 2]) AS 'DIFF' FROM (SELECT ID,BattingTeam,SUM(total_run) AS 'TOTAL RUNS' FROM IPL_Ball_by_Ball_2008_2022
WHERE innings = 1
GROUP BY ID,BattingTeam) T
JOIN (SELECT ID,BattingTeam,SUM(total_run) AS 'TOTAL RUNS 2' FROM IPL_Ball_by_Ball_2008_2022
WHERE innings = 2
GROUP BY ID,BattingTeam) T1
ON T.ID = T1.ID
GROUP BY T1.BattingTeam
ORDER BY DIFF DESC

--21.	What is the average number of runs scored per over in the IPL dataset?
SELECT AVG(T.[RUNS PER OVER]) 
FROM (SELECT ID,innings,overs,BattingTeam,SUM(total_run) AS 'RUNS PER OVER' 
		FROM IPL_Ball_by_Ball_2008_2022
		GROUP BY ID,innings,overs,BattingTeam) T

--22.	What is the total number of catches taken by a particular player or team in the IPL dataset?
SELECT fielders_involved,COUNT(*) AS 'No. of Catches' FROM IPL_Ball_by_Ball_2008_2022
WHERE kind = 'caught'
GROUP BY fielders_involved
ORDER BY [No. of Catches] DESC

--23.	Which team has won the maximum number of matches in the Super Over in the IPL dataset?
SELECT TOP 1 WinningTeam,COUNT(*) AS 'WINS' FROM IPL_Matches_2008_2022
WHERE SuperOver = 1
GROUP BY WinningTeam
ORDER BY WINS DESC

--24.	Which bowler has conceded the maximum number of runs in the IPL dataset?
SELECT TOP 1 bowler,SUM(total_run) AS 'RUNS CONCEDED' FROM IPL_Ball_by_Ball_2008_2022
GROUP BY bowler
ORDER BY [RUNS CONCEDED] DESC

--25.	Which bowler has bowled the maximum number of dot balls in the IPL dataset?
SELECT TOP 1 BOWLER,COUNT(*) AS 'DOT BALLS' FROM IPL_Ball_by_Ball_2008_2022
WHERE total_run = 0
GROUP BY bowler
ORDER BY [DOT BALLS] DESC

--26.	Which team has won the maximum number of matches in a particular city in the IPL dataset?
SELECT City,WinningTeam,COUNT(*) AS 'WINS' FROM IPL_Matches_2008_2022
GROUP BY City,WinningTeam
ORDER BY WINS DESC

--27.	Which player has won the maximum number of Purple Cap awards in the IPL dataset?
SELECT TOP 1 bowler,COUNT(*) AS 'P.C WINNER' FROM (SELECT T2.Season,bowler,SUM(1*isWicketDelivery) AS 'WICKETS',
DENSE_RANK() OVER(PARTITION BY T2.Season ORDER BY SUM(1*isWicketDelivery) DESC) AS 'RANKING'
FROM IPL_Ball_by_Ball_2008_2022 T1
JOIN IPL_Matches_2008_2022 T2
ON T1.ID = T2.ID
GROUP BY T2.Season,bowler) T
WHERE T.RANKING=1
GROUP BY bowler
ORDER BY 'P.C WINNER' DESC

--28.	Which player has won the maximum number of Orange Cap awards in the IPL dataset?
SELECT TOP 1 batter,COUNT(*) AS 'O.C. WINNER' FROM (SELECT * FROM (SELECT Season,batter,SUM(batsman_run) AS 'RUNS', 
DENSE_RANK() OVER(PARTITION BY Season ORDER BY SUM(batsman_run) DESC) AS 'RANKING'
FROM IPL_Ball_by_Ball_2008_2022 T1
JOIN IPL_Matches_2008_2022 T2
ON T1.ID=T2.ID
GROUP BY Season,batter) T
WHERE T.RANKING = 1) T3
GROUP BY batter
ORDER BY 'O.C. WINNER' DESC

--29.	What is the highest team total in the IPL dataset and who has achieved it?
SELECT TOP 1 ID,BattingTeam,SUM(total_run) AS 'RUNS' FROM IPL_Ball_by_Ball_2008_2022
GROUP BY ID,BattingTeam
ORDER BY 'RUNS' DESC

--30.	Which team has scored the maximum number of fours in the IPL dataset?
SELECT TOP 1 BattingTeam,COUNT(*) AS 'NO OF 4S' FROM IPL_Ball_by_Ball_2008_2022
WHERE batsman_run = 4
GROUP BY BattingTeam
ORDER BY 'NO OF 4S' DESC

--31.	What is the highest partnership in the IPL dataset and who has achieved it?
SELECT TOP 1 K.batter,K.non_striker,(RUNS+RUNS2)AS 'TOTAL RUNS' 
FROM (SELECT T.ID,T.batter,T.non_striker,T.RUNS AS 'RUNS',T1.batter AS BATTER1,
T1.non_striker AS NONSTRIKER1,SUM(T1.total_run) AS RUNS2
FROM (SELECT ID,batter,non_striker,SUM(total_run) AS 'RUNS' FROM IPL_Ball_by_Ball_2008_2022
GROUP BY ID,batter,non_striker) T
JOIN IPL_Ball_by_Ball_2008_2022 T1
ON T.ID=T1.ID AND T1.batter=T.non_striker AND T1.non_striker=T.batter
GROUP BY T.ID,T.batter,T.non_striker,T1.batter,T1.non_striker,T.RUNS) K
ORDER BY 'TOTAL RUNS' DESC

--32.	Which player has taken the maximum number of catches in the IPL dataset?
SELECT TOP 1 fielders_involved,COUNT(*) AS 'CATCHES' FROM IPL_Ball_by_Ball_2008_2022
WHERE fielders_involved != 'NA'
GROUP BY fielders_involved
ORDER BY CATCHES DESC

--33.	Which player has the highest batting average in the IPL dataset?
SELECT batter,((1.0*SUM(T.RUNS))/(1.0*SUM(T.OUT))) AS 'AVG' 
FROM (SELECT batter,SUM(batsman_run) AS 'RUNS',
SUM(1*isWicketDelivery) AS 'OUT'
FROM IPL_Ball_by_Ball_2008_2022
GROUP BY batter)T
GROUP BY batter
HAVING (1.0*SUM(T.OUT)) > 10
ORDER BY 'AVG' DESC

--34.	Which player has scored the maximum number of runs in the death overs in the IPL dataset?
--CONSIDERING LAST 5 OVERS AS DEATH OVERS OF EVERY INNING--
SELECT ID,batter,SUM(batsman_run) AS 'RUNS' FROM IPL_Ball_by_Ball_2008_2022
WHERE overs BETWEEN 15 AND 20
GROUP BY ID,batter
ORDER BY 'RUNS' DESC

--35.	Which bowler has taken the maximum number of wickets in the death overs in the IPL dataset?
--CONSIDERING LAST 5 OVERS AS DEATH OVERS OF EVERY INNING--
SELECT ID,bowler,SUM(1*isWicketDelivery) AS 'WICKETS' FROM IPL_Ball_by_Ball_2008_2022
WHERE overs BETWEEN 15 AND 20
GROUP BY ID,bowler
ORDER BY WICKETS DESC

--36.	What is the average score of a team batting first while playing at a particular venue?
SELECT T1.Venue,T.BattingTeam,AVG(T.RUNS) AS 'AVG'
FROM (SELECT ID,BattingTeam,SUM(total_run) AS 'RUNS' FROM IPL_Ball_by_Ball_2008_2022
WHERE innings = 1
GROUP BY ID,BattingTeam) T
JOIN IPL_Matches_2008_2022 T1
ON T.ID = T1.ID
GROUP BY T1.Venue,T.BattingTeam
ORDER BY 'AVG' DESC

--37.	What is the average score of a team batting second while playing at a particular venue?
SELECT T1.Venue,T.BattingTeam,AVG(T.RUNS) AS 'AVG'
FROM (SELECT ID,BattingTeam,SUM(total_run) AS 'RUNS' FROM IPL_Ball_by_Ball_2008_2022
WHERE innings = 2
GROUP BY ID,BattingTeam) T
JOIN IPL_Matches_2008_2022 T1
ON T.ID = T1.ID
GROUP BY T1.Venue,T.BattingTeam
ORDER BY 'AVG' DESC

--38.	Which player has the highest strike rate in the IPL dataset?
-- SR: (RUNS/BALLS)*100 
SELECT batter,((1.0*SUM(batsman_run)/(1.0*COUNT(batter)))*100) AS SR FROM IPL_Ball_by_Ball_2008_2022
GROUP BY batter
HAVING COUNT(batter)>300
ORDER BY SR DESC

--39.	Which player has the highest strike rate in the death overs in the IPL dataset?
--(CONSIDERING LAST 5 OVERS AS DEATH OVERS)
SELECT batter,((1.0*SUM(batsman_run))/(1.0*COUNT(batter)))*100 AS SR FROM IPL_Ball_by_Ball_2008_2022
WHERE overs BETWEEN 15 AND 20
GROUP BY batter
HAVING COUNT(batter)>30
ORDER BY SR DESC

--40.	Which player has scored the maximum number of runs in a single IPL season and which season was it?
SELECT TOP 1 T2.Season,T1.batter,SUM(T1.batsman_run) AS RUNS FROM IPL_Ball_by_Ball_2008_2022 T1
JOIN IPL_Matches_2008_2022 T2
ON T1.ID = T2.ID
GROUP BY T2.Season,T1.batter
ORDER BY RUNS DESC

--41.	Which team has won the maximum number of matches while batting second in the IPL dataset?
SELECT TOP 1 T3.BattingTeam,COUNT(*) AS WINS FROM (SELECT T.*,T2.WinningTeam 
FROM (SELECT DISTINCT(ID),BattingTeam FROM IPL_Ball_by_Ball_2008_2022
WHERE innings = 2) T
JOIN IPL_Matches_2008_2022 T2
ON T.ID = T2.ID
WHERE BattingTeam = WinningTeam) T3
GROUP BY T3.BattingTeam
ORDER BY WINS DESC

--42.	Which team has won the maximum number of matches while batting first in the IPL dataset?
SELECT TOP 1 T3.BattingTeam,COUNT(*) AS WINS FROM (SELECT T.*,T2.WinningTeam 
FROM (SELECT DISTINCT(ID),BattingTeam FROM IPL_Ball_by_Ball_2008_2022
WHERE innings = 1) T
JOIN IPL_Matches_2008_2022 T2
ON T.ID = T2.ID
WHERE BattingTeam = WinningTeam) T3
GROUP BY T3.BattingTeam
ORDER BY WINS DESC

--43.	Which team has the highest run rate in the death overs in the IPL dataset?
SELECT TOP 1 BattingTeam,(1.0*SUM(total_run))/5.0 AS RR FROM IPL_Ball_by_Ball_2008_2022
WHERE overs BETWEEN 15 AND 20
GROUP BY ID,innings,BattingTeam
ORDER BY RR DESC

--44.	Which player has hit the maximum number of sixes in the IPL dataset?
SELECT TOP 1 batter,COUNT(batter) AS 'NO OF SIXES' FROM IPL_Ball_by_Ball_2008_2022
WHERE batsman_run = 6
GROUP BY batter
ORDER BY 'NO OF SIXES' DESC

--45.	Which team has won the maximum number of matches while playing on a particular day and at a particular venue?
SELECT TOP 1 DAY(DATE) AS 'DATE',Venue,WinningTeam,COUNT(WinningTeam) AS WINS FROM IPL_Matches_2008_2022
GROUP BY DAY(DATE),Venue,WinningTeam
ORDER BY WINS DESC

--46.	Which player has scored the maximum number of runs in a single match in the IPL dataset and against which team?
SELECT TOP 1 T1.ID,batter,SUM(batsman_run) AS RUNS,T1.AGAINST 
FROM (SELECT ID,
CASE WHEN Team1 != WinningTeam THEN Team1
	 ELSE Team2
END AS 'AGAINST'
FROM IPL_Matches_2008_2022) T1
JOIN IPL_Ball_by_Ball_2008_2022 T2
ON T1.ID = T2.ID
GROUP BY T1.ID,batter,T1.AGAINST
ORDER BY RUNS DESC

--47.	Which bowler has conceded the maximum number of runs in a single match in the IPL dataset and against which team?
SELECT TOP 1 ID,bowler,BattingTeam,SUM(total_run) AS RUNS FROM IPL_Ball_by_Ball_2008_2022
GROUP BY ID,bowler,BattingTeam
ORDER BY RUNS DESC

--48.	Which team has won the maximum number of matches by the minimum margin of runs in the IPL dataset?
SELECT TOP 1 T4.WinningTeam,COUNT(WinningTeam) AS WINS FROM (SELECT T.ID,T.BattingTeam,ABS(T.RUNS-T1.RUNS) AS DIFF FROM(SELECT ID,BattingTeam,SUM(total_run) AS RUNS FROM IPL_Ball_by_Ball_2008_2022
WHERE innings = 1
GROUP BY ID,BattingTeam) T
JOIN (SELECT ID,BattingTeam,SUM(total_run) AS RUNS FROM IPL_Ball_by_Ball_2008_2022
WHERE innings = 2
GROUP BY ID,BattingTeam) T1
ON T.ID = T1.ID) T3
JOIN IPL_Matches_2008_2022 T4
ON T3.ID = T4.ID
WHERE DIFF=1
GROUP BY WinningTeam
ORDER BY WINS DESC

--49.	Which team has won the maximum number of matches by the minimum margin of wickets in the IPL dataset?
SELECT TOP 1 WinningTeam,COUNT(WinningTeam) AS WINS FROM (SELECT T.*,T1.WinningTeam
FROM (SELECT ID,BattingTeam,innings,(10-SUM(1*isWicketDelivery)) AS WON_BY_WICKETS FROM IPL_Ball_by_Ball_2008_2022
GROUP BY ID,BattingTeam,innings) T
JOIN IPL_Matches_2008_2022 T1
ON T.ID =T1.ID
WHERE WinningTeam = BattingTeam AND WON_BY_WICKETS=1) T2
GROUP BY WinningTeam
ORDER BY WINS DESC

--50.	Which player has scored the maximum number of runs in a death over in the IPL dataset?
SELECT TOP 1 ID,batter,SUM(batsman_run) AS RUNS FROM IPL_Ball_by_Ball_2008_2022
WHERE overs BETWEEN 15 AND 20
GROUP BY ID,batter
ORDER BY RUNS DESC












