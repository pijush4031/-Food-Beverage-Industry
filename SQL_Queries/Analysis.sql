-- 1. Who prefers energy drink more? (male/female/non-binary)
select
sum(if(Gender='Male',1,0)) as Total_Males,
sum(if(Gender='Female',1,0)) as Total_Females,
sum(if(Gender='Non-binary',1,0)) as Total_Non_Binaries
from dim_repondents;

-- 2. Which age group prefers energy drinks more?
select age, count(age) as Age_preferred,
round((count(*)*100)/(select count(*) from fact_survey_responses),2) as Percentage
from dim_repondents
group by age order by Age_preferred desc;

-- 3. Which type of marketing reaches the most Youth (15-30)?
select f.Marketing_channels, d.age, count(f.Marketing_channels) as No_of_reach from fact_survey_responses as f
join dim_repondents as d on f.Respondent_ID=d.Respondent_ID
where d.age>=15 and d.age<=30
group by f.Marketing_channels, d.age
order by No_of_reach desc;

-- 4. What are the preferred ingredients of energy drinks among respondents?
select Ingredients_expected, count(Ingredients_expected) as Preferred_Ingredient from fact_survey_responses
group by Ingredients_expected order by Preferred_Ingredient desc;

-- 5. What packaging preferences do respondents have for energy drinks?
select Packaging_preference as Packagings, count(Packaging_preference) as Total_packaging_preference
from fact_survey_responses
group by Packaging_preference order by Total_packaging_preference desc;

-- 6. Who are the current market leaders?
select current_brands, count(current_brands) as Market_leaders
from fact_survey_responses
group by current_brands order by Market_leaders desc;

-- 7. What are the primary reasons consumers prefer those brands over ours?
select Reasons_for_choosing_brands, count(Reasons_for_choosing_brands) as Reason_preferred_brands
from fact_survey_responses
group by Reasons_for_choosing_brands order by Reason_preferred_brands desc;

-- 8. Which marketing channel can be used to reach more customers?
select marketing_channels as Marketing, count(Respondent_ID) as No_of_reach
from fact_survey_responses
group by marketing_channels order by No_of_reach desc;

-- How effective are different marketing strategies and channels in reaching our customers?
-- same like query number 7

-- 9. What do people think about our brand? (overall rating)
-- Heard_before "YES" OR "NO" (seems like most consumers are new)
select Heard_before, count(Respondent_ID) as count_of_response
from fact_survey_responses
group by Heard_before order by count_of_response desc; -- "NO"= 5553, "YES"= 4447

-- General_perception
select General_perception, count(Respondent_ID) as count_of_response
from fact_survey_responses
group by General_perception order by count_of_response desc;

-- Tried_before (This count should be equal to the "Heard_before", but It's not)
select Tried_before, count(Respondent_ID) as count_of_response
from fact_survey_responses
group by Tried_before order by count_of_response desc; -- "NO"= 5119, "YES"= 4881

-- Taste_experience
select Taste_experience, count(Respondent_ID) as count_of_response
from fact_survey_responses
group by Taste_experience order by count_of_response desc;

-- Improvements_desired
select Improvements_desired, count(Respondent_ID) as count_of_response
from fact_survey_responses
group by Improvements_desired order by count_of_response desc;

-- 10. Which cities do we need to focus more on?
select d1.City, count(d2.Respondent_ID) as No_of_sells, 
round((count(d2.Respondent_ID)/(select count(*) from dim_repondents)*100),1) as Percentage
from dim_cities as d1
join dim_repondents as d2 on d1.city_id=d2.city_id
group by d1.City order by No_of_sells desc;

-- 11. Where do respondents prefer to purchase energy drinks?
select Purchase_location, count(Respondent_ID) as No_of_purchase
from fact_survey_responses
group by Purchase_location order by No_of_purchase desc;

-- 12. What are the typical consumption situations for energy drinks among respondents?
select Typical_consumption_situations as Situations, count(Respondent_ID) as No_of_purchase
from fact_survey_responses
group by Typical_consumption_situations order by No_of_purchase desc;

-- 13. What factors influence respondents' purchase decisions, such as price range and limited edition packaging?
-- For Price Range
select Price_range, count(Respondent_ID) as Total_purchase,
round((count(*)*100)/(select count(*) from fact_survey_responses),2) as Percentage
from fact_survey_responses
group by Price_range order by Total_purchase desc;

-- 14. For Limited edition packaging
select Limited_edition_packaging, count(Respondent_ID) as Total_response,
round((count(*)*100)/(select count(*) from fact_survey_responses),2) as Percentage
from fact_survey_responses
group by Limited_edition_packaging order by Total_response desc;

-- 15. Which area of business should we focus more on our product development? (Branding/taste/availability)
select Reasons_for_choosing_brands, count(Respondent_ID) as total_response,
round((count(*)*100)/(select count(*) from fact_survey_responses),2) as Percentage
from fact_survey_responses
group by Reasons_for_choosing_brands order by total_response desc;








