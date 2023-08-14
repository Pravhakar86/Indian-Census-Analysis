-- No of rows in the dataset 

select count(*) from growth;
select count(*) from population;

-- Insights for Jharkhand and Bihar

select * from  growth 
where state in ('Jharkhand' and 'Bihar');

-- All the state names starting with 'A' 

select distinct state from population
where state like 'A%';

-- Total population of India 

select sum(population) Total_population from population;

-- Average growth of India in the year 2011

select round(avg(growth)*100,2) average_growth from growth;

-- Average growth percentage for each state

select state, round(avg(growth)*100,2) average_growth from growth 
group by state;

-- Average Sex Ratio for each state 

select state, round(avg(sex_ratio),2) average_sex_ratio from growth 
group by state
order by 2 desc;

-- Average literacy rate for each state 

select state, round(avg(Literacy),2) average_literacy from growth 
group by state
order by 2 desc;

-- Top 5 states displaying highest growth percentage ratio 

select state, round(avg(growth)*100,2) as average_growth from growth
group by state
order by 2 desc
limit 5;

-- 5 states showing Least Sex Ratio

select state, round(avg(Sex_Ratio)*100,2) as average_Sex_Ratio from growth
group by state
order by 2 
limit 5;

-- fetch Top and Bottom 3 states for literacy rate in a single result set 

select * from (select state, round(avg(literacy),2) as average_literacy from growth
group by state
order by 2 desc
limit 3)a
union 
select * from (select state, round(avg(literacy),2) as average_literacy from growth
group by state
order by 2 
limit 3) b;

-- Total no of people who are literate from the population in each state 

select p.state, round(sum(population*literacy),2) literate from growth g
join population p on g.district = p.district
group by p.state;

-- Find out the top 3 district from each states having high literacy ratio
select state, district, literacy from (
select state, district, literacy, dense_rank() over(partition by state order by literacy desc) ranking from growth) subquery
where ranking < 4;
