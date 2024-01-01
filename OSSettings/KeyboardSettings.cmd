@ECHO ON
@SET uint=/t REG_DWORD /f /d
@SET rstr=/t REG_SZ /f /d

::@SET stCmd=@echo reg add
:: delete :: - see command

@SET stCmd=REG ADD
:: delete :: - patch registry

::@SET stCmd=@echo
:: delete :: - see key, value

@SET ARKeyboard="HKCU\Control Panel\Accessibility\Keyboard Response"
%stCmd% %ARKeyboard% /v "KeyboardDelay"         %rstr%    0
%stCmd% %ARKeyboard% /v "AutoRepeatDelay"       %rstr%  200
%stCmd% %ARKeyboard% /v "AutoRepeatRate"        %rstr%   10
%stCmd% %ARKeyboard% /v "DelayBeforeAcceptance" %rstr%   50
%stCmd% %ARKeyboard% /v "Flags"                 %rstr%   27
%stCmd% %ARKeyboard% /v "BounceTime"            %rstr%    0

@SET CPKeyboard="HKCU\Control Panel\Keyboard"
%stCmd% %CPKeyboard% /v "KeyboardDelay" %rstr%  0
%stCmd% %CPKeyboard% /v "KeyboardSpeed" %rstr% 31

@REG QUERY %ARKeyboard%
@REG QUERY %CPKeyboard%
