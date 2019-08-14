clear;
sample_x = 25;
sample_y = 40;
[point_sample,num_sample]=initialD(sample_x,sample_y);
h = 0;
t0 = clock;
[lse_record,lse_score,Lse_H,Lse_L,Lse_nL]=Lse(point_sample,num_sample,h);
t1 =clock;
t_lse = etime(t1,t0)
[Straddle_record,Straddle_score,Straddle_H,Straddle_L,Straddle_nL]=Straddle(point_sample,num_sample,h);
t2 = clock;
t_Straddle = etime(t2,t1)
[TVR_record,TVR_score,TVR_H,TVR_L,TVR_nL]=TVR(point_sample,num_sample,h);
t3 = clock;
t_TVR = etime(t3,t2)
figure(1)
subplot(2,2,1)
x_contour = linspace(1/sample_x, 1, sample_x);
y_contour = linspace(2/sample_y, 2, sample_y);
z_contour = zeros(sample_y, sample_x);
for m = 1 : sample_y
    for n = 1 : sample_x
        z_contour(m, n) = sin(10*x_contour(n)) + cos(4* y_contour(m)) - cos(3*x_contour(n)*y_contour(m));
    end
end
[c_1, h_1] = contourf(x_contour, y_contour, z_contour, [h h]);
clabel(c_1, h_1);
title('函数真实值');
xlabel('x');
ylabel('y');
subplot(2,2,3)
draw(h, Lse_L, Lse_nL, sample_x, sample_y, Lse_H,'lse-result');
subplot(2,2,2)
draw(h, Straddle_L, Straddle_nL, sample_x, sample_y, Straddle_H,'Straddle-result');
subplot(2,2,4)
draw(h, TVR_L, TVR_nL, sample_x, sample_y, TVR_H,'TVR-result');
saveas(gcf,'result','png');
figure(2); %F1-score
plot(Straddle_score(1:Straddle_record),'r');
hold on
plot(lse_score(1:lse_record),'g');
hold on
plot(TVR_score(1:TVR_record),'b');
legend(['Straddle  ',num2str(Straddle_score(Straddle_record))],['Lse  ',num2str(lse_score(lse_record))],['TVR  ',num2str(TVR_score(TVR_record))],'Location',"SouthEast");
hold off
xlabel('迭代次数t');
ylabel('F1-score');
saveas(gcf,'score','png');