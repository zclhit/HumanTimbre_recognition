clear all
clc
Point_N=30;
all_mfcc_faks0(1,:)=My_mfcc('dr1/faks0/sa1.wav',Point_N);
all_mfcc_faks0(2,:)=My_mfcc('dr1/faks0/sa2.wav',Point_N);
all_mfcc_faks0(3,:)=My_mfcc('dr1/faks0/si943.wav',Point_N);
all_mfcc_faks0(4,:)=My_mfcc('dr1/faks0/si1573.wav',Point_N);
all_mfcc_faks0(5,:)=My_mfcc('dr1/faks0/si2203.wav',Point_N);
all_mfcc_faks0(6,:)=My_mfcc('dr1/faks0/sx43.wav',Point_N);
all_mfcc_faks0(7,:)=My_mfcc('dr1/faks0/sx133.wav',Point_N);
all_mfcc_faks0(8,:)=My_mfcc('dr1/faks0/sx223.wav',Point_N);
all_mfcc_faks0(9,:)=My_mfcc('dr1/faks0/sx313.wav',Point_N);
all_mfcc_faks0(10,:)=My_mfcc('dr1/faks0/sx403.wav',Point_N);
subplot(3,1,1);
plot(1:Point_N,all_mfcc_faks0);title('dr1_faks0');ylabel('MFCC参数值');

all_mfcc_fdac1(1,:)=My_mfcc('dr1/fdac1/sa1.wav',Point_N);
all_mfcc_fdac1(2,:)=My_mfcc('dr1/fdac1/sa2.wav',Point_N);
all_mfcc_fdac1(3,:)=My_mfcc('dr1/fdac1/si844.wav',Point_N);
all_mfcc_fdac1(4,:)=My_mfcc('dr1/fdac1/si1474.wav',Point_N);
all_mfcc_fdac1(5,:)=My_mfcc('dr1/fdac1/si2104.wav',Point_N);
all_mfcc_fdac1(6,:)=My_mfcc('dr1/fdac1/sx34.wav',Point_N);
all_mfcc_fdac1(7,:)=My_mfcc('dr1/fdac1/sx124.wav',Point_N);
all_mfcc_fdac1(8,:)=My_mfcc('dr1/fdac1/sx214.wav',Point_N);
all_mfcc_fdac1(9,:)=My_mfcc('dr1/fdac1/sx304.wav',Point_N);
all_mfcc_fdac1(10,:)=My_mfcc('dr1/fdac1/sx394.wav',Point_N);
subplot(3,1,2);
plot(1:Point_N,all_mfcc_fdac1);title('dr1_fdac1');ylabel('MFCC参数值');

all_mfcc_felc0(1,:)=My_mfcc('dr1/felc0/sa1.wav',Point_N);
all_mfcc_felc0(2,:)=My_mfcc('dr1/felc0/sa2.wav',Point_N);
all_mfcc_felc0(3,:)=My_mfcc('dr1/felc0/si756.wav',Point_N);
all_mfcc_felc0(4,:)=My_mfcc('dr1/felc0/si1386.wav',Point_N);
all_mfcc_felc0(5,:)=My_mfcc('dr1/felc0/si2016.wav',Point_N);
all_mfcc_felc0(6,:)=My_mfcc('dr1/felc0/sx36.wav',Point_N);
all_mfcc_felc0(7,:)=My_mfcc('dr1/felc0/sx126.wav',Point_N);
all_mfcc_felc0(8,:)=My_mfcc('dr1/felc0/sx216.wav',Point_N);
all_mfcc_felc0(9,:)=My_mfcc('dr1/felc0/sx306.wav',Point_N);
all_mfcc_felc0(10,:)=My_mfcc('dr1/felc0/sx396.wav',Point_N);
subplot(3,1,3);
plot(1:Point_N,all_mfcc_felc0);title('dr1_felc0');ylabel('MFCC参数值');

% all_mfcc_sa1(1,:)=My_mfcc('dr1/faks0/sa1',Point_N);
% all_mfcc_sa1(2,:)=My_mfcc('dr1/fdac1/sa1',Point_N);
% all_mfcc_sa1(3,:)=My_mfcc('dr1/felc0/sa1',Point_N);
% all_mfcc_sa1(4,:)=My_mfcc('dr1/fjem0/sa1',Point_N);
% all_mfcc_sa1(5,:)=My_mfcc('dr1/mdab0/sa1',Point_N);
% all_mfcc_sa1(6,:)=My_mfcc('dr1/mjsw0/sa1',Point_N);
% all_mfcc_sa1(7,:)=My_mfcc('dr1/mreb0/sa1',Point_N);
% all_mfcc_sa1(8,:)=My_mfcc('dr1/mrjo0/sa1',Point_N);
% all_mfcc_sa1(9,:)=My_mfcc('dr1/msjs1/sa1',Point_N);
% all_mfcc_sa1(10,:)=My_mfcc('dr1/mstk0/sa1',Point_N);
% all_mfcc_sa1(11,:)=My_mfcc('dr1/mwbt0/sa1',Point_N);
% subplot(2,1,1);
% plot(1:24,all_mfcc_sa1);title('sa1');ylabel('MFCC参数值');
% 
% all_mfcc_sa1(1,:)=My_mfcc('dr1/faks0/sa2',Point_N);
% all_mfcc_sa1(2,:)=My_mfcc('dr1/fdac1/sa2',Point_N);
% all_mfcc_sa1(3,:)=My_mfcc('dr1/felc0/sa2',Point_N);
% all_mfcc_sa1(4,:)=My_mfcc('dr1/fjem0/sa2',Point_N);
% all_mfcc_sa1(5,:)=My_mfcc('dr1/mdab0/sa2',Point_N);
% all_mfcc_sa1(6,:)=My_mfcc('dr1/mjsw0/sa2',Point_N);
% all_mfcc_sa1(7,:)=My_mfcc('dr1/mreb0/sa2',Point_N);
% all_mfcc_sa1(8,:)=My_mfcc('dr1/mrjo0/sa2',Point_N);
% all_mfcc_sa1(9,:)=My_mfcc('dr1/msjs1/sa2',Point_N);
% all_mfcc_sa1(10,:)=My_mfcc('dr1/mstk0/sa2',Point_N);
% all_mfcc_sa1(11,:)=My_mfcc('dr1/mwbt0/sa2',Point_N);
% subplot(2,1,2);
% plot(1:24,all_mfcc_sa1);title('sa1');ylabel('MFCC参数值');



















