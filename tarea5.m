
if(exist('OCTAVE_VERSION','builtin')~=0)
pkg load signal;
end
opcion = 0;
while opcion ~=5
 disp('1.Grabar')
 disp('2.Reproducir')
 disp('3.Graficar')
 disp('4.Graficar densidad')
 disp('5.Salir')
 opcion = input('Ingrese su elección: ');
switch opcion
case 1
% Grabación de audio
try
duracion = input('Ingrese la duración de la grabación en segundos: ');
disp('Comenzando la grabación...');
recObj = audiorecorder;
recordblocking(recObj, duracion);
disp('Grabación finalizada.');
data = getaudiodata(recObj);
audiowrite('audio.wav', data, recObj.SampleRate);
disp('Archivo de audio grabado correctamente.');
catch
disp('Error al grabar el audio.');
end
case 2
try
  [data, fs] = audioread('audio.wav');
  sound(data, fs);
catch
  disp('Error al reproducir el audio.');
end
case 3
% Gráfico de audio
try
[data, fs] = audioread('audio.wav');
tiempo = linspace(0, length(data)/fs, length(data));
plot(tiempo, data);
xlabel('Tiempo (s)');
ylabel('Amplitud');
tite('Audio');
catch
disp('Error al graficar el audio.');
end
case 4
% Graficando espectro de frecuencia
try
disp('Graficando espectro de frecuencia...');
[audio, Fs] = audioread('audio.wav'); % Lee la señal desde el archivo .wav
N = length(audio); % Número de muestras de la señal
f=linspace(0, Fs/2, N/2+1); % Vector de frecuencias
ventana = hann(N); % Ventana de Hann para reducir el efecto de las discontinuidades al calcular la FFT
Sxx = pwelch(audio, ventana, 0, N, Fs); % Densidad espectral de potencia
plot(f, 10*log10(Sxx(1:N/2+1))); % Grafica el espectro de frecuencia en dB
xlabel('Frecuencia (Hz)');
ylabel('Densidad espectral de potencia (dB/Hz)');
tille('Espectro de frecuencia de la señal grabada');
catch
disp('Error al graficar el audio.');
end
case 5
% Salir
disp('Saliendo del programa...');
otherwise
disp('Opción no válida.');
end
end














