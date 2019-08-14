function [] = draw(h, L, num_L, sample_x, sample_y, point, str)
%绘制等高线图和F1-score，直观呈现算法效果
%figure(1);  %Sinusoidal2D的等高线图
x_contour = linspace(1/sample_x, 1, sample_x);
y_contour = linspace(2/sample_y, 2, sample_y);
z_contour = zeros(sample_y, sample_x);
for m = 1 : sample_y
    for n = 1 : sample_x
        z_contour(m, n) = sin(10*x_contour(n)) + cos(4* y_contour(m)) - cos(3*x_contour(n)*y_contour(m));
    end
end
%[c_1, h_1] = contourf(x_contour, y_contour, z_contour, [h h]);
%clabel(c_1, h_1);
%title('函数真实值');
%xlabel('x');
%ylabel('y');
%colorbar; %分类结果的等高线图
z_estimated = zeros(sample_y, sample_x);
for m = 1 : num_L
    z_estimated(round(L(m, 2) * sample_y/2), round(L(m, 1) * sample_x)) = h - 1;
end
for m = 1 : sample_y
    for n = 1 : sample_x
        if z_estimated(m, n) == 0
            z_estimated(m, n) = h + 1;
        end
    end
end
[c_2, h_2] = contourf(x_contour, y_contour, z_estimated, [h h]);
clabel(c_2, h_2);
title(str);
xlabel('x');
ylabel('y');
hold on;
if str == "lse-result"
    s = 'r';
else if str == "Straddle-result"
        s = 'g';
    else
        s = 'b';
    end
end
scatter(point(:,1), point(:,2), s);
hold off;
%colorbar;
