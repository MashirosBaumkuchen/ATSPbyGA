clear %清理变量
clc %清屏
close all %关闭图像
my_dir='data/56/m005/';
temp1=dir([my_dir,'*.txt']);
time=zeros(20,8);
data=zeros(20,8);
for i=1:20
    filename=[my_dir,temp1(i).name];
    fid=fopen(filename,'r+');
    fseek(fid,-232,'eof'); 
    tline=fgetl(fid);
    fseek(fid,-249,'eof'); 
    tline2=fgetl(fid);
    fclose(fid);
    time(i,1)=str2num(tline);
    data(i,1)=str2num(tline2);
end
%%%%%%%%%%%% 前保留後不保留
my_dir_2='data/56/m005/xx/';
temp2=dir([my_dir_2,'*.txt']);
for i=1:20
    filename=[my_dir_2,temp2(i).name];
    fid=fopen(filename,'r+');
    fseek(fid,-232,'eof'); 
    tline=fgetl(fid);
    fseek(fid,-249,'eof'); 
    tline2=fgetl(fid);
    fclose(fid); 
    time(i,2)=str2num(tline);
    data(i,2)=str2num(tline2)-100;
end
%%%%%%%%%%%%%%%%%5
my_dir_2='data/56/m010/';
temp2=dir([my_dir_2,'*.txt']);
for i=1:20
    filename=[my_dir_2,temp2(i).name];
    fid=fopen(filename,'r+');
    fseek(fid,-232,'eof'); 
    tline=fgetl(fid);
    fseek(fid,-249,'eof'); 
    tline2=fgetl(fid);
    fclose(fid); 
    time(i,3)=str2num(tline);
    data(i,3)=str2num(tline2);
end
%%%%%%%%%%%%%%%%%
my_dir_2='data/56/m010/xx/';
temp2=dir([my_dir_2,'*.txt']);
for i=1:20
    filename=[my_dir_2,temp2(i).name];
    fid=fopen(filename,'r+');
    fseek(fid,-232,'eof'); 
    tline=fgetl(fid);
    fseek(fid,-249,'eof'); 
    tline2=fgetl(fid);
    fclose(fid); 
    time(i,4)=str2num(tline);
    data(i,4)=str2num(tline2)-100;
end
%%%%%%%%%%%%%%%%%
my_dir_2='data/56/m015/';
temp2=dir([my_dir_2,'*.txt']);
for i=1:20
    filename=[my_dir_2,temp2(i).name];
    fid=fopen(filename,'r+');
    fseek(fid,-232,'eof'); 
    tline=fgetl(fid);
    fseek(fid,-249,'eof'); 
    tline2=fgetl(fid);
    fclose(fid); 
    time(i,5)=str2num(tline);
    data(i,5)=str2num(tline2);
end
%%%%%%%%%%%%%%%%%
my_dir_2='data/56/m015/xx/';
temp2=dir([my_dir_2,'*.txt']);
for i=1:20
    filename=[my_dir_2,temp2(i).name];
    fid=fopen(filename,'r+');
    fseek(fid,-232,'eof'); 
    tline=fgetl(fid);
    fseek(fid,-249,'eof'); 
    tline2=fgetl(fid);
    fclose(fid); 
    time(i,6)=str2num(tline);
    data(i,6)=str2num(tline2);
end
%%%%%%%%%%%%%%%%%
my_dir_2='data/56/m020/';
temp2=dir([my_dir_2,'*.txt']);
for i=1:20
    filename=[my_dir_2,temp2(i).name];
    fid=fopen(filename,'r+');
    fseek(fid,-232,'eof'); 
    tline=fgetl(fid);
    fseek(fid,-249,'eof'); 
    tline2=fgetl(fid);
    fclose(fid); 
    time(i,7)=str2num(tline);
    data(i,7)=str2num(tline2);
end
%%%%%%%%%%%%%%%%%
my_dir_2='data/56/m020/xx/';
temp2=dir([my_dir_2,'*.txt']);
for i=1:20
    filename=[my_dir_2,temp2(i).name];
    fid=fopen(filename,'r+');
    fseek(fid,-232,'eof'); 
    tline=fgetl(fid);
    fseek(fid,-249,'eof'); 
    tline2=fgetl(fid);
    fclose(fid); 
    time(i,8)=str2num(tline);
    data(i,8)=str2num(tline2);
end
%%%%%%%%%%%%%%%%%
time
data

boxplot(time,'labels',{'K-m005' 'UK-m005' 'K-m010 ' 'UK-m010' 'K-m015 ' 'UK-m015' 'K-m020 ' 'UK-m020'})
title('ftv55-Ts')
figure;
boxplot(data,'labels',{'K-m005' 'UK-m005' 'K-m010 ' 'UK-m010' 'K-m015 ' 'UK-m015' 'K-m020 ' 'UK-m020'})
title('ftv55-Ans')

mean(time,1)
mean(data,1)

std(time,0,1)
std(data,0,1)


