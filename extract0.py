import pandas as pd

# --- Parámetros conocidos del experimento ---
repeticiones = 5
tamanos = [400, 800, 1000, 1200, 1600]
hilos = [2, 4, 8]

# --- Archivos de entrada ---
carpeta = "nodo0"
archivos = {
    "Secuential": f"{carpeta}/Secuential.txt",
    "OMP": f"{carpeta}/OMP.txt",
    "OMP_T": f"{carpeta}/OMP_T.txt"
}

# --- Diccionario para guardar resultados ---
resultados = {}

# --- Procesamiento de cada archivo ---
for nombre, ruta in archivos.items():
    with open(ruta) as f:
        tiempos = [float(line.strip()) for line in f if line.strip()]
    
    data = []
    
    if nombre == "Secuential":
        # 25 valores → repeticiones × tamaños
        idx = 0
        for j in range(repeticiones):
            for tam in tamanos:
                data.append([j+1, tam, tiempos[idx]])
                idx += 1
        df = pd.DataFrame(data, columns=["Repetición", "Tamaño", "Tiempo (s)"])
    
    else:
        # 75 valores → repeticiones × tamaños × hilos
        idx = 0
        for j in range(repeticiones):
            for tam in tamanos:
                for hilo in hilos:
                    data.append([j+1, tam, hilo, tiempos[idx]])
                    idx += 1
        df = pd.DataFrame(data, columns=["Repetición", "Tamaño", "Hilos", "Tiempo (s)"])
    
    resultados[nombre] = df

# --- Exportar a un solo archivo Excel con tres hojas ---
with pd.ExcelWriter("Results_Node0.xlsx") as writer:
    for nombre, df in resultados.items():
        df.to_excel(writer, sheet_name=nombre, index=False)

print("✅ Resultados organizados en 'Resultados_Experimentos.xlsx'")