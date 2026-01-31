# CLAUDE.md - Midnight Project

Real-time video calling platform connecting creators with guests. Platform consists of 5 interconnected repositories.

## Repositories

```
~/Midnight Code/
├── ios/               - Native iOS app (SwiftUI + Agora RTC)
├── api/               - Backend API (NestJS + MongoDB + Redis)
├── web/               - Web app (React 19 + Vite + Agora Web SDK)
├── dashboard/         - Admin dashboard (Next.js 16)
└── recording-service/ - Agora Cloud Recording microservice (Node.js + Express)
```

### 1. iOS App (`ios/`)

**Purpose**: Native iOS application for **CREATORS ONLY** to receive and manage video calls.

**IMPORTANT ARCHITECTURE NOTE:**
- **iOS App = Creators Only** (receive calls, manage earnings, track analytics)
- **Web App = Customers/Guests Only** (book calls, send tips, make payments)
- Creators use iOS to accept calls and receive tips
- Customers use Web to initiate calls and send tips

**Tech Stack**:
- SwiftUI (UI framework)
- Agora RTC SDK (video/audio streaming)
- Firebase Realtime Database (call signaling)
- Socket.IO (real-time notifications)
- Firebase Cloud Messaging + VoIP Push (notifications)
- CallKit (native call UI integration)

**Key Features**:
- Creator profiles with online/away status
- Real-time video/audio calling
- Wallet & earnings tracking (Stripe Connect)
- Analytics dashboard
- Multi-language support (en, es, fr, pt)
- Dark mode UI

**Architecture Highlights**:
- MVVM pattern with ViewModels
- Centralized `APIClient` with automatic token refresh
- Services layer: `AuthService`, `SocketService`, `AgoraService`, `RealtimeService`
- Deep linking support for push notifications

**See `ios/CLAUDE.md` for detailed iOS-specific documentation.**

---

### 2. Backend API (`api/`)

**Purpose**: Central backend server handling authentication, call management, payments, and business logic.

**Tech Stack**:
- NestJS (Node.js framework)
- MongoDB + Mongoose (database)
- Redis + Bull (caching & job queues)
- Socket.IO (real-time events)
- Firebase Admin SDK (push notifications)
- Stripe (payment processing)
- Agora Access Token generation
- Auth0 (passwordless authentication)

**Project Structure**:
```
api/src/
├── config/              - Environment configuration
├── core/                - Core utilities (decorators, guards, interceptors)
├── infrastructure/      - Third-party service integrations
│   ├── agora/          - Agora token generation
│   ├── auth0/          - Passwordless auth integration
│   ├── firebase/       - Push notifications, Realtime DB
│   ├── stripe/         - Payment processing
│   ├── websocket/      - Socket.IO gateway
│   ├── storage/        - Cloudinary image uploads
│   └── ...
└── modules/            - Business logic modules
    ├── auth/           - Authentication & session management
    ├── users/          - User management
    ├── creators/       - Creator profiles & settings
    ├── calls/          - Call lifecycle & management
    ├── payments/       - Stripe Connect & payouts
    ├── analytics/      - Creator analytics
    └── ...
```

**Key Features**:
- RESTful API with JWT authentication
- WebSocket gateway for real-time updates (`/notifications` namespace)
- Agora RTC token generation for secure channel access
- Stripe Connect onboarding & payout management
- Firebase Realtime Database for call signaling coordination
- Redis caching for performance optimization
- Bull queues for background jobs (notifications, webhooks)

**API Response Format**:
All endpoints return:
```json
{
  "Status": true/false,
  "Message": "Descriptive message",
  "Data": {...},
  "Code": "ERROR_CODE" (optional)
}
```

**Environment Variables**:
- `MONGO_URI`: MongoDB connection string
- `REDIS_HOST`/`REDIS_PORT`: Redis connection
- `AGORA_APP_ID`/`AGORA_APP_CERTIFICATE`: Agora credentials
- `STRIPE_SECRET_KEY`: Stripe API key
- `AUTH0_DOMAIN`/`AUTH0_CLIENT_ID`: Auth0 configuration
- `FIREBASE_SERVICE_ACCOUNT`: Firebase Admin SDK credentials

---

### 3. Web Application (`web/`)

**Purpose**: Web-based interface for **CUSTOMERS/GUESTS ONLY** to discover creators, book calls, and send tips.

