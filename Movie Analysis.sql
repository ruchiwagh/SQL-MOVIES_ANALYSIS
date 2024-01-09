use data_analysis_movies
select * from members
select * from ratings
select * from movies

/*How many members are living in Texas ?*/
select count(*) as 'TotalMembers',member_state
from members
where trim(member_state)='Texas'
group by member_state



/*Display movies that blends at least 4 different genres*/
select movie_name,movie_genre
from movies
where movie_genre like '%|%|%|%'






/*Count the number of movies for each amount of genres*/
select len(movie_genre)-len(REPLACE(movie_genre,'|','')) +1 as 'No_of_generes',
count(*) as 'No_of_Movies'
from dbo.movies
where movie_genre != '(no genres listed)'
group by len(movie_genre)-len(REPLACE(movie_genre,'|',''))

/* Which movie ID has the highest amount of ratings ?*/

select top 1 r.movie_id ,movie_name, count(*) as 'count of rating'
from movies mo, members m, ratings r
where m.member_id= r.member_id
and mo.movie_id=r.movie_id
and mo.movie_id = r.movie_id
group by r.movie_id,movie_name
order by [count of rating] desc
 



/*Advanced Analysis
1. Out of the total number registered members, how many have actually left
a movie rating ?*/

select count(distinct(m.member_id)) as 'Total Vote Count'
from ratings r , members m
where m.member_id=r.member_id
and m.member_id in (r.member_id)



/* Members who voted at least once*/
select m.member_id as 'Voted atleast once'
from ratings r , members m
where m.member_id=r.member_id
and m.member_id in (r.member_id)
group by
having count(*)<=1


/*Which gender has left most ratings ?*/
select top 1 gender, count(distinct(r.member_id)) as 'ratings'
from members m , ratings r
where m.member_id = r.member_id
group by gender
order by count(distinct(r.member_id)) desc

/*Display the number of members in New York, for the gender you
retrieved in previous exercise*/

select top 1 gender, count(distinct(r.member_id)) as 'ratings'
from members m , ratings r
where m.member_id = r.member_id
and trim(member_state)='New York'
group by gender
order by count(distinct(r.member_id)) desc

/*Display the top-5 favorite Sci-Fi movies*/

select top 5 movie_name, movie_genre, sum(rating) as 'rating'
from movies m , ratings r
where m.movie_id=r.movie_id
and trim(movie_genre) like '%Sci-Fi%'
group by movie_name,movie_genre
order by sum(rating) desc

/*Which gender prefers to watch the Sci-Fi genre?*/

select top 1 gender,count(distinct(r.member_id)) as 'count'
from members m, ratings r, movies mo
where m.member_id = r.member_id 
and r.movie_id = mo.movie_id
and trim(movie_genre) like '%Sci-Fi%'
group by gender
order by count(distinct(r.member_id)) desc

/*Display all members who rated at least one of the movies rated by
member 106*/
select m.member_id, first_name + ' ' +last_name as'name',r.movie_id
from members m, ratings r, movies mo
where m.member_id = r.member_id
and r.movie_id = mo.movie_id
and r.movie_id in (select r.movie_id
                    from ratings r, movies mo
					where r.movie_id = mo.movie_id
					and member_id=106)



select case when movie_genre like '%|%|%|%|%' then '5' else 'empty' end as 'amt of genres',
count(*)as 'Number of movies'
from movies
group by case when movie_genre like '%|%|%|%|%' then '5' else 'empty' end 