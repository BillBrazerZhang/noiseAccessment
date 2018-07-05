% Speech Noise Assessment

% Step I. Read Audio File
fileName = 'sample.wav';
Fs = 1000;
[y,Fs] = audioread(fileName);

% A. Conventional Spectral Analysis
I = xlsread('phonemes.xlsx','A1025:A1280');
U = xlsread('phonemes.xlsx','B1025:B1280');
NG = xlsread('phonemes.xlsx','C1025:C1280');
n = 1024:1279;
figure(1);
subplot(3,1,1);
plot(n,I);
xlabel('time sequence n=1024:1279');
ylabel('impulse response');
title('impulse response of time series of phoneme /i/');
subplot(3,1,2);
plot(n,U);
xlabel('time sequence n=1024:1279');
ylabel('impulse response');
title('impulse response of time series of phoneme /u/');
subplot(3,1,3);
plot(n,NG);
xlabel('time sequence n=1024:1279');
ylabel('impulse response');
title('impulse response of time series of phoneme /\eta/');

H_I = fft(I,256);
H_U = fft(U,256);
H_NG = fft(NG,256);
L_I = zeros(1,128);
L_U = zeros(1,128);
L_NG = zeros(1,128);
for i = 1:128
    L_I(i) = mag2db(abs(H_I(i)));
    L_U(i) = mag2db(abs(H_U(i)));
    L_NG(i) = mag2db(abs(H_NG(i)));
end
N = 0:127;
Nf = N*10000/256; 
figure(2)
subplot(1,3,1);
plot(Nf,L_I,[270,270],[0,100],[2290,2290],[0,100],[3010,3010],[0,100]);
xlabel('frequency(Hz)');
ylabel('magnitude(dB)');
text(280,90,'F1:270Hz');
text(1000,80,'F2:2290Hz');
text(3100,80,'F3:3010Hz');
title('spectral magnitude of phoneme /i/, n=1024:1279');
subplot(1,3,2);
plot(Nf,L_U,[300,300],[0,100],[870,870],[0,100],[2240,2240],[0,100]);
xlabel('frequency(Hz)');
ylabel('magnitude(dB)');
text(310,90,'F1:300Hz');
text(900,80,'F2:870Hz');
text(2250,80,'F3:2240Hz');
title('spectral magnitude of phoneme /u/, n=1024:1279');
subplot(1,3,3);
plot(Nf,L_NG,[200,200],[0,100],[2460,2460],[0,100],[3680,3680],[0,100]);
xlabel('frequency(Hz)');
ylabel('magnitude(dB)');
text(210,90,'F1:200Hz');
text(1200,80,'F3:2460Hz');
text(3690,80,'F4:3680Hz');
title('spectral magnitude of phoneme /\eta/, n=1024:1279');

I(65:256) = zeros(192,1);
U(65:256) = zeros(192,1);
NG(65:256) = zeros(192,1);
H_I = fft(I,256);
H_U = fft(U,256);
H_NG = fft(NG,256);
L_I = zeros(1,128);
L_U = zeros(1,128);
L_NG = zeros(1,128);
for i = 1:128
    L_I(i) = mag2db(abs(H_I(i)));
    L_U(i) = mag2db(abs(H_U(i)));
    L_NG(i) = mag2db(abs(H_NG(i)));
end
N = 0:127;
Nf = N*10000/256; 
figure(3)
subplot(1,3,1);
plot(Nf,L_I,[270,270],[0,100],[2290,2290],[0,100],[3010,3010],[0,100]);
xlabel('frequency(Hz)');
ylabel('magnitude(dB)');
text(280,90,'F1:270Hz');
text(1000,80,'F2:2290Hz');
text(3100,80,'F3:3010Hz');
title('spectral magnitude of phoneme /i/, n=1024:1087');
subplot(1,3,2);
plot(Nf,L_U,[300,300],[0,100],[870,870],[0,100],[2240,2240],[0,100]);
xlabel('frequency(Hz)');
ylabel('magnitude(dB)');
text(310,90,'F1:300Hz');
text(900,80,'F2:870Hz');
text(2250,80,'F3:2240Hz');
title('spectral magnitude of phoneme /u/, n=1024:1087');
subplot(1,3,3);
plot(Nf,L_NG,[200,200],[0,100],[2460,2460],[0,100],[3680,3680],[0,100]);
xlabel('frequency(Hz)');
ylabel('magnitude(dB)');
text(210,90,'F1:200Hz');
text(1200,80,'F3:2460Hz');
text(3690,80,'F4:3680Hz');
title('spectral magnitude of phoneme /\eta/, n=1024:1087');

%B. Autocorrelation Method of Linear Prediction
I = xlsread('phonemes.xlsx','A1025:A1280');
U = xlsread('phonemes.xlsx','B1025:B1280');
NG = xlsread('phonemes.xlsx','C1025:C1280');
I = I.*kaiser(256,1.5);
U = U.*kaiser(256,1.5);
NG = NG.*kaiser(256,1.5);

