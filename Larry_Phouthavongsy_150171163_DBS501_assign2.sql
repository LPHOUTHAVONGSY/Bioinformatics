SET serveroutput ON
--Q1
CREATE OR REPLACE FUNCTION product_review(
    cat IN NUMBER)
  RETURN NUMBER
IS
  xx NUMBER;
BEGIN
  SELECT COUNT(product_status)
  INTO xx
  FROM product_information
  WHERE category_id  = cat
  AND product_status = 'orderable' ;
  RETURN(xx);
END product_review;
/
SELECT product_review(29)"# with orderable status" FROM dual ;
--Q2
CREATE OR REPLACE PROCEDURE display_orders
  IS
  type xx
IS
  record
  (
    ords orders%rowtype,
    ords_items order_items%rowtype);
  v_x xx;
BEGIN
  FOR i IN 2354..2458
  LOOP
    SELECT * INTO v_x.ords FROM orders WHERE order_id = i;
    dbms_output.put_line('Order ID: '||v_x.ords.order_id);
    dbms_output.put_line('Order date: '||v_x.ords.order_date);
    dbms_output.put_line('Order Mode: '||v_x.ords.order_mode);
    dbms_output.put_line('Customer ID: '||v_x.ords.customer_id);
    dbms_output.put_line('Order Status: '||v_x.ords.order_status);
    dbms_output.put_line('Order Total: '||v_x.ords.order_total);
    dbms_output.put_line('Sales Rep ID: '||v_x.ords.sales_rep_id);
    dbms_output.put_line('Promotion ID: '||v_x.ords.promotion_id);
    dbms_output.put_line('');
  END LOOP;
END display_orders;
/
BEGIN
  display_orders ;
END;
/
--Q3
CREATE OR REPLACE PROCEDURE update_order_type(
      input IN orders.order_id%type)
  IS
    i NUMBER :=0;
    CURSOR c_price_cursor
    IS
      SELECT discount_price,quantity FROM order_items WHERE order_id=input;
    new_total        NUMBER :=0;
    v_discount_price NUMBER :=0;
    v_quantity       NUMBER :=0;
  BEGIN
    v_quantity:=0;
    OPEN c_price_cursor;
    LOOP
      FETCH c_price_cursor INTO v_discount_price, v_quantity;
      EXIT
    WHEN c_price_cursor%notfound;
      new_total := new_total+v_discount_price * v_quantity;
    END LOOP;
    CLOSE c_price_cursor;
    dbms_output.put_line('Order ID: '||input||' ' ||'Updated Order Total: $'||new_total);
    UPDATE orders SET order_total = new_total WHERE order_id=input;
  END update_order_type;
/
BEGIN
  update_order_type(&Order_ID);
END;
/
--Q4
CREATE OR REPLACE PACKAGE ORDER_PACKAGE
AS
END ORDER_PACKAGE;
CREATE OR REPLACE PACKAGE BODY ORDER_PACKAGE
AS
  --Q4a
  PROCEDURE order_discount(
      input IN orders.order_id%type)
  IS
    i NUMBER :=0;
    CURSOR c_discount_cursor
    IS
      SELECT COUNT(line_item_id) FROM order_items WHERE order_id=input;
    v_count                       NUMBER :=0;
    v_five_percent_discount_price NUMBER :=0;
    CURSOR c_ordertotal
    IS
      SELECT order_total FROM orders WHERE order_id=input;
    v_order_total_old NUMBER :=0;
  BEGIN
    OPEN c_discount_cursor;
    OPEN c_ordertotal;
    LOOP
      FETCH c_discount_cursor INTO v_count;
      EXIT
    WHEN c_discount_cursor%notfound;
    END LOOP;
    FETCH c_ordertotal INTO v_order_total_old;
    CLOSE c_discount_cursor;
    CLOSE c_ordertotal;
    dbms_output.put_line(v_count);
    dbms_output.put_line(v_order_total_old);
    IF v_count >=5 THEN
      dbms_output.put_line('DISCOUNT');
      dbms_output.put_line(v_order_total_old-(v_order_total_old*0.05));
      UPDATE orders
      SET order_total = (v_order_total_old-(v_order_total_old*0.05))
      WHERE order_id  =input;
    ELSE
      dbms_output.put_line('NO DISCOUNT');
    END IF;
  END order_discount;
--Q4b
  FUNCTION total_cost_per_customer(
      f_start_date IN orders.order_date%type,
      f_end_date   IN orders.order_date%type,
      f_customer_id OUT orders.customer_id%type)
    RETURN NUMBER
  IS
  BEGIN
    SELECT customer_id
    INTO f_customer_id
    FROM orders
    WHERE order_date BETWEEN to_date( 'f_start_date', 'yy-mm-dd') AND to_date( 'f_end_date', 'yy-mm-dd');
    RETURN f_customer_id;
  END total_cost_per_customer;
--Q4c
  PROCEDURE get_customer_details(
      input_cust_id IN orders.customer_id%type )
  IS
    g_customer_id customers.customer_id%type;
    g_cust_first_name customers.cust_first_name%type;
    g_cust_last_name customers.cust_last_name%type;
    g_cust_address customers.address%type;
    g_phone_number customers.phone_number%type;
  BEGIN
    SELECT customer_id,
      cust_first_name,
      cust_last_name,
      address,
      phone_number
    INTO g_customer_id,
      g_cust_first_name,
      g_cust_last_name,
      g_cust_address,
      g_phone_number
    FROM customers
    WHERE customer_id = input_cust_id;
    dbms_output.put_line(g_customer_id||' '||g_cust_first_name||' '||g_cust_last_name||' '||g_cust_address||' '||g_phone_number);
  END get_customer_details;
--Q4d
  FUNCTION new_order_id
    RETURN NUMBER
  IS
    new_number NUMBER;
  BEGIN
    new_number:= orders_seq_new.nextval;
    dbms_output.put_line(new_number);
    RETURN (new_number);
  END new_order_id;
END ORDER_PACKAGE;
/