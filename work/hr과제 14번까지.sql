
--실습 8
SELECT countries.region_id, region_name, country_name
FROM countries, regions
WHERE countries.region_id = regions.region_id
AND region_name IN ('Europe');

--실습 9 ( row - 9
SELECT countries.region_id, region_name, country_name, city
FROM countries, regions, locations
WHERE countries.country_id = locations.country_id
AND countries.region_id = regions.region_id
AND region_name IN ('Europe');
--JOIN 에 실패한 국가가 있음. FRANCE, DENMARTK, BELGIOUM. LOCATIONS 정보 미존재.
--나머지 5개중에 다수의 LOCATION 정보를 갖고 있는 국가가 존재함을 알 수 있다.
--(실습 8과 9를 비교해보았을때 국가는 줄고 ROW 는 늘었음으로)
--데이터분석의 시작이 이런거라고 하심.


--실습 10
SELECT regions.region_id, region_name, country_name, city,department_name 
FROM countries,regions,locations,departments
WHERE countries.region_id = regions.region_id
AND countries.country_id = locations.country_id
AND locations.location_id = departments.location_id
AND region_name IN ('Europe');

--실습 11
SELECT regions.region_id, region_name, country_name, city,department_name, first_name || last_name name
FROM countries,regions,locations,departments,employees
WHERE countries.region_id = regions.region_id
AND countries.country_id = locations.country_id
AND locations.location_id = departments.location_id
AND departments.department_id = employees.department_id
AND region_name IN ('Europe');

--실습 12
SELECT employee_id, first_name || last_name name, jobs.job_id, job_title
FROM employees, jobs
WHERE employees.job_id = jobs.job_id;

--실습 13
SELECT a.manager_id mng_id, b. first_name || b. last_name mgr_name, a.employee_id ,
        
        a. first_name || a. last_name name, 
        
        jobs.job_id, job_title
FROM employees a, employees b, jobs
WHERE jobs.job_id = a.job_id
AND a.manager_id = b.employee_id;
-------------답 : 
SELECT employees.manager_id mgr_id, manager.first_name || manager.last_name name,
        
        employees.employee_id, employees.first_name || employees.last_name name,
        
        jobs.job_id, jobs.job_title
FROM jobs, employees, employees manager
WHERE jobs.job_id = employees.job_id
AND employees.manager_id = manager.employee_id;
