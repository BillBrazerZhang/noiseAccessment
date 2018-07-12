% End-Term Project: Excitation Signal Characterization

% Excitation Signal Generation
I1 = xlsread('phonemes.xlsx','A6001:A6256');
U1 = xlsread('phonemes.xlsx','B6001:B6256');
I2 = xlsread('phonemes.xlsx','A257:A512');
U2 = xlsread('phonemes.xlsx','B257:B512');
% plot(a)
% Time Series
n1 = 6000:6255;
n2 = 256:511;
figure(1);
subplot(2,2,1);
plot(n1,I1);
xlabel('time sequence n');
ylabel('impulse response');
title('Impulse Response of Time Series of Vowel /i/, n=6000:6255');
subplot(2,2,2);
plot(n1,U1);
xlabel('time sequence n');
ylabel('impulse response');
title('Impulse Response of Time Series of Vowel /u/, n=6000:6255');
subplot(2,2,3);
plot(n2,I2);
xlabel('time sequence n');
ylabel('impulse response');
title('Impulse Response of Time Series of Vowel /i/, n=256:511');
subplot(2,2,4);
plot(n2,U2);
xlabel('time sequence n');
ylabel('impulse response');
title('Impulse Response of Time Series of Vowel /u/, n=256:511');
% Conventional Power Spectrum
nfft = 256;
N = 0:127;
Nf = N*10/256;
p_i1 = 0.5*mag2db(pwelch(I1,nfft,0,nfft,1,'centered'));
p_u1 = 0.5*mag2db(pwelch(U1,nfft,0,nfft,1,'centered'));
p_i2 = 0.5*mag2db(pwelch(I2,nfft,0,nfft,1,'centered'));
p_u2 = 0.5*mag2db(pwelch(U2,nfft,0,nfft,1,'centered'));
figure(2)
subplot(2,2,1);
plot(Nf,p_i1(129:256),[0.27,0.27],[-20,100],[2.29,2.29],[-20,100],[3.01,3.01],[-20,100]);
text(0.28,90,'F1:270Hz');
text(1.4,80,'F2:2290Hz');
text(3.1,80,'F3:3010Hz');
xlabel('Frequency(kHz)');
ylabel('10log($|FFT|^2$)(dB)','Interpreter','latex','FontSize',11);
title('Conventional Power Spectrum Estimate(dB) of vowel /i/, n=6000:6255, nfft=256');
subplot(2,2,2);
plot(Nf,p_u1(129:256),[0.3,0.3],[-20,100],[0.87,0.87],[-20,100],[2.24,2.24],[-20,100]);
text(0.31,90,'F1:300Hz');
text(0.9,80,'F2:870Hz');
text(2.25,80,'F3:2240Hz');
xlabel('Frequency(kHz)');
ylabel('10log($|FFT|^2$)(dB)','Interpreter','latex','FontSize',11);
title('Conventional Power Spectrum Estimate(dB) of vowel /u/, n=6000:6255, nfft=256');
subplot(2,2,3);
plot(Nf,p_i2(129:256),[0.27,0.27],[-20,100],[2.29,2.29],[-20,100],[3.01,3.01],[-20,100]);
text(0.28,90,'F1:270Hz');
text(1.4,80,'F2:2290Hz');
text(3.1,80,'F3:3010Hz');
xlabel('Frequency(kHz)');
ylabel('10log($|FFT|^2$)(dB)','Interpreter','latex','FontSize',11);
title('Conventional Power Spectrum Estimate(dB) of vowel /i/, n=256:511, nfft=256');
subplot(2,2,4);
plot(Nf,p_u2(129:256),[0.3,0.3],[-20,100],[0.87,0.87],[-20,100],[2.24,2.24],[-20,100]);
text(0.31,90,'F1:300Hz');
text(0.9,80,'F2:870Hz');
text(2.25,80,'F3:2240Hz');
xlabel('Frequency(kHz)');
ylabel('10log($|FFT|^2$)(dB)','Interpreter','latex','FontSize',11);
title('Conventional Power Spectrum Estimate(dB) of vowel /u/, n=256:511, nfft=256');
% LPC Estimate of Power Spectrum
% p=14
I1_win = I1.*kaiser(256,1.5);
U1_win = U1.*kaiser(256,1.5);
I2_win = I2.*kaiser(256,1.5);
U2_win = U2.*kaiser(256,1.5);
a_i1 = zeros(1,256);
[a_i1(1:15),~] = lpc(I1_win,14);
N = 0:127;
Nf = N*10/256;
A_i1 = fft(a_i1,256);
L_i1 = zeros(1,128);
for i = 1:128
    L_i1(i) = 0.5*mag2db(1/((abs(A_i1(i)))^2));
