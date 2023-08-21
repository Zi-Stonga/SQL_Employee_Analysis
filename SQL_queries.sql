 -- Create the regions table
CREATE TABLE regions
(
region_id NUMERIC,
region_name TEXT(25)
);

-- Create a unique index on region_id
CREATE UNIQUE INDEX reg_id_unique_idx
ON regions (region_id);

-- Add primary key constraint on region_id
ALTER TABLE regions
ADD CONSTRAINT reg_id_pk
PRIMARY KEY (region_id);
 

-- Create the countries table
CREATE TABLE countries
(
   country_name TEXT(40),
   region_id NUMERIC,
   CONSTRAINT country_c_id_pk PRIMARY KEY (country_id)
);

-- Add foreign key constraint on region_id
ALTER TABLE countries
ADD CONSTRAINT countr_reg_fk
FOREIGN KEY (region_id)
REFERENCES regions(region_id);



CREATE TABLE locations
   ( location_id NUMERIC(4),
   street_address TEXT(40),
   postal_code NUMERIC(12),
   city TEXT(30),
   state_province TEXT(25),
   country_id NUMERIC(2)
   ) ;

      CREATE UNIQUE INDEX loc_id_unique_idx
ON locations (location_id);

-- Add primary key and foreign key constraints
ALTER TABLE locations
ADD CONSTRAINT loc_id_pk
PRIMARY KEY (location_id),
ADD CONSTRAINT loc_c_id_fk
FOREIGN KEY (country_id)
REFERENCES countries(country_id);


CREATE TABLE departments
   ( department_id NUMERIC(4),
   department_name TEXT(30),
   manager_id NUMERIC(6),
   location_id NUMERIC(4)
   ) ;
CREATE UNIQUE INDEX dept_id_pk
         ON departments (department_id) ;
ALTER TABLE departments
         ADD ( CONSTRAINT dept_id_pk
   PRIMARY KEY (department_id),
   CONSTRAINT dept_loc_fk
   FOREIGN KEY (location_id)
   REFERENCES locations (location_id)
   ) ;


ALTER TABLE departments
         ADD ( CONSTRAINT dept_mgr_fk
   FOREIGN KEY (manager_id)
   REFERENCES employees (employee_id)
   ) ;

CREATE TABLE jobs
   ( job_id NUMERIC(10),
   job_title TEXT(35),
   min_salary NUMERIC(6),
   max_salary NUMERIC(6)
   ) ;
CREATE UNIQUE INDEX job_id_pk 
         ON jobs (job_id) ;
ALTER TABLE jobs
         ADD ( CONSTRAINT job_id_pk
   PRIMARY KEY(job_id)
   ) ;

CREATE TABLE employees
   ( employee_id NUMERIC(6),
   first_name TEXT(20),
   last_name TEXT(25),
   email TEXT(25) NOT NULL,
   phone_number NUMERIC(20),
	hire_date DATE NOT NULL,
   job_id numeric(10) NOT NULL,
   salary NUMERIC(8,2),
   commission_pct NUMERIC(2,2),
   manager_id NUMERIC(6),
   department_id NUMERIC(4),
   CONSTRAINT emp_salary_min
   CHECK (salary > 0) ,
   CONSTRAINT emp_email_uk
   UNIQUE (email(60)))
    ;
CREATE UNIQUE INDEX emp_emp_id_pk
         ON employees (employee_id);

      ALTER TABLE employees
	ADD CONSTRAINT emp_emp_id_pk PRIMARY KEY (employee_id),
   ADD CONSTRAINT emp_dept_fk FOREIGN KEY (department_id) REFERENCES departments,
   ADD CONSTRAINT emp_job_fk FOREIGN KEY (job_id) REFERENCES jobs (job_id),
   ADD CONSTRAINT emp_manager_fk FOREIGN KEY (manager_id) REFERENCES employees;



   CREATE TABLE job_history
   ( employee_id NUMERIC(6) NOT NULL,
   start_date DATE NOT NULL)


CREATE TABLE job_history
   ( employee_id NUMERIC(6) NOT NULL,
   start_date DATE NOT NULL,
   end_date DATE NOT NULL,
   job_id NUMERIC(10) NOT NULL,
   department_id NUMERIC(4),
   CONSTRAINT jhist_date_interval
   CHECK (end_date > start_date)
   ) ;

   CREATE UNIQUE INDEX jhist_emp_id_st_date_pk 
         ON job_history (employee_id, start_date) ;

ALTER TABLE job_history
   ADD CONSTRAINT jhist_emp_id_st_date_pk PRIMARY KEY (employee_id, start_date),
   ADD CONSTRAINT jhist_job_fk FOREIGN KEY (job_id) REFERENCES jobs,
   ADD CONSTRAINT jhist_emp_fk FOREIGN KEY (employee_id) REFERENCES employees,
   ADD CONSTRAINT jhist_dept_fk FOREIGN KEY (department_id) REFERENCES departments;