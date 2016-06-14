function [pure_sound] = against_simplenoise(x,y)
%运用(功率)谱减法对抗简单噪声
%[x fs] = wavread('filename1.wav')，在主函数预读取音频文件
%[y fs] = wavread('filename2.wav')，在主函数预读取无语音音频文件
%x，y为时域点；fs为采样频率
%该方法对输入语音有所要求，要求无语音音频输入
%
%
[col1,row] = size(x);
[col2,row] = size(y);
n_1 = col1;
n_2 = col2;
xx = zeros(col1,1);
yy = zeros(col2,1);
if row == 2
   xx = (x(:,1)+x(:,2))./2;
   yy = (y(:,1)+y(:,2))./2;%如果双声道，合并成单声道
else
   xx = x;
   yy = y;
end
% subplot(212);
% plot(xx);
% title('去噪声');
%%%%分帧%%%%  
n = 16000;
frame_1 = (n_1 - rem(n_1,n))/n + 1;
frame_2 = (n_2 - rem(n_2,n))/n ; %无语音输入尽量取整帧(尽量长)，只能略多，且要截取多余的
xx_split = zeros(frame_1,n);
yy_split = zeros(frame_2,n);
Fxx = zeros(frame_1,n);
Fyy = zeros(frame_2,n);
for i = 1:frame_1
    if i == frame_1
      xx_split(i,1:rem(n_1,n)) = xx(((frame_1-1)*n+1):n_1,1);
      xx_split(i,(rem(n_1,n)+1):n) = 0;
      xx_split(i,:) = xx_split(i,:)'.*hamming(n);
      Fxx(i,:) = abs(fft(xx_split(i,:),n)); %分帧并进行傅里叶变换
      break
   end
   xx_split(i,:) = xx(((i-1)*n+1):(i*n),1).*hamming(n);%加窗？
   Fxx(i,:) = abs(fft(xx_split(i,:),n));
end
ang = zeros(frame_1,n);
for i = 1:frame_1
   ang(i,:) = angle(fft(xx_split(i,:),n)); %%%求幅度信息以及功率谱
   Fxx(i,:) = Fxx(i,:).^2;
end
for i = 1:frame_2
   yy_split(i,:) = yy(((i-1)*n+1):(i*n),1).*hamming(n);
   Fyy(i,:) = abs(fft(yy_split(i,:),n));
end
%%%求噪声功率谱的期望%%%
E_noise = zeros(1,n);
for i = 1:frame_2
   E_noise(1,:) = E_noise(1,:) + Fyy(i,:).^2; 
end
E_noise(1,:) = E_noise(1,:)./frame_2;
%%%谱减法%%%
beta = 1;%%%当该系数大于1时为过减法
S = zeros(frame_1,n);
for i = 1:frame_1
   if i == frame_1
      S(i,:) = sqrt(Fxx(i,:) - beta*E_noise(1,:));
      S(i,:) = S(i,:).*exp(1j*ang(i,:));
      S(i,:) = real(ifft(S(i,:),n))'./hamming(n); 
      for p = (rem(n_1,n)+1):n
         S(i,p) = 0;
      end
      break
   end
   S(i,:) = sqrt(Fxx(i,:) - beta*E_noise(1,:));
   S(i,:) = S(i,:).*exp(1j*ang(i,:));
   S(i,:) = real(ifft(S(i,:),n))'./hamming(n); %%%加上相位，再进行去窗处理
   
end

result=[];
for count=1:7;
    result=[result S(i,:)];
end
result1 = [S(1,:) S(2,:) S(3,:) S(4,:) S(5,:) S(6,:) S(7,:)];
% result=int(result);
 subplot(211);

plot(result);
subplot(212);
plot(result1);
% title('原始');

audiowrite('quzaoshengjieguo1.wav',result,16000)