# 🍽️ Ahgzly App (MVP)

A modern restaurant booking application built with **Flutter** using **Clean Architecture** principles. This app allows users to browse restaurants, view details, and book tables seamlessly.

![Dart](https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)
![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)
![Laravel](https://img.shields.io/badge/laravel-%23FF2D20.svg?style=for-the-badge&logo=laravel&logoColor=white)

## 📱 Features

* **Authentication**: Login, Register, Logout, and Auto-Login (using JWT & Shared Preferences).
* **Restaurants**: Browse a list of restaurants with dynamic data fetching.
* **Booking System**: Book a table by selecting date, time, and guest count.
* **User Profile**: View user details.
* **Error Handling**: Robust error handling with custom exceptions.
* **State Management**: Advanced state management using **BLoC** & **Cubit**.

## 🏗️ Architecture & Tech Stack

The project follows strict **Clean Architecture** to ensure separation of concerns, testability, and scalability.

* **Architecture**: Clean Architecture (Presentation, Domain, Data).
* **State Management**: `flutter_bloc`.
* **Networking**: `dio` (with Interceptors & Logging).
* **Dependency Injection**: `get_it`.
* **Value Equality**: `equatable`.
* **Local Storage**: `shared_preferences`.
* **UI**: Responsive design using `flutter_screenutil`.

### 📂 Folder Structure
```text
lib/
├── core/                   # Shared logic (Network, Errors, Utils, Widgets)
├── features/               # App Features (Auth, Home, Restaurants, Bookings)
│   ├── data/               # Models, Repositories Impl, Data Sources
│   ├── domain/             # Entities, Repositories Interfaces, UseCases
│   └── presentation/       # BLoC/Cubit, Screens, Widgets
└── main.dart

📸 Screenshots: 
    * Login Screen ![Login].
    * Regsiter Screen ![Register].
    * Home Screen ![Home].
    * Bookings Screen ![Bookings].
    * MyBookings Screen ![MyBookings].
🚀 Getting Started
    Prerequisites
    Flutter SDK installed.
    Laravel Backend running locally (or hosted).

#### Installation
Clone the repository: clone [https://github.com/IBRHMHMDY/ahgzly_app.git](https://github.com/IBRHMHMDY/ahgzly_app.git)
Install dependencies: flutter pub get
Configure API Endpoint:Go to lib/core/api/end_points.dart.
Update ip variable with your local machine IP (for Android Emulator/Physical Device).
>> static const String ip = "192.168.1.X"; // Your IP here
Run the App: >>flutter run

### 🔗 Backend
This app connects to a Laravel API.
Authentication: Sanctum (Bearer Token).
Endpoints: /login, /register, /restaurants, /bookings, /mybookings ....

Developed with ❤️ by IbrahimHamdy