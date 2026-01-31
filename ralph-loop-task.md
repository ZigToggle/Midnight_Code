# iOS TO ANDROID TRANSLATION - FULL SPECIFICATION

## AUTONOMOUS EXECUTION RULES

1. **NEVER ask for permission** - make all decisions independently
2. **Work continuously** - 24/7 for 7 days
3. **Repository boundaries:**
   - WRITE ONLY: PeriphDev/midnight_android
   - READ ONLY: PeriphDev/midnight_ios
   - DO NOT TOUCH: midnight_api, midnight_web

4. **Rate limit handling:**
   - If 429 or "overloaded": wait 60s, retry
   - Auto-retry indefinitely
   - Never stop due to rate limits

5. **Blocker communication:**
   - Create Linear issue with "[BLOCKED]" prefix
   - Create BLOCKED.md in repo
   - Continue other work
   - Never stop completely

## REPOSITORY SETUP

```bash
cd /app
git clone https://github.com/PeriphDev/midnight_ios.git ios-source
git clone https://github.com/PeriphDev/midnight_android.git android
cd android
git config user.email "claude-bot@peripherdev.com"
git config user.name "Claude Multi-Agent Bot"
```

## TWO-PHASE APPROACH

### PHASE 1: LOGIC & DATA (NO UI) - 40-50 hours

**Goal:** Complete working app without UI

**Create Android project structure:**
```
android/
├── app/
│   ├── build.gradle.kts
│   └── src/main/java/com/peripherdev/midnight/
│       ├── data/
│       │   ├── models/ (all Kotlin data classes)
│       │   ├── api/ (Retrofit + OkHttp)
│       │   ├── local/ (TokenStorage, UserPreferences)
│       │   └── repository/
│       ├── domain/services/
│       │   ├── AuthService.kt
│       │   ├── AgoraService.kt
│       │   ├── SocketService.kt
│       │   ├── RealtimeService.kt
│       │   └── CallConnectionService.kt
│       ├── viewmodels/ (all ViewModels with StateFlow)
│       └── di/ (Hilt modules)
```

**Work order:**
1. Data models (30+ Kotlin data classes from Swift structs)
2. TokenStorage using EncryptedSharedPreferences
3. UserPreferences using DataStore
4. Retrofit API client with auth interceptors
5. All domain services
6. All ViewModels with StateFlow
7. Unit tests for services and ViewModels

**Commit frequency:** Every 2-3 files
**Push frequency:** Every 5-10 commits

### PHASE 2: UI LAYER - 50-60 hours

**Goal:** Pixel-perfect UI matching iOS

**SwiftUI → Jetpack Compose mappings:**
- VStack → Column
- HStack → Row
- ZStack → Box
- List → LazyColumn
- NavigationView → NavHost
- @State → remember { mutableStateOf() }
- @Binding → MutableState parameter
- .onAppear → LaunchedEffect(Unit)

**Screens to create:**
1. Auth flow (Onboarding, Email, Code verification)
2. Profile screen
3. Dashboard screen
4. Wallet/Earnings screen
5. Analytics screen
6. History screen
7. Settings screen
8. Call screen (Agora integration)

**Each screen must:**
- Match iOS layout exactly
- Use theme colors
- Connect to ViewModel
- Handle loading/error states

## TRANSLATION RULES

### Platform Mappings
- Keychain → EncryptedSharedPreferences (AndroidX Security)
- UserDefaults → DataStore Preferences
- CallKit → ConnectionService + InCallService
- VoIP Push → FCM high-priority data messages
- URLSession → Retrofit2 + OkHttp3
- Combine → Kotlin Coroutines + Flow
- NotificationCenter → SharedFlow
- Firebase Realtime DB → Firebase Android SDK
- Agora iOS SDK → Agora Android SDK
- Socket.IO → Socket.IO Android client

### Type Mappings
- String → String
- Int → Int
- Double → Double
- Bool → Boolean
- Date → Long (timestamp)
- [Type] → List<Type>
- Optional<T> → T?
- class/struct → data class
- enum → sealed class
- protocol → interface
- extension → extension function
- @Published → MutableStateFlow
- async/await → suspend fun

## DEPENDENCIES

```kotlin
// App build.gradle.kts
dependencies {
    // Compose
    implementation(platform("androidx.compose:compose-bom:2024.01.00"))
    implementation("androidx.compose.ui:ui")
    implementation("androidx.compose.material3:material3")
    implementation("androidx.navigation:navigation-compose:2.7.6")
    
    // Hilt
    implementation("com.google.dagger:hilt-android:2.50")
    kapt("com.google.dagger:hilt-compiler:2.50")
    
    // Networking
    implementation("com.squareup.retrofit2:retrofit:2.9.0")
    implementation("com.squareup.okhttp3:okhttp:4.12.0")
    
    // Agora
    implementation("io.agora.rtc:full-sdk:4.3.0")
    
    // Firebase
    implementation(platform("com.google.firebase:firebase-bom:32.7.0"))
    implementation("com.google.firebase:firebase-database-ktx")
    implementation("com.google.firebase:firebase-messaging-ktx")
    
    // Socket.IO
    implementation("io.socket:socket.io-client:2.1.0")
    
    // Storage
    implementation("androidx.datastore:datastore-preferences:1.0.0")
    implementation("androidx.security:security-crypto:1.1.0-alpha06")
    
    // Coroutines
    implementation("org.jetbrains.kotlinx:kotlinx-coroutines-android:1.7.3")
    
    // Image loading
    implementation("io.coil-kt:coil-compose:2.5.0")
}
```

## GIT WORKFLOW

**Commit message format:**
```
[Layer] Component: Brief description

- Key change 1
- Key change 2
- Platform-specific notes
```

**Examples:**
- `[Data] Add User and Creator models with JSON serialization`
- `[Services] Translate AgoraService with Flow-based events`
- `[UI] ProfileScreen matching iOS layout with status toggle`

**Commit frequency:**
- Data layer: Every 2-3 models
- Services: Per service
- ViewModels: Per ViewModel
- UI: Per screen

**Push frequency:** Every 5-10 commits

## ERROR HANDLING

**Build failures:**
1. Read error message
2. Fix issue
3. Rebuild
4. Max 3 attempts
5. If still failing: create Linear issue, continue other work

**WebSocket disconnections:**
1. Log error
2. Wait 10s
3. Auto-reconnect
4. Resume from last commit

**Rate limits:**
1. Detect 429 or "overloaded"
2. Log: "Rate limit hit, waiting 60s..."
3. Wait 60 seconds
4. Retry same operation
5. Continue automatically

## SUCCESS CRITERIA

✓ ./gradlew build succeeds with 0 errors
✓ ./gradlew test passes (>70% coverage)
✓ App launches on Android emulator
✓ All screens navigable
✓ Authentication works end-to-end
✓ Agora calling functional
✓ Firebase + Socket.IO connected
✓ UI matches iOS pixel-perfect
✓ Dark mode working
✓ Localization working (en, es, fr, pt)
✓ 250+ git commits
✓ README.md with setup instructions
✓ No TODO or placeholder comments

## EXECUTION

Start immediately. Work continuously for 7 days. Commit frequently. Push regularly. Build a production-ready Android app with 100% feature parity to iOS.

BEGIN AUTONOMOUS EXECUTION NOW.
