---
layout: default
title: 로컬 {% include product %} 사이트에서 {% include product %} 데스크톱을 사용할 때 CERTIFICATE_VERIFY_FAILED 오류 발생
pagename: certificate-fail-local-error-message
lang: ko
---

# 로컬 {% include product %} 사이트에서 {% include product %} 데스크톱을 사용할 때 CERTIFICATE_VERIFY_FAILED 오류 발생

## 활용 사례:

{% include product %}의 로컬 설치를 사용하는 경우 다음 두 가지 시나리오에서 이 오류가 발생할 수 있습니다.

- {% include product %} 데스크톱 로그인 시
- 툴킷 AppStore에서 미디어 다운로드 시

## 해결 방법:

이 문제를 해결하려면 사용자의 CA를 포함하여 유효한 모든 CA 목록이 포함된 파일을 {% include product %} API에 제공해야 합니다. 일반적으로 Python의 `certifi` 패키지에서 [이 파일](https://github.com/certifi/python-certifi/blob/master/certifi/cacert.pem)의 새 사본을 다운로드한 후 파일 끝에 자체 CA를 추가하는 것이 좋습니다. 그런 다음 모든 사용자가 액세스할 수 있는 위치에 해당 파일을 저장합니다. 마지막으로 각 컴퓨터에서 `SHOTGUN_API_CACERTS` 환경 변수를 해당 파일에 대한 전체 경로(예: `/path/to/my/ca/file.pem`)로 설정합니다.

이렇게 하면 로컬 사이트에서 발생하는 `CERTIFICATE_VERIFY_FAILED` 오류가 모두 해결됩니다. {% include product %} 사이트에 연결할 수는 있지만 툴킷 AppStore에서 업데이트를 다운로드할 수 없는 경우에는 `.pem` 파일에 Amazon CA가 없기 때문에 발생한 문제일 수 있습니다. 이 문제는 일반적으로 위에서 링크한 것과 같은 파일로 시작하지 않고 빈 파일로 시작한 후 커스텀 CA만 추가한 경우에 발생합니다.

이 정보는 *로컬 설치에만* 적용됩니다. 호스트된 사이트가 있고 이 오류가 발생한다면 Windows의 경우 [이 포럼 게시물](https://community.shotgridsoftware.com/t/certificate-verify-failed-error-on-windows/8860)을 살펴보십시오. 다른 OS에서 이 문제가 발생하는 경우 [이 문서](https://developer.shotgridsoftware.com/c593f0aa/)를 살펴보십시오.

## 이 오류가 발생하는 원인의 예:

이 문제는 일반적으로 로컬 사이트에서 HTTPS를 사용하도록 구성했지만 로컬 사이트의 인증서에 서명하는 데 사용한 인증 기관(여기서는 CA라고 함)이 인식되도록 툴킷을 구성하지 않은 경우에 발생합니다.

[커뮤니티에서 전체 스레드를 참조](https://community.shotgridsoftware.com/t/getting-certificate-verify-failed-when-using-shotgun-desktop-on-a-local-shotgun-site/10466)하십시오.

