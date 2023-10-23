# digisalad_task
Job application task by Ng Man Sao, David
## Getting Started
iTunes Explorer is the project created in flutter using GetX and AssetsAudioPlayer. iTunes Explorer supports both iOS and Android, it has been optimized and adapted to both platform, including adaptive app icons, music player notification support

How to Use
- Step 1: Download or clone this repo by using the link below: https://github.com/davidsao/digisalad_task.git
- Step 2: Go to project root and execute the following command in console to get the required dependencies:
`flutter pub get `

### Current Features
- Search for songs on iTunes using keywords
- Preview album art and 30-second sound tracks
- Built-in audio player with play-pause controls
- System notification player support
- 3 languages support (English, Simplified Chinese and Traditional Chinese)
- Internet connection checking

### Folder Structure
Here is the core folder structure which flutter provides.

    flutter-app/
    |- android
	|- assets
    |- build
    |- ios
    |- lib
	|- linux (Not yet developed)
	|- macos (Not yet developed)
    |- test
	|- web (Not yet developed)
	|- windows (Not yet developed)

Here is the **/lib **folder structure

    lib/
    |- constants/
	|- controllers/
    |- data_models/
    |- screens/
    |- utils/ (For API services, localization and Internet connection checking)
	|- main.dart

**Detail of each folder**
- constants: For storing color constants and widget styling
- controllers: For GetX controllers
- data_models: For handling JSON response from API calls
- screens: For UI and widgets
- utils: For API services, localization and Internet connection checking

### UI
This directory contains all the ui of your application. Each screen is located in a separate folder making it easy to combine group of files related to that particular screen. All the screen specific widgets will be placed in widgets directory as shown below:

	ui/
	|- home_screen.dart
	|- player_screen.dart
	|- search_screen.dart
	|- settings_screen.dart
	|- widgets/
		|- album_art.dart
		|- empty_image.dart
		|- position_seek.dart
		|- song_list_item.dart

### Libraries & Tools Used

	- lotties: Animated Image
	- cached_network_image: Caching album art image
	- assets_audio_player: Playing audio with iOS and Android support
	- flutter_spinkit: Loading animation
	- http: For REST API call
	- connectivity_plus: Checking device internet connection
	- get: GETX module for state management and additional flutter features
	- get_storage: For storing system preferences