**IMPORTANT ARCHITECTURE NOTE:**
- **Web App = Customers/Guests Only** (no creator access)
- Customers book calls, make payments, and send tips from Web
- All payment flows (call booking, tips) originate from Web
- Creators never use the Web app

**Tech Stack**:
- React 19 + TypeScript
- Vite (build tool)
- React Router (routing)
- Zustand (state management)
- Agora RTC SDK (web)
- Socket.IO Client (real-time updates)
- Firebase SDK (Realtime Database)
- Stripe.js (payment processing)
- i18next (internationalization)

**Project Structure**:
```
web/src/
├── assets/             - Static assets (images, icons)
├── components/         - Reusable React components
│   └── call/          - Call-related UI components
├── hooks/             - Custom React hooks
│   └── call/          - Call-specific hooks
├── lib/               - Utility libraries
├── locales/           - Translation files (en, es, fr, pt)
├── pages/             - Page components (routes)
├── services/          - External service integrations
│   ├── api/          - API client & service methods
│   └── realtime/     - Firebase Realtime DB
├── stores/            - Zustand state stores
├── types/             - TypeScript type definitions
└── utils/             - Utility functions
```

**Key Features**:
- Creator profile discovery & browsing
- Guest registration & authentication
- Real-time video/audio calling (Agora Web SDK)
- Call request & acceptance flow
- Tipping during calls (Stripe integration)
- Multi-language support
- Responsive design for desktop/tablet

**Build Commands**:
```bash
npm run dev              # Development server (production API)
npm run dev:staging      # Development with staging API
npm run build            # Production build
```

---

### 4. Admin Dashboard (`dashboard/`)

**Purpose**: Internal admin panel for managing users, creators, calls, payments, and platform analytics.

**Tech Stack**:
- Next.js 16 (React framework with SSR)
- TypeScript
- Tailwind CSS (styling)
- Auth0 Next.js SDK (admin authentication)
- ApexCharts (data visualization)
- FullCalendar (scheduling views)

**Key Features**:
- User & creator management
- Call history & monitoring
- Payment & payout tracking
- Platform analytics & reporting
- Content moderation tools
- System configuration

**Build Commands**:
```bash
npm run dev              # Development server
npm run build            # Production build
npm start                # Production server
```

---

### 5. Recording Service (`recording-service/`)

**Purpose**: Private microservice that securely handles Agora Cloud Recording operations. Stores sensitive Agora and AWS credentials separately from the main API for security isolation.

**Tech Stack**:
- Node.js + TypeScript
- Express.js (lightweight HTTP server)
- Agora Cloud Recording RESTful API SDK
- AWS SDK (S3 storage integration)
- Docker (containerized deployment)

**Project Structure**:
```
recording-service/
├── src/
│   ├── index.ts           - Main Express server & endpoints
│   ├── agora.ts           - Agora Cloud Recording API wrapper
│   ├── s3.ts              - AWS S3 configuration
│   └── env.ts             - Environment variable loader
├── Dockerfile             - Docker build configuration
├── package.json           - Dependencies
└── README.md              - Deployment documentation
```

**Key Features**:
- Agora Cloud Recording start/stop operations
- S3 bucket write verification
- Bearer token authentication
- Deterministic recorder UID generation
- No credential exposure in responses

**API Endpoints**:

**1. GET `/health`**
- Health check endpoint
- Returns: `{ ok: true }`
- No authentication required

**2. POST `/s3/test-write`**
- Tests S3 write permissions
- Auth: `Authorization: Bearer <RECORDING_SERVICE_TOKEN>`
- Writes test file to S3 bucket
- Returns: `{ ok: true, key: string }`

**3. POST `/recording/start`**
- Starts Agora Cloud Recording for a call
- Auth: `Authorization: Bearer <RECORDING_SERVICE_TOKEN>`
- Body: `{ callId: string, channelName: string }`
- Workflow:
  1. Calls Agora `acquire` API → gets `resourceId`
  2. Calls Agora `start` API → gets `sid` (session ID)
  3. Configures individual recording mode with S3 storage
- Returns: `{ callId, channelName, resourceId, sid, recorderUid }`
- Note: `recorderUid` is deterministically derived from `callId`

**4. POST `/recording/stop`**
- Stops Agora Cloud Recording
- Auth: `Authorization: Bearer <RECORDING_SERVICE_TOKEN>`
- Body: `{ callId: string, channelName: string, resourceId: string, sid: string }`
- Returns: `{ ok: true }`

