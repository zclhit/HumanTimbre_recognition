 clc;clear all;close all;
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %MFCC参数获取程序-分帧处理
 %输入：wav文件
 %输出：MFCC参数
 %制作人：张常乐
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 [signalspeech,fs,bit]=wavread('sa1.wav');              %文件读取
 %[StartPoint,EndPoint]=vad(signalspeech); %%起始点，终止点---因为运算速度问题没有调用
 %MfccCoefficient=mfcc(signalspeech(StartPoint:EndPoint));  %以断点工作
 
 framelength=44100;                                                 %帧长度
 framenumber=fix(length(signalspeech)/framelength);                    %语音帧数

    i=1;
    framesignal = signalspeech((i-1)*framelength+framelength/2:i*framelength);    %获取首帧后半帧数据
    MfccCoefficient=mfcc(framesignal);                                      %计算了MFCC参数，调用了mfcc.m
    Mave(:,:,1)=mean(MfccCoefficient);                                     %第一层             
    %plot(MfccCoefficient);
    for i=2;framenumber;
         framesignal = signalspeech((i-1)*framelength+22050:i*framelength);    %获取每帧数据
        MfccCoefficient=mfcc(framesignal);
        Mave(:,:,i)=mean(MfccCoefficient);                                  %每一层
    end
    
    for j=1:framenumber;                                                %提取出三维矩阵中的感兴趣元素
        for k=1:12;
            M(k,j)=Mave(1,k,j);
        end
    end
    L=0;
    
     for l=1:12;                                                         %对二维数组的12个参数求平均值
       Me(l)=mean(M(l,:));
    end