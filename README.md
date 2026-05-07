# MARCO

MARCO is a Flutter application scaffolded with Riverpod state management, GoRouter for navigation, and Flutter Map for map features. This repository contains the app source, platform builds, and example mock API used during development.

**Quick Summary**
- **Project**: MARCO
- **Language**: Dart + Flutter
- **State management**: `flutter_riverpod`
- **Routing**: `go_router`
- **Mapping**: `flutter_map` + `latlong2`
- **HTTP clients**: `dio`, `http`

**Contents**
- **Source**: [lib](lib)
- **Android**: [android](android)
- **iOS**: [ios](ios)
- **Linux**: [linux](linux)
- **Mock API**: [mock-api](mock-api)
- **Pubspec**: [pubspec.yaml](pubspec.yaml)

**Prerequisites**
- Install Flutter (SDK >= 3.11.4) and set up your platform toolchains: Android SDK, Xcode (macOS), or development packages for Linux/Windows as needed.
- Ensure `flutter` is on your PATH and run `flutter doctor` to verify setup.

Getting started

1. Clone the repo and fetch dependencies:

	`git clone <repo-url>`
	`cd marco`
	`flutter pub get`

2. Run the app on the default device/emulator:

	`flutter run`

3. To run for a specific platform, pass a device or target flag, for example:

	- `flutter run -d linux`
	- `flutter run -d android` (or use an Android emulator/device)
	- `flutter run -d web-server` (for web builds)

Building

- Android (APK): `flutter build apk`
- Android (AAB): `flutter build appbundle`
- iOS: `flutter build ios`
- Web: `flutter build web`
- Linux: `flutter build linux`

Project structure notes

- `lib/main.dart`: app entry point. See [lib/main.dart](lib/main.dart) for startup logic.
- `lib/core`, `lib/features`, `lib/shared`: separated by responsibility (core services, feature modules, shared widgets).
- `mock-api`: a simple mock API used during development; start it with `npn start` (ensure dependencies are installed with `npm install`).

Contact

vaioschristodoulou@gmail.com

## Screens

### Signup Flow

<table>
	<tr>
		<td><img src="assets/images/Screenshot%20from%202026-05-07%2010-44-02.png" alt="Signup flow screenshot 1" width="100%" /></td>
		<td><img src="assets/images/Screenshot%20from%202026-05-07%2010-44-11.png" alt="Signup flow screenshot 2" width="100%" /></td>
	</tr>
	<tr>
		<td><img src="assets/images/Screenshot%20from%202026-05-07%2011-01-51.png" alt="Signup flow screenshot 3" width="100%" /></td>
		<td><img src="assets/images/Screenshot%20from%202026-05-07%2010-44-53.png" alt="Signup flow screenshot 4" width="100%" /></td>
	</tr>
</table>

### Main Screens

<table>
	<tr>
		<td><img src="assets/images/Screenshot%20from%202026-05-07%2010-43-05.png" alt="Main screen screenshot 1" width="100%" /></td>
		<td><img src="assets/images/Screenshot%20from%202026-05-07%2010-43-13.png" alt="Main screen screenshot 2" width="100%" /></td>
		<td><img src="assets/images/Screenshot%20from%202026-05-07%2010-43-20.png" alt="Main screen screenshot 3" width="100%" /></td>
	</tr>
	<tr>
		<td><img src="assets/images/Screenshot%20from%202026-05-07%2010-43-24.png" alt="Main screen screenshot 4" width="100%" /></td>
        <td><img src="assets/images/Screenshot%20from%202026-05-07%2010-57-13.png" alt="Main screen screenshot 5" width="100%" /></td>
	</tr>
</table>