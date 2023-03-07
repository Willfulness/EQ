  :: or REM, comment line
  :: show command: @SET RunCommand=0, patch registry @SET RunCommand=1
  @SET RunCommand=0
  
  :: Эта закоментированная строка с скрытыми ключами 
  :: дает указание, что переменной присваивается целое число
  ::@SET /I /A RunCommand=0 
  
  ::REG_DWORD 32-разрядное число. 
  :: Именованием uint показываем что значение неотрицательное целое.
  @SET uint=/t REG_DWORD /d
  
  ::REG_SZ Строка с нулевым символом в конце. Это либо строка Unicode, либо строка ANSI
  @SET rstr=/t REG_SZ /d
  
  :: show command:
  IF 0==%RunCommand% @SET stCmd=@echo
  
  ::  patch registry
  IF 1==%RunCommand% @SET stCmd=reg add

  @SET Control=HKLM\SYSTEM\CurrentControlSet\Control
  
  @SET Prefetch="%Control%\Session Manager\Memory Management\PrefetchParameters"
  %stCmd% %Prefetch% /v EnablePrefetcher %uint% 5 /f
  %stCmd% %Prefetch% /v EnableSuperfetch %uint% 3 /f
  
  @SET FS="%Control%\FileSystem"
  %stCmd% %FS% /v NtfsDisableLastAccessUpdate %uint% 1 /f
  %stCmd% %FS% /v NtfsMemoryUsage %uint% 2 /f
  %stCmd% %FS% /v NtfsEncryptPagingFile %uint% 0 /f

  @SET Priority="%Control%\PriorityControl"
  %stCmd% %Priority% /v Win32PrioritySeparation %uint% 2 /f
  %stCmd% %Priority% /v IRQ8Priority %uint% 1 /f
  %stCmd% %Priority% /v IRQ14Priority %uint% 1 /f
  %stCmd% %Priority% /v IRQ15Priority %uint% 1 /f

  @SET Memory="%Control%\Session Manager\Memory Management"
  %stCmd% %Memory% /v DisablePagingExecutive %uint% 1 /f
  %stCmd% %Memory% /v LargeSystemCache %uint% 1 /f
  %stCmd% %Memory% /v IOPageLockLimit %uint% 0x04000000 /f
  
  @SET RegExplorer="HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer"
  %stCmd% %RegExplorer% /v AlwaysUnloadDLL %rstr% 0 /f
