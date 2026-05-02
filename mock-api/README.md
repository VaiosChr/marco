# MARCO Mock API

A `json-server` mock backend for the MARCO Flutter assignment.

## Setup

```bash
cd mock-api
npm install
npm start
```

Server runs at **http://localhost:3000**

> For physical Android device testing use `npm run start:host` and point Flutter to `http://<your-machine-IP>:3000`.

---

## Endpoints

### Auth

| Method | Path | Description |
|--------|------|-------------|
| POST | `/api/sessions` | Login — returns `{ token, parentId }` |
| DELETE | `/api/sessions/:id` | Logout |

### OTP

| Method | Path | Description |
|--------|------|-------------|
| POST | `/api/otp/request` | Trigger mock OTP (any 6-digit code will verify) |
| POST | `/api/otp/verify?action=verify` | Verify code — body: `{ code: "123456" }` |

### Parents

| Method | Path |
|--------|------|
| GET/POST | `/api/parents` |
| GET/PUT/PATCH/DELETE | `/api/parents/:id` |

### Children

| Method | Path |
|--------|------|
| GET/POST | `/api/children` |
| GET/PUT/PATCH/DELETE | `/api/children/:id` |

**Consent update example:**
```http
PATCH /api/children/c1
Content-Type: application/json

{
  "consents": {
    "anonymizedRouteData": false,
    "aiRouteSuggestions": true,
    "municipalityDataSharing": false
  }
}
```

### Routes

| Method | Path |
|--------|------|
| GET/POST | `/api/routes` |
| GET/PUT/PATCH/DELETE | `/api/routes/:id` |

### Route Status *(mock-live)*

```
GET /api/route-status?routeId=r1
```
Returns randomised values on every call — use this to simulate polling.

**Response:**
```json
{
  "routeId": "r1",
  "safety": 8.4,
  "airQuality": 6.1,
  "noiseDb": 65,
  "overallStatus": "CAUTION",
  "updatedAt": "..."
}
```

**Threshold logic (document in your Flutter README):**
- `OK` — safety ≥ 7, airQuality ≥ 6, noiseDb ≤ 70
- `CAUTION` — any one metric slightly outside OK range
- `ALERT` — safety < 5, airQuality < 4, or noiseDb > 80

### AI Suggestions

```
GET /api/ai-suggestions?routeId=r1
```

### Suggestion Feedback

```
POST /api/suggestion-feedback
{ "suggestionId": "as1", "liked": true, "stars": 4 }
```
Returns `pointsEarned` (50 if liked, 5 otherwise).

### Trip Logs

```
POST /api/trip-logs
{
  "childId": "c1",
  "parentId": "p1",
  "date": "2026-05-01",
  "routeTaken": "usual" | "suggested" | "other",
  "mood": "happy" | "neutral" | "sad" | "excited",
  "notes": ""
}
```
Points: `usual/other` → 10 pts, `suggested` → 50 pts.

### Rewards

```
GET /api/rewards?parentId=p1
PATCH /api/rewards/rw1   ← update points/streak after trip log
```

### Kid Profiles

```
GET /api/kid-profiles?childId=c1
```

---

## Base URLs for Flutter

```dart
// lib/core/constants/api_constants.dart

// Android emulator
const kBaseUrl = 'http://10.0.2.2:3000/api';

// Physical device (replace with your machine IP)
// const kBaseUrl = 'http://192.168.1.X:3000/api';

// iOS simulator
// const kBaseUrl = 'http://127.0.0.1:3000/api';
```
