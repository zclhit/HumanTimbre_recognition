clc;clear all;close all;
[x,fs] = wavread('quzaoshengjieguo.wav');
%result=Sex_distinction(x);
TP_max = 0.02; %最大基音周期设定为40ms
TP_min = 0.0025; %最小基音周期设定为2.5ms
[col1,row] = size(x);
xx = zeros(col1,1);
if row == 2
   xx = (x(:,1)+x(:,2))./2;%如果双声道，合并成单声道
else
   xx = x;
end
%%%%在中心削波之前还要加上端点检测%%%%

%%%%中心削波%%%%
a = max(xx);
coefficient = 0.7;%待调试的参数
threshold = a*coefficient;
for i=1:col1
   if xx(i,1)>=threshold
      xx(i,1) = xx(i,1) - threshold;
   elseif xx(i,1)<threshold
      xx(i,1) = xx(i,1) + threshold;   
   end
end
%%%%分帧与加窗，帧长设定为40ms，帧移为10ms%%%%
n = 6400;      %这是一帧的长度，具体值我没有换算，最好是40ms，因为最大基音周期设定为40ms
n_shift = 1600;  %这是帧移的长度，具体值我没有换算，最好是10ms
flame = ceil(col1/n_shift)-3;
surPlus = rem(col1,n_shift);
S = zeros(flame,n);
for i=1:flame
   if surPlus>0&&i==flame
      S(i,:) = xx((i-2)*n_shift+1+surPlus:(i+3)*n_shift+surPlus,1).*hamming(n);
      break
   end
   S(i,:) = xx((i-1)*n_shift+1:(i+3)*n_shift,1).*hamming(n);
end
%%%%求系数D(k)%%%%
D=zeros(flame,n);
for i=1:flame
   for j=1:n
      for p=1:n
      D(i,j) = D(i,j)+abs(S(i,mod((p+j),n-2)+1)-S(i,p));
      end
   end
end
%%%%查找D(i,j)的局部最小点,统计为为M个，不包括端点%%%%
TP = zeros(flame,1);
for i=1:flame
   Min_location = find(diff(sign(diff(D(i,:))))>0)+1;
   Min_value = D(i,Min_location);
   M = length(Min_location);
   if M<=1     %如果小于等于1则为静音帧
      TP(i) = 0;
      break
   elseif M==2
      P1 = min(Min_value);
      P2 = max(Min_value);
      if P2<TP_min
         TP(i) = 0;
         break
      elseif P1>=TP_min
         TP(i) = P1;
         break
      else
         TP(i) = P2;
         break
      end
%    elseif M>=3
%       %tmp = find(min(Min_value)>=TP_min&min(Min_value)<=TP_max);
%       TP(i) = min(D(i,tmp));
   end
end
%%%%将所有帧的基音周期取平均%%%%
TP_mean = mean(TP);
Frequency = 1/TP_mean
if Frequency<=200
   sex = '男';
elseif Frequency>200
   sex = '女';
end