# OPENAI_MESHY_ARCHITECTURE.md

# 내 남자친구는 AI
## OpenAI + Meshy Architecture

---

# 전체 시스템 구조

```text
Flutter App
     │
     ▼
Firebase Auth
     │
     ▼
Cloud Functions
     │
     ├─────────────── OpenAI GPT
     │
     ├─────────────── OpenAI Image
     │
     ├─────────────── OpenAI Realtime
     │
     └─────────────── Meshy API
                         │
                         ▼
                    3D Model(GLB)
                         │
                         ▼
                 Firebase Storage
                         │
                         ▼
                    Flutter Viewer
```

---

# 생성 프로세스

## STEP 1

사용자 이상형 설정

```json
{
  "faceType": "cat",
  "hairStyle": "dandy",
  "bodyType": "athletic",
  "fashionStyle": "minimal",

  "kindness": 90,
  "humor": 80,

  "voice": "warm"
}
```

---

# STEP 2

GPT 페르소나 생성

Cloud Function

```typescript
generatePersona()
```

---

Prompt

```text
사용자의 이상형을 바탕으로

이름
나이
직업
MBTI
말투
취미
가치관

을 생성하라.
```

---

응답

```json
{
  "name": "민준",

  "age": 25,

  "job": "Software Engineer",

  "mbti": "ENFP",

  "speechStyle": "다정한 반말"
}
```

---

저장

```text
Firestore

ai_boyfriends
```

---

# STEP 3

이미지 생성

Cloud Function

```typescript
generateBoyfriendImage()
```

---

Prompt 생성

```text
Korean handsome male

25 years old

cat face

dandy haircut

athletic body

minimal fashion

photorealistic

studio quality
```

---

OpenAI Image API

```text
POST
/images/generate
```

---

결과

```text
profile.png
```

---

Storage 저장

```text
/users/{uid}/boyfriend/images/profile.png
```

---

# STEP 4

Meshy 3D 생성

Cloud Function

```typescript
generateBoyfriend3D()
```

---

입력

```text
profile.png
```

---

Meshy API

```http
POST /image-to-3d
```

---

응답

```json
{
  "task_id": "task123"
}
```

---

Polling

```http
GET /tasks/task123
```

---

상태

```text
PENDING
PROCESSING
SUCCEEDED
FAILED
```

---

완료

```json
{
  "model_url": "https://..."
}
```

---

Storage 저장

```text
/users/{uid}/boyfriend/3d/model.glb
```

---

# STEP 5

썸네일 생성

Cloud Function

```typescript
generateThumbnail()
```

---

결과

```text
thumbnail.png
```

---

# STEP 6

Firestore 업데이트

```json
{
  "profileImageUrl": "...",

  "modelUrl": "...",

  "status": "completed"
}
```

---

# 채팅 아키텍처

사용자

↓

채팅 입력

↓

Cloud Function

↓

GPT

↓

응답 생성

↓

Firestore 저장

↓

실시간 UI 반영

---

구조

```text
Flutter
 ↓

Firestore

 ↓

Cloud Function

 ↓

GPT

 ↓

Firestore

 ↓

Flutter
```

---

# 기억 시스템

사용자 대화

↓

Memory Extractor

↓

중요 정보 추출

---

예시

```text
내 생일은 5월 3일이야.
```

↓

저장

```json
{
  "type": "birthday",

  "value": "05-03"
}
```

---

Collection

```text
memories
```

---

# 음성 통화

## Realtime API

```text
Flutter Mic

 ↓

OpenAI Realtime

 ↓

AI 음성

 ↓

Flutter Speaker
```

---

기능

- 실시간 대화
- 감정 표현
- 음성 스트리밍

---

# 관계 성장 시스템

행동

↓

포인트

↓

호감도 증가

---

예시

```text
채팅
+1

음성통화
+5

데이트
+10

기념일
+30
```

---

Firestore

```text
relationship_logs
```

---

# 이미지 생성 이벤트

트리거

```text
100일

생일

데이트

크리스마스

여행
```

---

GPT Prompt

```text
민준과 사용자가

크리스마스 데이트를
하는 장면 생성
```

---

OpenAI

↓

이미지 생성

↓

앨범 저장

---

# 위치 기반 데이트

Flutter

↓

GPS

↓

Google Places

↓

장소 분석

↓

GPT

---

예시

```text
현재 위치

스타벅스
```

↓

AI

```text
여기 분위기 좋다.

같이 커피 마시는 기분이야.
```

---

# 비용 최적화

## GPT

캐시 사용

---

중복 질문

```text
오늘 날씨 어때?
```

↓

재사용

---

## 이미지

이벤트 발생 시만 생성

---

매일 생성 금지

---

## Meshy

생성 시 1회만 실행

---

재생성은 유료 기능

---

# 추천 인프라

Frontend

- Flutter

Backend

- Firebase Functions

Database

- Firestore

Storage

- Firebase Storage

AI

- OpenAI GPT-5
- OpenAI Image
- OpenAI Realtime

3D

- Meshy API

Map

- Google Maps
- Google Places

Weather

- OpenWeather

Analytics

- Firebase Analytics

Push

- Firebase Messaging
```
:::

현재 설계 기준으로 보면 **Firebase 서버리스 구조만으로 MVP~초기 상용화까지 충분히 가능**합니다.

특히 주인님 서비스는 사용자가 생성하는 순간이 핵심이므로, 생성 파이프라인을 다음과 같이 비동기 처리하는 것을 추천합니다.

```text
생성하기 클릭
↓
Cloud Function Queue
↓
GPT 페르소나 생성
↓
이미지 생성
↓
Meshy 생성
↓
Firestore 상태 업데이트
↓
실시간 진행률 표시
↓
첫 만남 화면 진입
```

이 구조가 가장 안정적이고 비용 효율적입니다.