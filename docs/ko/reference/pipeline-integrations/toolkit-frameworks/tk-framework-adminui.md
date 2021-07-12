---
layout: default
title: 관리자 UI
pagename: tk-framework-adminui
lang: ko
---

# 툴킷 관리자 UI 프레임워크

관리자 UI 프레임워크는 툴킷 관리 명령을 래핑하는 표준 사용자 인터페이스의 위치를 구현합니다.

현재 유일한 인터페이스는 setup_project 명령에 대한 인터페이스입니다.

## SetupProjectWizard API 참조

![](images/setup_project_wizard.png)

이 API는 툴킷용 {% include product %} 인스턴스를 통해 프로젝트를 설정하는 단계를 보여 주는 QWizard 구현입니다. 이 마법사를 사용하려면 (표준 {% include product %} API 엔티티 사전으로) 설정할 프로젝트와 부모로 지정할 창을 전달하는 클래스 인스턴스를 생성하기만 하면 됩니다.

```python
adminui = sgtk.platform.import_framework("tk-framework-adminui", "setup_project")
setup = adminui.SetupProjectWizard(project, parent)
dialog_result = setup.exec_()
```

이렇게 하면 마법사가 실행되고, 표준 QDialog Accepted 또는 Rejected 값이 반환됩니다.

### SetupProjectWizard 생성자

SetupProjectWizard를 초기화합니다. 다음은 QtGui.QWizard의 하위 클래스입니다.

```python
SetupProjectWizard()
```