[~,g2] = lpc(I,2);
[~,g4] = lpc(I,4);
[~,g6] = lpc(I,6);
[~,g8] = lpc(I,8);
[~,g10] = lpc(I,10);
[~,g12] = lpc(I,12);
[~,g14] = lpc(I,14);
p = [2,4,6,8,10,12,14];
figure(4)
subplot(1,3,1);
plot(p,[g2,g4,g6,g8,g10,g12,g14]);
xlabel('order of inverse filter (p)');
ylabel('$E_p$','Interpreter','latex','FontSize',11);
title('$E_p$ v.s. inverse filter order p of /i/, n=1024:1279','Interpreter','latex');

[~,g2] = lpc(U,2);
[~,g4] = lpc(U,4);
[~,g6] = lpc(U,6);
[~,g8] = lpc(U,8);
[~,g10] = lpc(U,10);
[~,g12] = lpc(U,12);
[~,g14] = lpc(U,14);
p = [2,4,6,8,10,12,14];
subplot(1,3,2);
plot(p,[g2,g4,g6,g8,g10,g12,g14]);
xlabel('order of inverse filter (p)');
ylabel('$E_p$','Interpreter','latex','FontSize',11);
title('$E_p$ v.s. inverse filter order p of /u/, n=1024:1279','Interpreter','latex');

[~,g2] = lpc(NG,2);
[~,g4] = lpc(NG,4);
[~,g6] = lpc(NG,6);
[~,g8] = lpc(NG,8);
[~,g10] = lpc(NG,10);
[~,g12] = lpc(NG,12);
[~,g14] = lpc(NG,14);
p = [2,4,6,8,10,12,14];
subplot(1,3,3);
plot(p,[g2,g4,g6,g8,g10,g12,g14]);
xlabel('order of inverse filter (p)');
ylabel('$E_p$','Interpreter','latex','FontSize',11);
title('$E_p$ v.s. inverse filter order p of /$\eta$/, n=1024:1279','Interpreter','latex');

I14 = zeros(1,256);
[I14(1:15),~] = lpc(I,14);
N = 0:127;
Nf = N*10000/256;
A14 = fft(I14,256);
L = zeros(1,128);
for i = 1:128
    L(i) = 0.5*mag2db(1/((abs(A14(i)))^2));
end
figure(5)
subplot(1,3,1)
plot(Nf,L,[270,270],[-20,100],[2290,2290],[-20,100],[3010,3010],[-20,100]);
xlabel('frequency(Hz)');
ylabel('10log($\frac{1}{|\hat{A}(k)|^2}$)','Interpreter','latex','FontSize',11);
text(280,90,'F1:270Hz');
text(1000,80,'F2:2290Hz');
text(3100,80,'F3:3010Hz');
title('10log($\frac{1}{|\hat{A}(k)|^2}$) of /i/, n=1024:1279, p=14','Interpreter','latex');

U14 = zeros(1,256);
[U14(1:15),~] = lpc(U,14);
N = 0:127;
Nf = N*10000/256;
A14 = fft(U14,256);
L = zeros(1,128);
for i = 1:128
    L(i) = 0.5*mag2db(1/((abs(A14(i)))^2));
end
figure(5)
subplot(1,3,2)
plot(Nf,L,[300,300],[-20,100],[870,870],[-20,100],[2240,2240],[-20,100]);
xlabel('frequency(Hz)');
ylabel('10log($\frac{1}{|\hat{A}(k)|^2}$)','Interpreter','latex','FontSize',11);
text(310,90,'F1:300Hz');
text(900,80,'F2:870Hz');
text(2250,80,'F3:2240Hz');
title('10log($\frac{1}{|\hat{A}(k)|^2}$) of /u/, n=1024:1279, p=14','Interpreter','latex');

NG14 = zeros(1,256);
[NG14(1:15),~] = lpc(NG,14);
N = 0:127;
Nf = N*10000/256;
A14 = fft(NG14,256);
L = zeros(1,128);
for i = 1:128
    L(i) = 0.5*mag2db(1/((abs(A14(i)))^2));
end
figure(5)
subplot(1,3,3)
plot(Nf,L,[200,200],[-20,100],[2460,2460],[-20,100],[3680,3680],[-20,100]);
xlabel('frequency(Hz)');
ylabel('10log($\frac{1}{|\hat{A}(k)|^2}$)','Interpreter','latex','FontSize',11);
text(210,90,'F1:200Hz');
text(1200,80,'F3:2460Hz');
text(3690,80,'F4:3680Hz');
title('10log($\frac{1}{|\hat{A}(k)|^2}$) of /$\eta$/, n=1024:1279, p=14','Interpreter','latex');

