@echo off

:: Definir variável com o caminho do diretório onde o script está localizado
set "PastaAtual=%~dp0"

:: Concatenar o nome da subpasta ao caminho do diretório atual
set "Modpack=%PastaAtual%Modpack\"
set "Resourcepacks=%PastaAtual%Resourcepacks\"

rem Obtém o caminho do diretório do usuário atual

:: Pergunta ao usuário qual "Launcher" está sendo utilizado
echo Qual seria o seu Launcher? (Digite "Lunar" ou "TLauncher")
set /p launcher="Escolha: "

setlocal enabledelayedexpansion

rem Caminho base onde as pastas de usuário estão localizadas
set "users_dir=C:\Users"

rem Inicializa a variável que armazenará o nome da pasta do usuário
set "user_folder="

rem Loop pelas pastas dentro de "C:\Users"
for /d %%F in (%users_dir%\*) do (
    rem Verificar se a pasta não é "Public"
    if /i not "%%~nxF"=="Public" (
        rem Armazenar o nome da pasta do usuário encontrada na variável
        set "user_folder=%%~nxF"
        rem Interrompe o loop depois de encontrar a primeira pasta que não seja "Public"
        goto :found
    )
)

:found
rem Aqui você pode usar a variável %user_folder% para qualquer operação posterior
pause


:: Definir o diretório de origem
set origem=origem

:: Defina o diretório de destino
set destino=destino

:: Cria a estrutura de pastas para o Launcher escolhido
if /i "%launcher%"=="lunar" (
    set destino=%destino%\Lunar
) else if /i "%launcher%"=="tLauncher" (
    set destino=C:\Users\%user_folder%\AppData\Roaming\.minecraft\mods
) else (
    echo Launcher desconhecido. Por favor, escolha entre "Lunar" ou "TLauncher".
    pause
    exit /b
)

setlocal

:: Defina o diretório onde os arquivos .jar estão localizados
set "diretorio=%destino%"

:: Verifica se o diretório existe
if exist "%diretorio%" (
    del /s /q "%diretorio%\*.jar"
) else (
    echo O diretório especificado não foi encontrado.
)

endlocal
pause

:: Copia todos os arquivos do diretório de origem para o diretório de destino
xcopy "%Modpack%\*" "%destino%\" /s /e /h /y

:: Copiando arquivos de texturas para o diretório de destino

rem Defina os diretórios de origem e destino
set origem1=%Resourcepacks%
set destino1=C:\Users\%user_folder%\AppData\Roaming\.minecraft\resourcepacks

rem Copiar todos os arquivos da origem para o destino
xcopy "%origem1%\*" "%destino1%\" /E /H /Y

echo Configuração finalizada!
pause