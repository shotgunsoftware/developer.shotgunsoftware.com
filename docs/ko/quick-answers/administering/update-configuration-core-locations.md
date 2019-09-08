---
layout: default
title: 파이프라인 구성 코어 위치를 업데이트하려면 어떻게 해야 합니까?
pagename: update-configuration-core-locations
lang: ko
---

# 파이프라인 구성 코어 위치를 업데이트하려면 어떻게 해야 합니까?

## 파이프라인 구성이 로컬 코어를 사용하도록 업데이트하려면 어떻게 해야 합니까?

파이프라인 구성이 [공유 Toolkit Core를 사용하도록 설정](https://support.shotgunsoftware.com/hc/ko/articles/219040468#shared)되어 있는 경우에는 해당 프로세스를 실행 취소하거나 tank localize 명령을 사용하여 파이프라인 구성 내부에 Toolkit Core API의 사본을 설치함으로써 코어의 "공유를 해제"할 수 있습니다. 이를 가리켜 코어를 "지역화"한다고 합니다. 

1. 터미널을 열고 Toolkit Core를 설치하려는 파이프라인 구성으로 이동합니다.

       $ cd /sgtk/software/shotgun/scarlet
 
2. 다음 tank 명령을 실행합니다.

       $ ./tank localize
       
       ...
       ...
       
       ----------------------------------------------------------------------
       Command: Localize
       ----------------------------------------------------------------------
       
       This will copy the Core API in /sgtk/software/shotgun/studio into the Pipeline
       configuration /sgtk/software/shotgun/scarlet.
       
       Do you want to proceed [yn]
   
   계속 진행하기 전에 툴킷이 모든 사항을 확인합니다. 파이프라인 구성이 현재 가리키고 있는 Toolkit Core 사본이 파이프라인 구성에 로컬로 복사됩니다.

3. 이제 툴킷이 파이프라인 구성에서 사용 중인 모든 앱, 엔진 및 프레임워크를 `install` 폴더에 로컬로 복사합니다. 그런 후 Toolkit Core를 복사하고 새로 설치된 로컬 Toolkit Core를 사용하도록 파이프라인 구성의 구성 파일을 업데이트합니다.


       Copying 59 apps, engines and frameworks...
       1/59: Copying tk-multi-workfiles v0.6.15...
       2/59: Copying tk-maya v0.4.7...
       3/59: Copying tk-nuke-breakdown v0.3.0...
       4/59: Copying tk-framework-widget v0.2.2...
       5/59: Copying tk-shell v0.4.1...
       6/59: Copying tk-multi-launchapp Undefined...
       7/59: Copying tk-motionbuilder v0.3.0...
       8/59: Copying tk-hiero-openinshotgun v0.1.0...
       9/59: Copying tk-multi-workfiles2 v0.7.9...
       ...
       ...
       59/59: Copying tk-framework-qtwidgets v2.0.1...
       Localizing Core: /sgtk/software/shotgun/studio/install/core ->
       /sgtk/software/shotgun/scarlet/install/core
       Copying Core Configuration Files...
       The Core API was successfully localized.
       
       Localize complete! This pipeline configuration now has an independent API. If
       you upgrade the API for this configuration (using the 'tank core' command), no
       other configurations or projects will be affected.
   
{% include info title="참고" content="설치한 앱, 엔진 및 프레임워크 버전에 따라 출력이 달라집니다." %}

## 파이프라인 구성이 기존 공유 코어를 사용하도록 업데이트하려면 어떻게 해야 합니까?
기존 공유 Toolkit Core가 있는 경우 tank 명령을 사용하여 공유 코어를 사용하도록 기존의 "지역화된" 파이프라인 구성을 업데이트할 수 있습니다.

1. 터미널을 열고 업데이트하려는 파이프라인 구성으로 이동합니다.

       $ cd /sgtk/software/shotgun/scarlet
 
2. 그리고 `tank attach_to_core` 명령을 실행하고, 현재 플랫폼에 있는 유효한 공유 코어 경로를 제공합니다.

       $ ./tank attach_to_core /sgtk/software/shotgun/studio
       ...
       ...
       ----------------------------------------------------------------------
       Command: Attach to core
       ----------------------------------------------------------------------
       After this command has completed, the configuration will not contain an
       embedded copy of the core but instead it will be picked up from the following
       locations:
       
       - Linux: '/mnt/hgfs/sgtk/software/shotgun/studio'
       - Windows: 'z:\sgtk\software\shotgun\studio'
       - Mac: '/sgtk/software/shotgun/studio'
       
       Note for expert users: Prior to executing this command, please ensure that you
       have no configurations that are using the core embedded in this configuration.
       
       Do you want to proceed [yn]
   
   계속 진행하기 전에 툴킷이 모든 사항을 확인합니다. 이 공유 코어는 이미 여러 플랫폼에 맞게 설정되었기 때문에 각 플랫폼의 위치가 표시됩니다.

   *새 플랫폼의 위치를 추가해야 한다면 공유 코어 구성에서 config/core/install_location.yml 파일을 업데이트하고 필요한 경로를 추가합니다.*

3. 이제 툴킷이 파이프라인 구성에 로컬 Core API를 백업하고, 지역화된 코어를 제거한 후에 공유 코어에 있는 파이프라인 구성을 가리키도록 필요한 구성을 추가합니다.

       Backing up local core install...
       Removing core system files from configuration...
       Creating core proxy...
       The Core API was successfully processed.
   
   나중에 파이프라인 구성에서 Toolkit Core를 지역화하기로 결정할 경우(예: 공유 코어에서 파이프라인 구성을 분리하고 로컬로 설치된 버전을 사용) `tank localize` 명령을 사용하여 그렇게 할 수 있습니다.

{% include info title="참고" content="공유 스튜디오 코어는 현재 파이프라인 구성의 코어 버전 이상이어야 합니다." %}

## 프로젝트 간에 Toolkit Core를 어떻게 공유합니까?

현재는 SG 데스크톱을 사용하여 프로젝트를 설정하는 경우 Toolkit Core API가 "지역화됩니다". 즉, 파이프라인 구성 내부에 설치됩니다. 모든 파이프라인 구성이 툴킷 설치를 완벽하게 포함하게 됩니다. 원한다면 Toolkit Core API 버전이 프로젝트 간에 공유되도록 하여 유지 관리 부담을 최소화하고, 모든 프로젝트가 같은 코어 코드를 사용하도록 할 수도 있습니다. 이를 대개 **"공유 스튜디오 코어"**라고 합니다.

여기서는 여러 프로젝트 파이프라인 구성 간에 공유할 수 있는 새 Toolkit Core API 구성을 생성하는 방법을 소개합니다.

1. 터미널을 열고, 공유하려는 Toolkit Core 버전이 포함된 기존의 파이프라인 구성으로 이동합니다. 프로젝트가 완료되면 이 파이프라인 구성은 더 이상 지역화된 상태로 유지되지 않고 새로 생성된 공유 코어를 사용하게 됩니다.

       $ cd /sgtk/software/shotgun/pied_piper
 
2. 다음 tank 명령을 실행하여 Toolkit Core를 디스크의 외부 위치로 복사합니다. 이 경로를 모든 플랫폼에서 찾을 수 있도록 해당 위치를 제공해야 합니다(linux_path, windows_path, mac_path). 각 경로마다 따옴표를 사용하는 것이 좋습니다. 특정 플랫폼에서는 툴킷을 사용하지 않는다면 그냥 빈 문자열(`""`)을 지정하면 됩니다. 

       $ ./tank share_core "/mnt/sgtk/software/shotgun/studio" "Z:\sgtk\software\shotgun\studio" \ "/sgtk/software/shotgun/studio"
 
3. 툴킷이 작업을 진행하기 전에 변경될 사항을 요약하여 보여 줍니다.

       ----------------------------------------------------------------------
       Command: Share core
       ----------------------------------------------------------------------
       This will move the embedded core API in the configuration
       '/sgtk/software/shotgun/pied_piper'.
       After this command has completed, the configuration will not contain an
       embedded copy of the core but instead it will be picked up from the following
       locations:
       - Linux: '/mnt/sgtk/software/shotgun/studio'
       - Windows: 'Z:\sgtk\software\shotgun\studio'
       - Mac: '/sgtk/software/shotgun/studio'
       Note for expert users: Prior to executing this command, please ensure that you
       have no configurations that are using the core embedded in this configuration.
       Do you want to proceed [yn]
 
4. 툴킷이 새 공유 위치로 코어 설치를 복사하고, 새 공유 위치를 가리키도록 기존 파이프라인 구성을 업데이트합니다.

       Setting up base structure...
       Copying configuration files...
       Copying core installation...
       Backing up local core install...
       Removing core system files from configuration...
       Creating core proxy...
       The Core API was successfully processed.
   
이제 다른 파이프라인 구성에서 이 새로운 공유 코어를 사용할 수 있습니다. (방금 생성한 것과 같은) 기존 공유 코어를 사용하도록 파이프라인 구성을 업데이트하려면 `tank attach_to_core` 명령을 사용하면 됩니다.