---
layout: default
title: "{% include product %} 데스크톱을 시작할 때 오류 모듈 'tank'에 'support_url' 특성이 없음"
pagename: module-tank-has-no-attribute-support-url
lang: ko
---

# {% include product %} 데스크톱을 시작할 때 오류 모듈 'tank'에 'support_url' 특성이 없음

## 문제

버전을 업그레이드한 후 {% include product %} 데스크톱을 시작하면 다음 메시지가 나타납니다.

```
{% include product %} Desktop Error:
Error: module 'tank' has no attribute 'support_url'
```

## 원인

디스크립터 버전이 최신 {% include product %} 데스크톱 버전 1.7.3과 호환되지 않습니다. 'support_url'은 tk-core v0.19.18에서 도입되었습니다.

## 솔루션

이 문제를 해결하려면 다음을 수행합니다.

1. {% include product %} 웹 사이트의 파이프라인 구성 목록(Pipeline Configuration List) 페이지에 액세스합니다.
2. 디스크립터 필드에 최신 {% include product %} 데스크톱 버전과 호환되지 않는 이전 버전이 있는지 확인합니다.

## 관련 링크

- [기술 자료 지원 문서](https://www.autodesk.co.kr/support/technical/article/caas/sfdcarticles/sfdcarticles/KOR/Error-module-tank-has-no-attribute-support-url-when-launching-ShotGrid-Desktop.html)

