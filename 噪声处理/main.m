clc;clear all;close all;
[x,fs] = wavread('noise_test.wav');             %生意读取
%%%%%这个程序调用against_simplenoise函数处理一般噪声
y(:,1)=x(8192:24575,1);                       %噪声取样
y(:,2)=x(8192:24575,2);                       %噪声取样
against_simplenoise(x,y);
%%%%这个程序调用Generalized_eigenvalue_decmposition来进行子空间分解，处理一般噪声
% y(:,1)=x(fs/160:(fs/80-1),1);                       %0.5秒到1.5秒作为噪声取样
% y(:,2)=x(fs/160:(fs/80-1),2);                       %0.5秒到1.5秒作为噪声取样
% %声道合并
% [col1,row] = size(x);
% [col2,row] = size(y);
% n_1 = col1;
% n_2 = col2;
% xx = zeros(col1,1);
% yy = zeros(col2,1);
% if row == 2
%    xx = (x(:,1)+x(:,2))./2;
%    yy = (y(:,1)+y(:,2))./2;                     %如果双声道，合并成单声道
% else
%    xx = x;
%    yy = y;
% end
% xx1=xx(fs/2:n_1);                               %xx1为去掉前半帧的待处理语音信号
% lengthxx1=length(xx1);                                %xx1长度
% % frame_num = round(lengthxx1*2/fs);
% % for i=1:frame_num
% %     x2process=xx1((i-1)*fs/2+1:i*fs/2);
% %     outputmatrix(i,:)=Generalized_eigenvalue_decomposition_enhanced(x2process,yy,i);
% % end
% i=4;
%      x2process=xx1((i-1)*fs/160+1:i*fs/160);
%      outputmatrix(i,:)=Generalized_eigenvalue_decomposition_enhanced(x2process,yy,i);