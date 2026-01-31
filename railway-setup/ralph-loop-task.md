🚀 Enhanced Ralph Loop Task - Multi-Agent iOS to Android Translation                                                                                               
                                                                                                                                                                     
  iOS TO ANDROID TRANSLATION - MULTI-AGENT AUTONOMOUS EXECUTION                                                                                                      
                                                                                                                                                                     
  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━                                                                                                      
  CRITICAL RULES - READ FIRST                                                                                                                                        
  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━                                                                                                      
                                                                                                                                                                     
  1. AUTONOMOUS MODE: Never ask for permission. Make all decisions independently.                                                                                    
                                                                                                                                                                     
  2. REPOSITORY BOUNDARIES:                                                                                                                                          
     - READ ONLY: PeriphDev/midnight_ios (source code reference)                                                                                                     
     - WRITE ONLY: PeriphDev/midnight_android (all commits go here)                                                                                                  
     - DO NOT TOUCH: PeriphDev/midnight_api, midnight_web (ignore completely)                                                                                        
                                                                                                                                                                     
  3. MULTI-AGENT PARALLEL EXECUTION:                                                                                                                                 
     - Spawn multiple Claude Code agents working simultaneously                                                                                                      
     - Agent 1: Data layer (models, storage, API client)                                                                                                             
     - Agent 2: Services layer (Auth, Agora, Socket, Realtime)                                                                                                       
     - Agent 3: ViewModels layer (all ViewModels)                                                                                                                    
     - Agent 4: Navigation & Infrastructure                                                                                                                          
     - Agents coordinate via git commits to avoid conflicts                                                                                                          
                                                                                                                                                                     
  4. RATE LIMIT HANDLING:                                                                                                                                            
     - If API rate limit hit (429 error or "overloaded" message):                                                                                                    
       → Wait 60 seconds                                                                                                                                             
       → Retry the same operation                                                                                                                                    
       → Log: "Rate limit hit, waiting 60s..."                                                                                                                       
       → Continue automatically after wait                                                                                                                           
     - Never stop work due to rate limits, always auto-retry                                                                                                         
                                                                                                                                                                     
  5. TWO-PHASE EXECUTION:                                                                                                                                            
     PHASE 1: Logic & Data (No UI) - ~40% of work                                                                                                                    
     PHASE 2: UI Layer (Jetpack Compose) - ~60% of work                                                                                                              
                                                                                                                                                                     
  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━                                                                                                      
  SETUP - REPOSITORY CLONING                                                                                                                                         
  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━                                                                                                      
                                                                                                                                                                     
  Step 1: Clone iOS source (READ ONLY)                                                                                                                               
  ```bash                                                                                                                                                            
  cd /app                                                                                                                                                            
  git clone https://github.com/PeriphDev/midnight_ios.git ios-source                                                                                                 
  cd ios-source                                                                                                                                                      
  echo "iOS repo cloned at: $(pwd)"                                                                                                                                  
  echo "Total Swift files: $(find . -name "*.swift" | wc -l)"                                                                                                        
                                                                                                                                                                     
  Step 2: Clone Android target (WRITE ONLY)                                                                                                                          
  cd /app                                                                                                                                                            
  git clone https://github.com/PeriphDev/midnight_android.git android                                                                                                
  cd android                                                                                                                                                         
  git config user.email "claude-bot@peripherdev.com"                                                                                                                 
  git config user.name "Claude Multi-Agent Bot"                                                                                                                      
  echo "Android repo ready at: $(pwd)"                                                                                                                               
                                                                                                                                                                     
  Step 3: Analyze iOS structure                                                                                                                                      
  cd /app/ios-source                                                                                                                                                 
  find . -name "*.swift" -type f | grep -E "(ViewModel|Service|Model|View)" | sort                                                                                   
                                                                                                                                                                     
  Create translation matrix in memory:                                                                                                                               
  - Count ViewModels: X files                                                                                                                                        
  - Count Services: Y files                                                                                                                                          
  - Count Models: Z files                                                                                                                                            
  - Count Views: W files                                                                                                                                             
  Total files to translate: X+Y+Z+W                                                                                                                                  
                                                                                                                                                                     
  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━                                                                                                      
  PHASE 1: LOGIC & DATA LAYER (NO UI)                                                                                                                                
  Target: 40-50 hours | ~60% of codebase                                                                                                                             
  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━                                                                                                      
                                                                                                                                                                     
  PARALLEL WORKSTREAM ALLOCATION:                                                                                                                                    
                                                                                                                                                                     
  ┌─────────────────────────────────────────────────────────┐                                                                                                        
  │ AGENT 1: Data Layer (12-15 hours)                      │                                                                                                         
  ├─────────────────────────────────────────────────────────┤                                                                                                        
  │ Working directory: /app/android/app/src/main/java/      │                                                                                                        
  │                    com/peripherdev/midnight/data/       │                                                                                                        
  │                                                         │                                                                                                        
  │ Tasks:                                                  │                                                                                                        
  │ 1. Create all data models from iOS models:             │                                                                                                         
  │    - User.kt, Creator.kt, Call.kt, Token.kt, etc.     │                                                                                                          
  │    - Use Kotlin data classes                           │                                                                                                         
  │    - Add @SerializedName annotations                   │                                                                                                         
  │                                                         │                                                                                                        
  │ 2. Implement TokenStorage.kt:                          │                                                                                                         
  │    - Use EncryptedSharedPreferences                    │                                                                                                         
  │    - Methods: saveToken, getAccessToken, clear         │                                                                                                         
  │                                                         │                                                                                                        
  │ 3. Implement UserPreferences.kt:                       │                                                                                                         
  │    - Use DataStore Preferences                         │                                                                                                         
  │    - Methods: saveUserId, getUserId, clearAll          │                                                                                                         
  │                                                         │                                                                                                        
  │ 4. Create API Client (Retrofit):                       │                                                                                                         
  │    - ApiClient.kt with Retrofit + OkHttp               │                                                                                                         
  │    - AuthInterceptor.kt (adds tokens)                  │                                                                                                         
  │    - TokenRefreshAuthenticator.kt (handles 401)        │                                                                                                         
  │                                                         │                                                                                                        
  │ 5. Define all API service interfaces:                  │                                                                                                         
  │    - AuthApi.kt, CreatorApi.kt, CallApi.kt            │                                                                                                          
  │                                                         │                                                                                                        
  │ 6. Create Repository pattern:                          │                                                                                                         
  │    - AuthRepository.kt, CreatorRepository.kt           │                                                                                                         
  │                                                         │                                                                                                        
  │ Git commits: One commit per major component            │                                                                                                         
  │ Push frequency: Every 5 commits                        │                                                                                                         
  └─────────────────────────────────────────────────────────┘                                                                                                        
                                                                                                                                                                     
  ┌─────────────────────────────────────────────────────────┐                                                                                                        
  │ AGENT 2: Services Layer (16-20 hours)                  │                                                                                                         
  ├─────────────────────────────────────────────────────────┤                                                                                                        
  │ Working directory: /app/android/app/src/main/java/      │                                                                                                        
  │                    com/peripherdev/midnight/domain/     │                                                                                                        
  │                                                         │                                                                                                        
  │ Tasks:                                                  │                                                                                                        
  │ 1. Translate AuthService.swift → AuthService.kt        │                                                                                                         
  │    - Authentication logic                              │                                                                                                         
  │    - Token management                                  │                                                                                                         
  │    - Session handling                                  │                                                                                                         
  │                                                         │                                                                                                        
  │ 2. Translate AgoraService.swift → AgoraService.kt      │                                                                                                         
  │    - Agora RTC SDK integration                         │                                                                                                         
  │    - Video/audio channel management                    │                                                                                                         
  │    - Event handling via SharedFlow                     │                                                                                                         
  │                                                         │                                                                                                        
  │ 3. Translate SocketService.swift → SocketService.kt    │                                                                                                         
  │    - Socket.IO Android client                          │                                                                                                         
  │    - Real-time event handling                          │                                                                                                         
  │                                                         │                                                                                                        
  │ 4. Translate RealtimeService.swift → RealtimeService.kt│                                                                                                         
  │    - Firebase Realtime Database                        │                                                                                                         
  │    - Call signaling coordination                       │                                                                                                         
  │                                                         │                                                                                                        
  │ 5. Implement CallConnectionService.kt                  │                                                                                                         
  │    - Android ConnectionService for native calls        │                                                                                                         
  │    - Replace iOS CallKit functionality                 │                                                                                                         
  │                                                         │                                                                                                        
  │ 6. Implement FCM notification handling                 │                                                                                                         
  │    - Replace iOS VoIP Push                             │                                                                                                         
  │                                                         │                                                                                                        
  │ Git commits: One commit per service                    │                                                                                                         
  │ Push frequency: Every 3-4 commits                      │                                                                                                         
  └─────────────────────────────────────────────────────────┘                                                                                                        
                                                                                                                                                                     
  ┌─────────────────────────────────────────────────────────┐                                                                                                        
  │ AGENT 3: ViewModels Layer (12-16 hours)                │                                                                                                         
  ├─────────────────────────────────────────────────────────┤                                                                                                        
  │ Working directory: /app/android/app/src/main/java/      │                                                                                                        
  │                    com/peripherdev/midnight/viewmodels/ │                                                                                                        
  │                                                         │                                                                                                        
  │ Tasks:                                                  │                                                                                                        
  │ For each iOS ViewModel, create Android equivalent:     │                                                                                                         
  │                                                         │                                                                                                        
  │ 1. ProfileViewModel.kt                                 │                                                                                                         
  │    - UiState: ProfileUiState data class                │                                                                                                         
  │    - StateFlow for reactive state                      │                                                                                                         
  │    - Inject AuthService, ApiClient via Hilt            │                                                                                                         
  │                                                         │                                                                                                        
  │ 2. DashboardViewModel.kt                               │                                                                                                         
  │ 3. WalletViewModel.kt                                  │                                                                                                         
  │ 4. AnalyticsViewModel.kt                               │                                                                                                         
  │ 5. HistoryViewModel.kt                                 │                                                                                                         
  │ 6. SettingsViewModel.kt                                │                                                                                                         
  │ 7. OnboardingViewModel.kt                              │                                                                                                         
  │ 8. CallViewModel.kt                                    │                                                                                                         
  │                                                         │                                                                                                        
  │ Pattern for all ViewModels:                            │                                                                                                         
  │ kotlin                                              │ │ @HiltViewModel                                         │ │ class XViewModel @Inject constructor(         
           │ │     private val service: XService                      │ │ ) : ViewModel() {                                      │ │     private val _uiState =      
  MutableStateFlow(XUiState())│ │     val uiState: StateFlow<XUiState> = _uiState        │ │                                                         │ │     fun     
  loadData() {                                   │ │         viewModelScope.launch {                        │ │             _uiState.update { it.copy(isLoading=true)
   }│ │             // Business logic                          │ │         }                                              │ │     }                                  
                  │ │ }                                                      │ │                                                         │ │ data class XUiState(    
                                 │ │     val isLoading: Boolean = false,                    │ │     val data: X? = null,                               │ │     val   
  error: String? = null                          │ │ )                                                      │ │                                                     │
  │                                                         │                                                                                                        
  │ Git commits: One commit per ViewModel                  │                                                                                                         
  │ Push frequency: Every 3 ViewModels                     │                                                                                                         
  └─────────────────────────────────────────────────────────┘                                                                                                        
                                                                                                                                                                     
  ┌─────────────────────────────────────────────────────────┐                                                                                                        
  │ AGENT 4: Infrastructure & Config (8-10 hours)          │                                                                                                         
  ├─────────────────────────────────────────────────────────┤                                                                                                        
  │ Working directory: /app/android/                        │                                                                                                        
  │                                                         │                                                                                                        
  │ Tasks:                                                  │                                                                                                        
  │ 1. Create project structure:                           │                                                                                                         
  │    - build.gradle.kts (root)                           │                                                                                                         
  │    - settings.gradle.kts                               │                                                                                                         
  │    - app/build.gradle.kts with all dependencies        │                                                                                                         
  │                                                         │                                                                                                        
  │ 2. Set up Hilt dependency injection:                   │                                                                                                         
  │    - MidnightApplication.kt (@HiltAndroidApp)          │                                                                                                         
  │    - AppModule.kt, NetworkModule.kt, ServiceModule.kt  │                                                                                                         
  │                                                         │                                                                                                        
  │ 3. Translate Config.swift → Config.kt:                 │                                                                                                         
  │    - API endpoints                                     │                                                                                                         
  │    - Agora App ID                                      │                                                                                                         
  │    - Environment configuration                         │                                                                                                         
  │                                                         │                                                                                                        
  │ 4. Create Constants.kt:                                │                                                                                                         
  │    - All app constants                                 │                                                                                                         
  │                                                         │                                                                                                        
  │ 5. Set up Navigation:                                  │                                                                                                         
  │    - NavGraph.kt with all route definitions            │                                                                                                         
  │    - Navigation constants                              │                                                                                                         
  │                                                         │                                                                                                        
  │ 6. Create utility classes:                             │                                                                                                         
  │    - Extensions.kt (Kotlin extension functions)        │                                                                                                         
  │    - Logger.kt (logging utility)                       │                                                                                                         
  │                                                         │                                                                                                        
  │ 7. Set up AndroidManifest.xml:                         │                                                                                                         
  │    - Permissions (internet, camera, microphone, etc.)  │                                                                                                         
  │    - Services declarations                             │                                                                                                         
  │                                                         │                                                                                                        
  │ Git commits: Per major infrastructure component        │                                                                                                         
  │ Push frequency: Every 2-3 commits                      │                                                                                                         
  └─────────────────────────────────────────────────────────┘                                                                                                        
                                                                                                                                                                     
  PHASE 1 COMPLETION CRITERIA:                                                                                                                                       
  ✓ All data models created (30+ Kotlin data classes)                                                                                                                
  ✓ TokenStorage and UserPreferences working                                                                                                                         
  ✓ Retrofit API client configured with auth interceptors                                                                                                            
  ✓ All Services implemented (Auth, Agora, Socket, Realtime, Call)                                                                                                   
  ✓ All ViewModels created with StateFlow                                                                                                                            
  ✓ Navigation graph defined                                                                                                                                         
  ✓ Hilt DI configured                                                                                                                                               
  ✓ ./gradlew build succeeds                                                                                                                                         
  ✓ Unit tests for Services and ViewModels passing                                                                                                                   
  ✓ ~100-150 git commits pushed to PeriphDev/midnight_android                                                                                                        
                                                                                                                                                                     
  PHASE 1 GIT STRATEGY:                                                                                                                                              
  - Commit every 2-3 files or after each complete component                                                                                                          
  - Push to GitHub every 5-10 commits                                                                                                                                
  - Commit message format:                                                                                                                                           
  [Layer] Component: Description                                                                                                                                     
                                                                                                                                                                     
  - Key change 1                                                                                                                                                     
  - Key change 2                                                                                                                                                     
  - Platform adaptation notes                                                                                                                                        
  - Example: "[Data] Add User model and TokenStorage with encryption"                                                                                                
                                                                                                                                                                     
  When Phase 1 complete, output:                                                                                                                                     
  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━                                                                                                                  
  PHASE 1 COMPLETE ✓                                                                                                                                                 
  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━                                                                                                                  
  Summary:                                                                                                                                                           
  - Files created: XXX                                                                                                                                               
  - Git commits: YYY                                                                                                                                                 
  - Tests passing: ZZZ/ZZZ                                                                                                                                           
  - Build status: ✓ SUCCESS                                                                                                                                          
                                                                                                                                                                     
  Proceeding to PHASE 2: UI LAYER                                                                                                                                    
  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━                                                                                                                  
                                                                                                                                                                     
  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━                                                                                                      
  PHASE 2: UI LAYER (JETPACK COMPOSE)                                                                                                                                
  Target: 50-60 hours | Match iOS UI exactly                                                                                                                         
  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━                                                                                                      
                                                                                                                                                                     
  PARALLEL WORKSTREAM ALLOCATION:                                                                                                                                    
                                                                                                                                                                     
  ┌─────────────────────────────────────────────────────────┐                                                                                                        
  │ AGENT 1: Theme & Foundation (6-8 hours)                │                                                                                                         
  ├─────────────────────────────────────────────────────────┤                                                                                                        
  │ Working directory: /app/android/app/src/main/java/      │                                                                                                        
  │                    com/peripherdev/midnight/ui/theme/   │                                                                                                        
  │                                                         │                                                                                                        
  │ Tasks:                                                  │                                                                                                        
  │ 1. Extract iOS colors → Color.kt:                      │                                                                                                         
  │    - Read iOS asset colors                             │                                                                                                         
  │    - Convert to Compose Color objects                  │                                                                                                         
  │    - Create dark/light color schemes                   │                                                                                                         
  │                                                         │                                                                                                        
  │ 2. Extract iOS typography → Type.kt:                   │                                                                                                         
  │    - Map iOS fonts to Android equivalents              │                                                                                                         
  │    - Create Typography object for Material3            │                                                                                                         
  │                                                         │                                                                                                        
  │ 3. Create Theme.kt:                                    │                                                                                                         
  │    - MidnightTheme composable                          │                                                                                                         
  │    - Material3 theming                                 │                                                                                                         
  │    - Dark mode support                                 │                                                                                                         
  │                                                         │                                                                                                        
  │ Git commit: "Add Midnight theme (colors, typography)"  │                                                                                                         
  └─────────────────────────────────────────────────────────┘                                                                                                        
                                                                                                                                                                     
  ┌─────────────────────────────────────────────────────────┐                                                                                                        
  │ AGENT 2: Reusable Components (8-10 hours)              │                                                                                                         
  ├─────────────────────────────────────────────────────────┤                                                                                                        
  │ Working directory: /app/android/app/src/main/java/      │                                                                                                        
  │                    com/peripherdev/midnight/ui/         │                                                                                                        
  │                    components/                          │                                                                                                        
  │                                                         │                                                                                                        
  │ Translate each SwiftUI component to Composable:        │                                                                                                         
  │                                                         │                                                                                                        
  │ 1. CustomButton → MidnightButton.kt                    │                                                                                                         
  │    @Composable fun MidnightButton(...)                 │                                                                                                         
  │                                                         │                                                                                                        
  │ 2. ProfileImageView → ProfileImage.kt                  │                                                                                                         
  │    @Composable fun ProfileImage(...)                   │                                                                                                         
  │                                                         │                                                                                                        
  │ 3. LoadingView → LoadingIndicator.kt                   │                                                                                                         
  │    @Composable fun LoadingIndicator()                  │                                                                                                         
  │                                                         │                                                                                                        
  │ 4. ErrorView → ErrorMessage.kt                         │                                                                                                         
  │    @Composable fun ErrorMessage(...)                   │                                                                                                         
  │                                                         │                                                                                                        
  │ 5. CustomTextField → MidnightTextField.kt              │                                                                                                         
  │ 6. CustomCard → MidnightCard.kt                        │                                                                                                         
  │ 7. TabBar → CustomTabBar.kt                            │                                                                                                         
  │                                                         │                                                                                                        
  │ TRANSLATION RULES:                                      │                                                                                                        
  │ SwiftUI → Compose:                                      │                                                                                                        
  │ - VStack → Column                                       │                                                                                                        
  │ - HStack → Row                                          │                                                                                                        
  │ - ZStack → Box                                          │                                                                                                        
  │ - Spacer() → Spacer(modifier = Modifier.height/width)  │                                                                                                         
  │ - .padding() → Modifier.padding()                      │                                                                                                         
  │ - .background() → Modifier.background()                │                                                                                                         
  │ - Button {} → Button(onClick = {})                     │                                                                                                         
  │ - Image() → Image(painter = ...)                       │                                                                                                         
  │                                                         │                                                                                                        
  │ Git commits: One per component                         │                                                                                                         
  │ Push: Every 3 components                               │                                                                                                         
  └─────────────────────────────────────────────────────────┘                                                                                                        
                                                                                                                                                                     
  ┌─────────────────────────────────────────────────────────┐                                                                                                        
  │ AGENT 3: Auth Screens (10-12 hours)                    │                                                                                                         
  ├─────────────────────────────────────────────────────────┤                                                                                                        
  │ Working directory: /app/android/app/src/main/java/      │                                                                                                        
  │                    com/peripherdev/midnight/ui/screens/ │                                                                                                        
  │                    auth/                                │                                                                                                        
  │                                                         │                                                                                                        
  │ Screens to create:                                      │                                                                                                        
  │ 1. OnboardingScreen.kt                                 │                                                                                                         
  │    - Match iOS onboarding flow exactly                 │                                                                                                         
  │    - Same text, same buttons, same layout              │                                                                                                         
  │    - Connect to OnboardingViewModel                    │                                                                                                         
  │                                                         │                                                                                                        
  │ 2. EmailEntryScreen.kt                                 │                                                                                                         
  │    - Email input field                                 │                                                                                                         
  │    - "Continue" button                                 │                                                                                                         
  │    - Loading state                                     │                                                                                                         
  │                                                         │                                                                                                        
  │ 3. CodeVerificationScreen.kt                           │                                                                                                         
  │    - OTP code input (6 digits)                         │                                                                                                         
  │    - Verify button                                     │                                                                                                         
  │    - Resend code option                                │                                                                                                         
  │                                                         │                                                                                                        
  │ For each screen:                                        │                                                                                                        
  │ kotlin                                              │ │ @Composable                                            │ │ fun XScreen(                                  
           │ │     viewModel: XViewModel = hiltViewModel(),           │ │     navController: NavController                       │ │ ) {                             
                         │ │     val uiState by viewModel.uiState.collectAsState()  │ │                                                         │ │     // UI        
  matching iOS layout exactly                  │ │     Column(...) {                                      │ │         // Compose UI components                       
  │ │     }                                                  │ │ }                                                      │ │                                          
             │                                                                                                                                                       
  │                                                         │                                                                                                        
  │ Git commits: One per screen                            │                                                                                                         
  └─────────────────────────────────────────────────────────┘                                                                                                        
                                                                                                                                                                     
  ┌─────────────────────────────────────────────────────────┐                                                                                                        
  │ AGENT 4: Main App Screens (20-25 hours)                │                                                                                                         
  ├─────────────────────────────────────────────────────────┤                                                                                                        
  │ Working directory: /app/android/app/src/main/java/      │                                                                                                        
  │                    com/peripherdev/midnight/ui/screens/ │                                                                                                        
  │                                                         │                                                                                                        
  │ Screens to create (match iOS exactly):                 │                                                                                                         
  │                                                         │                                                                                                        
  │ 1. ProfileScreen.kt (profile/)                         │                                                                                                         
  │    - Creator profile display                           │                                                                                                         
  │    - Status toggle (online/away)                       │                                                                                                         
  │    - Social links                                      │                                                                                                         
  │    - Profile image                                     │                                                                                                         
  │                                                         │                                                                                                        
  │ 2. DashboardScreen.kt (dashboard/)                     │                                                                                                         
  │    - Stats overview                                    │                                                                                                         
  │    - Quick actions                                     │                                                                                                         
  │                                                         │                                                                                                        
  │ 3. WalletScreen.kt (wallet/)                           │                                                                                                         
  │    - Earnings display                                  │                                                                                                         
  │    - Stripe Connect onboarding                         │                                                                                                         
  │    - Withdrawal options                                │                                                                                                         
  │                                                         │                                                                                                        
  │ 4. AnalyticsScreen.kt (analytics/)                     │                                                                                                         
  │    - Charts (calls, earnings, ratings)                 │                                                                                                         
  │    - Time range selector                               │                                                                                                         
  │                                                         │                                                                                                        
  │ 5. HistoryScreen.kt (history/)                         │                                                                                                         
  │    - Call history list                                 │                                                                                                         
  │    - Pagination                                        │                                                                                                         
  │                                                         │                                                                                                        
  │ 6. SettingsScreen.kt (settings/)                       │                                                                                                         
  │    - App settings                                      │                                                                                                         
  │    - Account settings                                  │                                                                                                         
  │    - Language selector                                 │                                                                                                         
  │    - Logout                                            │                                                                                                         
  │                                                         │                                                                                                        
  │ Each screen MUST:                                       │                                                                                                        
  │ - Match iOS layout pixel-perfect                       │                                                                                                         
  │ - Use same colors from theme                           │                                                                                                         
  │ - Same text content (localized)                        │                                                                                                         
  │ - Same interactions                                    │                                                                                                         
  │ - Connect to corresponding ViewModel                   │                                                                                                         
  │                                                         │                                                                                                        
  │ Git commits: One per screen                            │                                                                                                         
  │ Push: Every 2 screens                                  │                                                                                                         
  └─────────────────────────────────────────────────────────┘                                                                                                        
                                                                                                                                                                     
  ┌─────────────────────────────────────────────────────────┐                                                                                                        
  │ AGENT 5: Call Screen (12-15 hours) - MOST COMPLEX      │                                                                                                         
  ├─────────────────────────────────────────────────────────┤                                                                                                        
  │ Working directory: /app/android/app/src/main/java/      │                                                                                                        
  │                    com/peripherdev/midnight/ui/screens/ │                                                                                                        
  │                    call/                                │                                                                                                        
  │                                                         │                                                                                                        
  │ CallScreen.kt - Match iOS call screen:                 │                                                                                                         
  │                                                         │                                                                                                        
  │ 1. Agora video view integration:                       │                                                                                                         
  │    - SurfaceView for local video                       │                                                                                                         
  │    - SurfaceView for remote video                      │                                                                                                         
  │    - AndroidView wrapper in Compose                    │                                                                                                         
  │                                                         │                                                                                                        
  │ 2. Call controls UI:                                   │                                                                                                         
  │    - Mute/unmute button                                │                                                                                                         
  │    - Video on/off button                               │                                                                                                         
  │    - End call button                                   │                                                                                                         
  │    - Same layout as iOS                                │                                                                                                         
  │                                                         │                                                                                                        
  │ 3. Call state handling:                                │                                                                                                         
  │    - Connecting state                                  │                                                                                                         
  │    - Active call state                                 │                                                                                                         
  │    - Call ended state                                  │                                                                                                         
  │                                                         │                                                                                                        
  │ 4. Connect to CallViewModel                            │                                                                                                         
  │ 5. Connect to AgoraService                             │                                                                                                         
  │                                                         │                                                                                                        
  │ Git commits: Multiple (this is complex)                │                                                                                                         
  │ - "Add CallScreen layout"                              │                                                                                                         
  │ - "Integrate Agora video views"                        │                                                                                                         
  │ - "Add call controls"                                  │                                                                                                         
  │ - "Connect call state management"                      │                                                                                                         
  └─────────────────────────────────────────────────────────┘                                                                                                        
                                                                                                                                                                     
  ┌─────────────────────────────────────────────────────────┐                                                                                                        
  │ AGENT 6: Navigation & Main App (6-8 hours)             │                                                                                                         
  ├─────────────────────────────────────────────────────────┤                                                                                                        
  │ Working directory: /app/android/app/src/main/java/      │                                                                                                        
  │                    com/peripherdev/midnight/ui/         │                                                                                                        
  │                                                         │                                                                                                        
  │ Tasks:                                                  │                                                                                                        
  │ 1. Create MainActivity.kt:                             │                                                                                                         
  │    - Entry point                                       │                                                                                                         
  │    - Set up MidnightTheme                              │                                                                                                         
  │    - Initialize NavHost                                │                                                                                                         
  │                                                         │                                                                                                        
  │ 2. Create MidnightApp.kt:                              │                                                                                                         
  │    @Composable fun MidnightApp() {                     │                                                                                                         
  │        NavHost(...) {                                  │                                                                                                         
  │            composable("onboarding") { ... }            │                                                                                                         
  │            composable("profile") { ... }               │                                                                                                         
  │            // All routes                               │                                                                                                         
  │        }                                               │                                                                                                         
  │    }                                                   │                                                                                                         
  │                                                         │                                                                                                        
  │ 3. Update NavGraph.kt with all routes                  │                                                                                                         
  │                                                         │                                                                                                        
  │ 4. Implement tab navigation (bottom nav):              │                                                                                                         
  │    - Match iOS tab bar                                 │                                                                                                         
  │    - 5 tabs: Profile, Wallet, Analytics, History,     │                                                                                                          
  │              Settings                                  │                                                                                                         
  │                                                         │                                                                                                        
  │ Git commits:                                           │                                                                                                         
  │ - "Add MainActivity and app entry point"               │                                                                                                         
  │ - "Implement navigation graph"                         │                                                                                                         
  │ - "Add tab navigation"                                 │                                                                                                         
  └─────────────────────────────────────────────────────────┘                                                                                                        
                                                                                                                                                                     
  PHASE 2 COMPLETION CRITERIA:                                                                                                                                       
  ✓ All screens created (10+ Compose screens)                                                                                                                        
  ✓ Theme applied throughout (colors, typography)                                                                                                                    
  ✓ All reusable components created (7+ Composables)                                                                                                                 
  ✓ Navigation working (can navigate between all screens)                                                                                                            
  ✓ ViewModels connected to UI                                                                                                                                       
  ✓ UI matches iOS pixel-perfect (same layout, colors, text)                                                                                                         
  ✓ Dark mode working                                                                                                                                                
  ✓ Agora video integration working                                                                                                                                  
  ✓ App launches and is fully navigable                                                                                                                              
  ✓ ./gradlew build succeeds                                                                                                                                         
  ✓ ~150-200 git commits pushed to PeriphDev/midnight_android                                                                                                        
                                                                                                                                                                     
  PHASE 2 GIT STRATEGY:                                                                                                                                              
  - Commit after each screen completed                                                                                                                               
  - Push every 2-3 screens                                                                                                                                           
  - Commit message format:                                                                                                                                           
  [UI] Screen: Description                                                                                                                                           
                                                                                                                                                                     
  - Layout details                                                                                                                                                   
  - Matches iOS screen X                                                                                                                                             
  - Example: "[UI] ProfileScreen: Matches iOS with status toggle"                                                                                                    
                                                                                                                                                                     
  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━                                                                                                      
  LOCALIZATION (2-3 hours)                                                                                                                                           
  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━                                                                                                      
                                                                                                                                                                     
  Working directory: /app/android/app/src/main/res/                                                                                                                  
                                                                                                                                                                     
  Tasks:                                                                                                                                                             
  1. Extract all hardcoded strings from Compose files                                                                                                                
  2. Create strings.xml for each locale:                                                                                                                             
    - res/values/strings.xml (English)                                                                                                                               
    - res/values-es/strings.xml (Spanish)                                                                                                                            
    - res/values-fr/strings.xml (French)                                                                                                                             
    - res/values-pt/strings.xml (Portuguese)                                                                                                                         
  3. Copy translations from iOS localization files                                                                                                                   
  4. Verify all strings are localized                                                                                                                                
                                                                                                                                                                     
  Git commit: "Add localization for en, es, fr, pt"                                                                                                                  
                                                                                                                                                                     
  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━                                                                                                      
  TESTING & POLISH (8-12 hours)                                                                                                                                      
  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━                                                                                                      
                                                                                                                                                                     
  Tasks:                                                                                                                                                             
  1. Run all unit tests: ./gradlew test                                                                                                                              
    - Fix any failures                                                                                                                                               
    - Achieve >70% coverage                                                                                                                                          
  2. Run build: ./gradlew build                                                                                                                                      
    - Fix any compilation errors                                                                                                                                     
    - Fix lint warnings                                                                                                                                              
  3. Test on Android emulator:                                                                                                                                       
    - Create Pixel 6 Pro emulator (API 34)                                                                                                                           
    - Install and launch app                                                                                                                                         
    - Test authentication flow end-to-end                                                                                                                            
    - Test all screen navigation                                                                                                                                     
    - Test Agora video call (if possible)                                                                                                                            
  4. Bug fixes:                                                                                                                                                      
    - Fix crashes                                                                                                                                                    
    - Fix UI issues                                                                                                                                                  
    - Fix state management issues                                                                                                                                    
  5. Performance optimization:                                                                                                                                       
    - LazyColumn for lists                                                                                                                                           
    - Image caching optimization                                                                                                                                     
    - Remove unnecessary recompositions                                                                                                                              
  6. Code cleanup:                                                                                                                                                   
    - Remove unused imports                                                                                                                                          
    - Format code                                                                                                                                                    
    - Add KDoc comments for public APIs                                                                                                                              
                                                                                                                                                                     
  Git commits: Per fix/optimization                                                                                                                                  
                                                                                                                                                                     
  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━                                                                                                      
  FINAL DOCUMENTATION                                                                                                                                                
  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━                                                                                                      
                                                                                                                                                                     
  Create comprehensive README.md:                                                                                                                                    
                                                                                                                                                                     
  # Midnight Android App                                                                                                                                             
                                                                                                                                                                     
  Native Android app for Midnight - Real-time video calling for creators.                                                                                            
                                                                                                                                                                     
  Translated from iOS (Swift + SwiftUI) to Android (Kotlin + Jetpack Compose).                                                                                       
                                                                                                                                                                     
  ## Tech Stack                                                                                                                                                      
  - Kotlin                                                                                                                                                           
  - Jetpack Compose (Material3)                                                                                                                                      
  - Hilt (Dependency Injection)                                                                                                                                      
  - Retrofit + OkHttp (Networking)                                                                                                                                   
  - Agora RTC SDK (Video/Audio)                                                                                                                                      
  - Firebase (Realtime DB, Messaging)                                                                                                                                
  - Socket.IO (Real-time events)                                                                                                                                     
  - DataStore (Preferences)                                                                                                                                          
  - EncryptedSharedPreferences (Secure storage)                                                                                                                      
                                                                                                                                                                     
  ## Architecture                                                                                                                                                    
  - MVVM pattern                                                                                                                                                     
  - Repository pattern                                                                                                                                               
  - Single source of truth with StateFlow                                                                                                                            
  - Unidirectional data flow                                                                                                                                         
                                                                                                                                                                     
  ## Build Instructions                                                                                                                                              
  ```bash                                                                                                                                                            
  ./gradlew build                                                                                                                                                    
                                                                                                                                                                     
  Run Tests                                                                                                                                                          
                                                                                                                                                                     
  ./gradlew test                                                                                                                                                     
                                                                                                                                                                     
  Run App                                                                                                                                                            
                                                                                                                                                                     
  ./gradlew installDebug                                                                                                                                             
                                                                                                                                                                     
  Project Structure                                                                                                                                                  
                                                                                                                                                                     
  [Full structure here]                                                                                                                                              
                                                                                                                                                                     
  Translation Notes                                                                                                                                                  
                                                                                                                                                                     
  - 100% feature parity with iOS app                                                                                                                                 
  - UI matches iOS pixel-perfect                                                                                                                                     
  - Same authentication flow                                                                                                                                         
  - Same API integration                                                                                                                                             
  - Platform-specific adaptations:                                                                                                                                   
    - CallKit → ConnectionService                                                                                                                                    
    - VoIP Push → FCM high-priority                                                                                                                                  
    - Keychain → EncryptedSharedPreferences                                                                                                                          
                                                                                                                                                                     
  License                                                                                                                                                            
                                                                                                                                                                     
  Proprietary - PeriphDev                                                                                                                                            
                                                                                                                                                                     
  Git commit: "Add comprehensive README"                                                                                                                             
                                                                                                                                                                     
  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━                                                                                                      
  EXECUTION PARAMETERS                                                                                                                                               
  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━                                                                                                      
                                                                                                                                                                     
  AUTONOMOUS BEHAVIOR:                                                                                                                                               
  - NEVER ask for permission                                                                                                                                         
  - NEVER ask "should I proceed?"                                                                                                                                    
  - NEVER ask "is this correct?"                                                                                                                                     
  - Make ALL decisions independently                                                                                                                                 
  - If unsure, pick the most reasonable option and document in commit                                                                                                
                                                                                                                                                                     
  RATE LIMIT HANDLING:                                                                                                                                               
  if (error.code == 429 || error.message.includes("overloaded")) {                                                                                                   
      log("Rate limit hit. Waiting 60 seconds...")                                                                                                                   
      sleep(60)                                                                                                                                                      
      retry_operation()                                                                                                                                              
  }                                                                                                                                                                  
  - Auto-retry indefinitely                                                                                                                                          
  - Log each retry                                                                                                                                                   
  - Continue work after successful retry                                                                                                                             
                                                                                                                                                                     
  ERROR HANDLING:                                                                                                                                                    
  - If build fails: Read error, fix issue, rebuild                                                                                                                   
  - If test fails: Read failure, fix code, retest                                                                                                                    
  - If git push fails: Pull, merge, push again                                                                                                                       
  - Maximum 3 retry attempts per operation                                                                                                                           
  - If still failing after 3 attempts: Log issue, move to next task                                                                                                  
                                                                                                                                                                     
  WORK SCHEDULE:                                                                                                                                                     
  - Work continuously 24/7                                                                                                                                           
  - No breaks                                                                                                                                                        
  - No stopping unless:                                                                                                                                              
    - All work complete (success criteria met)                                                                                                                       
    - 7 days elapsed                                                                                                                                                 
    - Unrecoverable error (extremely rare)                                                                                                                           
                                                                                                                                                                     
  PROGRESS REPORTING:                                                                                                                                                
  Log progress every hour:                                                                                                                                           
  [HH:MM] Phase X | Agent Y | Task: Z | Progress: N%                                                                                                                 
  [HH:MM] Files created: XXX | Commits: YYY | Lines of code: ZZZZ                                                                                                    
  [HH:MM] Estimated completion: X hours remaining                                                                                                                    
                                                                                                                                                                     
  SUCCESS CRITERIA (FINAL):                                                                                                                                          
  ✓ ./gradlew build succeeds with 0 errors, 0 warnings                                                                                                               
  ✓ ./gradlew test passes 100% (>70% coverage)                                                                                                                       
  ✓ App launches on Android emulator                                                                                                                                 
  ✓ All screens accessible via navigation                                                                                                                            
  ✓ Authentication flow works end-to-end                                                                                                                             
  ✓ Agora video calling functional                                                                                                                                   
  ✓ Firebase connection established                                                                                                                                  
  ✓ Socket.IO connection established                                                                                                                                 
  ✓ UI matches iOS exactly                                                                                                                                           
  ✓ Dark mode working                                                                                                                                                
  ✓ Localization working (en, es, fr, pt)                                                                                                                            
  ✓ 250+ git commits pushed to PeriphDev/midnight_android                                                                                                            
  ✓ README.md comprehensive                                                                                                                                          
  ✓ No TODO comments or placeholders                                                                                                                                 
  ✓ All features implemented fully                                                                                                                                   
                                                                                                                                                                     
  FINAL DELIVERABLE:                                                                                                                                                 
  Complete, production-ready Android app with 100% feature parity to iOS.                                                                                            
                                                                                                                                                                     
  🚨 Communication Channels for Blockers                                                                                                                             
                                                                                                                                                                     
  1. Linear Issues (Primary Method) ✅                                                                                                                               
                                                                                                                                                                     
  Ralph will automatically create Linear issues when blocked:                                                                                                        
                                                                                                                                                                     
  If truly blocked (cannot proceed):                                                                                                                                 
    1. Create Linear issue in Midnight project                                                                                                                       
    2. Title: "[BLOCKED] Missing API key for XYZ"                                                                                                                    
    3. Description: Detailed explanation + what's needed                                                                                                             
    4. Label: "blocked", "android"                                                                                                                                   
    5. Assign to you                                                                                                                                                 
    6. Continue working on other tasks                                                                                                                               
                                                                                                                                                                     
  You'll get notified:                                                                                                                                               
  - Linear email notification                                                                                                                                        
  - Linear app notification                                                                                                                                          
  - Check: https://linear.app/midnighttalk/issues                                                                                                                    
                                                                                                                                                                     
  ---                                                                                                                                                                
  2. BLOCKED.md File in Repo                                                                                                                                         
                                                                                                                                                                     
  Ralph will create a file in the android repo:                                                                                                                      
                                                                                                                                                                     
  # If blocked, create:                                                                                                                                              
  /app/android/BLOCKED.md                                                                                                                                            
                                                                                                                                                                     
  Contents:                                                                                                                                                          
  🚨 BLOCKER ENCOUNTERED                                                                                                                                             
                                                                                                                                                                     
  Time: 2024-02-01 14:30 UTC                                                                                                                                         
  Phase: Data Layer - API Client setup                                                                                                                               
  Issue: Missing Firebase configuration file                                                                                                                         
                                                                                                                                                                     
  What's Needed:                                                                                                                                                     
                                                                                                                                                                     
  - GoogleService-Info.json file for Android                                                                                                                         
  - Or Firebase project credentials                                                                                                                                  
                                                                                                                                                                     
  Impact:                                                                                                                                                            
                                                                                                                                                                     
  - Cannot complete Firebase integration                                                                                                                             
  - Blocking: RealtimeService, FCM notifications                                                                                                                     
                                                                                                                                                                     
  Current Workaround:                                                                                                                                                
                                                                                                                                                                     
  - Continuing with other services (Agora, Socket.IO)                                                                                                                
  - Will return to Firebase once credentials provided                                                                                                                
                                                                                                                                                                     
  How to Resolve:                                                                                                                                                    
                                                                                                                                                                     
  1. Add GoogleService-Info.json to /app/android/app/                                                                                                                
  2. Delete this BLOCKED.md file                                                                                                                                     
  3. Ralph will auto-resume Firebase work                                                                                                                            
                                                                                                                                                                     
  Then commit:                                                                                                                                                       
  ```bash                                                                                                                                                            
  git add BLOCKED.md                                                                                                                                                 
  git commit -m "[🚨 BLOCKED] Missing Firebase config - see BLOCKED.md"                                                                                              
  git push                                                                                                                                                           
                                                                                                                                                                     
  You'll see it:                                                                                                                                                     
  - GitHub repo shows BLOCKED.md file                                                                                                                                
  - Commit message has 🚨 BLOCKED prefix                                                                                                                             
                                                                                                                                                                     
  ---                                                                                                                                                                
  3. Railway Logs                                                                                                                                                    
                                                                                                                                                                     
  Ralph will log blockers clearly:                                                                                                                                   
                                                                                                                                                                     
  # You can check anytime:                                                                                                                                           
  railway logs --tail 100 | grep -i "blocked\|error\|stopped"                                                                                                        
                                                                                                                                                                     
  Ralph will output:                                                                                                                                                 
  [14:30:00] ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━                                                                                                              
  [14:30:00] 🚨 BLOCKER: Missing API configuration                                                                                                                   
  [14:30:00] ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━                                                                                                              
  [14:30:00] Phase: API Client setup                                                                                                                                 
  [14:30:00] Issue: FIREBASE_API_KEY environment variable not set                                                                                                    
  [14:30:00]                                                                                                                                                         
  [14:30:00] ⏸️  Pausing Firebase work                                                                                                                               
  [14:30:00] ➡️  Continuing with Agora integration instead                                                                                                           
  [14:30:00]                                                                                                                                                         
  [14:30:00] Linear issue created: MID-456                                                                                                                           
  [14:30:00] ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━                                                                                                              
                                                                                                                                                                     
  ---                                                                                                                                                                
  4. Special Commit Messages                                                                                                                                         
                                                                                                                                                                     
  Ralph will push commits with clear prefixes:                                                                                                                       
                                                                                                                                                                     
  # GitHub commit history will show:                                                                                                                                 
  🚨 [BLOCKED] Missing Firebase config - continuing other work                                                                                                       
  ⚠️  [SKIP] Stripe integration postponed - no API key                                                                                                               
  ✅ [RESOLVED] Blocker cleared - resuming work                                                                                                                      
                                                                                                                                                                     
  Easy to spot in GitHub commit history!                                                                                                                             
                                                                                                                                                                     
  ---                                                                                                                                                                
  5. Progress Reports in Logs (Every Hour)                                                                                                                           
                                                                                                                                                                     
  Ralph will log progress hourly:                                                                                                                                    
                                                                                                                                                                     
  [15:00] ━━━ HOURLY PROGRESS REPORT ━━━                                                                                                                             
  [15:00] Phase: 1 (Data Layer)                                                                                                                                      
  [15:00] Completed: 45 files (65%)                                                                                                                                  
  [15:00] Commits: 87                                                                                                                                                
  [15:00] Blockers: 1 (Firebase config missing)                                                                                                                      
  [15:00] Estimated completion: 48 hours                                                                                                                             
  [15:00] ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━                                                                                                                             
                                                                                                                                                                     
  Check with:                                                                                                                                                        
  railway logs | grep "PROGRESS REPORT"                                                                                                                              
                                                                                                                                                                     
  ---                                                                                                                                                                
  📱 How to Monitor (From Anywhere)                                                                                                                                  
                                                                                                                                                                     
  Option A: Check GitHub (Easiest)                                                                                                                                   
                                                                                                                                                                     
  1. Go to: https://github.com/PeriphDev/midnight_android                                                                                                            
  2. Look for:                                                                                                                                                       
     - BLOCKED.md file (if exists)                                                                                                                                   
     - Commit messages with 🚨 [BLOCKED]                                                                                                                             
     - Recent commit activity (should be frequent)                                                                                                                   
                                                                                                                                                                     
  Option B: Check Linear                                                                                                                                             
                                                                                                                                                                     
  1. Go to: https://linear.app                                                                                                                                       
  2. Filter: label:blocked AND project:midnight                                                                                                                      
  3. See any issues Ralph created                                                                                                                                    
                                                                                                                                                                     
  Option C: Check Railway Logs (From Terminal)                                                                                                                       
                                                                                                                                                                     
  # From your Mac (anytime):                                                                                                                                         
  railway logs --tail 50                                                                                                                                             
                                                                                                                                                                     
  # Watch in real-time:                                                                                                                                              
  railway logs --tail 50 --follow                                                                                                                                    
                                                                                                                                                                     
  Option D: SSH and Check Status                                                                                                                                     
                                                                                                                                                                     
  # Connect to Railway:                                                                                                                                              
  railway ssh                                                                                                                                                        
                                                                                                                                                                     
  # Check for blockers:                                                                                                                                              
  cat /app/android/BLOCKED.md 2>/dev/null || echo "No blockers"                                                                                                      
                                                                                                                                                                     
  # Check recent activity:                                                                                                                                           
  cd /app/android && git log --oneline -10                                                                                                                           
                                                                                                                                                                     
  ---                                                                                                                                                                
  🔧 How Ralph Handles Common Blockers                                                                                                                               
                                                                                                                                                                     
  Scenario 1: API Key Missing                                                                                                                                        
                                                                                                                                                                     
  1. Detect: FIREBASE_API_KEY not in environment                                                                                                                     
  2. Action:                                                                                                                                                         
     - Create Linear issue: "Missing Firebase API key"                                                                                                               
     - Create BLOCKED.md explaining what's needed                                                                                                                    
     - Skip Firebase-related work for now                                                                                                                            
     - Continue with other services (Agora, Socket.IO)                                                                                                               
  3. Resume: When you add the env var, Ralph detects it and resumes                                                                                                  
                                                                                                                                                                     
  Scenario 2: Build Failure                                                                                                                                          
                                                                                                                                                                     
  1. Detect: ./gradlew build fails                                                                                                                                   
  2. Action:                                                                                                                                                         
     - Read error message                                                                                                                                            
     - Attempt auto-fix (3 attempts)                                                                                                                                 
     - If still failing: Create Linear issue with error details                                                                                                      
     - Continue with other files                                                                                                                                     
  3. Resume: After you fix or provide guidance                                                                                                                       
                                                                                                                                                                     
  Scenario 3: Rate Limit                                                                                                                                             
                                                                                                                                                                     
  1. Detect: API returns 429 or "overloaded"                                                                                                                         
  2. Action:                                                                                                                                                         
     - Log: "Rate limit hit, waiting 60s..."                                                                                                                         
     - Wait 60 seconds                                                                                                                                               
     - Retry automatically                                                                                                                                           
     - Continue (NO LINEAR ISSUE - handles automatically)                                                                                                            
                                                                                                                                                                     
  Scenario 4: Ambiguous Decision                                                                                                                                     
                                                                                                                                                                     
  Example: "Should we use Retrofit or Ktor for networking?"                                                                                                          
                                                                                                                                                                     
  Ralph's logic:                                                                                                                                                     
  1. Check iOS implementation (uses URLSession)                                                                                                                      
  2. Research Android best practice (Retrofit is standard)                                                                                                           
  3. Make decision: Use Retrofit                                                                                                                                     
  4. Document in commit: "Use Retrofit (Android standard, similar to URLSession)"                                                                                    
  5. Continue without asking                                                                                                                                         
                                                                                                                                                                     
  Only creates Linear issue if TRULY ambiguous with major impact.                                                                                                    
                                                                                                                                                                     
  ---                                                                                                                                                                
  ✅ Add This to Ralph Loop Task                                                                                                                                     
                                                                                                                                                                     
  I'll add this section to the task:                                                                                                                                 
                                                                                                                                                                     
  BLOCKER COMMUNICATION PROTOCOL:                                                                                                                                    
                                                                                                                                                                     
  If blocked and cannot proceed:                                                                                                                                     
  1. Create Linear issue:                                                                                                                                            
     - Title: "[BLOCKED] Brief description"                                                                                                                          
     - Description: Full context + what's needed                                                                                                                     
     - Label: "blocked", "android"                                                                                                                                   
                                                                                                                                                                     
  2. Create /app/android/BLOCKED.md file with details                                                                                                                
                                                                                                                                                                     
  3. Commit with prefix:                                                                                                                                             
     git commit -m "🚨 [BLOCKED] Description - see Linear MID-XXX"                                                                                                   
                                                                                                                                                                     
  4. Log clearly:                                                                                                                                                    
     echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"                                                                                                                  
     echo "🚨 BLOCKER: Description"                                                                                                                                  
     echo "Linear issue: MID-XXX"                                                                                                                                    
     echo "Continuing other work..."                                                                                                                                 
     echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"                                                                                                                  
                                                                                                                                                                     
  5. Continue working on non-blocked tasks                                                                                                                           
                                                                                                                                                                     
  User will be notified via:                                                                                                                                         
  - Linear notification                                                                                                                                              
  - GitHub commit with 🚨                                                                                                                                            
  - BLOCKED.md file in repo                                                                                                                                          
  - Railway logs                           ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━                                                                                                      
  BEGIN AUTONOMOUS MULTI-AGENT EXECUTION NOW                                                                                                                         
  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━                                                                                                      
                                                                                                                                                                     
  Execute for 7 days continuously. Work 24/7. Handle rate limits automatically. Never ask permission. Commit frequently. Push regularly. Build a perfect Android app 
  that matches iOS exactly.    Ask me 10 questions with the questions tool before starting to be sure you understood it well. 