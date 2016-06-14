function ccc=My_mfcc(music,Point_N)
[x fs]=audioread(music);
MEL_N=ceil(4.6*log10(fs));
%bank=melbankm(24,256,fs,0,0.4,'t');%Mel滤波器的阶数为24，fft变换的长度为256，采样频率为16000Hz
bank = melbankm(MEL_N, 256, fs, 0 , 0.5, 'm'); %设定Mel滤波器系数
%归一化mel滤波器组系数
bank=full(bank);
bank=bank/max(bank(:));
%设置DCT参数即MFCC参数个数
DCT_N=Point_N;
for k=1:DCT_N         
    n=0:MEL_N-1;
    dctcoef(k,:)=cos((2*n+1)*k*pi/(2*MEL_N));
end
%归一化倒谱提升窗口
w=1+6*sin(pi*[1:DCT_N]./DCT_N);
w=w/max(w);
%预加重滤波器
xx=double(x);
xx=filter([1-0.9375],1,xx);
%语音信号分帧
%xx=enframe(xx,256,80);%对x 256点分为一帧
xx=enframe(xx,hamming(256),128);
%计算每帧的MFCC参数
for i=1:size(xx,1)
    y=xx(i,:);
    s=y'.*hamming(256);
    t=abs(fft(s));%fft快速傅立叶变换
    test_fre=t;%%%%%%%%%%%%%%%%%%%%%
    t=t.^2;
    c1=dctcoef*log(bank*t(1:129));
    c2=c1.*w';
    m(i,:)=c2';
end
m_copy=m;
m_copy(any(isnan( m_copy)'),:)=[];
My_Mfcc=mean(m_copy);
ccc=My_Mfcc;


% %求取一阶差分系数
% dtm=zeros(size(m));
% for i=3:size(m,1)-2
%     dtm(i,:)=-2*m(i-2,:)-m(i-1,:)+m(i+1,:)+2*m(i+2,:);
% end
% dtm=dtm/3;
% %求取二阶差分系数
% dtmm=zeros(size(dtm));
% for i=3:size(dtm,1)-2
% dtmm(i,:)=-2*dtm(i-2,:)-dtm(i-1,:)+dtm(i+1,:)+2*dtm(i+2,:);
% end
% dtmm=dtmm/3;
% %合并mfcc参数和一阶差分mfcc参数
% ccc=[m dtm dtmm];
% %去除首尾两帧，因为这两帧的一阶差分参数为0
% ccc=ccc(3:size(m,1)-2,:);
% ccc;
% subplot(2,1,1) 
% ccc_1=ccc(:,1);
% plot(ccc_1);title('MFCC');ylabel('幅值');
% [h,w]=size(ccc);
% A=size(ccc);
% subplot(212)    
% plot([1,w],A);
% xlabel('维数');
% ylabel('幅值');
% title('维数与幅值的关系') 