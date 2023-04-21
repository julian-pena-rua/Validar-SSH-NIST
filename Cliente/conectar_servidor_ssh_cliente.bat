::-------------------------------------------------------------------------------------------
:: AUTOMATIZACIÓN DE CONEXIÓN A SERVIDOR SSH
:: NIVEL: INTERMEDIO
:: 
:: AUTOR: 			Julian A. Peña
:: FECHA: 			05 Abril 2023
:: VERSIÓN: 		1.0.0
:: SITIO: 			https://julian-pena-rua.github.io/cv/	
:: DESCRIPCIÓN:	
::			Rutina de prueba para conectar al servidor SSH utilizando los credenciales:
:: 	
:: 				ssh -p22 bichoj@192.168.214.128 
::
::			Se establece una rutina para realizar conexión a servidor con los credenciales definidos
:: 			en las variables, la contraseña será ingresada por medio de un SendKeys() en __ 
:: 			de esta manera será capturada e ingresada automaticamente.
:: NOTA: 
:: 			Debe tener plink.exe instalado en el sistema. Se encuentra incluído en la distribución windows de PuTTY, 
::			si tiene PuTTY instalado, debe tener plink.exe también. Si no, puede descargar PuTTY desde el sitio oficial
::			(https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html) .
::			Manual de comandos Putty https://tartarus.org/~simon/putty-snapshots/htmldoc/Chapter7.html
:: 	
::-------------------------------------------------------------------------------------------

:: elimina el eco, la repetición de la ruta en cada línea
	@echo off 					


:: ==============
:: VARIABLES
:: ===============
:: Para definir las variables no pueden tener espacios entre <variable>=<valor>

:: Estáticas
	
	set NombreAutor=Julian Andres Peña
	set Version=1.0.0

	set username=test-guest-1
	set password=aqIJ@MEw@xOct
	set hostname=192.168.214.128
	set port=543
	
:: Setencia IF la cual valida que se defina un puerto sino establece por defecto (22)
	if "%port%"=="" set port=22
	
:: ==============
:: MENSAJE BIENVENIDA
:: ===============

:: imprime el mensaje después de echo
	echo =============================================================
	echo =								 
	echo =	BIEVENIDO AL MINI PROGRAMA PARA CONEXIÓN SSH
	echo =				POR: 		%NombreAutor%		 
	echo =				VERSION: 	%Version%		 
	echo =============================================================	

	echo ""
	echo ""
	echo ""

:: /timeout 5 o /t 5 es para tiempo de espera, /nobreak > nul previene que el usuario interrumpa la espera
	timeout /t 2 /nobreak >nul 					
	
:: limpia la pantalla
	cls

:: ==============
:: OPERACIONES
:: ===============

	echo =============================================================
	echo =								 
	echo =	INICIANDO CONEXIÓN A SERVIDOR SSH 
	echo =				POR: 		%NombreAutor%		 
	echo =				VERSION: 	%Version%		 
	echo =============================================================	
	
	echo ""
	echo ""
	echo ""

	:: Mensaje de avance en carga
	echo "#####                     (33%)"
		echo.
		echo Conectando a %username%@%hostname% en puerto %port%...
	
	echo "#############             (66%)"

	
	echo "###################       (86%)"


	:: Mensaje de finalización
	echo "#######################   (100%)"
		echo Carga de programas completa
		timeout /t 2 /nobreak >nul 	
	cls

	start plink.exe -ssh -t -P %port% %username%@%hostname% -pw %password%
	::start plink.exe -ssh -t -P 543 test-guest-1@192.168.214.128 -pw aqIJ@MEw@xOct
	::start plink.exe -ssh -t -P 543 javier@192.168.214.128 -pw 123456789
	


	timeout /t 2 /nobreak >nul 	

	:: Envía teclas
	::powershell -Command "(New-Object -ComObject WScript.Shell).SendKeys('{F}')"
	::powershell -Command "$wshell = New-Object -ComObject WScript.Shell; foreach ($key in 'exit') { $wshell.SendKeys($key) }"
	::powershell -Command "(New-Object -ComObject WScript.Shell).SendKeys('{ENTER}')"
	
	
	powershell -Command "$wshell = New-Object -ComObject WScript.Shell; $wshell.AppActivate('plink.exe'); Start-Sleep -Milliseconds 100; $wshell.SendKeys('{ENTER}')"
	
	
:: ==============
:: MATAR PROCESOS
:: ===============

	::echo =============================================================
	::echo =								 
	::echo =	CERRANDO PROCESOS
	::echo =								 
	::echo =============================================================	

:: /f Fuerza el término del proceso.
	::taskkill /f /im vscode "C:\xampp\htdocs\"

	::pause
	::cls


:: ==============
:: FIN DE EJECUCIÓN
:: ===============

	::echo =============================================================
	::echo =								 
	::echo =	CERRANDO PROGRAMA PARA CONEXIÓN A SERVIDOR SSH
	::echo =				POR: 		%NombreAutor%		 
	::echo =				VERSION: 	%Version%		 
	::echo =============================================================	
	
	::pause

:: cierra ventana, termina ejecución
	::exit