end
a_u1 = zeros(1,256);
[a_u1(1:15),~] = lpc(U1_win,14);
N = 0:127;
Nf = N*10/256;
A_u1 = fft(a_u1,256);
L_u1 = zeros(1,128);
for i = 1:128
    L_u1(i) = 0.5*mag2db(1/((abs(A_u1(i)))^2));
end
a_i2 = zeros(1,256);
[a_i2(1:15),~] = lpc(I2_win,14);
N = 0:127;
Nf = N*10/256;
A_i2 = fft(a_i2,256);
L_i2 = zeros(1,128);
for i = 1:128
    L_i2(i) = 0.5*mag2db(1/((abs(A_i2(i)))^2));
end
a_u2 = zeros(1,256);
[a_u2(1:15),~] = lpc(U2_win,14);
N = 0:127;
Nf = N*10/256;
A_u2 = fft(a_u2,256);
L_u2 = zeros(1,128);
for i = 1:128
    L_u2(i) = 0.5*mag2db(1/((abs(A_u2(i)))^2));
end
figure(3)
subplot(2,2,1)
plot(Nf,L_i1,[0.27,0.27],[-20,100],[2.29,2.29],[-20,100],[3.01,3.01],[-20,100]);
text(0.28,90,'F1:270Hz');
text(1.4,80,'F2:2290Hz');
text(3.1,80,'F3:3010Hz');
xlabel('frequency(kHz)');
ylabel('10log($\frac{1}{|\hat{A}(k)|^2}$)(dB)','Interpreter','latex','FontSize',11);
title('LPC Power Spectrum Estimate of /i/, n=6000:6255, p=14','Interpreter','latex');
subplot(2,2,2)
plot(Nf,L_u1,[0.3,0.3],[-20,100],[0.87,0.87],[-20,100],[2.24,2.24],[-20,100]);
text(0.31,90,'F1:300Hz');
text(0.9,80,'F2:870Hz');
text(2.25,80,'F3:2240Hz');
xlabel('frequency(kHz)');
ylabel('10log($\frac{1}{|\hat{A}(k)|^2}$)(dB)','Interpreter','latex','FontSize',11);
title('LPC Power Spectrum Estimate of /u/, n=6000:6255, p=14','Interpreter','latex');
subplot(2,2,3)
plot(Nf,L_i2,[0.27,0.27],[-20,100],[2.29,2.29],[-20,100],[3.01,3.01],[-20,100]);
text(0.28,90,'F1:270Hz');
text(1.4,80,'F2:2290Hz');
text(3.1,80,'F3:3010Hz');
xlabel('frequency(kHz)');
ylabel('10log($\frac{1}{|\hat{A}(k)|^2}$)(dB)','Interpreter','latex','FontSize',11);
title('LPC Power Spectrum Estimate of /i/, n=256:511, p=14','Interpreter','latex');
subplot(2,2,4)
plot(Nf,L_u2,[0.3,0.3],[-20,100],[0.87,0.87],[-20,100],[2.24,2.24],[-20,100]);
text(0.31,90,'F1:300Hz');
text(0.9,80,'F2:870Hz');
text(2.25,80,'F3:2240Hz');
xlabel('frequency(kHz)');
ylabel('10log($\frac{1}{|\hat{A}(k)|^2}$)(dB)','Interpreter','latex','FontSize',11);
title('LPC Power Spectrum Estimate of /u/, n=256:511, p=14','Interpreter','latex');

