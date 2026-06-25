# FIRESTORE_COLLECTIONS.md

# 내 남자친구는 AI
## Firestore Collection Design

---

# 전체 구조

```text
users
│
├── ai_boyfriends
│   ├── chats
│   ├── memories
│   ├── calls
│   ├── relationship_logs
│   ├── gallery
│   ├── schedules
│   └── notifications
│
subscriptions
payments
system_configs
```

---

# 1. users

사용자 기본 정보

Collection

```text
users
```

Document

```text
users/{uid}
```

Example

```json
{
  "uid": "uid123",

  "nickname": "지연",

  "email": "test@test.com",

  "provider": "google",

  "birthDate": "2000-01-01",

  "gender": "female",

  "premium": false,

  "currentBoyfriendId": "bf_001",

  "createdAt": Timestamp,

  "updatedAt": Timestamp,

  "lastLoginAt": Timestamp
}
```

---

# 2. ai_boyfriends

AI 남자친구

```text
users/{uid}/ai_boyfriends
```

---

Document

```text
users/{uid}/ai_boyfriends/{boyfriendId}
```

---

Example

```json
{
  "boyfriendId": "bf_001",

  "name": "민준",

  "age": 25,

  "job": "Software Engineer",

  "mbti": "ENFP",

  "loveLevel": 3,

  "loveScore": 72,

  "voiceType": "warm",

  "profileImageUrl": "",

  "modelUrl": "",

  "personaPrompt": "",

  "status": "active",

  "createdAt": Timestamp,

  "updatedAt": Timestamp
}
```

---

# 3. appearance

외형 설정

```text
users/{uid}/ai_boyfriends/{boyfriendId}/appearance
```

---

Document

```json
{
  "faceType": "cat",

  "hairStyle": "dandy",

  "bodyType": "athletic",

  "fashionStyle": "minimal",

  "height": 182
}
```

---

# 4. personality

성격

```text
users/{uid}/ai_boyfriends/{boyfriendId}/personality
```

---

Document

```json
{
  "kindness": 90,

  "humor": 80,

  "leadership": 70,

  "jealousy": 40,

  "romantic": 95,

  "empathy": 85
}
```

---

# 5. chats

채팅

가장 큰 Collection

```text
users/{uid}/ai_boyfriends/{boyfriendId}/chats
```

---

Document

```json
{
  "messageId": "msg001",

  "sender": "user",

  "message": "안녕",

  "messageType": "text",

  "imageUrl": null,

  "audioUrl": null,

  "createdAt": Timestamp
}
```

---

messageType

```text
text
image
voice
system
```

---

추천

하루 500~1000개 가능

월 단위 분리

```text
chat_rooms
 └─ 2026_01
 └─ 2026_02
```

가능

---

# 6. memories

추억

```text
users/{uid}/ai_boyfriends/{boyfriendId}/memories
```

---

Document

```json
{
  "memoryId": "memory001",

  "title": "첫 만남",

  "description": "민준과 처음 만난 날",

  "memoryType": "first_meeting",

  "imageUrl": "",

  "eventDate": Timestamp,

  "createdAt": Timestamp
}
```

---

memoryType

```text
first_meeting
date
anniversary
travel
daily
gift
```

---

# 7. calls

음성 통화

```text
users/{uid}/ai_boyfriends/{boyfriendId}/calls
```

---

Document

```json
{
  "callId": "call001",

  "duration": 480,

  "summary": "오늘 하루 이야기",

  "emotionScore": 85,

  "createdAt": Timestamp
}
```

---

# 8. relationship_logs

관계 성장

```text
users/{uid}/ai_boyfriends/{boyfriendId}/relationship_logs
```

---

Document

```json
{
  "action": "chat",

  "score": 5,

  "totalScore": 72,

  "createdAt": Timestamp
}
```

---

action

```text
chat
call
date
gift
memory
anniversary
```

---

# 9. gallery

AI 이미지

```text
users/{uid}/ai_boyfriends/{boyfriendId}/gallery
```

---

Document

```json
{
  "imageId": "img001",

  "imageUrl": "",

  "prompt": "",

  "type": "profile",

  "createdAt": Timestamp
}
```

---

type

```text
profile
daily
date
event
memory
```

---

# 10. schedules

데이트 일정

```text
users/{uid}/ai_boyfriends/{boyfriendId}/schedules
```

---

Document

```json
{
  "title": "한강 데이트",

  "location": "여의도",

  "scheduledAt": Timestamp,

  "status": "planned"
}
```

---

# 11. notifications

알림

```text
users/{uid}/notifications
```

---

Document

```json
{
  "title": "민준이 보고 싶어해요",

  "body": "오늘 하루 어땠어?",

  "isRead": false,

  "type": "chat",

  "createdAt": Timestamp
}
```

---

# 12. settings

설정

```text
users/{uid}/settings/main
```

---

Document

```json
{
  "theme": "dark",

  "language": "ko",

  "pushEnabled": true,

  "voiceEnabled": true,

  "locationEnabled": true
}
```

---

# 13. subscriptions

구독

Top Level Collection

```text
subscriptions
```

---

Document

```json
{
  "uid": "uid123",

  "plan": "premium",

  "status": "active",

  "startedAt": Timestamp,

  "expiredAt": Timestamp
}
```

---

# 14. payments

결제

```text
payments
```

---

Document

```json
{
  "uid": "uid123",

  "amount": 9900,

  "currency": "KRW",

  "status": "paid",

  "paymentMethod": "iap",

  "createdAt": Timestamp
}
```

---

# 15. system_configs

운영 설정

```text
system_configs
```

---

Document

```json
{
  "dailyChatLimit": 50,

  "freeImageLimit": 3,

  "premiumImageLimit": 100
}
```

---

# Firebase Storage

```text
storage

/users
    /{uid}

        /profile

        /boyfriends

            /bf_001

                /images

                /memories

                /voice

                /3d

                    model.glb

                    thumbnail.png

                    animations
```

---

# 필수 Composite Index

```text
chats
createdAt DESC

memories
eventDate DESC

relationship_logs
createdAt DESC

gallery
createdAt DESC

notifications
createdAt DESC
```

---

# 예상 문서 수

```text
User 1명

boyfriend
      1

chats
      100,000+

memories
      1,000+

gallery
      500+

calls
      1,000+

relationship_logs
      10,000+
```

Firestore 기준 충분히 처리 가능.