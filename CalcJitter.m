function CalcJitter()
  close all;

  % Cargar el archivo CSV
  datos = csvread('Datos.csv');

  % Obtener cada columna de los datos
  columna1 = datos(:, 1);
  cold = diff(columna1);

  % Graficar cada columna
  figure;
  subplot(2,1,1);
  plot(columna1, 'b', 'linewidth', 2); % Curva de la primera columna en rojo
  grid on;
  xlabel('Tiempo');
  ylabel('Valores');
  title('Señal del pulso para medición del tiempo de muestreo');
  subplot(2,1,2);
  plot(cold, 'r', 'linewidth', 2); % Curva de la primera columna en rojo
  grid on;
  xlabel('Tiempo');
  ylabel('Valores');
  title('Cambios de la señal original');

  % Etiquetas y leyenda
  xlabel('Tiempo');
  ylabel('Valores');

  cambios = find(cold>10|cold< -10);

  Diferecias_flancos = [];
  Muestreo_OSC = 250e6;    % Muestreo del osciloscopio a 250Msps

  for (i=2:length(cambios))
    Diferecias_flancos = [Diferecias_flancos cambios(i) - cambios(i-1)];
  endfor

  Diferecias_flancos
  Promedio_diferencias = sum(Diferecias_flancos)/length(Diferecias_flancos)

  Jitter = Promedio_diferencias/Muestreo_OSC


endfunction

