----------------------------------------------------------------------------------------------------------------------------------------------------------------------
--
--	Dimension Time
--
--	2016-09-29
--
--	Create a calendar to use as dim time
--
--	João Perdigão
--
----------------------------------------------------------------------------------------------------------------------------------------------------------------------

--var
DECLARE @todate datetime; 
DECLARE @fromdate datetime;

set @fromdate = '2016-01-01';
set @todate = '2017-12-31';
 
--calendar
WITH DateSequence ([Date]) AS
(
    SELECT @fromdate AS [Date]
    UNION ALL
    SELECT dateadd(day, 1, [Date]) FROM DateSequence WHERE [Date] < @todate
)
SELECT
     CONVERT(VARCHAR,[Date],112)																												AS [Date]
	,CONVERT(VARCHAR(10),[Date],126)																											AS [DateType1]
	,CONVERT(VARCHAR,[Date],102)																												AS [DateType2]
	,CONVERT(VARCHAR,[Date],100)																												AS [DateType3]
	,[Date]																																		AS [DateType4]
    ,DATEPART(DAY,[Date])																														AS [Day]
    ,CASE
         WHEN DATEPART(DAY,[Date]) = 1 THEN CAST(DATEPART(DAY,[Date]) AS VARCHAR) + 'st'
         WHEN DATEPART(DAY,[Date]) = 2 THEN CAST(DATEPART(DAY,[Date]) AS VARCHAR) + 'nd'
         WHEN DATEPART(DAY,[Date]) = 3 THEN CAST(DATEPART(DAY,[Date]) AS VARCHAR) + 'rd'
         ELSE CAST(DATEPART(DAY,[Date]) AS VARCHAR) + 'th'
    END																																			AS [DaySuffix]
    ,DATENAME(dw, [Date])																														AS [DayOfWeek]
    ,DATEPART(DAYOFYEAR,[Date])																													AS [DayOfYear]
    ,DATEPART(WEEK,[Date])																														AS [WeekOfYear]
    ,DATEPART(WEEK,[Date]) + 1 - DATEPART(WEEK,CAST(DATEPART(MONTH,[Date]) AS VARCHAR) + '/1/' + CAST(DATEPART(YEAR,[Date]) AS VARCHAR))		AS [WeekOfMonth]
    ,DATEPART(MONTH,[Date])																														AS [Month]
    ,DATENAME(MONTH,[Date])																														AS [MonthName]
	,UPPER(left(DATENAME(MONTH,[Date]),3))																										AS [ShortMonthName]
    ,DATEPART(QUARTER,[Date])																													AS [Quarter]
    ,CASE DATEPART(QUARTER,[Date])
        WHEN 1 THEN 'First'
        WHEN 2 THEN 'Second'
        WHEN 3 THEN 'Third'
        WHEN 4 THEN 'Fourth'
    END as [QuarterName]
    ,DATEPART(YEAR,[Date])																														AS [Year]
from DateSequence option (MaxRecursion 10000);

-------------------------------------------------------------------------------END------------------------------------------------------------------------------------