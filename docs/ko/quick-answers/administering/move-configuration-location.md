---
layout: default
title: 파이프라인 구성을 새 위치로 이동하려면 어떻게 해야 합니까?
pagename: move-configuration-location
lang: ko
---

# 파이프라인 구성을 새 위치로 이동하려면 어떻게 해야 합니까?

{% include info title="참고" content="이 문서의 내용은 [중앙 집중식 구성 설정](https://developer.shotgunsoftware.com/tk-core/initializing.html#centralized-configurations)에만 적용됩니다. [분산 구성](https://developer.shotgunsoftware.com/tk-core/initializing.html#distributed-configurations)은 개별 클라이언트 시스템에 로컬로 캐시되고 툴킷에서 자동으로 관리됩니다." %}

파이프라인 구성을 새 위치로 옮길 수 있는 가장 쉬운 방법은 `tank move_configuration` 명령을 사용하는 것입니다. 이렇게 하면 파일을 이동하고, Shotgun을 업데이트하고, 새 위치를 가리키도록 구성 파일을 업데이트하는 작업이 모두 이루어집니다. 

이 명령은 단일 운영 체제의 위치만 옮기거나 이전에는 특정 운영 체제를 사용하지 않았지만 이제 운영 체제를 추가하고 싶은 경우에도 유용합니다. 이동하거나 추가해야 하는 항목과 그렇지 않은 항목은 툴킷이 감지하여 진행할 작업을 미리 보여 주기 때문에 진행하기 전에 확인할 수 있습니다.

