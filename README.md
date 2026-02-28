# 💸 AI Expense Tracker

![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?logo=dart&logoColor=white)
![Firebase](https://img.shields.io/badge/Firebase-Auth%20+%20Firestore-FFCA28?logo=firebase&logoColor=black)
![Status](https://img.shields.io/badge/Status-In%20Progress-orange)

A personal expense tracking app with AI-powered spending insights. Built with Flutter, Firebase, and the Gemini API. The goal is to make budgeting feel less like a chore — you log your expenses, the app crunches the numbers, and an AI assistant tells you what it all means.

---

## Screenshots

> Screenshots will be added once the UI is complete.

|  Onboarding   |     Login     |     Home      |   Analytics   |    AI Chat    |
| :-----------: | :-----------: | :-----------: | :-----------: | :-----------: |
| _coming soon_ | _coming soon_ | _coming soon_ | _coming soon_ | _coming soon_ |

---

## What's Built So Far

- **Onboarding screen** — entry point before auth
- **Firebase Authentication** — email/password sign-up + sign-in, Google OAuth
- **Firestore user persistence** — user profile (name, email, UID) saved on first sign-in
- **Clean Architecture structure** — domain, data, and presentation layers separated per feature
- **Custom theme** — Material 3 color scheme (`primary: #362670`, `secondary: #CFBEFF`, `background: #F6F5FA`) plus a custom `AppVisuals` theme extension with semantic colors for charts, income, expenses, and glow effects
- **App launcher icon** configured
- **Centralized routing** — `AppRoutes` constants, `RouteGenerator`, `NavigationHelper` wrappers
- **Dependency injection** — `get_it` with interface-based registration, initialized at startup
- **Structured logging** — `AppLogger` wrapping the `logger` package; debug/info suppressed in release builds
- **Typed error handling** — `Either<Failure, T>` via `dartz`; `AuthFailure`, `NetworkFailure`, `ServerFailure` subtypes

---

## Roadmap

- [ ] Expense entry form with categories (Food, Transport, Shopping, Bills, Entertainment)
- [ ] Home screen — monthly summary card and recent transactions
- [ ] Transactions list with date/category filters
- [ ] Analytics screen — pie chart (by category) and bar chart (monthly trend) using `fl_chart`
- [ ] AI Chat screen — conversational spending analysis powered by Google Gemini API

---

## Tech Stack

| Area                 | Tool                          |
| -------------------- | ----------------------------- |
| Framework            | Flutter + Dart                |
| State Management     | `flutter_bloc` (Cubit)        |
| Authentication       | Firebase Auth                 |
| Database             | Cloud Firestore               |
| Dependency Injection | `get_it`                      |
| Error Handling       | `dartz` (`Either`)            |
| Charts               | `fl_chart`                    |
| AI / LLM             | Google Generative AI (Gemini) |
| Logging              | `logger`                      |
| Equality             | `equatable`                   |

---

## Architecture

Clean Architecture with a feature-based folder structure. Each feature owns its domain, data, and presentation layers independently.

```
lib/
├── core/
│   ├── constants/
│   ├── di/                  # GetIt service locator setup
│   ├── errors/              # Failure types (Auth, Network, Server)
│   ├── routes/              # AppRoutes, RouteGenerator, NavigationHelper
│   ├── theme/               # ColorScheme + AppVisuals extension
│   ├── utils/               # AppLogger, SizeConfig
│   └── widgets/             # Shared reusable widgets
│
├── features/
│   ├── auth/
│   │   ├── domain/          # UserEntity, AuthRepo interface, AuthServices
│   │   ├── data/            # UserModel, AuthRemoteDataSource, AuthRepoImpl
│   │   └── presentation/    # AuthCubit, AuthState, LoginView
│   ├── expenses/            # (planned)
│   ├── analytics/           # (planned)
│   └── ai_chat/             # (planned)
│
└── main.dart
```

**State flow:** Cubit emits sealed state classes (`AuthInitial`, `AuthLoading`, `AuthSuccess`, `AuthError`). The UI consumes them with `BlocConsumer` — listener handles navigation and snackbars, builder handles rendering.

**Error flow:** Repository methods return `Either<Failure, T>`. The Cubit calls `.fold()` to branch between emitting an error state or a success state. No exceptions leak into the presentation layer.

---

## Getting Started

### Prerequisites

- Flutter SDK `^3.7.0`
- A Firebase project with **Email/Password + Google** sign-in methods enabled and **Firestore** provisioned
- For Android: SHA-1 fingerprint added in the Firebase console
- For iOS: `GoogleService-Info.plist` placed in `ios/Runner/`

### Setup

```bash
# 1. Clone
git clone <repository-url>
cd ai_expense_tracker

# 2. Install packages
flutter pub get

# 3. (Re)generate firebase_options.dart if needed
flutterfire configure

# 4. Run
flutter run
```

### Tests

```bash
flutter test
```

---

## Theme

The app uses a custom Material 3 color scheme alongside a `ThemeExtension` called `AppVisuals`:

| Token            | Value     | Used for                       |
| ---------------- | --------- | ------------------------------ |
| `primary`        | `#362670` | Buttons, active states         |
| `secondary`      | `#CFBEFF` | Secondary actions, backgrounds |
| `background`     | `#F6F5FA` | Screen backgrounds             |
| `chartPrimary`   | —         | Primary chart color            |
| `chartSecondary` | —         | Secondary chart color          |
| `incomeColor`    | —         | Income indicators              |
| `expenseColor`   | —         | Expense indicators             |
| `glow`           | —         | Decorative glow effects        |

---

## Contributing

- Keep new features inside `features/<feature_name>/` with `domain/`, `data/`, and `presentation/` subfolders.
- Register new dependencies in `dependency_injection_container.dart` using interfaces, not concrete classes.
- Use `AppLogger` — not `print()` — for all diagnostic output.
- Error paths should return `Left(Failure)`, not throw exceptions.
