-- Retrieve the total number of orders placed.


select count(order_id) as Total_orders from orders;




-- Calculate the total revenue generated from pizza sales.

SELECT 
    ROUND(SUM(order_details.quantity * pizzas.price),
            2) AS Revenue 
FROM
    order_details
        JOIN
    pizzas ON pizzas.pizza_id = order_details.pizza_id;


-- Identify the highest-priced pizza.

SELECT 
    pizza_types.name, pizzas.price
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
ORDER BY pizzas.price DESC
LIMIT 1;



-- Identify the most common pizza size ordered.

SELECT 
    pizzas.size,
    COUNT(order_details.order_details_id) AS Order_count
FROM
    pizzas
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizzas.size
ORDER BY Order_count DESC;


-- List the top 5 most ordered pizza types 
-- along with their quantities.


SELECT 
    pizza_types.name, SUM(order_details.quantity) AS most_order
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY most_order DESC
LIMIT 5




-- Join the necessary tables to find the total quantity of each pizza category ordered.

SELECT 
    pizza_types.category, SUM(order_details.quantity) AS Total
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category


-- Determine the distribution of orders by hour of the day.

SELECT 
    HOUR(orders.order_time) AS Hours,
    COUNT(order_id) AS Oderbyhour
FROM
    orders
GROUP BY Hours



-- Join relevant tables to find the category-wise distribution of pizzas.
SELECT 
    pizza_types.category, COUNT(order_details.quantity)
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizza_types.category



-- Group the orders by date and calculate the average number of pizzas ordered per day.
SELECT 
   round(AVG(Total_number),0) as Avg_per_day
FROM
    (SELECT 
        orders.order_date,
            SUM(order_details.quantity) AS Total_number
    FROM
        orders
    JOIN order_details ON orders.order_id = order_details.order_id
    GROUP BY orders.order_date) AS order_quantiy
    
    
    
    -- Determine the top 3 most ordered pizza types based on revenue.

select pizza_types.name, ROUND(SUM(order_details.quantity * pizzas.price),
            2) AS Revenue FROM order_details JOIN pizzas ON pizzas.pizza_id = order_details.pizza_id  join pizza_types on pizza_types.pizza_type_id = pizzas.pizza_type_id
            group by pizza_types.name order by Revenue DESC limit 3;
            
            
            
            -- Calculate the percentage contribution of each pizza type to total revenue.
SELECT 
    pizza_types.category,
    (SUM(order_details.quantity * pizzas.price) /(select ROUND(SUM(order_details.quantity * pizzas.price),
            2) 
FROM
    order_details
        JOIN
    pizzas ON pizzas.pizza_id = order_details.pizza_id) * 100) AS REVENUE
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category
ORDER BY revenue desc



