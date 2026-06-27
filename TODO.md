# TODO

## Goal: Fix app stuck on Flutter logo

### Info gathered
- `lib/main.dart` loads `.env` and then awaits `supabaseService.initialize()` before calling `runApp()`.
- `supabase_service.dart` `initialize()` calls `Supabase.initialize(...)` and can throw/hang if credentials/network are wrong.
- `home_page.dart` is a normal UI and would render if `runApp()` is reached.

### Plan
1. Add `try/catch` around Supabase initialization in `lib/main.dart` so UI always renders even if Supabase fails.
2. (Optional) Add debug prints before/after Supabase init to confirm where it stalls.
3. Rebuild and run Android debug APK again.
4. If still stuck, check `.env` presence on device and validate SUPABASE_URL / SUPABASE_ANON_KEY.

### Dependent files
- `lib/main.dart`
- (for reference) `lib/services/supabase_service.dart`

### Followup steps
- `flutter run` / `flutter build apk --debug` and watch console for the new log lines.

