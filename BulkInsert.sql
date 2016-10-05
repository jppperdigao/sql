----------------------------------------------------------------------------------------------------------------------------------------------------------------------
--
--	Bulk
--
--	2016-10-02
--
--	Sintax to do a bulk insert
--
--	João Perdigão
--
----------------------------------------------------------------------------------------------------------------------------------------------------------------------

use Saturn; --db

/*
Create a *.csv called example.csv with the following content:
lisbon|portugal
oporto|portugal
evora|portugal
madrid|spain
barcelona|spain
seville|spain
*/

CREATE TABLE saturn.dbo.example (
city varchar(25) null,
country varchar(25) null
);

--SELECT * FROM saturn.dbo.example; --0 rows

BULK INSERT saturn.dbo.example
FROM 'C:\Joao\example.csv' --source
WITH (
       FIRSTROW = 1, --2 with header or 1 without header
       CODEPAGE = '1252',-- ANSI 1252 Windows West European Latin 1
       DATAFILETYPE = 'char',--character format (default)
       FIELDTERMINATOR = '|', --separator
       ROWTERMINATOR = '\n', --new line
       ERRORFILE =  'C:\Joao\example.csv_error.txt', --fill in the name of the error file
       TABLOCK  --speeds up the bulk insert as it locks the table as a whole
);

SELECT * FROM saturn.dbo.example; --6 rows

-------------------------------------------------------------------------------END------------------------------------------------------------------------------------