**Environment Variables**:
```bash
# Server
PORT=3000

# Authentication
RECORDING_SERVICE_TOKEN=<long-random-secret>
RECORDER_UID=999999999  # Reserved UID for cloud recorder

# Agora Cloud Recording
AGORA_APP_ID=<agora-app-id>
AGORA_CUSTOMER_ID=<agora-customer-id>
AGORA_CUSTOMER_SECRET=<agora-customer-secret>
AGORA_APP_CERTIFICATE=<agora-app-certificate>  # Optional

# AWS S3 Storage
S3_BUCKET=periph-modo-record
S3_REGION_CODE=2  # Agora S3 region code (2 = us-west-1)
S3_ACCESS_KEY_ID=<aws-access-key>
S3_SECRET_ACCESS_KEY=<aws-secret-key>
S3_PREFIX=recordings
```

**Architecture & Security**:

The recording service is intentionally separated from the main API for security:
- **Credential Isolation**: Agora and AWS credentials never exposed in main API
- **Owner-Only Access**: Deployed to private Railway project (owner access only)
- **No Credential Leakage**: Never returns S3 URLs or AWS credentials
- **Bearer Token Auth**: All endpoints require matching token from main API

**Integration with Main API**:

The main API calls this microservice via HTTP:
```
Main API (NestJS) → HTTP POST → Recording Service → Agora Cloud Recording API
                                        ↓
                                    AWS S3 Storage
```

Main API files that integrate:
- `api/src/infrastructure/recording/recording.private.service.ts` - HTTP client
- `api/src/modules/calls/infrastructure/events/handlers/call-started.handler.ts` - Calls `/recording/start`
- `api/src/modules/calls/infrastructure/events/handlers/call-ended.handler.ts` - Calls `/recording/stop`

**Deployment**:

Recommended: Railway (private project)
```bash
# Deploy to Railway
railway init
railway up

# Set environment variables via Railway dashboard
# Restrict project membership to owner only
```

Alternative: Heroku, AWS ECS, Google Cloud Run, DigitalOcean App Platform

**Local Development**:
```bash
cd recording-service/
npm install

# Set environment variables (copy from .env.example)
export PORT=3000
export RECORDING_SERVICE_TOKEN="..."
export AGORA_APP_ID="..."
# ... (other vars)

npm run dev
# Service runs on http://localhost:3000
```

**Security Notes**:
- Keep `RECORDING_SERVICE_TOKEN` long and random (minimum 32 hex characters)
- Never commit `.env` files or credentials to git
- Only deploy to private Railway project with restricted access
- Service never returns AWS credentials or S3 URLs in responses
- All sensitive operations logged securely without exposing secrets

**Related Documentation**:
- `recording-service/README.md` - Full deployment guide
- `CALL_RECORDING_AUDIT.md` - Complete recording system audit
- Main API recording integration: `api/src/infrastructure/recording/`

---

## How the System Works Together

### Authentication Flow

1. **Guest/Creator enters email** → `web` or `ios` sends request to `api`
2. **API** validates email and sends OTP code via Auth0/email service
3. **User enters OTP** → `api` validates code
4. **API returns**:
   - `User` object
   - `Creator` object (if creator account)
   - `Token` (access + refresh tokens)
5. **Client stores tokens** (Keychain on iOS, localStorage on web)
6. **All subsequent API calls** include `Authorization: <accessToken>` header
7. **On 401 response**, client auto-refreshes token via `/api/v1/auth/refresh`

### Real-Time Communication Stack

**1. Socket.IO** (Notifications & Status Updates)
- **Namespace**: `/notifications`
- **Authentication**: Handshake includes `{ UserID, AccessToken }`
- **Events**:
  - `creator_status_update`: Creator goes online/away
  - `incoming_call`: New call request notification
  - `call_accepted`: Call accepted by creator
  - `call_ended`: Call terminated

**2. Firebase Realtime Database** (Call Signaling)
- **Paths**:
  - `users/{userId}/activeCalls`: Incoming call queue
  - `lobbies/{callId}`: Call lobby coordination
    - `guest/joined`: Guest joined status
    - `creator/joined`: Creator joined status
- **Purpose**: Coordinate call join state before Agora connection

**3. Agora RTC** (Video/Audio Streaming)
- **Channel**: Unique channel name per call (e.g., `call_{callId}`)
- **Token**: Generated by `api` via `/getToken` endpoint (expires after 24h)
- **Flow**:
  1. Client requests Agora token from API
  2. API generates token using Agora SDK
  3. Client joins Agora channel with token
  4. Agora handles media streaming peer-to-peer

