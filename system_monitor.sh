#!/bin/bash

# Define el humbral de valores para el CPU, memoria, y uso del disko (en porcentaje)

CPU_THRESHOLD=80
MEMORY_THRESHOLD=80
DISK_THRESHOLD=80

# Funcion para mandar alerta

send_alert() {
  echo "$(tput setaf 1)ALERT: $1 usage exceeded threshold! Current value: $2%$(tput sgr0)"
}

# Monitoreo del uso de la CPU
#Top -bn1: Ejecuta el comando top en modo batch durante una iteración para obtener las estadísticas de la CPU en tiempo real.
#Grep "Cpu(s)": Filtra la salida para centrarse en la línea de uso de la CPU
#awk '{print $2 + $4}': Extrae y suma los porcentajes de uso de la CPU por parte del usuario y del sistema.
#if ((cpu_usage >= CPU_THRESHOLD)): Compara el uso de la CPU con el umbral y llama a send_alert si se supera.

cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
cpu_usage=${cpu_usage%.*} # Convert to integer
echo "Current CPU usage: $cpu_usage%"

if ((cpu_usage >= CPU_THRESHOLD)); then
  send_alert "CPU" "$cpu_usage"
fi

