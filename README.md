tapfortap-ane
=============

The official Tap for Tap ANE (Air Native Extension).

Prerequisites
-------------

- JDK 1.6 or later
- Flash Builder 4.5.2 or later
- AIR 3.2 SDK or later
- Android SDK with the API version 8 (for Android 2.2)
- Eclipse (the one included with Flash Builder is sufficient)
- Make sure your FLEX_HOME environment variable is set and valid.
- Xcode 3.1 or later

How to build
------------

### 1/ Build fake.p12 (or provide your own certificate)
- Modify build_p12.bat in order to specify your name and a password for that certificate.
- Run build_p12.bat

### 2/ Build native/tapfortap-ane-android.jar
- Import the native/android project into Eclipse.
- Copy FlashRuntimeExtensions.jar from your AIR SDK into native/android/lib
- Copy the latest version of TapForTap.jar from your TapForTap SDK into native/android/lib
- Build the project.
- Click on File > Export > Java > JAR file and follow the steps.
- Extract the com directory from TapForTap.jar and add it to tapfortap-ane-android.jar (to manually import *.class files)

### 3/ Build native/libTapForTapExtension.a
- Import the native/ios/iosextension project into Xcode.
- Copy FlashRuntimeExtensions.h from your AIR SDK into native/ios/iosextension
- Copy the latest version of libTapForTapAds.a from your TapForTap SDK into native/ios/iosextension/lib
- Build the project.

### 4/ Build library/bin/tapfortap-ane.swc
- Import the library project into Flash Builder.
- Build it.

### 5/ Build tapfortap.ane
- Extract library.swf from tapfortap-ane.swc (in the same directory)
- Run build_ane.bat (may need some changes if you use your own certificate)

How to run
----------

First, follow the previous steps to build tapfortap.ane or download the latest version from https://github.com/raoul12/tapfortap-ane/downloads

### A/ Run tapfortap-ane-demo
- Import the example project into Flash Builder.
- Open the project properties panel and go to ActionScript Build Path > Native Extensions > Add ANE then find tapfortap.ane
- Run the project on your mobile device as usual.

### B/ Integrate tapfortap-ane to your own project
- Open your project properties panel and go to ActionScript Build Path > Native Extensions > Add ANE then find tapfortap.ane
- Do not forget to specify the right Android permissions to your app XML.
- Run your project as usual.

Useful links
------------

- http://developer.tapfortap.com/sdk
- http://developer.android.com/sdk/installing/installing-adt.html
- http://www.adobe.com/devnet/air/articles/developing-native-extensions-air.html
- http://help.adobe.com/en_US/air/extensions/WSf268776665d7970d-2482335412ffea65006-8000.html