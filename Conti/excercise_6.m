% EXCERCISE_6:
%   Takes as input the coordinates of the control polygon of a cubic
%   B�zier curve use the degree elevation algorithm to find the control 
%   polygons of this curve elevated to 4, 5, 6 degrees and draws them.
%
% Requires:
%   - de_casteljau.m
%   - degree_elevation.m

% Authors: Elia Mercatanti, Marco Calamai
% Emails: elia.mercatanti@stud.unifi.it, marco.calamai@stud.unifi.it

clear

% Ask user for input.
prompt = {'X Axis Left Limit:', 'X Axis Right Limit:', ...
          'Y Axis Left Limit:', 'Y Axis Right Limit:', ...
          'Number of points of the B�zier curves to draw:', ...
          'Left Parameter t Range (a):', 'Right Parameter t Range (b):'};
inputs_title = 'Inputs to Draw the B�zier Curve';
dimensions = [1 54];
default_inputs = {'0', '1', '0', '1', '1000', '0', '1'};
inputs = inputdlg(prompt, inputs_title, dimensions, default_inputs);

% Retrive inputs.
x_left_limit = str2double(inputs{1});
x_right_limit = str2double(inputs{2});
y_left_limit = str2double(inputs{3});
y_right_limit = str2double(inputs{4});
num_curve_points = str2double(inputs{5});
a = str2double(inputs{6});
b = str2double(inputs{7});

% Initialize number of control points.
num_control_points = 4;

% Set the figure window for drawing plots.
fig = figure('Name', 'Exercise 6', 'NumberTitle', 'off');
fig.Position(3:4) = [800 600];
movegui(fig, 'center');
hold on;
grid on;
xlabel('X');
ylabel('Y');
title('B�zier Curve with Eleveted Degree');
axes = gca;
axes.XAxisLocation = 'origin';
axes.YAxisLocation = 'origin';
xlim([x_left_limit x_right_limit]);
ylim([y_left_limit y_right_limit]);

% Ask user to choose control vertices for the B�zier curve and plot them.
control_points = zeros(num_control_points, 2);
for i = 1 : num_control_points
    [x, y] = ginput(1);
    control_points(i, :) = [x, y];
    poi_plot = plot(control_points(i, 1), control_points(i, 2), 'k.', ...
                    'MarkerSize', 20);
    if i ~= 1
        pol_plot = plot(control_points(i-1:i,1), control_points(i-1:i, ...
                        2), '-', 'linewidth', 1, 'color', '#0072BD');
    end
end
   
% Calculate the parameter (t) steps for drawing the B�zier curves.
steps = linspace(a, b, num_curve_points);
if a ~= 0 || b ~= 1
    steps = (steps-a) / (b-a);
end

% Calculate and plot the B�zier curve using de Casteljau algorithm.
bezier_curve = zeros(num_curve_points, 2);
for i = 1 : num_curve_points
    bezier_curve(i, :) = de_casteljau(control_points, steps(i));
end
curve_plot = plot(bezier_curve(:, 1), bezier_curve(:, 2), 'linewidth', ...
                  3, 'color', '#D95319');
 
% Plot new control polygons from degree elevation algorithm.
cp_plot_cell = cell(3);
for i = 1 : 3
    control_points = degree_elevation(control_points);
    plot(control_points(:, 1), control_points(:, 2), '.', ...
         'MarkerSize', 20);
    cp_plot_cell{i} = plot(control_points(:, 1), control_points(:, 2), ...
                           '-', 'linewidth', 1);
end

legend([poi_plot pol_plot curve_plot cp_plot_cell{1} cp_plot_cell{2} ...
       cp_plot_cell{3}], 'Control Points', 'Original Control Polygon', ...
       'B�zier Curve', 'Control Polygon - Degree 4', ...
       'Control Polygon - Degree 5', 'Control Polygon - Degree 6', ...
       'Location', 'best');
