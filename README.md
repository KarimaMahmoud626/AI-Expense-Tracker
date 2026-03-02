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

### Infrastructure

- **Clean Architecture** — domain, data, and presentation layers separated per feature
- **Dependency injection** — `get_it` with interface-based registration, initialized at app startup
- **Centralized routing** — `AppRoutes` constants, `RouteGenerator`, `NavigationHelper` wrappers
- **Structured logging** — `AppLogger` wrapping the `logger` package; debug/info suppressed in release builds
- **Typed error handling** — `Either<Failure, T>` via `dartz`; `AuthFailure`, `NetworkFailure`, `ServerFailure` subtypes
- **Custom theme** — Material 3 color scheme (`primary: #362670`, `secondary: #CFBEFF`, `background: #F6F5FA`) with a `AppVisuals` theme extension covering chart, income, expense, and glow tokens
- **App launcher icon** configured

### Authentication

- **Onboarding screen** — entry point shown before auth
- **Firebase Auth** — email/password sign-up + sign-in, Google OAuth
- **Firestore user persistence** — profile (name, email, UID) written on first sign-in
- Error messages are user-friendly and typed: weak password, wrong credentials, canceled sign-in, network errors

### Navigation Shell _(new)_

- **`NavigationShell`** — a persistent bottom navigation bar wrapping the four main app screens
- Powered by `persistent_bottom_nav_bar` with `NavBarStyle.style14`
- Tabs: **Home**, **Transactions**, **Reports**, **AI Chat**
- State is preserved across tab switches (`stateManagement: true`)
- Nav bar hides when the keyboard appears; Android back button is handled; pop-to-root on re-tap of active tab
- The AI Chat tab icon uses a Font Awesome robot icon via `font_awesome_icon_class`
- After a successful sign-in, the app navigates to `/main` which renders the `NavigationShell`

### Feature Views (scaffolded, UI pending)

- **`HomeView`** — monthly summary screen placeholder
- **`TransactionsView`** — transactions list screen placeholder
- **`ReportsView`** — analytics/reports screen placeholder
- **`AiChatView`** — AI chat screen placeholder

### Shared Widgets

- `CustomGenralButton` — full-width primary button with loading state
- `CustomLoginWithButton` — OAuth-style button with icon + label
- `CustomTextField` — themed input with prefix/suffix icon support
- `CustomIconButton` _(new)_ — stateful toggle button that swaps between two icons on tap
- `CustomLine`, `VerticalSpace`, `HorizontalSpace`, `RoundedRectangleImageContainer`

---

## Roadmap

- [ ] Home screen — monthly summary card and recent transactions list
- [ ] Expense entry form with categories (Food, Transport, Shopping, Bills, Entertainment)
- [ ] Transactions list with date/category filters
- [ ] Reports screen — pie chart by category + bar chart by month using `fl_chart`
- [ ] AI Chat — conversational spending analysis powered by Google Gemini API

---

## User Flow

```
App Launch
    │
    ▼
Onboarding  ──[Get Started]──►  Login / Sign-Up
                                      │
                    ┌─────────────────┼─────────────────┐
                    ▼                 ▼                  ▼
             Email + Password    Email (existing)  Google Sign-In
             (create account)   (auto sign-in)
                    │                 │                  │
                    └─────────────────┴──────────────────┘
                                      │
                                 Auth Success
                                      │
                                      ▼
                            NavigationShell (/main)
                      ┌───────┬────────────┬────────┐
                      ▼       ▼            ▼        ▼
                    Home  Transactions  Reports  AI Chat
```

---

## Tech Stack

