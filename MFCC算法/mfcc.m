%%%%%%%%%%%%%%%%%%
%名称：用MEL滤波器进行mfcc参数的计算
%输入：待检测信号x
%输出：信号的mfcc参数
%作者：张常乐
%%%%%%%%%%%%%%%%%%%%%%%%
function ccc = mfcc(x)
bank = melbankm(24, 256, 44100, 0 , 0.5, 'm');   %设定Mel滤波器系数，24个滤波器组，256的fft长度，采样频率44100Hz，滤波器下界为0，上界为0.5倍采样频率，采用hamming形式的filter
bank = full(bank);                              %对bank中为空的部分补零
bank = bank/max(bank(:));                       %归一化
%设定DCT系数
for k = 1:12                                    %循环体，生成12*24的dct矩阵
    n = 0:23;
    dct(k,:)=cos((2*n+1)*k*pi/(2*24));
end
%设置归一化的倒谱提升窗口
w=1+6*sin(pi*[1:12]./12);                       %1*12的w窗口
w=w/max(w);                                     %归一化
%设置预加重滤波器
ss = double(x);                                 %变为double数型
xx = filter([1 -0.9375],1,ss);                  %滤波器函数，h(x)=A*sin(x)+B*cos(x)
%对信号进行分帧处理
xx=enframe(xx,hamming(256),128);                %256长度的海明窗进行分帧处理
%计算每帧的MFCC参数
for i=1:size(xx,1)                              %按帧计算
    s=xx(i,:);
    %对信号s进行fft
    t= abs(fft(s));
    t=t.^2;
    %对fft参数进行mel滤波取对数再计算倒谱
    c1=dct*log(bank*t(1:129)');                 %w' (1:129)'代表的是矩阵或相量的转置
    c2=c1.*w';
    %mfcc参数
    m(i,:)=c2;
end
ccc= m; 