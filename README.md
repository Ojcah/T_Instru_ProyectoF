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

#### Codigo Utilizado para hacer los Calculos
```python 
import pyodbc
import pandas as pd

def read_db(muestraID,conexion):
    query = f"SELECT * FROM Dato WHERE muestraID='{muestraID}'"
    data = pd.read_sql(query, conexion)
    return data

# Funcion para crear la lista de datos obtenidos
def crear_lista(data):
    lista = []
    for i in data.valor:
        lista.append(i)

    return lista

# Función para calcular la constante k utilizando diferencias finitas
def calcular_constante_k(lista_temperaturas, tasa_muestreo,temperatura_ambiente):
    k_values = []
    for i in range(1, len(lista_temperaturas)):
        delta_t = tasa_muestreo / 1000  # Convertir tasa de muestreo a segundos
        delta_T = lista_temperaturas[i - 1] - lista_temperaturas[i]
        k = delta_T / (delta_t * (lista_temperaturas[i - 1] - temperatura_ambiente))
        k_values.append(k)
    return sum(k_values) / len(k_values) if k_values else None

def main():
    cnxn_str = ("Driver={SQL Server};"
                "Server=SEBASPC;"
                "Database=proyecto3;"
                "Trusted_Connection=yes;")
    cnxn = pyodbc.connect(cnxn_str)

    cursor = cnxn.cursor()

    # Leer la Base de Datos
    data1 = read_db(5,cnxn)
    data2 = read_db(10,cnxn)
    data3 = read_db(10,cnxn)


    # Crear las Listas
    lista1 = crear_lista(data1)
    lista2 = crear_lista(data2)
    lista3 = crear_lista(data3)

    # Temperatura ambiente
    temperatura_ambiente = 25

    # Tasa de muestreo en milisegundos
    tasa_muestreo = 50

    # Calcular la constante k para cada lista de temperaturas
    k1 = calcular_constante_k(lista1, tasa_muestreo,temperatura_ambiente)
    k2 = calcular_constante_k(lista2, tasa_muestreo,temperatura_ambiente)
    k3 = calcular_constante_k(lista3, tasa_muestreo,temperatura_ambiente)

    # Tomar el promedio de las constantes k de los tres experimentos
    constante_k_promedio = (k1 + k2 + k3) / 3

    print(f"Constante K de los primeros datos: {k1}")
    print(f"Constante k promedio: {constante_k_promedio}")

main()
```
