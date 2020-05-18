# Pewlett-Hackard-Analysis

A senior member of Pewlett Hackard requested a detailed analysis of current employees, stratified by age, hire-date and department, aimed at identifying those eligible for retirement. Identifying this subset of employees will allow for strategic planning to help mitigate the impact of this impending workforce reduction. 

The data was presented in comma-separated-values (or CSV) format, comprised of several distinct but interrelated tables. The cardinal step in the overall analysis was establishing the unique references within each table and characterizing how those references related to, or defined, values in the other tables. Visually, this is easily accomplished by creating an entity-relationship-diagram, or ERD (represented as ERD.png in this repository). Once the ERD was constructed, the rate-limiting component in the data analysis workflow was the removal of duplicate entries across the generated tables, as one employee may have worked for or managed several different departments during his or her tenure, for example. The skeleton code for removal of duplicates and partitioning of data is as follows: 

SELECT column_A, column_B, column_C,
INTO choose_file_name
FROM
  (SELECT column_A, column_B, column_C, ROW_NUMBER() OVER
  (PARTITION BY choose_value DESC) rn
  FROM source_data_file
  ) tmp WHERE rn = 1;
  
The results of the analysis identified that roughly 5% of the current workforce is of retirement age. The roles least likely to be affected by retirees are those of Assistant Engineer, and Manager, while the roles most likely to be affected are Senior Engineer and Senior Staff; the retirees are spread proportionately across the remaining positions. To help ease transition, employees eligible for a mentorship program were identified through further analysis, numbering 1,549. The most prudent action would be to focus on mentoring  employees in the positions of Senior Engineer and Senior Staff, as they will have the highest percentage or turnover following the upcoming retirement. The mentorship program will help ensure knowledge transfer between seasoned employees and newer personnel, thereby minimizing service discrepancies on larger, more valuable, accounts and logistical variations in more error-prone operations, or those with a lower acceptable margin of error. For further analysis, I feel it's imperative to consider the direct financial burden of the impending retirees, as accrued vacation pay, sick pay, and other benefits may be due the employee via a lump-sum at the point of retirement. Forecasting the fiscal impact may also help in determining near-term allocation of investment capital, as senior officers deem appropriate, so as to further reduce the overall impact of mass retirement. 

