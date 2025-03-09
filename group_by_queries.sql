-- Average salary by title
select title, avg(salary) from employees group by title;

-- Average salary by company
select c.company_name, avg(e.salary) from employees e join companies c on e.company_id = c.id group by c.company_name;

-- Average salary by company and title
select c.company_name, e.title, avg(e.salary) from employees e join companies c on e.company_id = c.id group by c.company_name, e.title;

-- Average salary by company and title and age
select c.company_name, e.title, e.age, avg(e.salary) from employees e join companies c on e.company_id = c.id group by c.company_name, e.title, e.age;
    
-- Show me the minimum salary across all companies for managers where the minimum salary is greater than 100000
select c.company_name, min(e.salary) 
from employees e 
join companies c on e.company_id = c.id 
where e.is_manager = true
group by c.company_name
having min(e.salary) > 100000;


