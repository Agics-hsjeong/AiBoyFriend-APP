/* 공통 UI 조각 주입 — 상태바 / 하단 탭바 */
(function () {
  var STATUS =
    '<span class="sb-time">9:41</span>' +
    '<span class="sb-icons">' +
    '<svg width="18" height="12" viewBox="0 0 18 12" fill="currentColor"><rect y="7" width="3" height="5" rx="1"/><rect x="5" y="4" width="3" height="8" rx="1"/><rect x="10" y="2" width="3" height="10" rx="1"/><rect x="15" width="3" height="12" rx="1"/></svg>' +
    '<svg width="16" height="12" viewBox="0 0 16 12" fill="currentColor"><path d="M8 2.6c2.4 0 4.6.9 6.3 2.5l-1.3 1.3A7 7 0 0 0 8 4.4 7 7 0 0 0 3 6.4L1.7 5.1A9 9 0 0 1 8 2.6Zm0 3.7c1.4 0 2.7.5 3.7 1.5L10.3 9.1a3.3 3.3 0 0 0-4.6 0L4.3 7.8A5.3 5.3 0 0 1 8 6.3Zm0 3.1 1.5 1.5L8 11.9 6.5 10.4 8 9.4Z"/></svg>' +
    '<svg width="25" height="12" viewBox="0 0 25 12"><rect x=".5" y=".5" width="21" height="11" rx="3" stroke="currentColor" fill="none" opacity=".45"/><rect x="2" y="2" width="18" height="8" rx="1.5" fill="currentColor"/><rect x="23" y="4" width="2" height="4" rx="1" fill="currentColor" opacity=".5"/></svg>' +
    '</span>';

  var ICONS = {
    home: '<svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M4 10.5 12 4l8 6.5"/><path d="M5.5 9.5V19a1 1 0 0 0 1 1h11a1 1 0 0 0 1-1V9.5"/><path d="M9.5 20v-5h5v5"/></svg>',
    chat: '<svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M4 5.5h16a1 1 0 0 1 1 1v9a1 1 0 0 1-1 1H9l-4 3.5v-3.5H4a1 1 0 0 1-1-1v-9a1 1 0 0 1 1-1Z"/></svg>',
    memory: '<svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="3.5" y="4.5" width="17" height="15" rx="2.5"/><path d="M3.5 15l4-3.5 3.5 3 4-4 5.5 5"/><circle cx="8.5" cy="9" r="1.4"/></svg>',
    profile: '<svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="8.5" r="3.5"/><path d="M5 20c.7-3.6 3.4-5.5 7-5.5s6.3 1.9 7 5.5"/></svg>',
    more: '<svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="5" cy="12" r="1.6"/><circle cx="12" cy="12" r="1.6"/><circle cx="19" cy="12" r="1.6"/></svg>'
  };
  var TABS = [['home','홈'],['chat','채팅'],['memory','추억'],['profile','프로필'],['more','더보기']];

  function tabbar(active) {
    return TABS.map(function (t) {
      var on = t[0] === active ? ' active' : '';
      return '<div class="tab' + on + '"><span class="ic">' + ICONS[t[0]] + '</span><span>' + t[1] + '</span></div>';
    }).join('');
  }

  var STEPS = ['얼굴상', '헤어', '체형', '스타일', '성격', '목소리', '완성'];
  function stepper(cur) {
    cur = parseInt(cur, 10);
    return STEPS.map(function (lbl, i) {
      var n = i + 1, cls = n < cur ? ' done' : (n === cur ? ' cur' : '');
      var inner = n < cur ? '✓' : n;
      return '<div class="snode' + cls + '"><span class="dot">' + inner + '</span><span class="lbl">' + lbl + '</span></div>';
    }).join('');
  }

  document.querySelectorAll('.statusbar').forEach(function (el) { el.innerHTML = STATUS; });
  document.querySelectorAll('.tabbar').forEach(function (el) { el.innerHTML = tabbar(el.getAttribute('data-active') || ''); });
  document.querySelectorAll('.stepper').forEach(function (el) { el.innerHTML = stepper(el.getAttribute('data-step') || 1); });

  /* ---------- 화면 네비게이터 ---------- */
  var SCREENS = [
    ['01-onboarding-welcome.html', '온보딩 · 환영'],
    ['02-onboarding-ideal.html', '온보딩 · 이상형 생성'],
    ['03-onboarding-memory.html', '온보딩 · AI 기억'],
    ['04-onboarding-date.html', '온보딩 · 데이트'],
    ['05-onboarding-3d.html', '온보딩 · 3D 생성'],
    ['06-onboarding-start.html', '온보딩 · 시작하기'],
    ['07-login.html', '로그인'],
    ['08-signup.html', '회원가입'],
    ['09-wizard-step1-face.html', 'STEP 1 · 얼굴상'],
    ['10-wizard-step2-hair.html', 'STEP 2 · 헤어'],
    ['11-wizard-step3-body.html', 'STEP 3 · 체형'],
    ['12-wizard-step4-style.html', 'STEP 4 · 스타일'],
    ['13-wizard-step5-personality.html', 'STEP 5 · 성격'],
    ['14-wizard-step6-voice.html', 'STEP 6 · 목소리'],
    ['15-wizard-step7-complete.html', 'STEP 7 · 완성'],
    ['16-ai-generating.html', 'AI 생성중'],
    ['17-first-meeting.html', '첫 만남'],
    ['18-home.html', '홈'],
    ['19-chat.html', '채팅'],
    ['20-voice-call.html', '음성 통화'],
    ['21-profile.html', '프로필'],
    ['22-relationship.html', '관계 성장'],
    ['23-memory-album.html', '추억 앨범'],
    ['24-3d-viewer.html', '3D 모델 뷰어'],
    ['25-date-places.html', '데이트 장소'],
    ['26-settings.html', '설정']
  ];

  function buildNav() {
    // 갤러리(iframe) 안이나 화면 페이지가 아니면 표시하지 않음
    if (window.self !== window.top) return;
    if (!document.body.classList.contains('screen')) return;

    var file = decodeURIComponent(location.pathname.split('/').pop());
    var idx = -1;
    for (var i = 0; i < SCREENS.length; i++) { if (SCREENS[i][0] === file) { idx = i; break; } }
    if (idx === -1) return;

    var prev = idx > 0 ? SCREENS[idx - 1][0] : null;
    var next = idx < SCREENS.length - 1 ? SCREENS[idx + 1][0] : null;

    var bar = document.createElement('div');
    bar.className = 'topnav';
    bar.innerHTML =
      '<button class="nav-btn' + (prev ? '' : ' disabled') + '" data-go="' + (prev || '') + '"><span class="ar">‹</span> 이전</button>' +
      '<a class="nav-center" href="../index.html">' +
      '<span class="nt">' + SCREENS[idx][1] + '</span>' +
      '<span class="nc"><span class="gi">⊞</span> ' + (idx + 1) + ' / ' + SCREENS.length + ' · 목록</span>' +
      '</a>' +
      '<button class="nav-btn' + (next ? '' : ' disabled') + '" data-go="' + (next || '') + '">다음 <span class="ar">›</span></button>';

    document.body.appendChild(bar);
    document.body.classList.add('has-nav');

    bar.querySelectorAll('.nav-btn').forEach(function (b) {
      b.addEventListener('click', function () { var g = b.getAttribute('data-go'); if (g) location.href = g; });
    });
    document.addEventListener('keydown', function (e) {
      if (e.key === 'ArrowLeft' && prev) location.href = prev;
      if (e.key === 'ArrowRight' && next) location.href = next;
    });
  }
  buildNav();

  /* ---------- 화면 내 인터랙션 (목업) ---------- */
  function inGallery() { return window.self !== window.top; }
  function nowTime() { var d = new Date(); var h = d.getHours(), m = d.getMinutes(); return (h < 10 ? '0' : '') + h + ':' + (m < 10 ? '0' : '') + m; }

  // 단일 선택 그룹: [그룹 셀렉터, 아이템 셀렉터, 활성 클래스]
  var PICK = [
    ['.opt-grid', '.opt', 'on'],
    ['.opts', '.voice', 'on'],
    ['.opts', '.opt', 'on'],
    ['.cattabs', '.chip', 'on'],
    ['.tabs', '.chip', 'on'],
    ['.cats', '.cat', 'on'],
    ['.colors', 'i', 'on'],
    ['.tabbar', '.tab', 'active'],
    ['.strip', '.th', 'on'],
    ['.bgs', '.b', 'on']
  ];

  function sendChat(text) {
    var msgs = document.querySelector('.msgs');
    if (!msgs) return;
    var me = document.createElement('div');
    me.className = 'm me';
    me.innerHTML = '<div class="bubble"></div><span class="time">' + nowTime() + '</span>';
    me.querySelector('.bubble').textContent = text;
    msgs.appendChild(me);
    msgs.scrollTop = msgs.scrollHeight;
    setTimeout(function () {
      var R = ['응 나도 너무 좋아 💜', '헤헤 기대된다 😊', '오늘도 너랑 있어서 행복해 🥰', '좋아 좋아! 이따 봐 👋'];
      var them = document.createElement('div');
      them.className = 'm them';
      them.innerHTML = '<span class="ava photo night"></span><div class="bubble">' + R[Math.floor(Math.random() * R.length)] + '</div><span class="time">' + nowTime() + '</span>';
      msgs.appendChild(them);
      msgs.scrollTop = msgs.scrollHeight;
    }, 750);
  }

  document.addEventListener('click', function (e) {
    // 토글류
    var tog = e.target.closest('.toggle');
    if (tog) { tog.classList.toggle('off'); return; }
    var fchip = e.target.closest('.filters .fchip');
    if (fchip) { fchip.classList.toggle('on'); return; }
    var like = e.target.closest('.mcard .like');
    if (like) { like.classList.toggle('liked'); return; }
    var bm = e.target.closest('.place .bm');
    if (bm) { bm.classList.toggle('saved'); return; }
    // 채팅 빠른 답장
    var qc = e.target.closest('.quick .qc');
    if (qc) { sendChat(qc.textContent.trim()); return; }
    // 음성 미리듣기 ▶ → 웨이브 애니메이션
    var play = e.target.closest('.voice .play');
    if (play) { var wc = document.querySelector('.wave-card'); if (wc) wc.classList.add('playing'); }
    // 단일 선택 그룹
    for (var i = 0; i < PICK.length; i++) {
      var item = e.target.closest(PICK[i][1]);
      if (!item) continue;
      var grp = item.closest(PICK[i][0]);
      if (!grp) continue;
      var g = grp, ac = PICK[i][2];
      grp.querySelectorAll(PICK[i][1]).forEach(function (x) { if (x.closest(PICK[i][0]) === g) x.classList.remove(ac); });
      item.classList.add(ac);
      break;
    }
  });

  // 슬라이더 드래그 (성격 단계 등)
  document.querySelectorAll('.slider .track').forEach(function (track) {
    var fill = track.querySelector('i'), thumb = track.querySelector('b');
    var sl = track.closest('.slider'), pctEl = sl && sl.querySelector('.pct');
    var drag = false;
    function set(clientX) {
      var r = track.getBoundingClientRect();
      var p = Math.max(0, Math.min(100, Math.round((clientX - r.left) / r.width * 100)));
      if (fill) fill.style.width = p + '%';
      if (thumb) thumb.style.left = p + '%';
      if (pctEl) pctEl.textContent = p + '%';
    }
    track.addEventListener('pointerdown', function (e) { drag = true; try { track.setPointerCapture(e.pointerId); } catch (_) {} set(e.clientX); });
    track.addEventListener('pointermove', function (e) { if (drag) set(e.clientX); });
    window.addEventListener('pointerup', function () { drag = false; });
  });

  // 음성 통화 화면: 웨이브 상시 재생 (썸네일에서는 정지)
  if (!inGallery()) {
    var cw = document.querySelector('.layer .wave');
    if (cw) cw.classList.add('playing');
  }
})();
