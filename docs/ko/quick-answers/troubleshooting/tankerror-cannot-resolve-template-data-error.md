---
layout: default
title: 컨텍스트에 대한 템플릿 데이터를 확인할 수 없습니다.
pagename: tankerror-cannot-resolve-template-data-error
lang: ko
---

# TankError: 컨텍스트에 대한 템플릿 데이터를 확인할 수 없습니다.

## 활용 사례

새 프로젝트에서 고급 프로젝트 설정을 수행하고 {% include product %} 데스크톱의 독립 실행형 Publisher 앱을 사용하여 작성한 새 에셋 태스크에 대한 일부 이미지를 게시할 때 게시를 확인할 컨텍스트를 선택하면 다음과 같은 오류가 표시됩니다.


```
creation for %s and try again!" % (self, self.shotgun_url))
TankError: Cannot resolve template data for context ‘concept, Asset door-01’ - this context does not have any associated folders created on disk yet and therefore no template data can be extracted. Please run the folder creation for and try again!
```

터미널에서 `tank.bat Asset door-01 folders`를 실행하여 이 문제를 해결했습니다. 하지만 이전 프로젝트에서는 이런 오류가 발생한 적이 없습니다.

## 해결 방법

이 오류는 DCC를 먼저 수행하지 않고 새 엔티티/태스크에 대해 독립 실행형 게시를 처음으로 시도하는 것이 그 원인일 수 있습니다.

이전에는 이러한 문제가 발생하지 않았을 수 있는 이유는 독립 실행형 Publisher를 사용하기 전에 소프트웨어에서 에셋에 대한 작업을 시작했기 때문에 폴더가 이미 생성/동기화되었기 때문입니다. (툴킷을 통해) 소프트웨어를 실행하면 실행하는 컨텍스트에 대한 폴더가 생성되고, 열린 앱은 새 파일을 시작하는 컨텍스트에 대한 폴더를 만듭니다. 따라서 일반적으로 폴더를 특별히 만들 필요가 없습니다.

일반적으로 스튜디오는 {% include product %}에 샷/에셋이 추가된 후 수동으로 폴더를 생성하는 것이 일반적입니다.

또한 "폴더 스키마"의 영향을 받으므로 템플릿과 완전히 일치하지 않는 경우 이상한 문제가 발생할 수 있습니다.

## 관련 링크

[커뮤니티에서 전체 스레드 참조](https://community.shotgridsoftware.com/t/tank-folder-creation/8674/5)