### Call Lifecycle

```
1. Guest browses creator profile (web/ios)
   ↓
2. Guest requests call → API creates Call document in MongoDB
   ↓
3. API writes to Firebase: users/{creatorId}/activeCalls/{callId}
   ↓
4. API sends Socket.IO event: incoming_call to creator
   ↓
5. API sends Push Notification to creator (VoIP/FCM)
   ↓
6. Creator accepts call → API updates Call status
   ↓
7. Both parties join Firebase lobby: lobbies/{callId}
   ↓
8. Both parties request Agora token from API
   ↓
9. Both parties join Agora channel and start streaming
   ↓
10. API starts recording (async, non-blocking):
    - Calls recording-service POST /recording/start
    - Recording-service calls Agora Cloud Recording API
    - Agora records to S3 bucket
    - API saves recording metadata to MongoDB
   ↓
11. Call ends → API records duration, calculates earnings
    ↓
12. API stops recording:
    - Calls recording-service POST /recording/stop
    - Agora finalizes recording and generates files
    ↓
13. API creates Stripe payout for creator
    ↓
14. Both clients leave Agora channel and Firebase lobby
```

### Payment Flow

**Stripe Connect Integration**:
- **Creators** onboard via Stripe Connect (OAuth flow)
- **Platform** acts as parent Stripe account
- **Guests** pay for calls → funds go to platform account
- **Platform** transfers creator earnings to their Stripe Connect account
- **Creators** withdraw to bank account via Stripe payouts

**Call Pricing**:
- Stored in `Creator.PricePerMinute` (in cents)
- Calculated post-call: `duration (minutes) × pricePerMinute`
- Platform takes commission (configurable percentage)

---

## Development Workflow

### Running the Full Stack Locally

**1. Backend API**:
```bash
cd api/
npm install
npm run start:dev
# Runs on http://localhost:3000
```

**2. Web App**:
```bash
cd web/
npm install
npm run dev:staging
# Runs on http://localhost:5173
```

**3. iOS App**:
```bash
cd ios/
# Open Midnight.xcodeproj in Xcode
# Run on simulator or device
```

**4. Admin Dashboard**:
```bash
cd dashboard/
npm install
npm run dev
# Runs on http://localhost:3000 (different port if API is running)
```

**5. Recording Service** (optional for local development):
```bash
cd recording-service/
npm install
# Configure environment variables (see recording-service/README.md)
npm run dev
# Runs on http://localhost:3000 (or configured PORT)
```

### Environment Configuration

**API** (`api/.env`):
- `NODE_ENV`: `development` | `staging` | `production`
- `MONGO_URI`: MongoDB connection string
- `REDIS_HOST`, `REDIS_PORT`: Redis config
- `AGORA_APP_ID`, `AGORA_APP_CERTIFICATE`: Agora credentials
- `STRIPE_SECRET_KEY`: Stripe API key
- `AUTH0_DOMAIN`, `AUTH0_CLIENT_ID`, `AUTH0_CLIENT_SECRET`: Auth0 config
- `FIREBASE_SERVICE_ACCOUNT`: Firebase Admin SDK JSON

**Web** (`web/.env`):
- `VITE_API_URL`: Backend API URL
- `VITE_AGORA_APP_ID`: Agora App ID
- `VITE_FIREBASE_CONFIG`: Firebase client SDK config

**iOS** (`ios/Midnight/Config.swift`):
- `apiBaseURL`: Backend API endpoint
- `agoraAppID`: Agora App ID
- `isStaging`: Toggle staging/production
- Environment switching via `./switch-env.sh staging|prod`

**Dashboard** (`dashboard/.env.local`):
- `AUTH0_SECRET`: Auth0 session secret
- `AUTH0_BASE_URL`: Dashboard URL
- `AUTH0_ISSUER_BASE_URL`: Auth0 domain
- `AUTH0_CLIENT_ID`, `AUTH0_CLIENT_SECRET`: Auth0 admin app credentials

---

## Common Development Tasks

### Adding a New API Endpoint

1. **Create module** in `api/src/modules/{module-name}/`
2. **Define controller** with route handlers
3. **Create service** with business logic
4. **Add DTOs** for request/response validation (class-validator)
5. **Update module imports** in `app.module.ts`
6. **Test endpoint** with Postman/Thunder Client
7. **Update iOS/Web clients** to consume new endpoint

