# Quizly

Quizly is a feature-rich math quiz application built with Flutter. It's designed to provide an engaging and interactive learning experience for users who want to practice and improve their math skills. The app follows modern development practices, including Clean Architecture, for a scalable and maintainable codebase.

## 📸 Screenshots

### Skill Performance
<img src="screenshots/skill_performance.jpg" alt="Screenshot" width="300" height="600">

### Pre Quiz Screen
<img src="screenshots/pre_quiz.jpg" alt="Screenshot" width="300" height="600">

### Quiz Screen
<img src="screenshots/quiz1.jpg" alt="Screenshot" width="300" height="600">
<img src="screenshots/quiz2.jpg" alt="Screenshot" width="300" height="600">
<img src="screenshots/quiz3.jpg" alt="Screenshot" width="300" height="600">
<img src="screenshots/quiz4.jpg" alt="Screenshot" width="300" height="600">

### Quiz Performance Screen 
<img src="screenshots/quiz_performance.jpg" alt="Screenshot" width="300" height="600">


## 📱 Demo
🎬 [Watch Demo Video](https://drive.google.com/file/d/1B49to1d5dwgfCfkIt5yrNFVh2y3Vcbvt/view?usp=sharing)
## ✨ Features

- **Dynamic Quizzes**: Take quizzes tailored to specific math skills and units.
- **Multiple Question Types**: Supports both Multiple Choice Questions (MCQ) and Fill-in-the-Blank (FITB) questions.
- **Performance Tracking**: Get detailed performance analysis, including scores and a review of incorrect answers.
- **Difficulty Levels**: Quizzes are categorized by difficulty to cater to different user levels.
- **Clean UI**: Aesthetically pleasing and intuitive user interface for a smooth user experience.
- **Local Database**: Utilizes `sqflite` to store quiz data locally on the device.

## 🏗️ Tech Stack & Architecture

This project is built using the **Flutter** framework and follows the principles of **Clean Architecture**. The codebase is structured feature-first, with a clear separation of concerns into `data`, `domain`, and `presentation` layers.

- **State Management**: [**Flutter Bloc (Cubit)**](https://bloclibrary.dev/) is used for predictable and scalable state management.
- **Dependency Injection**: [**get_it**](https://pub.dev/packages/get_it) is used as a service locator for decoupling dependencies.
- **Routing**: [**go_router**](https://pub.dev/packages/go_router) for declarative routing.
- **Local Storage**: [**sqflite**](https://pub.dev/packages/sqflite) for on-device SQL database.
- **Functional Programming**: [**dartz**](https://pub.dev/packages/dartz) for error handling using `Either` type.
- **UI**: [**Google Fonts**](https://pub.dev/packages/google_fonts) for beautiful typography.

## 📂 Project Structure

The project's `lib` directory is organized as follows:

```
lib/
├── core/               # Core utilities, constants, and setup
│   ├── app_router/
│   ├── constants/
│   ├── di/
│   ├── sqflite/
│   └── utils/
│
├── features/           # Feature-based modules
│   ├── quiz/
│   ├── quiz_performance/
│   ├── skill_performance/
│   ├── skills/
│   └── units/
│
└── main.dart           # Main entry point of the application
```

## 🚀 Getting Started

To get a local copy up and running, follow these simple steps.

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- An emulator or a physical device to run the app.

### Installation

1.  **Clone the repository:**
    ```sh
    git clone https://github.com/your_username/quizly_app.git
    ```
2.  **Navigate to the project directory:**
    ```sh
    cd quizly_app
    ```
3.  **Install dependencies:**
    ```sh
    flutter pub get
    ```
4.  **Run the app:**
    ```sh
    flutter run
    ```

### Download apk

1.  **Download the APK:**
    - [Download the latest APK here](app-release.apk)

2.  **Install the APK on your device:**
    - Locate the downloaded APK file on your device.
    - Tap the APK file to begin installation.
    - If prompted, allow installation from unknown sources in your device settings.

