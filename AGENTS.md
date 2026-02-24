# Canteiro AI

Flutter/Dart mobile application for AI-powered construction site layout optimization.

## Cursor Cloud specific instructions

### Project overview

- Pure Flutter/Dart project (no Node.js, no Docker).
- Uses OpenAI GPT-4 API via Dio HTTP client to generate optimized site layouts.
- Local SQLite database via `sqflite` for persistence.
- State management: `flutter_bloc`. Routing/DI: `flutter_modular`.
- Requires Dart SDK `>=3.1.3 <4.0.0`.

### Prerequisites

- **Flutter SDK** must be installed at `/opt/flutter` and on `PATH` (`export PATH="/opt/flutter/bin:$PATH"`).
- **Google Chrome** is required for Flutter web dev server (set `CHROME_EXECUTABLE=$(which google-chrome)`).
- System packages needed for Flutter Linux/web: `clang cmake ninja-build pkg-config libgtk-3-dev`.

### Common commands

| Task | Command |
|------|---------|
| Install deps | `flutter pub get` |
| Lint / analyze | `flutter analyze` |
| Run tests | `flutter test` |
| Run web dev server | `CHROME_EXECUTABLE=$(which google-chrome) flutter run -d web-server --web-port=8080 --web-hostname=0.0.0.0` |
| Run on Linux desktop | `flutter run -d linux` |

### Gotchas

- The `.env` file (containing `API_KEY` for OpenAI) must be listed under `assets:` in `pubspec.yaml` for `flutter_dotenv` to load it in web mode. This was added as a fix during setup.
- A root route redirect (`/` → `/home/`) was added in `lib/module/app_module.dart` because `flutter_modular` doesn't serve the home module at `/` by default.
- The default widget test (`test/widget_test.dart`) is a leftover counter app smoke test and does **not** match the actual app. It will fail — this is expected.
- `flutter analyze` reports 4 `info`-level deprecation warnings (e.g., `withOpacity`, `MaterialStateProperty`). These are non-blocking.
- The committed `API_KEY` in `.env` is likely revoked. A valid OpenAI API key is needed to use the AI layout generation feature.
