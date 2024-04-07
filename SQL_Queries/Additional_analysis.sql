-- There are some consumers who have not heard about “CodeX” but 
-- they have filled in the survey form that they have tried before the drink. 
-- Find the error count and percentage in between "Heard_before" and "Tried_before"
select heard_before, Tried_before, count(respondent_id) as No_of_response,
round((count(respondent_id)*100)/(select count(*) from fact_survey_responses),2) as percentage
from fact_survey_responses
group by Heard_before, Tried_before
having Heard_before='YES' and Tried_before='NO'
union
select heard_before, Tried_before, count(respondent_id) as No_of_response,
round((count(respondent_id)*100)/(select count(*) from fact_survey_responses),2) as percentage
from fact_survey_responses
group by Heard_before, Tried_before
having Heard_before='NO' and Tried_before='YES'
order by No_of_response desc;

-- What is the most preferable time to consume time based on the age group?
-- (FOR AGE 19 AND 30)
select d.age, f.Typical_consumption_situations as Consume_time, count(f.Typical_consumption_situations) as No_of_response,
round((count(f.Typical_consumption_situations)*100)/(select count(*) from fact_survey_responses),2) as percentage
from fact_survey_responses as f
join dim_repondents as d on d.Respondent_ID=f.Respondent_ID
group by d.Age, f.Typical_consumption_situations
having d.age between 19 and 30
order by No_of_response desc;

-- ( FOR AGE 31 AND 45)
select d.age, f.Typical_consumption_situations as Consume_time, count(f.Typical_consumption_situations) as No_of_response,
round((count(f.Typical_consumption_situations)*100)/(select count(*) from fact_survey_responses),2) as percentage
from fact_survey_responses as f
join dim_repondents as d on d.Respondent_ID=f.Respondent_ID
group by d.Age, f.Typical_consumption_situations
having d.age between 31 and 45
order by No_of_response desc;

-- (FOR AGE 15 AND 18 )
select d.age, f.Typical_consumption_situations as Consume_time, count(f.Typical_consumption_situations) as No_of_response,
round((count(f.Typical_consumption_situations)*100)/(select count(*) from fact_survey_responses),2) as percentage
from fact_survey_responses as f
join dim_repondents as d on d.Respondent_ID=f.Respondent_ID
group by d.Age, f.Typical_consumption_situations
having d.age between 15 and 18
order by No_of_response desc;

-- (FOR AGE 46 AND 65 )
select d.age, f.Typical_consumption_situations as Consume_time, count(f.Typical_consumption_situations) as No_of_response,
round((count(f.Typical_consumption_situations)*100)/(select count(*) from fact_survey_responses),2) as percentage
from fact_survey_responses as f
join dim_repondents as d on d.Respondent_ID=f.Respondent_ID
group by d.Age, f.Typical_consumption_situations
having d.age between 46 and 65
order by No_of_response desc;

-- What is the reason which prevents trying the drinks?
select Reasons_preventing_trying, count(Respondent_ID) as No_of_Response,
round((count(Respondent_ID)*100)/(select count(*) from fact_survey_responses),2) as percentage
from fact_survey_responses
group by Reasons_preventing_trying order by No_of_response desc;

-- which age of groups are most unfamiliar with the brands?
select f.Reasons_preventing_trying, d.age,count(f.Respondent_ID) as Total_count
from fact_survey_responses as f
join dim_repondents as d on d.Respondent_ID=f.Respondent_ID
group by d.age, f.Reasons_preventing_trying
having f.Reasons_preventing_trying = 'Unfamiliar with the brand'
order by Total_count desc;

-- What improvements are required among age =’46-65’
select f.Improvements_desired, d.age, count(f.Respondent_ID) as No_of_response,
round((count(f.Respondent_ID)*100)/(select count(*) from dim_repondents
	where age between 46 and 65),2) as percentage
from fact_survey_responses as f
join dim_repondents as d on d.Respondent_ID=f.Respondent_ID
group by f.Improvements_desired, d.age
having d.age>=46 and d.age<=65
order by No_of_response desc;

-- Overall consume frequency
select Consume_frequency, count(Respondent_ID) as No_of_Consuming
from fact_survey_responses 
group by Consume_frequency order by No_of_consuming desc;

-- What is the Consume frequency of different age groups? ( FOR AGE 19-30 )
select f.Consume_frequency, d.age, count(f.Respondent_ID) as No_of_Consuming
from fact_survey_responses as f
join dim_repondents as d on d.Respondent_ID=f.Respondent_ID
group by Consume_frequency, d.age
having d.age between 19 and 30
order by No_of_consuming desc;

-- ( FOR AGE 31 AND 45 )
select f.Consume_frequency, d.age, count(f.Respondent_ID) as No_of_Consuming
from fact_survey_responses as f
join dim_repondents as d on d.Respondent_ID=f.Respondent_ID
group by Consume_frequency, d.age
having d.age between 31 and 45
order by No_of_consuming desc;

-- What is the reason for consuming the drink?
select Consume_reason, count(Respondent_ID) as Total_consumers
from fact_survey_responses
group by Consume_reason order by Total_consumers desc;

-- What is the reason which prevents trying the drinks?
select Brand_perception, count(Respondent_ID) as Total_response
from fact_survey_responses
group by Brand_perception order by Total_response desc;

-- What will be the ideal price based on the tier of the city?
select d2.tier, f.price_range as price, count(f.price_range) as total_sales
from dim_repondents as d1
join dim_cities as d2 on d2.city_id=d1.city_id
join fact_survey_responses as f on f.respondent_id=d1.respondent_id
group by d2.tier, f.price_range
order by total_sales desc;
