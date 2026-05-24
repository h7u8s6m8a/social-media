create Database social_media;
/* ==========================
	Business Questions
   =========================== */
   -- Which platform gets the highest Engagement_rate --
   -- Which platform recieve max likes, shares, and comments --
   -- Whih day_of_week gives better Engagement --
   -- What is the posting time gives more immpresions --
   -- Mostly users reacting sentiment --
   -- What emotion_type of posts mostly appeared in social media --
   -- Which brand mostly receive negative comments --
   -- Which type hashtags commonly used --
use social_media;
show tables;
/* ===========================
    Loading the data 
   =========================== */
select *
from social_media_engagement;
/* ============================
    Data Cleaning Steps
   ============================ */ 
-- Find the Duplicates --
select post_id, count(*)
from social_media_engagement
group by post_id
having count(*) > 1;
-- Count Null Values --
select count(*)
from social_media_engagement
where location is null
or language is null
or text_content is null
or hashtags is null
or mentions is null
or impressions is null
or keywords is null
or topic_category is null
or sentiment_score is null
or sentiment_label is null
or emotion_type is null
or toxicity_score is null;
select count(*)
from social_media_engagement
where likes_count is null
or shares_count is null
or comments_count is null
or engagement_rate is null
or brand_name is null
or product_name is null
or campaign_name is null
or campaign_phase is null
or user_past_sentiment_avg is null
or user_engagement_growth is null
or buzz_change_rate is null;
describe social_media_engagement;
-- Standardize text data --
select *
from social_media_engagement
where trim(mentions) = '';
-- Checking invalid data --
select count(*) 
from social_media_engagement
where engagement_rate < 0;
select distinct day_of_week
from social_media_engagement
where day_of_week not in('Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday');
-- checking data types --
-- Convert timestamp column text to date format --
desc social_media_engagement;
select cast(timestamp as date)
from social_media_engagement;
-- Check unique values --
select distinct platform
from social_media_engagement;
select distinct day_of_week
from social_media_engagement;
select distinct topic_category
from social_media_engagement;
select distinct emotion_type
from social_media_engagement;
select distinct campaign_phase
from social_media_engagement;
select distinct brand_name
from social_media_engagement;
select distinct product_name
from social_media_engagement;
select product_name, count(*)
from social_media_engagement
group by product_name;
-- Checking Outliers --
select min(likes_count), max(likes_count)
from social_media_engagement;
select likes_count
from social_media_engagement
order by likes_count asc
limit 1000;
/* ===========================
     Cross Checking 
   =========================== */
-- Total records --
select count(*)
from social_media_engagement;
select * from social_media_engagement;
-- Length of the text --
select post_id, text_content, length(text_content) as text_length
from social_media_engagement
order by text_length asc
limit 1;
select post_id, text_content, length(text_content) as text_length
from social_media_engagement
order by text_length desc
limit 1;
/* =============================
     Exploratory data analysis 
    ============================== */
-- total posts by platform --
select platform, count(post_id) as total_posts
from social_media_engagement
group by platform;
-- Top engagement rate by soacial_media_platform --
select platform, max(engagement_rate) as most_engagement
from social_media_engagement
group by platform;
-- Top 10 likes posts --
select post_id, max(likes_count) as highest_liked_posts
from social_media_engagement
group by post_id
order by highest_liked_posts desc
limit 10;
-- Mostly used hashtags --
select hashtags, count(*) as total
from social_media_engagement
group by hashtags
order by total desc;
-- Most active platform among users
select platform, count(user_id) as count_of_users
from social_media_engagement
group by platform
order by count_of_users desc
limit 1;
-- peak posting Hours --
select hour(timestamp) as posting_hour, count(post_id) as total_posts
from social_media_engagement
group by posting_hour
order by total_posts desc;
-- Time period with highest user activity --
select 
case
when hour(timestamp) between 5 and 11 then 'Morning'
when hour(timestamp) between 12 and 16 then 'Afternoon'
when hour(timestamp) between 17 and 20 then 'Evening'
 else 'Night'
 end as time_period,
 count(*) as total_users
 from social_media_engagement
 group by time_period
 order by total_users desc;
 -- Top_most Popular Brand --
 select brand_name, count(*) as total_posts
 from social_media_engagement
 group by brand_name
 order by total_posts desc
 limit 1;
 -- Mostly used product by users --
 select product_name, count(*) as total_users
 from social_media_engagement
 group by product_name
 order by total_users desc
 limit 1;
 -- which campaign phase creates more buzz --
 select campaign_phase, max(buzz_change_rate) as max_buzz
 from social_media_engagement
 group by campaign_phase
 order by max_buzz desc;
 select day_of_week, count(*) as total_impressions
 from social_media_engagement
 group by day_of_week;
 -- Sentiment Anlysis -- 
 select sentiment_label, count(user_id)
 from social_media_engagement
 group by sentiment_label;
 /* =============================
       Save the cleaned data 
	============================= */
 create view cleaned_data_social_media as
 select *
 from social_media_engagement
 where post_id is not null;
 /* =============================
      Business Insights
	============================= */
-- Instagram emerged as the top-performing platform with the highest engagement rate --
-- 87gq6xrd3ykv post receive highest likes (5000) compare to other posts --
-- Posts published on Monday generated the highest impressions --
-- Morning 3 AM and night 11 PM hours peak posting hours --
-- Mostly users reactive positively --
-- Nighttime recorded the highest social media activity, suggesting that users are more engaged during Night hours --
-- Sad posts are mostly appeared in social media --
-- Microsoft is the top most Brand by users --
-- YouTube is the top performing platform --
-- Most users are used #NewRelease and #Fitness type hashtags. --
-- Launch campaign phase creates more buzz --