### Adding a New iOS Screen

1. **Create View** in `ios/Midnight/Views/{section}/`
2. **Create ViewModel** in `ios/Midnight/ViewModels/` (if needed)
3. **Add navigation** from parent view
4. **Update APIClient** if new endpoints needed
5. **Add localized strings** to `Localizable.strings` (all languages)
6. **Test on simulator** and physical device

### Adding a New Web Page

1. **Create page component** in `web/src/pages/`
2. **Add route** in `App.tsx` or router config
3. **Create service methods** in `web/src/services/api/`
4. **Add Zustand store** if complex state needed
5. **Add translations** in `web/src/locales/{lang}/`
6. **Test responsiveness** at different screen sizes

### Running Database Migrations

```bash
cd api/
# Mongoose auto-handles schema changes
# For manual data migrations, create scripts in api/src/scripts/
npm run migration:name-of-migration
```

### Deploying to Production

**API**:
- Deployed to cloud server (AWS/DigitalOcean/Heroku)
- Environment variables configured on server
- MongoDB Atlas for production database
- Redis Cloud for production caching

**Web**:
- Built with `npm run build`
- Deployed to Vercel/Netlify/Firebase Hosting
- Environment variables configured in deployment platform

**iOS**:
- Switch to production: `./switch-env.sh prod`
- Build in Xcode with Release configuration
- Submit to App Store Connect via Xcode

**Dashboard**:
- Built with `npm run build`
- Deployed to Vercel (Next.js optimized hosting)

---

## Key Patterns & Conventions

### API Error Handling
All API errors follow this format:
```typescript
{
  Status: false,
  Message: "User-friendly error message",
  Code: "ERROR_CODE", // e.g., "INVALID_TOKEN", "CALL_NOT_FOUND"
  Data: null
}
```

### iOS Token Management
- `TokenStorage`: Keychain storage for access/refresh tokens
- `APIClient`: Auto-refreshes tokens on 401 response
- `AuthService`: Manages login/logout flow
- Never manually refresh tokens; `APIClient` handles it

### Web State Management
- **Zustand stores** for global state (user, call, socket)
- **React Query** for server state caching
- **Local storage** for persistence (tokens, preferences)

### Database Schemas (MongoDB)

**User**:
```typescript
{
  _id: ObjectId,
  Email: string,
  Username: string (unique),
  FirstName: string,
  LastName: string,
  ProfileImageURL?: string,
  Role: 'Guest' | 'Creator' | 'Admin',
  Status: 'Active' | 'Suspended',
  CreatedAt: Date,
  UpdatedAt: Date
}
```

**Creator** (extends User):
```typescript
{
  UserID: ObjectId (ref: User),
  DisplayName: string,
  Bio: string,
  PricePerMinute: number (cents),
  IsOnline: boolean,
  StripeAccountID?: string,
  OnboardingCompleted: boolean,
  Categories: string[],
  SocialLinks: {...}
}
```

**Call**:
```typescript
{
  _id: ObjectId,
  GuestID: ObjectId (ref: User),
  CreatorID: ObjectId (ref: User),
  Status: 'Pending' | 'Active' | 'Completed' | 'Cancelled',
  StartedAt?: Date,
  EndedAt?: Date,
  DurationMinutes?: number,
  PricePerMinute: number,
  TotalAmount?: number,
  AgoraChannelName: string,
  FirebaseLobbyPath: string
}
```

---

## Testing

### API Tests
```bash
cd api/
npm run test              # Unit tests
npm run test:e2e          # End-to-end tests
npm run test:cov          # Coverage report
```

### iOS Tests
```bash
cd ios/
xcodebuild test -scheme Midnight -destination 'platform=iOS Simulator,name=iPhone 16'
```

### Web Tests
```bash
cd web/
npm run test              # (if test suite configured)
```

---

## Troubleshooting

### "Token expired" errors in iOS/Web
- Check if refresh token is valid in Keychain/localStorage
- Ensure `APIClient` token refresh logic is working
- Verify backend `/auth/refresh` endpoint is accessible

### Agora connection failures
- Verify `AGORA_APP_ID` matches in API and clients
- Check token expiration (default 24h)
- Ensure firewall allows UDP ports for Agora (1080, 8000)

### Socket.IO not connecting
- Verify `socketBaseURL` is correct in client config
- Check CORS settings in API (`@nestjs/platform-socket.io`)
- Ensure Socket.IO handshake includes valid tokens

