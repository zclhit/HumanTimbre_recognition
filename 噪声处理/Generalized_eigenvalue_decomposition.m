function [x] = Generalized_eigenvalue_decomposition(y,d)
%y为待处理的有语音音频，假定y=x+d,d是和y等长的无语音音频，一定要等长！！！
%该算法针对有色噪声
%
%
%
Ry = cov(y,y);
Rd = cov(d,d);
la0 = 4.2;
deta = 6.25;                              %la0、deta均为文献中给出的值
[U,Eigen_general] = eig((Ry-Rd),Rd);      %广义特征值分解
%%%%对信号子空间进行特征分解，以便估计维数%%%%
Ka = Rd\Ry - eye(size(Ry));               %定义Ka矩阵系统提示用左面的形式代替inv（Rd）*Ry
[Ux,Eigen_signalsubspace] = eig(Ka);
%%%%对特征值对角阵降序排列%%%%
M = 0;
tmp = zeros(1,size(Eigen_signalsubspace));
for i=1:size(Eigen_signalsubspace)
   tmp(i)=Eigen_signalsubspace(i,i);
   if Eigen_signalsubspace(i,i) > 0
      M = M + 1;                          %得到大于零的特征值的个数   
   end
end
tmp = sort(tmp,'descend');                %降序排列
%%%%计算拉格朗日乘子以及元素q%%%%
SNRdb = 0;
for i=1:M
   SNRdb = SNRdb + tmp(i);
end
SNRdb = 10*log10(SNRdb/(size(Eigen_signalsubspace)));
la = zeros(1,M);
for i=1:M
   if (SNRdb<=(-5))
      la(i) = 5;
   elseif (SNRdb>=20)
      la(i) = 1;
   else
      la(i) = la0 - tmp(i)/deta;
   end
end
%%%%确定最优线性估计器%%%%
g = zeros(1,size(Eigen_signalsubspace));
for i=1:size(Eigen_signalsubspace)
   if (i>=1 && i<=M)
      g(i) = tmp(i)/(tmp(i)+la(i));
   elseif (i>M && i<=size(Eigen_signalsubspace))
      g(i) = 0;
   end
end
G = diag(g);
Htdc = U'\G*U';                           %U的逆转置矩阵乘以G再乘以U的转置

x = Htdc*y;
      

   
   
   




