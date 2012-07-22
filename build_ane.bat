@echo off
set signing_options=-tsa none -storetype pkcs12 -keystore fake.p12 -storepass 1234
set dest_ANE=tapfortap.ane 
set extension_XML=library\src\extension.xml 
set library_SWC=library\bin\tapfortap-ane.swc 
set SWF_directory=library\bin
"%FLEX_HOME%/bin/adt" -package %signing_options% -target ane "%dest_ANE%" "%extension_XML%" -swc "%library_SWC%" -platform Android-ARM -C "%SWF_directory%" library.swf -C native tapfortap-ane-android.jar -platform iPhone-ARM -C "%SWF_directory%" library.swf -C native libTapForTapExtension.a
pause