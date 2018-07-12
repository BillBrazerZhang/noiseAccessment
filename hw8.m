% Speech Noise Assessment

% Step I. Read Audio File
% Sample: car noised speech, Fs=8KHz, mpb=128000
fileName = 'car.wav';
Fs = 8000;
[y,Fs] = audioread(fileName);
y = y/max(abs(y));
y = y/1.1;
p = audioplayer(y, Fs);
play(p);
n = length(y);
figure(1);
plot(0:n-1,y);
xlabel('time sequence');
ylabel('impulse response');
title('impulse response of car.wav');

% Step II. Spectrom Analysis
figure(2)
spectrogram(y,256,128,256,8000);
title('Spectrogram of Phrase "we were away", Length=128000, Fs=8kHz');

frame_num = n/128 - 1;
A_P = zeros(frame_num,256);
L_P = zeros(frame_num,128);
for i = 1:frame_num
	a_P = zeros(1,256);
    [a_P(1:15),~] = lpc(y(128*(i-1)+1:128*(i+1)).*kaiser(256,1.5),14);
	A_P(i,1:256) = fft(a_P,256);
    for j = 1:128
    	L_P(i,j) = 0.5*mag2db(1/((abs(A_P(i,j)))^2));
    end
end  
N = 0:127;
Nf = N*10/256;
C = L_P';
yy = Nf;
x = zeros(1,frame_num);
for i = 1:frame_num
	x(i) = i*128/8000;
end
figure (3)
imagesc(x,yy,C), axis xy
colorbar
xlabel('time(s)');
ylabel('frequency(kHz)');
title('LPC Analysis of car.wav, 128000-point');

% Step III. Pitch Period vs Time
% Excitation Signal Power(dB) v.s. Time
Period_Phrase = zeros(1,frame_num);
Power_Phrase = zeros(1,frame_num)
C_Phrase = zeros(frame_num,511);
for i = 1:frame_num
	a_P = zeros(1,256);
    [a_P(1:15),~] = lpc(y(128*(i-1)+1:128*(i+1)).*kaiser(256,1.5),14);
    Phrase_F = filter(a_P(1:15),1,y(128*(i-1)+1:128*(i+1)));
    C_Phrase(i,1:511) = xcorr(Phrase_F);
end
for i = 1:frame_num
	Power_Phrase(i) = 0.5*mag2db(C_Phrase(i,256));

    [maxi_P,lsorMax] = findpeaks(C_Phrase(i,266:501),10:245,'SortStr','descend','NPeaks',1);
    [maxi_PP,lsor] = findpeaks(C_Phrase(i,lsorMax+256-9:lsorMax+256+9),lsorMax-9:lsorMax+9,'MinPeakHeight',0.25*maxi_P,'SortStr','descend');
    if length(maxi_PP) > 2
    	Period_Phrase(i) = 0;
    else
    	Period_Phrase(i) = lsor(1);
    end
end
for i = 1:fix(frame_num/2)
    if Period_Phrase(i) > 200
        Period_Phrase(i) = Period_Phrase(i)/3;
    elseif Period_Phrase(i) > 100
        Period_Phrase(i) = Period_Phrase(i)/2;
    end
end
for i = fix(frame_num/2)+1:frame_num
    if Period_Phrase(i) > 120
        Period_Phrase(i) = Period_Phrase(i)/3;
    elseif Period_Phrase(i) > 60
        Period_Phrase(i) = Period_Phrase(i)/2;
    end
end
figure(4)
scatter(x,Period_Phrase/10);
% values = spcrv(Period_Phrase/10,3); 
% plot(x,values(1,:));
xlabel('evolving time(s)');
ylabel('Pitch Period(ms)');
title('Pitch Period vs. Time of Phrase, Scatter Graph');

figure(5)
plot(x,Power_Phrase);
xlabel('evolving time(s)');
ylabel('Average Power(dB)');
title('Excitation Signal Power vs. Time of car.wav');


