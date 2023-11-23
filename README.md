# T_Instru_ProyectoF

## Meidicion de Desempeño
### Tasa de Muestreo Efectiva y Jitter

### Cuantificación de Error Estático y Dinámico
#### Error Estático

Para obtener el error Estatico de las mediciones de las escalas se toma el valor maximo de la escala y se alimenta el ADC. Se obtiene primero el valor con un multimetro de la entrada del ADC y luego se obtiene la lectura realizada por el ADC para obtener cual es el pocentaje de error entre las mediciones. 

| Escala (V) | Valor ADC (V) | Valor Multimetro (V) | Porcentaje de error (%) |
|:----------:|:-------------:|:--------------------:|:-----------------------:|
|     10m    |      4.76     |         4.83         |           1.47          |
|      1     |      4.78     |         4.82         |           0.84          |
|     2.5    |      4.98     |         5.04         |           1.20          |
|      5     |      4.96     |         4.83         |           2.62          |
|     10     |      4.98     |         4.92         |           1.20          |

Porcentaje de error promedio = 1.47 %

### Experimento, Medicion de Temperatura del Agua
Para el experimento se necesita un vaso con agua a temperatura superior a los 50 grados Celcius en donde se coloca la thermocupla a una escala de 10mV. Se requiere verificar la temperatura del vaso para luego dejar enfriar el vaso y obtener el comportamiento de la temperatura disminuyendo. Estos datos son guardados en la base de datos para poder ser procesados luego con un script de Python. Este script puede acceder a la base de datos y obtener los valores relevantes. Los ordena en listas que pueden ser manipuladas y con una funcion hecha por nosotros utilizando la ley de Newton de la temperatura se puede obtener el valor de K para 3 distintas mediciones junto con el K promedio de las 3 mediciones. 