### Firebase Realtime Database permission errors
- Check Firebase rules allow authenticated read/write
- Verify Firebase service account credentials in API
- Ensure client Firebase SDK is initialized with correct config

### Call notifications not received (iOS)
- Verify VoIP certificate is uploaded to Apple Developer Portal
- Check FCM server key is configured in Firebase Console
- Ensure device tokens are registered with backend (`/devices/register`)

---

## Important Notes

### Security
- **Never commit** `.env` files or API keys to git
- **Always validate** user input on backend (class-validator DTOs)
- **Rate limit** sensitive endpoints (login, OTP, payments)
- **Use HTTPS** for all production traffic
- **Sanitize** user-generated content before rendering

### Performance
- **Cache** frequently accessed data in Redis
- **Paginate** API responses (default 20 items per page)
- **Optimize images** before uploading to Cloudinary
- **Use indexes** on MongoDB fields used in queries
- **Lazy load** images and components in web/iOS

### Monitoring
- **API logs** via Morgan middleware (HTTP requests)
- **Error logging** via custom error handlers
- **Agora analytics** in Agora Console
- **Stripe webhooks** for payment event tracking

---

## Additional Resources

- **Agora Documentation**: https://docs.agora.io
- **Stripe Connect Guide**: https://stripe.com/docs/connect
- **Firebase Realtime Database**: https://firebase.google.com/docs/database
- **NestJS Documentation**: https://docs.nestjs.com
- **SwiftUI Documentation**: https://developer.apple.com/documentation/swiftui

---

## Getting Help

When asking Claude Code for help across repositories:
- Specify which repo(s) the task involves
- Reference file paths clearly (e.g., `api/src/modules/calls/calls.service.ts`)
- Provide context about what you're trying to accomplish
- Include relevant error messages or logs

Claude has access to all 4 repositories in this workspace and can help with:
- Cross-repo feature implementation
- API endpoint creation and client integration
- Database schema design
- Real-time communication flows
- Payment processing logic
- UI/UX implementation across platforms

---

## Linear Workflow Integration

This section defines the standardized workflow for creating and executing Linear tickets in the Midnight project.

**Important**: This uses **standalone skills** (located in `~/.claude/skills/`) that connect to Linear via **Linear's GraphQL API** using a personal API key. All Linear operations use direct HTTP calls via curl/Bash for maximum reliability.

### 🎯 Midnight Linear Skill (Standalone Commands)

A **standalone Claude Code skill** has been created for the Midnight project. This skill provides interactive Linear workflow commands via **direct GraphQL API integration**.

**Location**: `~/.claude/skills/midnight-linear/`

**Architecture**:
- **Skill-based**: Standalone command system (NOT a plugin)
- **GraphQL API**: Uses Linear's GraphQL API directly via HTTP (curl/Bash)
- **API Key Authentication**: Uses personal API key for secure access
- **No MCP Dependency**: Direct HTTP calls eliminate MCP server limitations

**API Configuration**:
- **Endpoint**: `https://api.linear.app/graphql`
- **Authentication**: Personal API key (stored securely in skill configuration)
- **Team**: Midnighttalk (ID: `0e5a3787-60fb-4fcb-8436-d6ddd1e27e09`)

**Available Commands**:
- `/issues` - Browse all issues interactively with keyboard navigation
- `/projects` - View projects with progress bars and live status
- `/create-ticket` - Research codebase and create well-contexted tickets (AI auto-labels!)
- `/implement` - Full implementation workflow with plan confirmation
- `/review` - Code review with quality, security, performance checks
- `/status` - Live dashboard showing project/issue status
- `/my-tickets` - Your assigned tickets
- `/comment` - Quick comment on tickets
- `/sync` - Update ticket status

**Shortcuts**: `/i`, `/p`, `/s`, `/m`, `/c`, `/impl`, `/r`

**Key Features**:
- **AI Auto-Labeling**: Automatically analyzes ticket content and assigns appropriate labels based on description, file paths, and work type
- **Code Review**: Built-in review system checks quality, security, performance, and architecture after implementation
- **Reliable API**: Direct GraphQL API calls with no payload limits or MCP connection issues
- **Better Error Handling**: Clear HTTP error messages and status codes

**Advantages Over MCP**:
- ✅ No payload size limits (can handle large ticket descriptions)
- ✅ More reliable (direct HTTP vs proxy layer)
- ✅ Faster execution (no intermediary server)
- ✅ Better error messages (clear HTTP status codes)
- ✅ Can create multiple issues efficiently

