function [w] = perceptron(x,flag) 
%要求x为m*n维矩阵，m为训练样本总数，n为单个样本的维数
%flag为m维向量，类别标志位
[m,n] = size(x);
new_x = zeros(m,n+1);
for i=1:m            %将训练样本扩展，加上标志位
   if flag(i)==1
      new_x(i,:) = [x(i,:) 1];
   elseif flag(i)==-1
      new_x(i,:) = [x(i,:) 1]*(-1);
   end
end
new_x = new_x'; 
W = zeros(1,n+1);
for i=1:m
   wrong_number = 0;
   if W*new_x(:,i)<=0
      W = W+new_x(:,i)';
      wrong_number = wrong_number + 1;
   end
   if wrong_number == 0
      break
   end
end
w = W;