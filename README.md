Names & IDs: Mohamed Ayman Yakout 2305104
             Ahmed Sameh Ragab    2305122
             Amr Adel Antar       2305115
Project Overview

Laza is a simplified e-commerce mobile application built using Flutter as a single codebase for both Android and iOS platforms.
The project is developed as an MVP (Minimum Viable Product) based on the Laza UI Kit, focusing on core e-commerce functionalities.

Main Features

User authentication using Firebase Authentication

Product listing and product details using Platzi Fake Store API

Add/remove products to cart

Add/remove products to favorites

Mock checkout flow

Persist user cart and favorites using Firebase Firestore

How to Install Flutter & Project Dependencies
1. Install Flutter

Download Flutter SDK from:
https://flutter.dev/docs/get-started/install

Extract the SDK and add Flutter to your system PATH

Verify installation:

flutter doctor

2. Install Project Dependencies

Clone the repository:

git clone <repository-url>
cd <project-folder>


Install Flutter packages:

flutter pub get

Firebase Setup Steps
1. Create Firebase Project

Go to: https://console.firebase.google.com

Click Add project

Disable Google Analytics (optional)

Create the project

2. Add Android App

Select Add Android App

Use the applicationId from:

android/app/build.gradle.kts


Example:

com.example.laza_app


Download google-services.json

Place it in:

android/app/google-services.json

3. Enable Authentication

In Firebase Console:

Go to Build → Authentication

Click Get Started

Enable Email/Password

Save changes

4. Firebase Dependencies (Flutter)

Ensure the following dependencies exist in pubspec.yaml:

dependencies:
  firebase_core: ^2.30.0
  firebase_auth: ^4.19.0
  cloud_firestore: ^4.17.0


Run:

flutter pub get

Firestore Rules Installation

Create a file named firestore.rules with the following content:

rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {

    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }

    match /carts/{userId}/items/{itemId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }

    match /favorites/{userId}/items/{itemId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
  }
}


Go to Firestore Database → Rules

Replace existing rules with the above

Click Publish

How to Run Android & iOS Builds
Run on Android

Start an Android emulator or connect a physical device

flutter run


To build APK:

flutter build apk

Run on iOS (macOS only)

Install Xcode

Open iOS Simulator

flutter run


To build iOS app:
flutter build ios

firestore.rules:
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // للتنمية فقط - تسمح للجميع بالقراءة والكتابة
    match /{document=**} {
      allow read, write: if true;
    }
    
    // أو قواعد أكثر أماناً:
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
    match /orders/{orderId} {
      allow read, write: if request.auth != null;
    }
  }
}

firebase setup guide:
# Firebase Setup Guide

This document explains how to configure Firebase for the Laza Flutter mobile application.

---

## 1. Create a Firebase Project
1. Go to https://console.firebase.google.com
2. Click **Add project**
3. Enter a project name (e.g., Laza Mobile App)
4. Disable Google Analytics (optional)
5. Create the project

---

## 2. Add Android Application
1. From the Firebase project dashboard, click **Add app** → **Android**
2. Use the applicationId from:
android/app/build.gradle.kts

makefile
Copy code
Example:
com.example.laza_app

markdown
Copy code
3. Register the app
4. Download the `google-services.json` file
5. Place the file in:
android/app/google-services.json

yaml
Copy code

---

## 3. Enable Firebase Authentication
1. In Firebase Console, go to **Build → Authentication**
2. Click **Get Started**
3. Enable **Email/Password** authentication
4. Save changes

---

## 4. Enable Cloud Firestore
1. Go to **Build → Firestore Database**
2. Click **Create database**
3. Start in **test mode**
4. Select a database location

---

## 5. Configure Firebase in Flutter
1. Open `pubspec.yaml`
2. Ensure the following dependencies are added:
```yaml
dependencies:
  firebase_core: ^2.30.0
  firebase_auth: ^4.19.0
  cloud_firestore: ^4.17.0
Run:

bash
Copy code
flutter pub get
6. Run the Application
bash
Copy code
flutter run


flutter build ios
# Mobile-Programming-Project
