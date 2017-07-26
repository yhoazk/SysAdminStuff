:: This script verifyes that the drive T is currently mounted and prints Drive T found if it's the case

@echo off
:loop
  ::wmic path CIM_LogicalDevice where "Description like 'USB%%'" get /value > usb_log.txt
  wmic logicaldisk get name | find "T:"  :: regresa una lista de todos los drives conectados y busca por el drive T

:: get a list of all the properties of the disks
:: wmic logicaldisk get

  if  %errorlevel% == 0 echo "Drive t found"
  timeout /t 2
goto loop