| Area                 | Tool                                      |
| -------------------- | ----------------------------------------- |
| Framework            | Flutter + Dart                            |
| State Management     | `flutter_bloc` (Cubit)                    |
| Authentication       | Firebase Auth                             |
| Database             | Cloud Firestore                           |
| Dependency Injection | `get_it`                                  |
| Error Handling       | `dartz` (`Either`)                        |
| Bottom Navigation    | `persistent_bottom_nav_bar`               |
| Icons                | `font_awesome_icon_class`                 |
| Charts               | `fl_chart` _(planned)_                    |
| AI / LLM             | Google Generative AI / Gemini _(planned)_ |
| Logging              | `logger`                                  |
| Equality             | `equatable`                               |

---

## Architecture

Clean Architecture with a feature-based folder structure. Each feature owns its domain, data, and presentation layers.

```
lib/
├── core/
│   ├── di/                  # GetIt service locator setup
│   ├── errors/              # Failure, AuthFailure, NetworkFailure, ServerFailure
│   ├── navigation/          # NavigationShell (persistent bottom nav)
│   ├── routes/              # AppRoutes, RouteGenerator, NavigationHelper
│   ├── theme/               # ColorScheme + AppVisuals ThemeExtension
│   ├── utils/               # AppLogger, SizeConfig, NavigationHelper
│   └── widgets/             # Shared reusable widgets
│
├── features/
│   ├── auth/
│   │   ├── domain/          # UserEntity, AuthRepo interface, AuthServices
│   │   ├── data/            # UserModel, AuthRemoteDataSource, AuthRepoImpl
│   │   └── presentation/    # AuthCubit, AuthState, LoginView
│   ├── home/
│   │   └── presentation/    # HomeView (placeholder)
│   ├── transactions/
│   │   └── presentation/    # TransactionsView (placeholder)
│   ├── analytics/
│   │   └── presentation/    # ReportsView (placeholder)
│   └── ai_caht/             # note: folder name has a typo, to be renamed
│       └── presentation/    # AiChatView (placeholder)
│
└── main.dart
```

**State flow:** Cubit emits sealed state classes (`AuthInitial`, `AuthLoading`, `AuthSuccess`, `AuthError`). The UI uses `BlocConsumer` — the listener drives navigation and snackbars, the builder handles widget rendering.

**Error flow:** Repository methods return `Either<Failure, T>`. The Cubit calls `.fold()` to branch into an error or success state. No exceptions propagate into the presentation layer.

**Navigation flow:** Pre-auth screens (`/`, `/login`) are standalone routes managed by `RouteGenerator`. After successful auth, the app replaces the stack with `/main`, which renders `NavigationShell`. The four tabs inside the shell are managed by `PersistentTabController`.

---

## Getting Started

### Prerequisites

- Flutter SDK `^3.7.0`
- A Firebase project with **Email/Password + Google** sign-in enabled and **Firestore** provisioned
- For Android: SHA-1 fingerprint registered in the Firebase console
- For iOS: `GoogleService-Info.plist` placed in `ios/Runner/`

### Setup

```bash
# 1. Clone
git clone <repository-url>
cd ai_expense_tracker

# 2. Install packages
flutter pub get

# 3. (Re)generate firebase_options.dart if your Firebase config changes
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

| Token            | Value     | Used for                       |
| ---------------- | --------- | ------------------------------ |
| `primary`        | `#362670` | Buttons, active nav items      |
| `secondary`      | `#CFBEFF` | Secondary actions, backgrounds |
| `background`     | `#F6F5FA` | Screen backgrounds             |
| `chartPrimary`   | —         | Primary chart series           |
| `chartSecondary` | —         | Secondary chart series         |
| `incomeColor`    | —         | Income indicators              |
| `expenseColor`   | —         | Expense indicators             |
| `glow`           | —         | Decorative glow effects        |

---

## Contributing

- New features go in `features/<feature_name>/` with `domain/`, `data/`, and `presentation/` subfolders.
- Register dependencies in `dependency_injection_container.dart` against interfaces, not concrete types.
- Use `AppLogger` — not `print()` — for all diagnostic output.
- Error paths should return `Left(Failure)`, not throw exceptions.
- The `ai_caht` folder name is a known typo and should be corrected to `ai_chat` before merging any work in that feature.
