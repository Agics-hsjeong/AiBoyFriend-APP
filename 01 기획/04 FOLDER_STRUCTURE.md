# FOLDER_STRUCTURE.md

# 내 남자친구는 AI
## Flutter Project Structure

```text
lib
│
├── main.dart
│
├── app
│   ├── app.dart
│   ├── router
│   │   ├── app_router.dart
│   │   └── route_names.dart
│   │
│   ├── theme
│   │   ├── app_theme.dart
│   │   ├── colors.dart
│   │   ├── typography.dart
│   │   └── spacing.dart
│   │
│   └── constants
│       ├── app_constants.dart
│       ├── api_constants.dart
│       └── firebase_constants.dart
│
├── core
│   │
│   ├── network
│   │   ├── api_client.dart
│   │   └── network_info.dart
│   │
│   ├── storage
│   │   ├── hive_service.dart
│   │   └── secure_storage_service.dart
│   │
│   ├── firebase
│   │   ├── auth_service.dart
│   │   ├── firestore_service.dart
│   │   ├── storage_service.dart
│   │   └── analytics_service.dart
│   │
│   ├── services
│   │   ├── openai_service.dart
│   │   ├── meshy_service.dart
│   │   ├── location_service.dart
│   │   ├── weather_service.dart
│   │   └── notification_service.dart
│   │
│   ├── models
│   │
│   ├── widgets
│   │
│   ├── utils
│   │
│   └── providers
│
├── features
│
│   ├── splash
│   │
│   ├── onboarding
│   │
│   ├── auth
│   │
│   ├── boyfriend_creation
│   │
│   ├── ai_generation
│   │
│   ├── first_meeting
│   │
│   ├── home
│   │
│   ├── chat
│   │
│   ├── voice_call
│   │
│   ├── profile
│   │
│   ├── relationship
│   │
│   ├── memory_album
│   │
│   ├── model_viewer
│   │
│   ├── date_place
│   │
│   ├── notification
│   │
│   ├── premium
│   │
│   └── settings
│
└── shared
    ├── widgets
    ├── dialogs
    ├── bottom_sheet
    ├── extensions
    └── helpers
```

---

# Feature 구조

예시

boyfriend_creation

```text
features
└── boyfriend_creation

    ├── data
    │
    │   ├── datasource
    │   │   ├── remote
    │   │   └── local
    │   │
    │   ├── models
    │   │
    │   └── repositories
    │
    ├── domain
    │   │
    │   ├── entities
    │   │
    │   ├── repositories
    │   │
    │   └── usecases
    │
    └── presentation
        │
        ├── providers
        │
        ├── pages
        │
        ├── widgets
        │
        └── controllers
```

---

# 주요 Feature

## onboarding

```text
presentation

├── onboarding_01_page.dart
├── onboarding_02_page.dart
├── onboarding_03_page.dart
├── onboarding_04_page.dart
├── onboarding_05_page.dart
└── onboarding_06_page.dart
```

---

## auth

```text
presentation

├── login_page.dart
├── signup_page.dart
└── auth_provider.dart
```

---

## boyfriend_creation

```text
presentation

├── step1_face_page.dart
├── step2_hair_page.dart
├── step3_body_page.dart
├── step4_style_page.dart
├── step5_personality_page.dart
├── step6_voice_page.dart
├── step7_complete_page.dart
│
└── creation_provider.dart
```

---

## ai_generation

```text
presentation

├── generating_page.dart
└── generating_provider.dart
```

---

## first_meeting

```text
presentation

└── first_meeting_page.dart
```

---

## home

```text
presentation

├── home_page.dart
├── weather_widget.dart
├── relationship_widget.dart
└── date_widget.dart
```

---

## chat

```text
presentation

├── chat_page.dart
├── message_bubble.dart
├── chat_input.dart
└── chat_provider.dart
```

---

## voice_call

```text
presentation

├── call_page.dart
└── call_provider.dart
```

---

## profile

```text
presentation

├── profile_page.dart
├── personality_card.dart
└── profile_provider.dart
```

---

## relationship

```text
presentation

├── relationship_page.dart
├── level_card.dart
├── timeline_card.dart
└── relationship_provider.dart
```

---

## memory_album

```text
presentation

├── memory_album_page.dart
├── memory_detail_page.dart
└── memory_provider.dart
```

---

## model_viewer

```text
presentation

├── model_viewer_page.dart
├── pose_selector.dart
├── emotion_selector.dart
└── model_provider.dart
```

---

# Assets 구조

```text
assets

├── images
│
├── icons
│
├── lottie
│
├── animations
│
├── sounds
│
├── fonts
│
└── models
    └── default
```

---

# Riverpod Provider 구조

```text
providers

authProvider

userProvider

boyfriendProvider

chatProvider

callProvider

memoryProvider

relationshipProvider

subscriptionProvider
```

---

# Repository 패턴

```text
UI
 ↓
Provider
 ↓
UseCase
 ↓
Repository
 ↓
Datasource
 ↓
Firebase/OpenAI/Meshy
```

---

# Github Monorepo

```text
heartmate-platform

/apps
    mobile

/functions

/docs

/design

/scripts
```

---

# MVP 우선 개발 순서

1. Splash
2. Onboarding
3. Auth
4. Boyfriend Creation
5. AI Generation
6. First Meeting
7. Home
8. Chat
9. Profile

V1 출시

10. Voice Call
11. Relationship
12. Memory Album

V2 출시

13. Meshy 3D
14. Date Place
15. Premium
```
:::

이 구조면 주인님이 선호하는 **Flutter + Riverpod + Firebase + OpenAI + Meshy** 조합에서 기능이 늘어나도 유지보수가 쉽고, 향후 "내 여자친구는 AI"까지 확장할 때도 Feature만 추가하면 됩니다.