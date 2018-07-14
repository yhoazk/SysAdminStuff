@echo off
:loop
rem :: This script verifyes that the drive T is currently mounted and prints Drive T found if it's the case
rem  ::wmic path CIM_LogicalDevice where "Description like 'USB%%'" get /value > usb_log.txt
  wmic logicaldisk get name | find "G:"
  :: regresa una lista de todos los drives conectados y busca por el drive T

:: get a list of all the properties of the disks
:: wmic logicaldisk get

  if  %errorlevel% == 0 (
      echo "Drive g found"
  ) else (
      echo "Drive NOT g found"
  )
  timeout /t 2
goto loo