- [tank move_configuration 명령 사용](#using-the-tank-move_configuration-command)
- [수동으로 파이프라인 구성 이동](#manually-moving-your-pipeline-configuration)

{% include warning title="주의" content="현지화된 코어가 있는 구성을 옮기려고 하고, 이 파이프라인 구성에 포함된 Toolkit Core를 사용 중인 다른 프로젝트가 있는 경우에는(즉, 다른 구성에서 공유 코어로 사용) 해당 프로젝트의 구성 파일을 이 파이프라인 구성의 새 위치를 가리키도록 수동으로 업데이트해야 합니다. 이 파일의 위치는 다음과 같습니다.

- `/path/to/pipeline_configuration/install/core/core_Darwin.cfg`
- `/path/to/pipeline_configuration/install/core/core_Linux.cfg`
- `/path/to/pipeline_configuration/install/core/core_Windows.cfg`" %}

## tank move_configuration 명령 사용:

    $ cd /sgtk/software/shotgun/scarlet
    $ ./tank move_configuration
    
    Shotgun Pipeline Toolkit을 시작합니다.
    설명서는 https://toolkit.shotgunsoftware.com을 참조하십시오.
    현재 경로 '/sgtk/software/shotgun/scarlet'에 대해 툴킷 시작
    - 경로가 Shotgun 객체와 연결되어 있지 않음
    - 기본 프로젝트 설정으로 폴백
    - '기본' 구성 및 Core v0.15.22 
    - 컨텍스트를 Scarlet으로 설정
    - 명령 move_configuration 실행 중...
    
    
    ----------------------------------------------------------------------
    명령: 구성 이동
    ----------------------------------------------------------------------
    
    구문: move_configuration linux_path windows_path mac_path
    
    이 명령은 지정된 파이프라인 구성 위치를 이동합니다.
    또한 이 명령을 사용하여 파이프라인 구성에 새 플랫폼을
    추가할 수도 있습니다.
    
    현재 경로
    --------------------------------------------------------------
    
    현재 Linux 경로:   '/mnt/hgfs/sgtk/software/shotgun/scarlet'
    현재 Windows 경로: 'z:\sgtk\software\shotgun\scarlet'
    현재 Mac 경로:     '/sgtk/software/shotgun/scarlet'
    
    
    일반적으로 경로는 다음과 같이 따옴표로 묶어야 합니다.
    
    > tank move_configuration "/linux_root/my_config" "p:\configs\my_config"
    "/mac_root/my_config"
    
    플랫폼을 비워 두려면 빈 따옴표를 사용합니다. 예를 들어
    Windows에서만 작동하는 구성을 원할 경우 다음을 수행합니다.
    
    > tank move_configuration "" "p:\configs\my_config" ""


### 예시:

    $ cd /sgtk/software/shotgun/scarlet
    $ ./tank move_configuration "/mnt/hgfs/sgtk/software/shotgun/scarlet_new" "z:\sgtk\software\shotgun\scarlet_new" "/sgtk/software/shotgun/scarlet_new"
    
    Shotgun Pipeline Toolkit을 시작합니다.
    설명서는 https://toolkit.shotgunsoftware.com을 참조하십시오.
    경로 '/sgtk/software/shotgun/scarlet'에 대해 툴킷 시작
    - 경로가 Shotgun 객체와 연결되어 있지 않음
    - 기본 프로젝트 설정으로 폴백
    - '기본' 구성 및 Core v0.15.22 
    - 컨텍스트를 Scarlet으로 설정
    - 명령 move_configuration 실행 중...
    
    
    ----------------------------------------------------------------------
    명령: 구성 이동
    ----------------------------------------------------------------------
    
    
    현재 경로
    --------------------------------------------------------------
    현재 Linux 경로:   '/sgtk/software/shotgun/scarlet'
    현재 Windows 경로: 'z:\sgtk\software\shotgun\scarlet'
    현재 Mac 경로:     '/sgtk/software/shotgun/scarlet'
    
    새 경로
    --------------------------------------------------------------
    새 Linux 경로:   '/mnt/hgfs/sgtk/software/shotgun/scarlet_new'
    새 Windows 경로: 'z:\sgtk\software\shotgun\scarlet_new'
    새 Mac 경로:     '/sgtk/software/shotgun/scarlet_new'
    
    
    지정한 경로 변경을 반영하도록 구성이 이동됩니다.
    
    고급 사용자를 위한 참고 사항: 구성이 현지화되고 이 구성에 포함된 Core API에 링크된 다른
    프로젝트가 있는 경우 이동 작업 후 이 링크를 수동으로
    업데이트해야 합니다.
    
    구성을 이동하시겠습니까? [예/아니오] 예
    '/sgtk/software/shotgun/scarlet' 복사 중 -> '/sgtk/software/shotgun/scarlet_new'
    /sgtk/software/shotgun/scarlet/cache 복사 중...
    /sgtk/software/shotgun/scarlet/config 복사 중...
    /sgtk/software/shotgun/scarlet/config/core 복사 중...
    /sgtk/software/shotgun/scarlet/config/core/hooks 복사 중...
    /sgtk/software/shotgun/scarlet/config/core/schema 복사 중...
    /sgtk/software/shotgun/scarlet/config/env 복사 중...
    /sgtk/software/shotgun/scarlet/config/env/includes 복사 중...
    /sgtk/software/shotgun/scarlet/config/hooks 복사 중...
    /sgtk/software/shotgun/scarlet/config/icons 복사 중...
    /sgtk/software/shotgun/scarlet/install 복사 중...
    /sgtk/software/shotgun/scarlet/install/apps 복사 중...
    /sgtk/software/shotgun/scarlet/install/apps/app_store 복사 중...
    /sgtk/software/shotgun/scarlet/install/core 복사 중...
    /sgtk/software/shotgun/scarlet/install/core/python 복사 중...
    /sgtk/software/shotgun/scarlet/install/core.backup 복사 중...
    /sgtk/software/shotgun/scarlet/install/core.backup/20150518_143244 복사 중...
    /sgtk/software/shotgun/scarlet/install/core.backup/20150518_143940 복사 중...
    /sgtk/software/shotgun/scarlet/install/engines 복사 중...
    /sgtk/software/shotgun/scarlet/install/engines/app_store 복사 중...
    /sgtk/software/shotgun/scarlet/install/frameworks 복사 중...
    /sgtk/software/shotgun/scarlet/install/frameworks/app_store 복사 중...
    /sgtk/software/shotgun/scarlet_new/config/core/install_location.yml에서 캐시된 위치 업데이트 중...
    Shotgun 구성 레코드 업데이트 중...
    원본 구성 파일 삭제 중...
    
    완료되었습니다. 구성을 성공적으로 이동했습니다.



## 수동으로 파이프라인 구성 이동

{% include warning title="중요" content="아직 파이프라인 구성을 옮기지 않았다면 위의 [기본 제공 tank 명령](#using-the-tank-move_configuration-command)을 사용하여 이를 자동으로 처리하는 것이 가장 좋습니다." %}

이미 수동 이동을 시작했는데 중간에 막혀 버렸다면 툴킷이 이제 새 위치에 있는 파이프라인 구성을 통해 계속 작동하도록 하기 위해 변경해야 하는 사항들이 있습니다.

1. 파이프라인 구성 파일을 새 위치로 이동

       $ mv /sgtk/software/shotgun/scarlet /mnt/newserver/sgtk/software/shotgun/scarlet_new
   
2. 툴킷이 파이프라인 구성의 위치를 파악하는 데 도움을 주도록 `install_location.yml`을 편집:

       $ vi /mnt/newserver/sgtk/software/shotgun/scarlet_new/config/core/install_location.yml
   
   해당하는 모든 플랫폼에서 이 파일의 경로가 새 파이프라인 구성 위치를 가리키도록 업데이트합니다. 플랫폼을 사용하고 있지 않다면 빈 문자열 `''`을 입력합니다.

       # Shotgun Pipeline Toolkit 구성 파일
       # 이 파일은 setup_project에 의해 자동으로 생성되었습니다.
       # 이 파일은 기본 파이프라인의 경로를 반영합니다.
       
       # 이 프로젝트에 대해 정의된 구성.
       Windows: 'Y:\sgtk\software\shotgun\scarlet_new'
       Darwin: '/mnt/newserver/sgtk/software/shotgun/scarlet_new'
       Linux: ''
       
       # 파일 끝.
   
3. Shotgun에서 이 프로젝트에 대한 해당 파이프라인 구성 엔티티를 찾아 Linux 경로, Mac 경로 및 Windows 경로 필드 값이 위에서 변경한 사항과 일치하도록 수정합니다.

![Shotgun에서 파이프라인 구성 위치](images/new-pipeline-configuration-locations.png)

이제 파이프라인 구성이 새 위치에서 기대한 대로 작동할 것입니다.

{% include info title="참고" content="SG 데스크톱을 사용 중인 경우 프로젝트에서 나와 프로젝트 아이콘을 다시 클릭해서 파이프라인 구성을 새 위치에서 다시 로드해야 합니다." %}