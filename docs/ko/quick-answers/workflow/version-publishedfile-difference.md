---
layout: default
title: 버전과 게시된 파일 간의 차이점은 무엇입니까?
pagename: version-publishedfile-difference
lang: ko
---

# 버전과 게시된 파일 간의 차이점은 무엇입니까?

**"게시"**는 디스크에 저장되어 응용프로그램 내에서 사용할 수 있는 파일(또는 이미지 시퀀스)이나 데이터를 의미합니다. exr 시퀀스, abc, Maya 파일 등이 여기에 포함될 수 있습니다. 게시는 ShotGrid 내에서 `PublishedFile` 엔티티로 표현됩니다.

**"버전"**(ShotGrid 내 `Version` 엔티티)은 게시의 시각적 표현이며 리뷰 및 노트 작성에 사용됩니다. `Version` 엔티티에는 게시된 파일이라고 하는 필드가 있습니다. 이 필드에는 서로 연결할 게시 레코드의 수를 입력할 수 있습니다. 이를 통해 어떠한 리뷰 `Version`이 게시 그룹과 연결되는지 트래킹할 수 있습니다. 게시할 때 이 관계를 입력하는 것이 좋습니다. 버전은 ShotGrid 내에서 `Version` 엔티티로 표현됩니다.

궁극적인 아이디어는 게시할 때 파일 모음, 그러니까 대개 파일 형식은 다르지만 실질적으로 같은 내용을 가진 파일(Maya 파일, obj, alembic 등)을 생성할 수 있도록 하는 것입니다. 그리고 결국 이 파일들은 모두 같은 것을 서로 다르게 표현한 것입니다. 그런 후 이 파일들은 게시 데이터 미리보기 및 노트 작성을 위해 단일 리뷰 `Version`과 연결됩니다.

게시된 데이터가 이미지 시퀀스인 경우에는 이 아이디어가 조금 쓸모없어질 수 있습니다. 사실 이미지 시퀀스는 리뷰하려는 것이기도 하면서 파이프를 따라 전송될 것이기도 합니다. 이 경우 게시와 `Version` 모두를 "더블 업"하고 생성해야 할 수 있습니다. 그러면 Loader 앱 등을 통해 `Version`을 표현하는 게시된 데이터를 로드할 수 있습니다.

