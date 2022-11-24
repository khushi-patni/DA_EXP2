/* Generated Code (IMPORT) */
/* Source File: credit_train.csv */
/* Source Path: /home/u62333421/sasuser.v94 */
/* Code generated on: 11/24/22, 10:40 AM */

%web_drop_table(WORK.IMPORT);


FILENAME REFFILE '/home/u62333421/sasuser.v94/credit_train.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=WORK.IMPORT;
	GETNAMES=YES;
RUN;

PROC CONTENTS DATA=WORK.IMPORT; RUN;


%web_open_table(WORK.IMPORT);

PROC means DATA=WORK.IMPORT mean median mode std var min max;
run;

/* Missing values in our dataset */
PROC means DATA=WORK.IMPORT nmiss;
run;

PROC SQL;
select count(distinct 'Loan Status'n) as 'Loan Status'n,
       count(distinct Bankruptcies) as Bankruptcies,
       count(distinct Term) as Term,
       count(distinct 'Credit Score'n) as 'Credit Score'n,
       count(distinct 'Monthly Debt'n) as 'Monthly Debt'n
  from WORK.IMPORT;
QUIT;

/* You can give multiple variables in this procedure to create histograms */
PROC univariate DATA=WORK.IMPORT  novarcontents;
histogram 'Current Loan Amount'n 'Credit Score'n / ;
run;
/* Creating histogram with only one variable (i.e Credit Score) */
ods graphics / reset width=6.4in height=4.8in imagemap;
proc sgplot DATA=WORK.IMPORT;
	histogram 'Credit Score'n /;
	yaxis grid;
RUN;

/* Checking Relationship between two variables by using scatter plot */
ods graphics / reset width=6.4in height=4.8in imagemap;
PROC sgplot DATA=WORK.IMPORT;
	scatter x='Number of Open Accounts'n y='Current Credit Balance'n /;
	xaxis grid;
	yaxis grid;
RUN;
ods graphics / reset;

/* Correaltion among numeric variables */
ods noproctitle;
ods graphics / imagemap=on;
PROC corr DATA=WORK.IMPORT pearson nosimple noprob plots=none;
	var 'Current Loan Amount'n 'Credit Score'n 'Annual Income'n 'Monthly Debt'n 
		'Years of Credit History'n 'Number of Open Accounts'n 
		'Number of Credit Problems'n 'Current Credit Balance'n 'Maximum Open Credit'n 
		Bankruptcies 'Tax Liens'n;
RUN;

/* Box plot for checking outliers in the data */
ods graphics / reset width=6.4in height=4.8in imagemap;
proc sgplot  DATA=WORK.IMPORT;
	vbox 'Credit Score'n  / category='Loan Status'n;
	yaxis grid;
run;
ods graphics / reset;