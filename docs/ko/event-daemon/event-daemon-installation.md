---
layout: default
title: 설치
pagename: event-daemon-installation
lang: ko
---


# 설치

다음 안내서는 스튜디오에 대한 {% include product %}Events 구성을 지원합니다.

<a id="System_Requirements"></a>
## 시스템 요구사항

데몬은 Python이 설치되어 있고 {% include product %} 서버에 대한 네트워크 액세스 권한이 있는 모든 시스템에서 실행할 수 있습니다. {% include product %} 서버 자체에서 실행할 필요가 **없습니다**. 실제로 {% include product %}의 호스트된 버전을 사용하는 경우 이는 옵션이 아닙니다. 그러나 원하는 경우 {% include product %} 서버에서 실행할 수 있습니다. 그렇지 않으면 서버가 해당 작업을 수행합니다.

* Python v2.6, v2.7 또는 3.7
* [{% include product %} Python API](https://github.com/shotgunsoftware/python-api)
   * Python v2.6 또는 v2.7의 경우 v3.0.37 이상을 사용하고 Python 3.7의 경우 v3.1.0 이상을 사용합니다.
   * 어떤 경우든 [최신 Python API 버전](https://github.com/shotgunsoftware/python-api/releases)을 사용하고 이 종속성을 시간이 지남에 따라 계속 업데이트하는 것이 좋습니다.
* {% include product %} 서버에 대한 네트워크 액세스

<a id="Installing_Shotgun_API"></a>
## {% include product %} API 설치

Python이 이미 컴퓨터에 설치되어 있다고 가정하면 {% include product %} 이벤트 데몬에서 Python API를 사용하여 {% include product %} 서버에 연결할 수 있도록 {% include product %} Python API를 설치해야 합니다. 다음과 같은 방법으로 이 작업을 수행할 수 있습니다.

- {% include product %} 이벤트 데몬과 동일한 디렉토리에 배치합니다.
- [`PYTHONPATH` 환경 변수](http://docs.python.org/tutorial/modules.html)에서 지정한 디렉토리 중 하나에 배치합니다.

터미널 창에서 {% include product %} API가 제대로 설치되었는지 테스트하려면:

```
$ python -c "import shotgun_api3"
```

출력이 표시되지 않아야 합니다. 아래 출력과 같은 결과가 있는 경우 `PYTHONPATH`가 올바르게 설정되었는지 또는 {% include product %} API가 현재 디렉토리에 있는지 확인해야 합니다.

```
$ python -c "import shotgun_api3"
Traceback (most recent call last):
File "<string>", line 1, in <module>
ImportError: No module named shotgun_api3
```

<a id="Installing_shotgunEvents"></a>
## {% include product %}Events 설치

{% include product %}Events 설치 위치는 사용자가 임의로 선택할 수 있습니다. 다시 말하지만 Python 및 {% include product %} API가 컴퓨터에 설치되어 있고 {% include product %} 서버에 대한 네트워크 액세스 권한이 있는 경우 어디에서나 실행할 수 있습니다. 그러나 스튜디오에 적합한 위치(예: `/usr/local/shotgun/shotgunEvents`)에 설치하는 것이 타당하므로 이 위치를 예제에서 사용합니다.

소스 및 아카이브는 GitHub([https://github.com/shotgunsoftware/shotgunEvents]())에서 사용할 수 있습니다.

{% include info title="참고" content="**Windows:** Windows 서버가 있는 경우 `C:\shotgun\shotgunEvents`를 사용할 수 있지만 이 설명서에서는 Linux 경로를 사용합니다." %}

<a id="Cloning_Source"></a>
### 소스 복제

컴퓨터에 `git`가 설치된 경우 소스를 가져오는 가장 쉬운 방법은 프로젝트를 복제하는 것입니다. 이러한 방식으로 업데이트를 쉽게 가져와 버그 수정 및 새로운 기능으로 최신 상태를 유지할 수도 있습니다.

```
$ cd /usr/local/shotgun
$ git clone git://github.com/shotgunsoftware/shotgunEvents.git
```

{% include info title="경고" content="아무 것도 손실되지 않도록 GitHub에서 업데이트를 가져오기 전에 항상 shotgunEvents의 구성, 플러그인 및 모든 수정 사항을 백업해야 합니다. 또는 자체 변경 리포지토리를 유지할 수 있도록 프로젝트를 직접 분기(fork)합니다. :)" %}

<a id="Downloading_Archive"></a>
### 아카이브 다운로드

컴퓨터에 `git`가 없거나 단순히 소스 아카이브를 다운로드하려는 경우에는 다음 단계를 수행하여 시작할 수 있습니다.

- [https://github.com/shotgunsoftware/shotgunEvents/archives/master]()로 이동합니다.
- 원하는 형식으로 소스를 다운로드합니다.
- 이를 컴퓨터에 저장합니다.
- `/usr/local/shotgun` 디렉토리에 파일을 추출합니다.
- `/usr/local/shotgun/shotgunsoftware-shotgunEvents-xxxxxxx` 디렉토리 이름을 `/usr/local/shotgun/shotgunEvents`로 바꿉니다.

#### `/usr/local/shotgun`에 아카이브 압축 풀기

.tar.gz 아카이브의 경우:

```
$ tar -zxvf shotgunsoftware-shotgunEvents-v0.9-12-g1c0c3eb.tar.gz -C /usr/local/shotgun
```

.zip 아카이브의 경우:

```
$ unzip shotgunsoftware-shotgunEvents-v0.9-12-g1c0c3eb.zip -d /usr/local/shotgun
```

그런 다음 GitHub에서 할당된 디렉토리 이름을 `shotgunEvents`로 바꿀 수 있습니다.

```
$ mv shotgunsoftware-shotgunEvents-1c0c3eb shotgunEvents
```

결과는 다음과 같습니다.

```
$ ls -l /usr/local/shotgun/shotgunEvents
total 16
-rw-r--r--  1 kp  wheel  1127 Sep  1 17:46 LICENSE
-rw-r--r--  1 kp  wheel   268 Sep  1 17:46 README.mkd
drwxr-xr-x  9 kp  wheel   306 Sep  1 17:46 docs
drwxr-xr-x  6 kp  wheel   204 Sep  1 17:46 src
```

<a id="Installing Requirements"></a>
### 설치 요구사항

리포지토리의 루트에 `requirements.txt` 파일이 제공됩니다. 이 파일을 사용하여 필요한 패키지를 설치해야 합니다.

```
$ pip install -r /path/to/requirements.txt
```


<a id="Windows_Specifics"></a>
### Windows 세부 사항

Windows 시스템에 다음 중 하나가 필요합니다.

* [PyWin32](http://sourceforge.net/projects/pywin32/)와 함께 Python이 설치됨
* [Active Python](http://www.activestate.com/activepython)

활성 Python은 {% include product %} 이벤트 데몬을 Windows 서비스 아키텍처와 통합하는 데 필요한 PyWin32 모듈과 함께 제공됩니다.

다음 명령을 실행하여 서비스 데몬을 설치할 수 있습니다. `C:\Python27_32\python.exe`가 Python 실행 파일의 경로라고 가정하므로 그에 맞게 조정합니다.

```
> C:\Python27_32\python.exe shotgunEventDaemon.py install
```

또는 다음 방법으로 제거할 수 있습니다.

```
> C:\Python27_32\python.exe shotgunEventDaemon.py remove
```

서비스 시작 및 중지는 일반 서비스 관리 도구 또는 다음과 같은 명령행을 통해 수행할 수 있습니다.

```
> C:\Python27_32\python.exe shotgunEventDaemon.py start
> C:\Python27_32\python.exe shotgunEventDaemon.py stop
```

대부분의 경우 나열된 각 명령을 시스템의 관리 사용자로 실행해야 합니다. 이렇게 하려면 cmd 응용프로그램을 마우스 오른쪽 버튼으로 클릭하고 "관리자 권한으로 실행"을 선택합니다.

{% include info title="참고" content="네트워크 위치의 Windows에서 데몬을 설치한 경우 또는 네트워크 위치에서 로그 및 기타 리소스를 읽고 쓰도록 구성한 경우, 서비스를 실행하는 사용자를 로컬 시스템 계정에서 네트워크 리소스에 액세스할 수 있는 도메인 계정으로 변경하기 위해 서비스 특성을 편집해야 합니다." %}
