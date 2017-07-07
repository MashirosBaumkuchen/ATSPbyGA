for sas=1:1:20
clear %清理变量
clc %清屏
close all %关闭图像
format short g ;%改变显示格式，不使用默认的科学计数法的格式
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%参数定义部分
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
N=56;
YSize = 6000;
A = importdata('atsplib/ftv55.txt',' ',7);
CD = zeros(56,56);
A.data
for i=1:56
    for j=1:56
        CD(i,j)=A.data((i-1)*56+j);
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
M=500;%预设种群规模 
D=600;%迭代次数
DC=D;%迭代计数器
pc=0.8;%交叉概率
pm=0.020;%变异概率
lastT=0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%初始化种群Farm，采用随机生成方法
Temp2=zeros(M,1);%1列用于存放距离
Temp1=zeros(M,N);%N列用于存放路径
resPlot=zeros(1,D);%用于绘图
for index=1:M %循环M次
    Temp1(index,:)=randperm(N);%生成一个1到N随机序列
end
% 种群规模M为行数  城市的个数N+1为列数 ,最后一列放适应度
Farm=[Temp1,Temp2];%矩阵的合并
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
t = clock();
txtUrl = ['data/56/m020/xx/',num2str(N),num2str(M),num2str(D), num2str(t(6)),'.txt']; 
jpgUrl = ['data/56/m020/xx/',num2str(N),num2str(M),num2str(D), num2str(t(6)),'.jpg']; 
fid=fopen(txtUrl,'w+');
result=0;
best=zeros(1,N+1);%N列用于存放路径%%%%%%%%%%%%%%%%%%%%%%%
while 1    %循环体1  开始标识符
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %评价种群，计算每个个体的适应度
    Farm=AdaptFun(Farm,CD);%调用适应度函数AdaptFun，生成适应度
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if(result>min(Farm(:,N+1)))
        lastT = D-DC;
    end;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    result=min(Farm(:,N+1));%在所有行的第N+1列中寻找最小值
    best(1,N+1) = result;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    resPlot(1,D-DC+1) = result;
    fprintf('\n\n第%d代个体中最优路径的代价: %.1f\n',D-DC,result);fprintf(fid,'\n第%d代个体中最优路径的代价: %.1f\n',D-DC,result);%write
    fprintf('最优路径: ');fprintf(fid,'最优路径: ');%write
    [r,c]=find(Farm(:,N+1)==result);%寻找存放最小值的对应行号
    for index=1:N  %打印路径
        fprintf('%.0f  ',Farm(r(1),index));fprintf(fid,'%.0f  ',Farm(r(1),index));%write
        best(1,index) = Farm(r(1),index);%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %r可能出现多行情况（有多个解），故r(1)
    end
    
    fprintf('\n');fprintf(fid,'\n');%write
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if DC==0  %如果迭代次数达到了预设值
        %输出结果 ：最优路径、最优路径的代价
        result=min(Farm(:,N+1));%在所有行的第N+1列中寻找最小值
        fprintf('\n最优路径的代价: %.1f',result);fprintf(fid,'\n最优路径的代价: %.1f',result);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        fprintf('\n稳定时间: %.1f',lastT);fprintf(fid,'\n稳定时间: %.1f',lastT);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        fprintf('\n最优路径: ');fprintf(fid,'\n最优路径: ');
        [r,c]=find(Farm(:,N+1)==result);%寻找存放最小值的对应行号
        for index=1:N  %打印路径
            fprintf('%.0f  ',Farm(r(1),index));fprintf(fid,'%.0f  ',Farm(r(1),index));
        %r可能出现多行情况（有多个解），故r(1)
        end
        fprintf('\n');fprintf(fid,'\n');
        %FarmSize=(size(Farm));
        %FarmSize(1)
        %FarmSize(2)
        plot(resPlot);
        axis([0 D 20 YSize]); 
        name = ['Atsp N=',num2str(N)]; 
        title(name)
        saveas(1,jpgUrl)
        break;%那么跳出循环体1
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %选择
    Farm=Selection(Farm,M);
    %Farm=[Farm; best];%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %交叉
    Farm=Crossover(Farm,pc);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %变异
    Farm=Mutation(Farm,pm);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    DC=DC-1; %迭代计数器
    %重新跳转到“评价种群”这一步
end    %循环体1  结束标识符
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fclose(fid);
end