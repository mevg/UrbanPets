Write-Host "Iniciando configuración del entorno para UrbanPets..." -ForegroundColor Cyan

# 1. Verificar dependencias base
if (!(Get-Command dotnet -ErrorAction SilentlyContinue)) {
    Write-Error "El SDK de .NET no está instalado. Por favor, instálalo primero."
    exit
}

if (!(Get-Command npm -ErrorAction SilentlyContinue)) {
    Write-Error "Node.js (npm) no está instalado. Por favor, instálalo primero."
    exit
}

# 2. Instalar herramientas globales requeridas
Write-Host "Instalando herramientas globales de .NET (EF Core)..." -ForegroundColor Yellow
# Redirigimos el error en caso de que ya esté instalado para que el script no se detenga
dotnet tool install --global dotnet-ef 2>$null
# Actualizamos por si ya estaba instalado pero en una versión anterior
dotnet tool update --global dotnet-ef 2>$null

Write-Host "Instalando Angular CLI a nivel global..." -ForegroundColor Yellow
npm install -g @angular/cli

# 3. Construir la estructura del repositorio
$solutionName = "UrbanPets"

if (!(Test-Path "$solutionName.sln")) {
    Write-Host "Creando solución de .NET en blanco..." -ForegroundColor Yellow
    dotnet new sln -n $solutionName

    Write-Host "Generando proyecto Backend (Web API)..." -ForegroundColor Yellow
    dotnet new webapi -n "$solutionName.Api" -o src/Api
    dotnet sln add src/Api/"$solutionName.Api.csproj"

    Write-Host "Generando proyecto Frontend (Angular)..." -ForegroundColor Yellow
    # Usamos --defaults para evitar que Angular haga preguntas interactivas y pause el script
    ng new "$solutionName.Client" --directory src/Client --defaults

    Write-Host "Añadiendo archivo .gitignore de .NET..." -ForegroundColor Yellow
    dotnet new gitignore
} else {
    Write-Host "La solución ya existe. Saltando la creación de directorios." -ForegroundColor Green
}

Write-Host "¡Entorno de UrbanPets listo para programar!" -ForegroundColor Green