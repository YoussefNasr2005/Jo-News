<div align="center">

# 📰 Jo News

### A clean, lightweight news application built with Flutter

[![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![Dio](https://img.shields.io/badge/Dio-HTTP%20Client-blue?style=for-the-badge)](https://pub.dev/packages/dio)
[![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)](#-license)

*Stay informed, instantly — built with simplicity, speed, and the user in mind.*

</div>

---

## 📖 Table of Contents

- [Overview](#-overview)
- [Features](#-features)
- [Screenshots](#-screenshots)
- [Tech Stack](#-tech-stack)
- [Project Structure](#-project-structure)
- [Getting Started](#-getting-started)
- [Localization](#-localization)
- [Key Learnings](#-key-learnings)
- [Roadmap](#-roadmap)
- [Author](#-author)
- [License](#-license)

---

## 🔍 Overview

**Jo News** is a mobile application that allows users to stay updated with the latest news in real time. It is the developer's first real-world project working with external APIs, and represents an important milestone in their journey as a Flutter developer.

The app was designed with a **user-first mindset**, focusing on:

- ⚡ **Simplicity & Speed** — minimal friction, fast access to information
- ⭐ **Personalization** — keyword-based filtering tailored to user interests
- 🧭 **Clean Navigation** — an intuitive, distraction-free interface

The app was built by thinking as both a **developer** and an **end user**, optimizing for how someone would actually use it for their daily news routine.

---

## 🚀 Features

| Feature | Description |
|---|---|
| 🌐 Live News Feed | Fetches the latest news in real time using a REST API via Dio |
| 🔎 Keyword Search | Search for news articles by custom keywords |
| ⭐ Saved Preferences | Store favorite keywords for quick, personalized access |
| 💾 Local Storage | Persist user settings using `SharedPreferences` |
| 🌍 Multi-language | Full Arabic & English support via `EasyLocalization` |
| ⚡ Performance | Lightweight architecture for a fast, smooth experience |

---

## 📸 Screenshots

<div align="center">
<img src="https://raw.githubusercontent.com/YoussefNasr2005/Jo-News/main/assets/images/1.jpg" width="200"/>
<img src="https://raw.githubusercontent.com/YoussefNasr2005/Jo-News/main/assets/images/2.jpg" width="200"/>
<img src="https://raw.githubusercontent.com/YoussefNasr2005/Jo-News/main/assets/images/3.jpg" width="200"/>
<img src="https://raw.githubusercontent.com/YoussefNasr2005/Jo-News/main/assets/images/4.jpg" width="200"/>
</div>

---

## 🛠️ Tech Stack

- **Framework:** Flutter
- **Language:** Dart
- **Networking:** Dio (REST API client)
- **Local Storage:** SharedPreferences
- **Localization:** EasyLocalization (English / Arabic)

---

## 📂 Project Structure

```
lib/
├── core/                 # Shared utilities, constants, and base configuration
├── features/
│   ├── screens/          # App screens / pages
│   ├── widgets/          # Reusable UI components
│   └── services/         # API and data services
└── main.dart             # App entry point
```

---

## 🏁 Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) installed
- A code editor (VS Code / Android Studio)

### Installation

```bash
# Clone the repository
git clone https://github.com/YoussefNasr2005/Jo-News.git

# Navigate to the project directory
cd Jo-News

# Install dependencies
flutter pub get

# Run the app
flutter run
```

---

## 🌍 Localization

| Language | Status |
|---|---|
| 🇺🇸 English | ✅ Fully supported |
| 🇪🇬 Arabic | ✅ Fully supported |

> ⚠️ **Note:** The news API supports Arabic only in the **search functionality**, not in the main feed.

---

## 🧠 Key Learnings

This project marked several "firsts" in the developer's journey:

- First hands-on experience consuming and handling REST APIs in Flutter
- Parsing and managing JSON responses
- Implementing local data persistence with `SharedPreferences`
- Building a fully localized app supporting RTL (Arabic) and LTR (English)
- Designing with real user experience (UX) as the top priority

---

## 📌 Roadmap

- [ ] Add a categories system (e.g., Sports, Tech, Business)
- [ ] Migrate state management to **Bloc / Cubit**
- [ ] Implement offline caching for previously loaded articles
- [ ] Add Dark Mode support
- [ ] Enable push notifications for breaking news

---

## 👨‍💻 Author

**Youssef Nasr**
Flutter Developer passionate about building clean, scalable mobile applications.

[![GitHub](https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white)](https://github.com/YoussefNasr2005)

---

## ⭐ Status

This project marks the **beginning of a journey** into mobile development. More features and improvements are coming continuously 🚀

If you find this project useful or interesting, consider giving it a ⭐ on GitHub!

---

## 📄 License

This project is licensed under the [MIT License](LICENSE).
