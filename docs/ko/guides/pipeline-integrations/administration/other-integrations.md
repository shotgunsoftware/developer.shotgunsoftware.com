---
layout: default
title: 기타 통합
pagename: other-integrations
lang: ko
---

# 기타 통합

{% include product %} API를 사용하면 많은 타사 패키지를 통합할 수 있는데 즉각적으로 {% include product %}와 통합할 수 있는 패키지도 몇 가지 있습니다.

## Cinesync

Cinesync를 사용하면 여러 위치 사이를 동시에 동기화하여 재생할 수 있습니다. {% include product %} 통합을 통해 버전 재생 목록을 만들고, 이를 Cinesync에서 재생하고, 세션 중에 작성한 노트를 {% include product %}로 바로 보낼 수 있습니다.

자세한 정보는 [http://www.cinesync.com/manual/latest](http://www.cinesync.com/manual/latest/)를 참조하십시오.

## Deadline

{% include product %}+Deadline 통합을 사용하면 썸네일, 프레임 링크 및 기타 메타데이터가 모두 포함된 렌더링된 버전을 {% include product %}에 자동으로 제출할 수 있습니다.

자세한 정보는 [http://www.thinkboxsoftware.com/deadline-5-shotgunevent](http://www.thinkboxsoftware.com/deadline-5-shotgunevent)를 참조하십시오.

## Rush

Deadline 통합과 마찬가지로, {% include product %}+Rush 통합을 사용하면 썸네일, 프레임 링크 및 기타 메타데이터가 모두 포함된 렌더링된 버전을 {% include product %}에 자동으로 제출할 수 있습니다.

자세한 정보는 [http://seriss.com/rush-current/index.html](http://seriss.com/rush-current/index.html)을 참조하십시오.

## Subversion(SVN)

{% include product %}는 저희가 내부에서도 사용하고 있는 가볍지만 유연한 통합으로, 이를 사용하여 리비전 내역을 트래킹하고, {% include product %}에 있는 티켓 및 릴리즈에 링크할 수 있습니다. 또한 외부 웹 SVN 리포지토리 뷰어를 통합하기 위한 Trac 링크도 제공합니다. 커밋에서 몇몇 ENV 변수를 가져온 다음 {% include product %}에서 여러 필드가 입력되어 있는 리비전 엔티티를 생성하는 {% include product %} API 스크립트인 SVN에 포스트 커밋(post-commit) 후크만 추가하면 모든 작업이 이루어집니다. SVN은 스튜디오 요구 사항에 맞게 수정할 수 있으며 API만 사용하기 때문에 로컬 또는 호스팅되는 설치에 사용할 수 있습니다. 자세한 정보는 [https://subversion.apache.org/docs](https://subversion.apache.org/docs/)를 참조하십시오.
