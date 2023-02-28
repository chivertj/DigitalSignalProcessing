%sampling frequency
fs=100e3;
%cut-off frequency
fl=15e3;
fh=25e3;
fh=fs/2-fh;

%digital cut-off frequency
Omegal = 2*pi*fl/fs;
Omegah = 2*pi*fh/fs;

%length of filter
M=21;
halfM=floor(M/2);
%discrete time index
%n=-halfM:halfM;
n=0:M-1;
N=M;
%frequencies
f=0:fs/N:fs-fs/N;
%sinc based impulse response
h=Omegal/pi*sinc((n-halfM)*Omegal/pi)+Omegah/pi*sinc((n-halfM)*Omegah/pi).*cos((n-halfM)*pi);
%blackman window
w=blackman(M)';
%element wise multiplication with the sinc function
blackmanh=h.*w;
%visually compare time domain sinc based impulse response 
%with hamming windowed sinc function
plot(n,h,'DisplayName','Rectangular Window')
hold on
plw=plot(n,blackmanh,'r','DisplayName','Blackman Window')
hold off
xlabel('Time Index, n')
ylabel('Impulse Response Amplitude')
legend

%wait for window to close before going to next part of code  
waitfor(plw)

%
%DFTs and magnitude responses 
H=fft(h);
HmagdB=20*log10(abs(H));

BlackmanH=fft(blackmanh);
BlackmanHmagdB=20*log10(abs(BlackmanH));

plot(f,HmagdB,'DisplayName','Rectangular Window')
hold on
plot(f,BlackmanHmagdB,'r','DisplayName','Blackman Window')
hold off
xlabel('Frequency, Hz')
ylabel('Magnitude Response, dB')
legend