% plot(b)
% Excitation Signal
I1_F = filter(a_i1(1:15),1,I1);
U1_F = filter(a_u1(1:15),1,U1);
I2_F = filter(a_i2(1:15),1,I2);
U2_F = filter(a_u2(1:15),1,U2);
figure(4);
subplot(2,2,1);
plot(n1,I1_F);
xlabel('time sequence n');
ylabel('impulse response');
title('Estimation of Excitation Signal of vowel /i/, n=6000:6255');
subplot(2,2,2);
plot(n1,U1_F);
xlabel('time sequence n');
ylabel('impulse response');
title('Estimation of Excitation Signal of vowel /u/, n=6000:6255');
subplot(2,2,3);
plot(n2,I2_F);
xlabel('time sequence n');
ylabel('impulse response');
title('Estimation of Excitation Signal of vowel /i/, n=256:511');
subplot(2,2,4);
plot(n2,U2_F);
xlabel('time sequence n');
ylabel('impulse response');
title('Estimation of Excitation Signal of vowel /u/, n=256:511');
% Conventional Power Spectrum
nfft = 256;
N = 0:127;
Nf = N*10/256;
p_i1_F = 0.5*mag2db(pwelch(I1_F,nfft,0,nfft,1,'centered'));
p_u1_F = 0.5*mag2db(pwelch(U1_F,nfft,0,nfft,1,'centered'));
p_i2_F = 0.5*mag2db(pwelch(I2_F,nfft,0,nfft,1,'centered'));
p_u2_F = 0.5*mag2db(pwelch(U2_F,nfft,0,nfft,1,'centered'));
figure(5)
subplot(2,2,1);
plot(Nf,p_i1_F(129:256),[0.27,0.27],[-20,100],[2.29,2.29],[-20,100],[3.01,3.01],[-20,100]);
text(0.28,90,'F1:270Hz');
text(1.4,80,'F2:2290Hz');
text(3.1,80,'F3:3010Hz');
xlabel('Frequency(kHz)');
ylabel('10log($|FFT|^2$)(dB)','Interpreter','latex','FontSize',11);
title('Conventional Power Spectrum(dB) of Excitation /i/, n=6000:6255, nfft=256');
subplot(2,2,2);
plot(Nf,p_u1_F(129:256),[0.3,0.3],[-20,100],[0.87,0.87],[-20,100],[2.24,2.24],[-20,100]);
text(0.31,90,'F1:300Hz');
text(0.9,80,'F2:870Hz');
text(2.25,80,'F3:2240Hz');
xlabel('Frequency(kHz)');
ylabel('10log($|FFT|^2$)(dB)','Interpreter','latex','FontSize',11);
title('Conventional Power Spectrum(dB) of Excitation /u/, n=6000:6255, nfft=256');
subplot(2,2,3);
plot(Nf,p_i2_F(129:256),[0.27,0.27],[-20,100],[2.29,2.29],[-20,100],[3.01,3.01],[-20,100]);
text(0.28,90,'F1:270Hz');
text(1.4,80,'F2:2290Hz');
text(3.1,80,'F3:3010Hz');
xlabel('Frequency(kHz)');
ylabel('10log($|FFT|^2$)(dB)','Interpreter','latex','FontSize',11);
title('Conventional Power Spectrum(dB) of Excitation /i/, n=256:511, nfft=256');
subplot(2,2,4);
plot(Nf,p_u2_F(129:256),[0.3,0.3],[-20,100],[0.87,0.87],[-20,100],[2.24,2.24],[-20,100]);
text(0.31,90,'F1:300Hz');
text(0.9,80,'F2:870Hz');
text(2.25,80,'F3:2240Hz');
xlabel('Frequency(kHz)');
ylabel('10log($|FFT|^2$)(dB)','Interpreter','latex','FontSize',11);
title('Conventional Power Spectrum(dB) of Excitation /u/, n=256:511, nfft=256');
% Autocorrelation Function
C_I1 = xcorr(I1_F);
C_U1 = xcorr(U1_F);
C_I2 = xcorr(I2_F);
C_U2 = xcorr(U2_F);
nc = 0:255;
figure(6)
subplot(2,2,1);
plot(nc,C_I1(256:511));
xlabel('Lags(m)');
ylabel('magnitude of autocorrelation function');
title('Autocorrelation of Excitation Signal of /i/, n=6000:6255');
subplot(2,2,2);
plot(nc,C_U1(256:511));
xlabel('Lags(m)');
ylabel('magnitude of autocorrelation function');
title('Autocorrelation of Excitation Signal of /u/, n=6000:6255');
subplot(2,2,3);
plot(nc,C_I2(256:511));
xlabel('Lags(m)');
ylabel('magnitude of autocorrelation function');
title('Autocorrelation of Excitation Signal of /i/, n=256:511');
subplot(2,2,4);
plot(nc,C_U2(256:511));
xlabel('Lags(m)');
ylabel('magnitude of autocorrelation function');
title('Autocorrelation of Excitation Signal of /u/, n=256:511');
% Pitch Period of Excitation Signal
figure(7)
subplot(2,2,1);
[psor_I1,lsor_I1] = findpeaks(C_I1(306:406),50:150,'MinPeakHeight',2e5,'SortStr','descend');
findpeaks(C_I1(306:406),50:150,'MinPeakHeight',2e5,'SortStr','descend');
hold on;
plot([lsor_I1(1),lsor_I1(1)],[-500000,psor_I1(1)]);
text(lsor_I1+.02,psor_I1(1),num2str(1));
text(lsor_I1+.02,[-100000],num2str(lsor_I1(1)'));
hold off;
xlabel('Lags(m)');
ylabel('magnitude of autocorrelation function');
title('Peak Finding of /i/, n=6000:6255');
subplot(2,2,2);
[psor_U1,lsor_U1] = findpeaks(C_U1(306:406),50:150,'MinPeakHeight',1e5,'SortStr','descend');
findpeaks(C_U1(306:406),50:150,'MinPeakHeight',1e5,'SortStr','descend');
hold on;
plot([lsor_U1(1),lsor_U1(1)],[-500000,psor_U1(1)]);
text(lsor_U1+.02,psor_U1(1),num2str(1));
text(lsor_U1+.02,[-100000],num2str(lsor_U1(1)'));
hold off;
xlabel('Lags(m)');
ylabel('magnitude of autocorrelation function');
title('Peak Finding of /u/, n=6000:6255');
subplot(2,2,3);
[psor_I2,lsor_I2] = findpeaks(C_I2(306:406),50:150,'MinPeakHeight',2e5,'SortStr','descend');
findpeaks(C_I2(306:406),50:150,'MinPeakHeight',2e5,'SortStr','descend');
hold on;
plot([lsor_I2(1),lsor_I2(1)],[-500000,psor_I2(1)]);
text(lsor_I2+.02,psor_I2(1),num2str(1));
text(lsor_I2+.02,[-100000],num2str(lsor_I2(1)'));
hold off;
xlabel('Lags(m)');
ylabel('magnitude of autocorrelation function');
title('Peak Finding of /i/, n=256:511');
subplot(2,2,4);
[psor_U2,lsor_U2] = findpeaks(C_U2(306:406),50:150,'MinPeakHeight',1e5,'SortStr','descend');
findpeaks(C_U2(306:406),50:150,'MinPeakHeight',1e5,'SortStr','descend');
hold on;
plot([lsor_U2(1),lsor_U2(1)],[-500000,psor_U2(1)]);
text(lsor_U2+.02,psor_U2(1),num2str(1));
text(lsor_U2+.02,[-100000],num2str(lsor_U2(1)'));
hold off;
xlabel('Lags(m)');
ylabel('magnitude of autocorrelation function');
title('Peak Finding of /u/, n=256:511');

% plot(c)
% Voiced Extraction
load -ascii jcnwwa_single_col.txt
phrase = jcnwwa_single_col;
n_p = 0:(length(phrase)-1);
figure(8)
plot(n_p,phrase);
xlabel('sampling time series');
ylabel('impulse response');
title('Time Series of Phrase "we were away", Length=15360');
figure(9)
spectrogram(phrase,256,128,256,1e4);
title('Spectrogram of Phrase "we were away", Length=15360, Fs=10kHz');
% LPC Analysis
% Voiced Phrase: 4201-14440(10240-point, 0.42s-1.4439s)
phrase_v = phrase(4201:14440);
frame_num = 79;
A_P = zeros(79,256);
L_P = zeros(79,128);
for i = 1:79
	a_P = zeros(1,256);
    [a_P(1:15),~] = lpc(phrase_v(128*(i-1)+1:128*(i+1)).*kaiser(256,1.5),14);
	A_P(i,1:256) = fft(a_P,256);
    for j = 1:128
    	L_P(i,j) = 0.5*mag2db(1/((abs(A_P(i,j)))^2));
    end
end  
N = 0:127;
Nf = N*10/256;
C = L_P';
y = Nf;
x = zeros(1,79);
for i = 1:79
	x(i) = i*0.0128+0.42;
end
figure (10)
imagesc(x,y,C), axis xy
colorbar
xlabel('time(s)');
ylabel('frequency(kHz)');
title('LPC Analysis of Phrase "we were away", 0.42s-1.4439s, 10240-point, 79-segment');
% Pitch Period v.s. Time

% Excitation Signal Power(dB) v.s. Time
Period_Phrase = zeros(1,79);
Power_Phrase = zeros(1,79)
C_Phrase = zeros(79,511);
for i = 1:79
	a_P = zeros(1,256);
    [a_P(1:15),~] = lpc(phrase_v(128*(i-1)+1:128*(i+1)).*kaiser(256,1.5),14);
    Phrase_F = filter(a_P(1:15),1,phrase_v(128*(i-1)+1:128*(i+1)));
    C_Phrase(i,1:511) = xcorr(Phrase_F);
end
for i =1:79
	% [psor,lsor] = findpeaks(C_Phrase(i,306:406),50:150,'MinPeakHeight',1e5,'SortStr','descend');
	% Period_Phrase(i) = lsor;
	Power_Phrase(i) = 0.5*mag2db(C_Phrase(i,256));

    [maxi_P,lsor] = findpeaks(C_Phrase(i,306:376),50:120,'SortStr','descend','NPeaks',1);
    [maxi_PP,lsor] = findpeaks(C_Phrase(i,306:376),50:120,'MinPeakHeight',0.5*maxi_P,'SortStr','descend');
    % figure(10+i)
    % findpeaks(C_Phrase(i,306:406),50:150,'MinPeakHeight',0.5*maxi_P,'SortStr','descend');
    if length(maxi_PP) > 2
    	Period_Phrase(i) = 0;
    else
    	Period_Phrase(i) = lsor(1);
    end
    % plot([lsor,lsor],[-500000,psor]);
    % text(lsor+.02,psor,num2str((1:numel(psor))'));
    % text(lsor+.02,-100000,num2str(lsor));
    % hold off;
    % xlabel('Lags(m)');
    % ylabel('magnitude of autocorrelation function');
    % title(['Pitch Period of Segment',num2str(i),'is',num2str(lsor)]);
end
figure(11)
subplot(1,2,1);
scatter(x,Period_Phrase/10);
xlabel('evolving time(s)');
ylabel('Pitch Period(ms)');
title('Pitch Period vs. Time of Phrase, Scatter Graph');
figure(12)
plot(x,Power_Phrase);
xlabel('evolving time(s)');
ylabel('Average Power(dB)');
title('Excitation Signal Power vs. Time of Phrase "we were away", 0.42s-1.4439s, 10240-point, 79-segment');
for i = 27:28
	[maxi_P,Period_Phrase(i)] = findpeaks(C_Phrase(i,306:376),50:120,'SortStr','descend','NPeaks',1);
	figure(i)
	findpeaks(C_Phrase(i,306:376),50:120,'SortStr','descend','NPeaks',1)
end
figure(11)
subplot(1,2,2);
plot(x,Period_Phrase/10);
xlabel('evolving time(s)');
ylabel('Pitch Period(ms)');
title('Pitch Period vs. Time of Phrase, Plot Graph');