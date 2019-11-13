function [surface_point] = de_boor_algorithm_surface(t_1, t_2, ....
                 t_1_star, t_2_star, order_1, order_2, control_points)
             
Q = zeros(order_1, 3);
for i = 1 : order_1
    Q(i, :) =  de_boor_algorithm(t_2, t_2_star, order_2-1, ...
                            control_points(order_2*(i-1)+1:order_2*i, :));
end
surface_point = de_boor_algorithm(t_1, t_1_star, order_1-1, Q);