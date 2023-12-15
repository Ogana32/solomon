use mavenfuzzyfactory;
/* Gsearch seems to be the greatest driver of traffic can you pull the monthly trend search for gsearch sessions and orders*/
select 
month(website_sessions.created_at) as monthly_trend,
count( distinct website_sessions.website_session_id) as sessions,
count(distinct order_id) as orders
from website_sessions
left join orders on website_sessions.website_session_id = orders.website_session_id
where website_sessions.created_at < '2012-11-27' and utm_source ='gsearch'
group by 
monthly_trend;
select 
month(website_sessions.created_at) as monthly_trend,
count( case when utm_campaign = 'brand' then website_sessions.website_session_id else null end) as brand_sessions,
count( case when utm_campaign = 'nonbrand' then website_sessions.website_session_id else null end) as nonbrand_sessions,
count( case when utm_campaign = 'brand' then orders.order_id else null end) as brand_orders,
count( case when utm_campaign = 'nonbrand' then orders.order_id else null end) as nonbrand_orders
from website_sessions 
left join orders on website_sessions.website_session_id = orders.website_session_id
where website_sessions.created_at < '2012-11-27' and utm_source = 'gsearch'
group by 
monthly_trend;

select 
year(website_sessions.created_at) as year_date ,
month(website_sessions.created_at) as monthly_trend,
count( case when device_type = 'mobile' then website_sessions.website_session_id else null end) as mobile_sessions,
count( case when device_type = 'desktop' then website_sessions.website_session_id else null end) as desktop_sessions,
count( case when device_type = 'mobile' then orders.order_id else null end) as mobile_orders,
count( case when device_type = 'desktop' then orders.order_id else null end) as desktop_orders
from website_sessions 
left join orders on website_sessions.website_session_id = orders.website_session_id
where website_sessions.created_at < '2012-11-27' and utm_source = 'gsearch' and utm_campaign = 'nonbrand'
group by 
year_date,

monthly_trend;

/*select
distinct
utm_source,
utm_campaign, 
http_referer
from website_sessions
where created_at < '2012-11-27'
'2012-06-19 00:35:54'
;*/

select 
year(website_sessions.created_at),
month(website_sessions.created_at),
count(distinct case when utm_source = 'gsearch'  then website_sessions.website_session_id else null end) as paid_gsearch,
count(distinct	case when utm_source = 'bsearch'   then website_sessions.website_session_id else null end) as paid_bsearch,
count(distinct	case when utm_source is null and http_referer is not null then website_sessions.website_session_id else null end) as organic_search,
count(distinct	case when utm_source is null  and http_referer is null then website_sessions.website_session_id else null end) as direct_search 
from website_sessions
where created_at < '2012-11-27'
group  by 
1,2;

create temporary table landing_page
 select 
 website_sessions.website_session_id as session_id,
 min(website_pageviews.website_pageview_id) as pageview_id 
 from website_sessions 
 inner join website_pageviews on website_sessions.website_session_id = website_pageviews.website_session_id
 where website_sessions.created_at <'2012-07-28' 
 and website_pageview_id >= '23504'
 and utm_source = 'gsearch'
 and utm_campaign = 'nonbrand'
 group by 
 1;
 create temporary table landin
 select 
landing_page.session_id as session_id ,
landing_page.pageview_id as pageview_id,
 website_pageviews.pageview_url as pageview_url
 from landing_page 
 left join website_pageviews on website_pageviews.website_pageview_id = landing_page.pageview_id;
 
 select 
  landin.pageview_url,
 count(landin.session_id) as session_id, 
count(orders.order_id) as order_number,
count(orders.order_id) /count(landin.session_id) as conversion_rate
 from landin 
 left join orders on orders.website_session_id = landin.session_id 
 group by 
 1;
 
 select 
 max(website_sessions.website_session_id) 
 from 
 website_sessions inner join 
 website_pageviews on  website_sessions.website_session_id= website_pageviews.website_session_id 
 where  website_pageviews.pageview_url = '/home'
 and utm_source = 'gsearch'
 and utm_campaign = 'nonbrand';
  use mavenfuzzyfactory;
 select 
 count(website_session_id) as session_id
 from website_sessions
 where created_at <'2012-11-27'
 and website_session_id >'17145'
 and  utm_source = 'gsearch'
 and utm_campaign = 'nonbrand';

 select 
 yearweek(created_at)  as YRwk,
 min(date(created_at)) as  week_start_date,
 count(case when utm_source = 'gsearch' then website_session_id else null end) as gsearch_traffic,
 count(case when utm_source = 'bsearch' then website_session_id else null end)  as bsearch_traffic
 from  
 website_sessions
 where created_at < '2012-11-29'
 and created_at >= '2012-08-22'
 and utm_campaign = 'nonbrand'
 group by 
 1;
 
 /* pulling the non brand conversion rate from session to order for gsearch and bsearch slicing by device type*/
 
 -- gsearch 
 select 
 yearweek(created_at) asYRwk,
 min(date(created_at)) as week_start_date
 count(case when 
 
 
 
 
 
 

 
 





 
