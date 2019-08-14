clear;
sample_x = 20;
sample_y = 25;
[point_sample,num_sample]=initialD(sample_x,sample_y);
h = 0;
%1 ������� 0��������
[~,~,~,~,~,fasttime]=TVR(point_sample,num_sample,h,1);
[TVR_record,~,~,~,~,slowtime]=TVR(point_sample,num_sample,h,0);
hold on
plot(fasttime(2:TVR_record-1),'r');
hold on
plot(slowtime(2:TVR_record-1),'b');
legend(['fastTVR'],['slowTVR'],'Location',"SouthEast");

hold off
xlabel('��������t');
ylabel('time/s');
saveas(gcf,'testTVR','png');