SET serveroutput ON
DECLARE
type phone_rec_type
IS
  record
  (
    area_code     VARCHAR2(3),
    prefix        VARCHAR2(3),
    home_phone    VARCHAR2(4),
    office_phone  VARCHAR2(4),
    mobile_phone  VARCHAR2(4),
    cottage_phone VARCHAR2(4),
    pager_phone   VARCHAR2(4));
  v_myphone phone_rec_type;
BEGIN
  v_myphone.area_code    := '416';
  v_myphone.prefix       := '554';
  v_myphone.home_phone   := '1121';
  v_myphone.office_phone := '3343';
  v_myphone.mobile_phone := '9908';
  v_myphone.cottage_phone:= '5556';
  v_myphone.pager_phone  := '3332';
  DBMS_output.put_line ('Customer Home Phone: ' || v_myphone.area_code ||'-'|| v_myphone.prefix ||'-'|| v_myphone.home_phone);
  DBMS_output.put_line ('Customer Office Phone: ' || v_myphone.area_code ||'-'|| v_myphone.prefix ||'-'|| v_myphone.office_phone);
  DBMS_output.put_line ('Customer Mobile Phone: ' || v_myphone.area_code ||'-'|| v_myphone.prefix ||'-'|| v_myphone.mobile_phone);
  DBMS_output.put_line ('Customer Cottage Phone: ' || v_myphone.area_code ||'-'|| v_myphone.prefix ||'-'|| v_myphone.cottage_phone);
  DBMS_output.put_line ('Customer Pager Phone: ' || v_myphone.area_code ||'-'|| v_myphone.prefix ||'-'|| v_myphone.pager_phone);
END;
/
SET serveroutput ON
DECLARE
  v_department_name departments.department_name%type;
  v_employee employees.employee_id%type;
  v_salary_avg employees.salary%type;
  v_salary_total employees.salary%type;
BEGIN
  FOR i IN 1..27
  LOOP
    SELECT department_name
    INTO v_department_name
    FROM departments
    WHERE department_id=(i*10);
    SELECT COUNT(employee_id)
    INTO v_employee
    FROM employees
    WHERE department_id = (i*10);
    SELECT AVG(salary)
    INTO v_salary_avg
    FROM employees
    WHERE department_id = (i*10);
    SELECT SUM(salary)
    INTO v_salary_total
    FROM employees
    WHERE department_id = (i*10);
    DBMS_output.put_line (v_department_name);
    IF v_employee > 0 THEN
      DBMS_output.put_line ('Number of employees: ' || v_employee);
      DBMS_output.put_line ('Average Salary: ' || v_salary_avg);
      DBMS_output.put_line ('Total Salary: ' || v_salary_total);
    ELSE
      DBMS_output.put_line ('has no employees');
    END IF;
    DBMS_output.put_line ('');
  END LOOP;
END;
/
SET serveroutput ON
DECLARE
type u_rec
IS
  record
  (
    location_id locations.location_id%type,
    v_operation VARCHAR2(1):= 'U');
  v_u_rec u_rec;
type i_rec
IS
  record
  (
    location_id locations.location_id%type,
    v_operation VARCHAR2(1):= 'I');
  v_i_rec i_rec;
type d_rec
IS
  record
  (
    location_id locations.location_id%type,
    v_operation VARCHAR2(1):= 'D');
  v_d_rec d_rec;
type x_rec
IS
  record
  (
    location_id locations.location_id%type,
    v_operation VARCHAR2(1):= 'X');
  v_x_rec x_rec;
type location_array
IS
  TABLE OF    NUMBER INDEX BY pls_integer;
  location_id NUMBER (4,0);
  l_array location_array;
BEGIN
  l_array(1) := 1000;
  l_array(2) := 1001;
  l_array(3) := 1002;
  l_array(3) := 1003;
  l_array(4) := 1004;
  l_array(5) := 1005;
  l_array(6) := 1006;
  l_array(7) := 1007;
  l_array(8) := 1008;
  l_array(9) := 1009;
  l_array(10):= 1010;
  l_array(11):= 1100;
  SELECT location_id
  INTO v_u_rec.location_id
  FROM locations
  WHERE location_id = (1000) ;
  SELECT location_id
  INTO v_i_rec.location_id
  FROM locations
  WHERE location_id = (1000) ;
  SELECT location_id
  INTO v_d_rec.location_id
  FROM locations
  WHERE location_id = (1100) ;
  SELECT location_id
  INTO v_x_rec.location_id
  FROM locations
  WHERE location_id = (1000) ;
  FOR i IN 1..11
  LOOP
    IF l_array(i) = v_u_rec.location_id AND v_u_rec.v_operation = 'U' THEN
      DBMS_output.put_line ('Location_ID '|| l_array(i)||' Updated');
      UPDATE locationz
      SET location_id   = l_array(i),
        street_address  = 'U Street',
        postal_code     = 0000,
        city            = 'Oakville',
        state_province  = 'Quebec',
        country_id      ='CA'
      WHERE location_id = l_array(i);
    ELSIF l_array(i)   != v_i_rec.location_id AND v_i_rec.v_operation = 'I' THEN
      DBMS_output.put_line ('Location_ID '|| l_array(i)||' Inserted');
      INSERT
      INTO locationz
        (
          location_id,
          street_address,
          postal_code,
          city,
          state_province,
          country_id
        )
        VALUES
        (
          l_array(i),
          'Anywhere Street',
          9999,
          'Toronto',
          'Ontario',
          'CA'
        );
    END IF ;
  END LOOP;
  FOR i IN 1..11
  LOOP
    IF l_array
      (
        i
      )
      = v_d_rec.location_id AND v_d_rec.v_operation = 'D' THEN
      DBMS_output.put_line
      (
        'Location_ID '|| l_array(i)||' Deleted'
      )
      ;
      DELETE FROM locationz WHERE location_id = l_array(i);
    elsif l_array(i) = v_x_rec.location_id AND v_x_rec.v_operation = 'X' THEN
      DBMS_output.put_line ('Invalid Operation');
    END IF;
  END LOOP;
END;
