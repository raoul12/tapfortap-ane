tapfortap-ane
=============

The official Tap for Tap ANE (AIr Native Extension).

Prerequisites
-------------

- JDK 1.6 or later
- Flash Builder 4.5.2 or later
- AIR 3.2 SDK or later
- Android SDK with the API version 8 (for Android 2.2)
- Eclipse (the one included with Flash Builder is sufficient)
- Make sure your FLEX_HOME environment variable is set and valid.

How to build
------------

### 1/ Build fake.p12 (or provide your own certificate)
- Modify build_p12.bat in order to specify your name and a password for that certificate.
- Run build_p12.bat

### 2/ Build native/tapfortap-ane-android.jar
- Import the native/android project into Eclipse.
- Copy FlashRuntimeExtensions.jar from your AIR SDK into native/android/lib
- Build the project.
- Click on File > Export > Java > JAR file and follow the steps.

### 3/ Build library/bin/tapfortap-ane.swc
- Import the library project into Flash Builder.
- Build it.

### 4/ Build tapfortap.ane
- Extract library.swf from tapfortap-ane.swc (in the same directory)
- Run build_ane.bat (may need some changes if you use your own certificate)

### 5/ Run tapfortap-ane-demo
- Import the example project into Flash Builder.
- Open the project properties panel and go to ActionScript Build Path > Native Extensions > Add ANE then find tapfortap.ane
- Run the project on your mobile device as usual.

Useful links
------------

- http://developer.tapfortap.com/sign-in
- http://developer.android.com/sdk/installing/installing-adt.html
- http://www.adobe.com/devnet/air/articles/developing-native-extensions-air.html
- http://help.adobe.com/en_US/air/extensions/WSf268776665d7970d-2482335412ffea65006-8000.html