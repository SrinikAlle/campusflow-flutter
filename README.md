# CampusFlow

CampusFlow is a clean Flutter student-productivity app designed to keep academics in one place.

## Features

- Dashboard with academic overview
- Subject management
- Assignment and deadline tracking
- Attendance monitoring
- Notes workspace
- Study timer
- Responsive Material 3 interface
- Firebase-ready architecture for Authentication and Firestore

## Tech Stack

- Flutter
- Dart
- Material 3
- Firebase Core
- Firebase Authentication
- Cloud Firestore

## Run the project

This repository contains the app source code and is ready to be turned into a full Flutter project.

1. Install Flutter and confirm it works:

```bash
flutter doctor
```

2. From the project folder, generate platform files if they are not already present:

```bash
flutter create .
```

3. Install dependencies:

```bash
flutter pub get
```

4. Run the app:

```bash
flutter run
```

The app runs in local demo mode by default, so Firebase is not required just to preview it.

## Connect Firebase

1. Create a Firebase project.
2. Add your Android/iOS app in Firebase.
3. Install FlutterFire CLI:

```bash
dart pub global activate flutterfire_cli
```

4. Configure the project:

```bash
flutterfire configure
```

5. Use `lib/services/firebase_campus_service.dart` as the starting point for Authentication and Firestore integration.

## Suggested Firestore Collections

```text
users/{userId}
subjects/{subjectId}
assignments/{assignmentId}
notes/{noteId}
study_sessions/{sessionId}
```

## Current Status

The current version is a polished portfolio-ready frontend with local demo data. Firebase integration is prepared but not enabled by default, so the repository remains easy to run and review.

## Author

**Srinik Alle**  
Data Science Student | AI · Full-Stack · Flutter Developer
