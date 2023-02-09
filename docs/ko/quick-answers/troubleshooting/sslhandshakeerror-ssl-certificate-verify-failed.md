---
layout: default
title: SSLHandshakeError CERTIFICATE_VERIFY_FAILED 인증서 확인 실패
pagename: sslhandshakeerror-ssl-certificate-verify-failed
lang: ko
---

# SSLHandshakeError: [SSL: CERTIFICATE_VERIFY_FAILED] 인증서 확인 실패

## 활용 사례

로컬 패킷 검사를 수행하는 방화벽이 설정된 로컬 네트워크에서 다음 오류 메시지가 표시될 수 있습니다. 

```
SSLHandshakeError: [SSL: CERTIFICATE_VERIFY_FAILED] certificate verify failed (_ssl.c:727)
```

이 오류는 이러한 방화벽이 네트워크 관리자가 직접 생성했으며 Python이 액세스할 수 없는 자체 서명된 인증서로 구성된 경우가 많기 때문에 발생합니다. 다른 응용프로그램과 달리 Python은 OS의 인증서 키체인 내부를 들여다보지 않으므로 직접 제공해야 합니다.

## 해결 방법

Python API 및 Shotgun 데스크톱이 신뢰할 수 있는 인증 기관의 전체 목록이 포함된 파일이 디스크에 저장되도록 `SHOTGUN_API_CACERTS` 환경 변수를 설정해야 합니다.

이러한 [사본](https://github.com/certifi/python-certifi/blob/master/certifi/cacert.pem)은 Github의 `certifi` 패키지 최신 사본에서 다운로드할 수 있습니다. 이 작업을 수행한 후에는 **해당 파일의 맨 아래에 기업 방화벽의 공용 키를 추가하고 저장해야 합니다.**

이 작업이 완료되면 `SHOTGUN_API_CACERTS` 환경 변수를 경로 위치(예: `/opt/certs/cacert.pem`)로 설정하고 Shotgun 데스크톱을 시작하면 됩니다.

## 관련 링크

[커뮤니티에서 전체 스레드 보기](https://community.shotgridsoftware.com/t/using-shotgun-desktop-behind-an-firewall-with-ssl-introspection/11434)
