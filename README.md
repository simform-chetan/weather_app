# Weather App

[![Codacy Badge](https://app.codacy.com/project/badge/Grade/53926a0529af4a2a8577e7e6f8a35846)](https://app.codacy.com/gh/simform-chetan/weather_app/dashboard?utm_source=gh&utm_medium=referral&utm_content=&utm_campaign=Badge_grade)

Android App Link: [Weather App](https://github.com/simform-chetan/weather_app/preview/weather_app_release.apk)

## App Preview
<img src="https://raw.githubusercontent.com/simform-chetan/weather_app/main/preview/home_page.jpg" alt ="" height=500 width=250/><img src="https://raw.githubusercontent.com/simform-chetan/weather_app/main/preview/home_page2.jpg" alt="" height=500 width=250/><img src="https://raw.githubusercontent.com/simform-chetan/weather_app/main/preview/detail_page.jpg" alt ="" height=500 width=250/><img src="https://raw.githubusercontent.com/simform-chetan/weather_app/main/preview/settings_page.jpg" alt ="" height=500 width=250 />

## Requirements
- IDE: An Integrated Development Environment to view and run the code.
    - Recommended: Android Studio Giraffe (2022.3.1 Patch 4) or higher
- Android SDK (Required for Android apps)
    - NOTE: If you are using Android Studio as IDE, you won't need to do any additional setup for this.
- Flutter 3.13.0
    - Check [this](https://docs.flutter.dev/get-started/install) flutter setup guide to properly install flutter.
- XCode: 15.2 or Higher (Required for iOS apps)


## Minimum requirements

- Android Oreo 8 or higher
- iOS 15 or higher

## Setup & Run
Make sure all the required components are installed and properly setup before running below steps. And you are at the root directory of project.

- Step 1: Run flutter doctor by executing following command and make sure it has no issues. If there are fix those issues before moving to next step.
  ```shell
  flutter doctor
  ```

- Step 2: Clone repository from github using below command.
    ```shell
    git clone https://github.com/simform-chetan/weather_app.git
    ```

- Step 3: Open the project in your preferred IDE.

- Step 4: Get the API key from *[OpenWeather](https://openweathermap.org/api)* and set the `apiKey` variable at *`lib > core > api_constants.dart`* file.
    ```dart
   static const String apiKey = '[Paste your key here]';

    /// If the api key is "abddsjddhdhdhdhdh", it will be like following after pasting it.
    ///  static const String apiKey = 'abddsjddhdhdhdhdh';

    ```
- Step 5: Run `flutter pub get`.
- Step 6: Generate all the required files by running following command.
    ```shell
    flutter pub run build_runner build --delete-conflicting-outputs
    ```
- Step 7: Make sure an emulator is running. OR a physical device is connected with the system.
- Step 8: Run the flutter app using following command.
    ```shell
    flutter run
    ```
## APIs
We've used OpenWeather API to get the weather data. Make sure you have startup subscription plan of this API.

Also, we have used Open Meteo API to get the location data.

## Resources & References
- [OpenWeather](https://openweathermap.org/)
- [Open-Meteo](https://open-meteo.com/)
- UI Reference: IOS's weather app.
- Clean Architecture
- Bloc state management

## Development Tools:
- Android Studio Giraffe
- Flutter SDK 3.13.0
- XCode 15.2
- Postman