I = xlsread('phonemes.xlsx','A1025:A1088');
U = xlsread('phonemes.xlsx','B1025:B1088');
NG = xlsread('phonemes.xlsx','C1025:C1088');
I = I.*kaiser(64,1.5);
U = U.*kaiser(64,1.5);
NG = NG.*kaiser(64,1.5);

[~,g2] = lpc(I,2);
[~,g4] = lpc(I,4);
[~,g6] = lpc(I,6);
[~,g8] = lpc(I,8);
[~,g10] = lpc(I,10);
[~,g12] = lpc(I,12);
[~,g14] = lpc(I,14);
p = [2,4,6,8,10,12,14];
figure(6)
subplot(1,3,1);
plot(p,[g2,g4,g6,g8,g10,g12,g14]);
xlabel('order of inverse filter (p)');
ylabel('$E_p$','Interpreter','latex','FontSize',11);
title('$E_p$ v.s. inverse filter order p of /i/, n=1024:1087','Interpreter','latex');

[~,g2] = lpc(U,2);
[~,g4] = lpc(U,4);
[~,g6] = lpc(U,6);
[~,g8] = lpc(U,8);
[~,g10] = lpc(U,10);
[~,g12] = lpc(U,12);
[~,g14] = lpc(U,14);
p = [2,4,6,8,10,12,14];
subplot(1,3,2);
plot(p,[g2,g4,g6,g8,g10,g12,g14]);
xlabel('order of inverse filter (p)');
ylabel('$E_p$','Interpreter','latex','FontSize',11);
title('$E_p$ v.s. inverse filter order p of /u/, n=1024:1087','Interpreter','latex');

[~,g2] = lpc(NG,2);
[~,g4] = lpc(NG,4);
[~,g6] = lpc(NG,6);
[~,g8] = lpc(NG,8);
[~,g10] = lpc(NG,10);
[~,g12] = lpc(NG,12);
[~,g14] = lpc(NG,14);
p = [2,4,6,8,10,12,14];
subplot(1,3,3);
plot(p,[g2,g4,g6,g8,g10,g12,g14]);
xlabel('order of inverse filter (p)');
ylabel('$E_p$','Interpreter','latex','FontSize',11);
title('$E_p$ v.s. inverse filter order p of /$\eta$/, n=1024:1087','Interpreter','latex');

I14 = zeros(1,256);
[I14(1:15),~] = lpc(I,14);
N = 0:127;
Nf = N*10000/256;
A14 = fft(I14,256);
L = zeros(1,128);
for i = 1:128
    L(i) = 0.5*mag2db(1/((abs(A14(i)))^2));
end
figure(7)
subplot(1,3,1)
plot(Nf,L,[270,270],[-20,100],[2290,2290],[-20,100],[3010,3010],[-20,100]);
xlabel('frequency(Hz)');
ylabel('10log($\frac{1}{|\hat{A}(k)|^2}$)','Interpreter','latex','FontSize',11);
text(280,90,'F1:270Hz');
text(1000,80,'F2:2290Hz');
text(3100,80,'F3:3010Hz');
title('10log($\frac{1}{|\hat{A}(k)|^2}$)) of /i/, n=1024:1087, p=14','Interpreter','latex');

U14 = zeros(1,256);
[U14(1:15),~] = lpc(U,14);
N = 0:127;
Nf = N*10000/256;
A14 = fft(U14,256);
L = zeros(1,128);
for i = 1:128
    L(i) = 0.5*mag2db(1/((abs(A14(i)))^2));
end
figure(7)
subplot(1,3,2)
plot(Nf,L,[300,300],[-20,100],[870,870],[-20,100],[2240,2240],[-20,100]);
xlabel('frequency(Hz)');
ylabel('10log($\frac{1}{|\hat{A}(k)|^2}$)','Interpreter','latex','FontSize',11);
text(310,90,'F1:300Hz');
text(900,80,'F2:870Hz');
text(2250,80,'F3:2240Hz');
title('10log($\frac{1}{|\hat{A}(k)|^2}$) of /u/, n=1024:1087, p=14','Interpreter','latex');

NG14 = zeros(1,256);
[NG14(1:15),~] = lpc(NG,14);
N = 0:127;
Nf = N*10000/256;
A14 = fft(NG14,256);
L = zeros(1,128);
for i = 1:128
    L(i) = 0.5*mag2db(1/((abs(A14(i)))^2));
end
figure(7)
subplot(1,3,3)
plot(Nf,L,[200,200],[-20,100],[2460,2460],[-20,100],[3680,3680],[-20,100]);
xlabel('frequency(Hz)');
ylabel('10log($\frac{1}{|\hat{A}(k)|^2}$)','Interpreter','latex','FontSize',11);
text(210,90,'F1:200Hz');
text(1200,80,'F3:2460Hz');
text(3690,80,'F4:3680Hz');
title('10log($\frac{1}{|\hat{A}(k)|^2}$) of /$\eta$/, n=1024:1087, p=14','Interpreter','latex');
