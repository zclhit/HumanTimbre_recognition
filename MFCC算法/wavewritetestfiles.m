[a,fs,bit]=wavread('sa1.wav');
plot(a);
b=a(13000:48000);
figure
plot(b)
wavwrite(b,10000,'sa1_segmentation.wav')