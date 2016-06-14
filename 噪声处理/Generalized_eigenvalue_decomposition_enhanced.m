function [x] = Generalized_eigenvalue_decomposition_enhanced(y1,d,flame)

%该算法针对每一帧处理
%该算法针对有色噪声
%y为待处理的有语音音频帧，假定y=x+d,d是和y等长的无语音音频帧
%增加后置滤波器
%flame为当前处理的帧数（第一帧第二帧...）

Ry = (y1*y1')./length(y1);
Rd = (d*d')./length(d);

% temp1=[y1';y1'];
% Ry=cov(temp1);
% temp2=[d';d'];
% Rd=cov(temp2);

K = length(y1);
[~,Eigen_x] = eig(Ry-Rd);
[~,Eigen_d] = eig(Rd);
la0 = 4.2;
deta = 6.25;    
afa = 0.98;
%%%%计算r%%%%
r = zeros(1,K);
for i=1:K
   r(i) = Eigen_x(i)/Eigen_d(i);
end
rr(flame,:) = r(1,:);
%%%%拉氏系数%%%%
SNRdb = zeros(1,K);
for i=1:K
   SNRdb(i) = 10*log10(r(i));
end
la = zeros(1,K);
for i=1:K
   if (SNRdb<=(-5))
      la(i) = 5;
   elseif (SNRdb>=20)
      la(i) = 1;
   else
      la(i) = la0 - SNRdb(i)/deta;
   end
end
%%%%获取G矩阵对角线元素%%%%
[V,Eigen_general] = eig((Ry-Rd),Rd);      %有待证实
g = zeros(1,K);
for i=1:K
   if Eigen_general(i,i)<0
      Eigen_general(i,i) = 0;
   end
   g(i) = Eigen_general(i,i)/(Eigen_general(i,i)+la(i));
   gg(flame,i) = g(1,i);
end
%%%%获得先验信噪比%%%%
sigma = zeros(1,K);
for i=1:K
   if flame == 1                          %如果是第一帧
      sigma(i) = afa + (1 - afa) * max((r(i) - 1),0);
   else
      sigma(i) = afa * sqrt(gg(flame - 1,i)) * rr(flame-1,i) + (1 - afa) * max((r(i) - 1),0);
   end
end
%%%%获得ESI信噪比%%%%
SNR_ESIdb = zeros(1,K);
for i=1:K
   SNR_ESIdb(i) = sigma(i)/((1-g(i))^2*sigma(i)+(g(i))^2);
   SNR_ESIdb(i) = 10*log10(SNR_ESIdb(i));
end
%%%%获得后置滤波器处理后的增益矩阵元素并构成矩阵G%%%%
g_modulate = zeros(1,K);
q = zeros(1,K);
for i=1:K
   if SNR_ESIdb(i)<0
      q(i) = 0.8;
   else
      q(i) = 1;
   end
   g_modulate(i) = q(i)*g(i);
end
G_modulate = diag(g_modulate);
%%%%输出增强后的语音信号（当前帧）%%%%
x = V'.*G_modulate.*V'.*y1;
plot(x);


   

      