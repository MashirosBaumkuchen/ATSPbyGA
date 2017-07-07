clear %清理变量
clc %清屏
close all %关闭图像
my_dir='data/17/m005/';
temp1=dir([my_dir,'*.txt']);
time=zeros(20,2);
data=zeros(20,2);
for i=1:20
    filename=[my_dir,temp1(i).name];
    fid=fopen(filename,'r+');
    fseek(fid,-75,'eof'); 
    tline=fgetl(fid);
    fseek(fid,-90,'eof'); 
    tline2=fgetl(fid);
    fclose(fid); 
    time(i,1)=str2num(tline);
    data(i,1)=str2num(tline2);
end
%%%%%%%%%%%% 前保留後不保留
my_dir_2='data/17/m00502/';
temp2=dir([my_dir_2,'*.txt']);
for i=1:20
    filename=[my_dir_2,temp2(i).name];
    fid=fopen(filename,'r+');
    fseek(fid,-75,'eof'); 
    tline=fgetl(fid);
    fseek(fid,-90,'eof'); 
    tline2=fgetl(fid);
    fclose(fid); 
    time(i,2)=str2num(tline)/1.33;
    data(i,2)=str2num(tline2);
end
time
data

boxplot(time,'labels',{'K-m005' 'UK-m005'})
title('br17-Ts')
figure;
boxplot(data,'labels',{'K-m005' 'UK-m005'})
title('br17-Ans')

mean(time,1)
mean(data,1)

std(time,0,1)
std(data,0,1)


