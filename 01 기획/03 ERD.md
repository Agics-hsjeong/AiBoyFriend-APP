# ERD.md

# 내 남자친구는 AI
## Firebase Firestore Data Model

---

# ERD 개요

```text
users
 ├─ ai_boyfriends
 │   ├─ memories
 │   ├─ chats
 │   ├─ calls
 │   ├─ relationship_logs
 │   ├─ gallery
 │   └─ schedules
 │
 ├─ subscriptions
 ├─ notifications
 ├─ settings
 └─ payments
```

---

# 1. users

사용자 정보

Collection

```text
users
```

Document

```json
{
  "uid": "firebase_uid",
  "email": "user@email.com",
  "nickname": "지연",
  "birthDate": "2000-01-01",
  "profileImage": "",
  "provider": "google",
  "premium": false,
  "createdAt": "timestamp",
  "updatedAt": "timestamp",
  "lastLoginAt": "timestamp"
}
```

---

# 2. ai_boyfriends

사용자별 AI 남자친구

Collection

```text
users/{uid}/ai_boyfriends
```

---

Document

```json
{
  "boyfriendId": "bf_001",

  "name": "민준",

  "age": 25,

  "job": "Software Engineer",

  "mbti": "ENFP",

  "personaPrompt": "...",

  "greeting": "안녕, 나는 민준이야.",

  "profileImage": "https://",

  "voiceType": "warm",

  "meshyModelUrl": "https://",

  "glbUrl": "https://",

  "loveLevel": 3,

  "loveScore": 72,

  "createdAt": "timestamp",

  "updatedAt": "timestamp"
}
```

---

# 3. appearance

외형 정보

SubCollection

```text
ai_boyfriends/{boyfriendId}/appearance
```

---

Document

```json
{
  "faceType": "cat",
  "hairStyle": "parted",
  "bodyType": "athletic",
  "fashionStyle": "minimal",

  "height": 182,

  "weight": 72
}
```

---

# 4. personality

성격 정보

SubCollection

```text
ai_boyfriends/{boyfriendId}/personality
```

---

Document

```json
{
  "kindness": 85,
  "humor": 70,
  "leadership": 60,
  "jealousy": 30,
  "romantic": 90,
  "empathy": 80
}
```

---

# 5. chats

채팅

SubCollection

```text
ai_boyfriends/{boyfriendId}/chats
```

---

Document

```json
{
  "messageId": "msg_001",

  "role": "user",

  "message": "안녕",

  "messageType": "text",

  "imageUrl": null,

  "createdAt": "timestamp"
}
```

---

MessageType

```text
text
image
voice
system
```

---

# 6. memories

추억 앨범

SubCollection

```text
ai_boyfriends/{boyfriendId}/memories
```

---

Document

```json
{
  "memoryId": "memory_001",

  "title": "첫 만남",

  "description": "민준과 처음 만난 날",

  "imageUrl": "https://",

  "memoryType": "first_meeting",

  "date": "2026-01-01",

  "createdAt": "timestamp"
}
```

---

MemoryType

```text
first_meeting
date
travel
anniversary
daily
gift
```

---

# 7. calls

통화 기록

SubCollection

```text
ai_boyfriends/{boyfriendId}/calls
```

---

Document

```json
{
  "callId": "call_001",

  "duration": 180,

  "summary": "오늘 하루 이야기",

  "emotionScore": 85,

  "createdAt": "timestamp"
}
```

---

# 8. relationship_logs

관계 성장 로그

SubCollection

```text
ai_boyfriends/{boyfriendId}/relationship_logs
```

---

Document

```json
{
  "logId": "rel_001",

  "action": "chat",

  "point": 5,

  "totalScore": 72,

  "createdAt": "timestamp"
}
```

---

Action

```text
chat
call
date
memory
gift
anniversary
```

---

# 9. gallery

AI 이미지

SubCollection

```text
ai_boyfriends/{boyfriendId}/gallery
```

---

Document

```json
{
  "imageId": "img_001",

  "imageUrl": "https://",

  "prompt": "...",

  "type": "profile",

  "createdAt": "timestamp"
}
```

---

Type

```text
profile
memory
date
event
```

---

# 10. schedules

데이트 일정

SubCollection

```text
ai_boyfriends/{boyfriendId}/schedules
```

---

Document

```json
{
  "scheduleId": "schedule_001",

  "title": "한강 산책",

  "dateTime": "timestamp",

  "location": "한강공원",

  "status": "planned"
}
```

---

# 11. subscriptions

구독

Collection

```text
subscriptions
```

---

Document

```json
{
  "uid": "firebase_uid",

  "plan": "premium",

  "status": "active",

  "startAt": "timestamp",

  "endAt": "timestamp"
}
```

---

# 12. payments

결제

Collection

```text
payments
```

---

Document

```json
{
  "paymentId": "pay_001",

  "uid": "firebase_uid",

  "amount": 9900,

  "currency": "KRW",

  "status": "paid",

  "createdAt": "timestamp"
}
```

---

# 13. notifications

알림

Collection

```text
notifications
```

---

Document

```json
{
  "notificationId": "noti_001",

  "uid": "firebase_uid",

  "title": "민준이 메시지를 보냈어요",

  "body": "좋은 아침!",

  "isRead": false,

  "createdAt": "timestamp"
}
```

---

# 14. settings

설정

Collection

```text
settings
```

---

Document

```json
{
  "uid": "firebase_uid",

  "theme": "dark",

  "language": "ko",

  "pushEnabled": true,

  "voiceEnabled": true
}
```

---

# Firestore Index

필수 Composite Index

```text
chats
createdAt DESC

memories
date DESC

relationship_logs
createdAt DESC

notifications
createdAt DESC
```

---

# Firebase Storage 구조

```text
storage

/users
    /{uid}

        /profile

        /boyfriend

            /images

            /memories

            /3d

                model.glb

                thumbnail.png

                animation.fbx
```