function [point_sample, num_sample] = initialD(x_num, y_num)
x_up = 1.0;
x_down = 0.0;
y_up = 2.0;
y_down = 0.0;
num_sample = x_num * y_num;
point_sample = zeros(num_sample, 2);
x_step = (x_up - x_down) / x_num;
y_step = (y_up - y_down) / y_num;
for m = 1 : x_num
   for n = 1 : y_num
      point_sample(n + y_num * (m - 1), :) = [x_down + x_step * m, y_down + y_step * n]; 
   end
end