See `~/.claude/skills/midnight-linear/README.md` for full documentation.

### 🔐 Linear API Key Management

The Linear personal API key is used for all Linear operations and is configured in the skill:

**API Key**: `lin_api_************************************` (stored securely in `~/.claude/skills/midnight-linear/skill.md`)

**Security Notes**:
- API key is stored in the skill configuration file (NOT in git)
- ⚠️ NEVER commit this key to git repositories
- Key has full access to Linear workspace (Midnighttalk team)
- Can be rotated from Linear Settings → API → Personal API Keys
- All API requests use HTTPS for secure transmission

**Generating a New Key** (if needed):
1. Go to Linear Settings → API → Personal API Keys
2. Click "Create key"
3. Give it a descriptive name (e.g., "Claude Code Integration")
4. Copy the key (starts with `lin_api_`)
5. Update the key in `~/.claude/skills/midnight-linear/skill.md`

**Common Label IDs** (for reference):
- **Bug**: `c797ce5c-4375-4b48-8a9f-9f3f589695b7`
- **API**: `43ed2dd2-4bad-4d0c-9289-d02c8df8ef2b`
- **iOS**: `b467eadf-7b37-4e46-8cce-71a2b3542d62`
- **Feature**: `f780ae20-621a-488d-a893-f236e0a6ef47`
- **Improvement**: `6a960f7d-9db2-49df-9b8c-1ff03b9e2333`

---

## Linear Workflow (API-first, Project-first)

We use the standalone skill `~/.claude/skills/midnight-linear/` which talks to Linear via **GraphQL API (direct HTTP)**.
We do **not** use MCP for Linear.

### Auth / Config
- Endpoint: https://api.linear.app/graphql
- Team: Midnighttalk
- API key: stored in the skill config or env (recommended: `LINEAR_API_KEY`).
  (Do not commit secrets.)

### Commands (skill)
- /create-project <desc>      → creates a Linear Project + issues
- /create-ticket <desc>       → creates a single issue
- /implement <MID-123>        → implement issue end-to-end
- /review <MID-123>           → review + comment
- /issues /my-tickets /projects /status /comment /sync

---

# Mental Model: Project → Issues
We build features as a **Linear Project** containing multiple **Issues** (small tasks).
- Project = feature/initiative outcome
- Issues = concrete executable tasks that make the Project succeed
If something is >1–2 days or multi-area → create a Project and split into issues.

---

# Hard Rules
- Ticket content must match the codebase: **no guessy/random details**.
- No scope creep. Out-of-scope → new issue.
- Every issue must include: **Acceptance Criteria + Test Plan + Gates**.
- **Done = Acceptance Criteria satisfied AND Gates green** (not just green tests).
- Implementation: always ask **3–6 questions using the question tool BEFORE writing the plan**.
- If Gates fail with the same root cause 2x → stop, summarize, ask 1 targeted question or propose Plan B.

---

# Labels (auto-label required)
When creating any issue:
- Auto-label using our current label set based on:
  - description keywords
  - affected file paths / repo area (iOS/API/Web/etc.)
  - work type (Bug/Feature/Improvement/API/etc.)
- If uncertain between 2 labels, pick both or ask 1 blocking question.

---

# Ticket Template (required for every issue)
## Goal
## Non-goals
## Context (from research, with file paths)

## Technical Requirements (must be explicit)
- Data model / DB changes (if any)
- API contracts (endpoints, payloads, auth)
- Edge cases & constraints (perf, security, migration, backwards compat)
- Observability (logs/metrics) + rollout (flag) if relevant

## Approach (≤6 bullets)
## Checklist (small tasks)
- [ ] ...

## Acceptance Criteria (GIVEN / WHEN / THEN)
- GIVEN ... WHEN ... THEN ...

## Test Plan (required - must be explicit)
**DO NOT write vague plans like "Test the service" or "Unit tests"**
**DO specify: test file paths, specific test cases, mocks, assertions**

### Unit Tests (if applicable)
**Files to Create:**
- path/to/file.spec.ts - Brief description

**Test Cases (list specific it() blocks):**
1. Test case name
   - Mocks: What to mock
   - Assert: What to verify
2. Another test case...

**Mocks/Stubs Required:**
- Service/dependency to mock

### Integration Tests (if applicable)
**Files to Create:**
- path/to/file.integration.spec.ts

