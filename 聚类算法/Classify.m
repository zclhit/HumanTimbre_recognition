function [new_centre,FLAG,change] = Classify(data,centre)


[K,coefficient]=size(centre);
[M,coefficient]=size(data);
FLAG = zeros(1,M);
new_sum=zeros(K,coefficient);
counter=zeros(1,K);
new_centre=zeros(K,coefficient);
for i=1:M
   sum = zeros(1,K);
   for j=1:K
      for p=1:coefficient
         sum(1,j) = sum(1,j) + (data(i,p)-centre(j,p)).^2;
      end
   end
   FLAG(1,i) = find(sum==min(sum));
end                %分类完成，存储为FLAG行向量
%%%%更新中心点%%%%
for i=1:M
   for j=1:K
      if FLAG(1,i)==j
         counter(1,j) = counter(1,j) + 1;
         new_sum(j,:) = new_sum(j,:) + data(i,:);
      end
   end
end
for i=1:K
   new_sum(i,:) = new_sum(i,:)./counter(1,i);
   new_centre(i,:) = new_sum(i,:);
end
if isequal(new_centre,centre)
   change=0;
else
   change=1;
end

 




