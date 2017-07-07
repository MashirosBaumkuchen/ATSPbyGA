%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 
 17
 最优路径：39
 最优路径的代价： 14  1  12  6  16  15  7  5  4  17  9  8  10  13  11  2  3  
 N=17;
 YSize=100;
 A = importdata('atsplib/br17.txt',' ',7);
 CD = zeros(17,17);
 A.data
 for i=1:2:34
     col=0;
     for j=1:16
         CD(ceil(i/2),j)=A.data(i,j);
         col=col+1;
     end
     for j=17:17
         CD(ceil(i/2),j)=A.data(i+1,17-j+1);
         col=col+1;
         if(col>=17) break;
         end
     end
 end
 CD

N=56;
YSize = 4000;
A = importdata('atsplib/ftv55.txt',' ',7);
CD = zeros(56,56);
A.data
for i=1:56
    for j=1:56
        CD(i,j)=A.data((i-1)*56+j);
    end
end
CD

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

N=33;
YSize = 4000;
A = importdata('atsplib/ftv33.txt',' ',7);
CD = zeros(33,33);
A.data
for i=1:33
    for j=1:33
        CD(i,j)=A.data((i-1)*33+j);
    end
end
