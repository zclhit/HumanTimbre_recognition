
function [Centre,Result] = Kmeans(data)
%data: 人数乘系数数的样本矩阵
%singer: 待分类的人数；coefficient: 特征值个数
%flag: 分类的结果
[singer,coefficient] = size(data);
K = 4;
centre = zeros(K,coefficient);
for i=1:K                   %分为K类，分类个数以及中心点的选取有待研究，这里顺序选取K个
   centre(i,:)=data(i,:);
end                   %centre（中心点）已生成

[centre_new,flag,change]=Classify(data,centre);      
while(change==1)
   [centre_new,flag,change]=Classify(data,centre_new); %继续分类，直到中心点不再变化
end
Centre = centre_new;
Result = flag;