**Test Cases:**
1. End-to-end scenario name
   - Setup: Real/test services to use
   - Assert: Expected outcomes

### E2E Tests (only for critical user flows)
**Test Scenarios:**
1. Happy path: step-by-step
2. Error scenario: what should happen

### Manual Testing (if automated tests not possible)
**Steps:**
1. Specific action to perform
2. Expected result to verify

**Coverage Requirements:**
- Unit: >80% for new code
- Integration: Critical paths covered
- No skipped/pending tests in PR

## Gates (must pass)
Prefer single command: `./ci/gates.sh`
(Otherwise list exact commands: test/lint/typecheck/build)

---

# Linear Create Project + Issues (preferred for real features)
## Phase 0 — Research (mandatory before writing tickets)
Goal: produce tickets that match the codebase (no random info).

1) Understand request + success criteria.
2) Locate relevant areas via grep/glob.
3) Read key files (similar flows, patterns, existing abstractions).
4) Identify dependencies + constraints (DB, API, clients, migrations).

5) **Questions FIRST (required)**
   - Use the **question tool** to ask **4–6 questions** before drafting the ticket(s).
   - Questions must be high-leverage and clarify: desired UX/behavior, edge cases, data/validation, API contract, rollout/flags, constraints.
   - Do not ask anything already answered by the user or obvious from the codebase.
   - If something is not blocking, do not ask—make an explicit assumption later in the ticket.

6) Draft Technical Requirements grounded in real code structure (include file paths / components).
7) Only then: create a **Project** and split into **Issues**.

## Output for Project creation (required deliverable)
After Phase 0 research + 4–6 questions, output must include:

1) **Create the Linear Project**
   - Title: concise feature name
   - Description: Short summary (Linear has 255 char limit)

   **IMPORTANT: Create a Linear Document for the full master spec**
   - Use Linear's Document feature (linked to project)
   - Include: Goal, Non-goals, Context, Technical Requirements, Feature AC, Test Strategy, Gates, Risks, Implementation Order, Files to Modify, Success Metrics
   - This is the single source of truth for the entire feature
   - All issues reference this master spec

2) **Create N Issues (small executable slices)**
   - Each issue should be **< 0.5–1 day** and independently verifiable.
   - Each issue must include (issue-level slice template):
     - Goal (slice)
     - Context (link to Project + relevant file paths)
     - Checklist
     - Acceptance Criteria (slice)
     - Test Plan (slice)
     - Gates (inherit Project Gates + any extras)

3) **Linking & ordering**
   - Link every issue to the Project.
   - Order issues logically (backend first if needed, then clients, then polish).

4) **Auto-labeling**
   - Apply labels automatically using our current label set based on:
     - repo area (iOS/API/Web/etc.)
     - work type (Bug/Feature/Improvement/etc.)
     - file paths and keywords
   - If label uncertainty is high: apply top 2 likely labels or ask 1 blocking question.

5) **Quality bar**
   - No random/ungrounded details: everything must map to real code patterns/files.
   - Dependencies and risks called out explicitly (DB migration, API breaking changes, rollout/flags).

---

# Create Single Issue (/create-ticket)
Use only for small isolated tasks.
Same rules: do research first, then write ticket with grounded context.

---

# Implement Issue (/implement MID-123)

### Phase 1 — Intake
1) Read `Claude.md` rules + gates.
2) Fetch the Linear issue + read thoroughly (Goal/Non-goals/AC/Test Plan/Tech Req).
3) Read relevant code (grep/glob + open key files).

### Phase 2 — Questions FIRST (required)
4) Use the **question tool** to ask **3–6 questions** BEFORE writing the implementation plan.
   - High-leverage only: UX behavior, edge cases, data/validation, API contract, rollout, constraints.
   - If ticket already answers it, don’t ask again.
   - If not blocking, don’t ask—state an assumption later.

### Phase 3 — Implementation Plan (must follow Linear steps)
5) Create a short implementation plan that follows the issue’s **Checklist / Linear steps**:
   - list files to change/create
   - map each checklist item → concrete code steps
   - include tests to add/update
   - include gates to run

### Phase 4 — Execute
6) Implement + add/update tests.
7) Run Gates until green.

### Phase 5 — Update Linear
8) Update Linear:
   - status In Progress at start
   - final comment: summary + how to test + commands run + risks
   - status Done only after Acceptance Criteria + Gates are satisfied
