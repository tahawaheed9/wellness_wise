# 📱 Wellness Wise : Your AI Health Navigator

## 🧠 Overview

**Wellness Wise** is a Flutter-based mobile application designed to be a comprehensive guide and personal health assistant, empowering users on their journey toward improved well-being. Leveraging the power of **Artificial Intelligence (AI)**, this app analyzes user data to provide personalized health insights, predictions, and actionable recommendations.

## 🎯 Objectives

The primary goal of this project is to create a user-centric mobile solution that:

- Collects and processes user inputs such as **medical history**, **lifestyle habits**, and **real-time health data**
- Utilizes **advanced AI algorithms** to assess potential health risks
- Predicts possible health outcomes based on individual profiles
- Delivers **tailored strategies and recommendations** for improving wellness
- Encourages users to make **informed, proactive health decisions**
- Ultimately enhances overall **quality of life** through better health management

## 💻 Technologies Used

- **Flutter** – Cross-platform UI toolkit for building natively compiled mobile applications  
- **Dart** – Primary programming language for Flutter development  
- **Python** – Used for implementing AI models and backend logic  
- **Flask** – Lightweight Python web framework for creating RESTful APIs  
- **Firebase** – Cloud-based backend solution for real-time data storage and authentication  
- **Bloc (Flutter)** – State management solution ensuring a reactive and maintainable codebase

## 🚀 Key Features

- Intelligent data analysis using AI
- Personalized health tracking and predictions
- Dynamic wellness recommendations
- User-friendly Flutter interface for smooth navigation
- Support for integration with wearable devices (future scope)

## 📦 Installation
Use the following commands to run the application onto your local machine

1. **Clone the repository**
```bash
git clone https://github.com/tahawaheed9/wellness_wise.git
```

2. **Navigate to the project's directory**
```bash
cd wellness_wise
```

3. **Install Flutter Dependencies**
   - Make sure you have [Flutter](https://docs.flutter.dev/get-started/install) installed, then run:
```bash
flutter pub get
```

4. **Run the application**
   - Connect a device or start an emulator, then:
```bash
flutter run
```

- **Note:** You will not be able to make any predictions because, the AI Model is not embedded into the application. But communicates using RESTful API (**The AI Model is not entended to used publicly**).

## 🖼️ Screenshots

### Authentication Screen(s)
<div>
  <picture>
    <source srcset="assets/screenshots/register_screen.png" media="(max-width: 400px)">
    <img src="assets/screenshots/register_screen.png" width="300" alt="Logo">
  </picture>
  &nbsp;&nbsp;&nbsp;
  <picture>
    <source srcset="assets/screenshots/login_screen.png" media="(max-width: 400px)">
    <img src="assets/screenshots/login_screen.png" width="300" alt="Logo">
  </picture>
  &nbsp;&nbsp;&nbsp;
  <picture>
    <source srcset="assets/screenshots/reset_password_screen.png" media="(max-width: 400px)">
    <img src="assets/screenshots/reset_password_screen.png" width="300" alt="Logo">
  </picture>
</div>

### Home, Chart & History Screens
<div>
  <picture>
    <source srcset="assets/screenshots/home_page.png" media="(max-width: 400px)">
    <img src="assets/screenshots/home_page.png" width="300" alt="Logo">
  </picture>
  &nbsp;&nbsp;&nbsp;
  <picture>
    <source srcset="assets/screenshots/charts_screen.png" media="(max-width: 400px)">
    <img src="assets/screenshots/charts_screen.png" width="300" alt="Logo">
  </picture>
  &nbsp;&nbsp;&nbsp;
  <picture>
    <source srcset="assets/screenshots/history_screen.png" media="(max-width: 400px)">
    <img src="assets/screenshots/history_screen.png" width="300" alt="Logo">
  </picture>
</div>

### Disease Prediction Screen(s)
<div>
  <picture>
    <source srcset="assets/screenshots/heart_disease_screen.png" media="(max-width: 400px)">
    <img src="assets/screenshots/heart_disease_screen.png" width="300" alt="Logo">
  </picture>
  &nbsp;&nbsp;&nbsp;
  <picture>
    <source srcset="assets/screenshots/diabetes_prediction_screen.png" media="(max-width: 400px)">
    <img src="assets/screenshots/diabetes_prediction_screen.png" width="300" alt="Logo">
  </picture>
  &nbsp;&nbsp;&nbsp;
  <picture>
    <source srcset="assets/screenshots/lung_cancer_screen.png" media="(max-width: 400px)">
    <img src="assets/screenshots/lung_cancer_screen.png" width="300" alt="Logo">
  </picture>
</div>
