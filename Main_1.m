for sas=1:1:20
clear %�������
clc %����
close all %�ر�ͼ��
format short g ;%�ı���ʾ��ʽ����ʹ��Ĭ�ϵĿ�ѧ�������ĸ�ʽ
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%�������岿��
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
M=500;%Ԥ����Ⱥ��ģ 
D=600;%��������
DC=D;%����������
pc=0.8;%�������
pm=0.020;%�������
lastT=0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%��ʼ����ȺFarm������������ɷ���
Temp2=zeros(M,1);%1�����ڴ�ž���
Temp1=zeros(M,N);%N�����ڴ��·��
resPlot=zeros(1,D);%���ڻ�ͼ
for index=1:M %ѭ��M��
    Temp1(index,:)=randperm(N);%����һ��1��N�������
end
% ��Ⱥ��ģMΪ����  ���еĸ���N+1Ϊ���� ,���һ�з���Ӧ��
Farm=[Temp1,Temp2];%����ĺϲ�
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
t = clock();
txtUrl = ['data/56/m020/xx/',num2str(N),num2str(M),num2str(D), num2str(t(6)),'.txt']; 
jpgUrl = ['data/56/m020/xx/',num2str(N),num2str(M),num2str(D), num2str(t(6)),'.jpg']; 
fid=fopen(txtUrl,'w+');
result=0;
best=zeros(1,N+1);%N�����ڴ��·��%%%%%%%%%%%%%%%%%%%%%%%
while 1    %ѭ����1  ��ʼ��ʶ��
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %������Ⱥ������ÿ���������Ӧ��
    Farm=AdaptFun(Farm,CD);%������Ӧ�Ⱥ���AdaptFun��������Ӧ��
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if(result>min(Farm(:,N+1)))
        lastT = D-DC;
    end;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    result=min(Farm(:,N+1));%�������еĵ�N+1����Ѱ����Сֵ
    best(1,N+1) = result;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    resPlot(1,D-DC+1) = result;
    fprintf('\n\n��%d������������·���Ĵ���: %.1f\n',D-DC,result);fprintf(fid,'\n��%d������������·���Ĵ���: %.1f\n',D-DC,result);%write
    fprintf('����·��: ');fprintf(fid,'����·��: ');%write
    [r,c]=find(Farm(:,N+1)==result);%Ѱ�Ҵ����Сֵ�Ķ�Ӧ�к�
    for index=1:N  %��ӡ·��
        fprintf('%.0f  ',Farm(r(1),index));fprintf(fid,'%.0f  ',Farm(r(1),index));%write
        best(1,index) = Farm(r(1),index);%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %r���ܳ��ֶ���������ж���⣩����r(1)
    end
    
    fprintf('\n');fprintf(fid,'\n');%write
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if DC==0  %������������ﵽ��Ԥ��ֵ
        %������ ������·��������·���Ĵ���
        result=min(Farm(:,N+1));%�������еĵ�N+1����Ѱ����Сֵ
        fprintf('\n����·���Ĵ���: %.1f',result);fprintf(fid,'\n����·���Ĵ���: %.1f',result);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        fprintf('\n�ȶ�ʱ��: %.1f',lastT);fprintf(fid,'\n�ȶ�ʱ��: %.1f',lastT);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        fprintf('\n����·��: ');fprintf(fid,'\n����·��: ');
        [r,c]=find(Farm(:,N+1)==result);%Ѱ�Ҵ����Сֵ�Ķ�Ӧ�к�
        for index=1:N  %��ӡ·��
            fprintf('%.0f  ',Farm(r(1),index));fprintf(fid,'%.0f  ',Farm(r(1),index));
        %r���ܳ��ֶ���������ж���⣩����r(1)
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
        break;%��ô����ѭ����1
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %ѡ��
    Farm=Selection(Farm,M);
    %Farm=[Farm; best];%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %����
    Farm=Crossover(Farm,pc);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %����
    Farm=Mutation(Farm,pm);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    DC=DC-1; %����������
    %������ת����������Ⱥ����һ��
end    %ѭ����1  ������ʶ��
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fclose(fid);
end