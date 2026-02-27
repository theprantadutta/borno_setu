<div align="center">

# বর্ণসেতু — BornoSetu

**A bridge between Bijoy and Unicode Bangla**

[![Flutter](https://img.shields.io/badge/Flutter-3.11+-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.11+-0175C2?logo=dart&logoColor=white)](https://dart.dev)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

BornoSetu is an offline Bangla typing utility that converts text between legacy Bijoy ANSI encoding and modern Unicode — instantly, accurately, and without an internet connection.

</div>

---

## Screenshots

<!-- Replace the placeholder images with actual screenshots -->

| Converter | History | Settings |
|:---------:|:-------:|:--------:|
| ![Converter](screenshots/converter.png) | ![History](screenshots/history.png) | ![Settings](screenshots/settings.png) |

| Light Theme | Dark Theme |
|:-----------:|:----------:|
| ![Light](screenshots/light_theme.png) | ![Dark](screenshots/dark_theme.png) |

---

## Features

- **Two-way conversion** — Bijoy → Unicode and Unicode → Bijoy
- **Conversion history** — Every conversion is saved locally for quick access later
- **Copy & paste** — One-tap copy to clipboard, paste from clipboard
- **Swap** — Instantly reverse input/output to convert the other way
- **Dark mode** — Light, Dark, and System theme options
- **Bilingual UI** — Full English and বাংলা interface
- **Fully offline** — No internet required, everything runs on-device
- **Fast & accurate** — Handles reph, pre-kars, conjuncts, nukta, and all the tricky parts of Bangla text encoding

---

## How It Works

The Bijoy-to-Unicode converter uses a **4-stage pipeline**:

1. **Pre-processing** — Fix common Bijoy encoding errors (doubled kars, hasanta issues)
2. **Character mapping** — Replace Bijoy ANSI characters with Unicode equivalents
3. **Reordering** — Fix reph (র্), pre-kar (ি, ে, ৈ), and nukta (ঁ) positions
4. **Post-processing** — Collapse artifacts, normalize vowel combinations (ো, ৌ)

The reverse direction (Unicode → Bijoy) mirrors these stages in opposite order.

---

## Tech Stack

| Layer | Technology |
|-------|-----------|
| Framework | Flutter (Material Design 3) |
| State Management | Riverpod |
| Navigation | go_router (StatefulShellRoute) |
| Database | Drift (SQLite) |
| Preferences | SharedPreferences |
| Localization | Flutter intl / ARB files |
| Architecture | Clean Architecture with feature modules |

---

## Project Structure

```
lib/
├── core/                     # Theme, constants, utilities
├── database/                 # Drift database, DAOs, tables
├── features/
│   ├── converter/            # Bijoy ↔ Unicode conversion
│   │   ├── domain/           # Converter logic & charset maps
│   │   └── presentation/     # Converter page & widgets
│   ├── history/              # Conversion history
│   │   ├── data/             # Repository implementation
│   │   ├── domain/           # Entities & repository interface
│   │   └── presentation/     # History page & widgets
│   └── settings/             # Theme, language, about, legal
│       └── presentation/     # Settings pages & widgets
├── l10n/                     # Localization (en, bn)
├── routing/                  # go_router configuration
└── main.dart
```

---

## Getting Started

### Prerequisites

- Flutter SDK **3.11+**
- Dart **3.11+**

### Install & Run

```bash
# Clone the repo
git clone https://github.com/user/borno_setu.git
cd borno_setu

# Get dependencies
flutter pub get

# Run code generation (Drift database, localizations)
dart run build_runner build --delete-conflicting-outputs

# Launch the app
flutter run
```

### Run Tests

```bash
flutter test
```

---

## License

This project is licensed under the MIT License — see the [LICENSE](LICENSE) file for details.
