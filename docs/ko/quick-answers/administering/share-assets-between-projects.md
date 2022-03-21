---
layout: default
title: 프로젝트 간에 에셋을 어떻게 공유합니까?
pagename: share-assets-between-projects
lang: ko
---

# 프로젝트 간에 에셋을 어떻게 공유합니까?

한 프로젝트가 다른 프로젝트의 샷에 로드할 수 있는 에셋을 포함하는 에셋 라이브러리로 사용되는 경우를 흔히 볼 수 있습니다.

이제 에셋 엔티티에 링크된 프로젝트(Linked Projects) 필드가 도입되어, [Loader 앱](https://help.autodesk.com/view/SGSUB/KOR/?guid=SG_Supervisor_Artist_sa_integrations_sa_integrations_user_guide_html#the-loader)에 링크된 프로젝트를 모두 포함하는 단일 탭을 추가할 수 있습니다. 이렇게 하려면 작업 중인 엔진 및 환경에 대한 로더 설정에서 이를 정의해야 합니다. 아마도 이 설정을 여러 위치에서 업데이트해야 할 것입니다.

```yaml
- caption: Assets - Linked
    entity_type: Asset
    filters:
      - [linked_projects, is, "{context.project}"]
    hierarchy: [project.Project.name, sg_asset_type, code]
```

[tk-config-default2](https://github.com/shotgunsoftware/tk-config-default2)에 포함된 [tk-multi-loader2.yml 구성 파일](https://github.com/shotgunsoftware/tk-config-default2/blob/a5af14aefbafaec6cf0933db83343f600eb75870/env/includes/settings/tk-multi-loader2.yml#L343-L347)에서 Alias 엔진 설정을 참조하십시오. 이것이 기본 동작입니다.

---

에셋에 링크된 프로젝트(Linked Projects) 필드를 도입하기 전에 프로젝트 간에 공유를 수행하려면 특정 에셋 라이브러리 프로젝트의 에셋이 나열된 탭을 [Loader 앱](https://help.autodesk.com/view/SGSUB/KOR/?guid=SG_Supervisor_Artist_sa_integrations_sa_integrations_user_guide_html#the-loader)에 추가해야 했습니다.

예를 들어, [샷 단계 환경의 Maya 엔진](https://github.com/shotgunsoftware/tk-config-default2/blob/e09236bf4b91a6dd79ca5b3ef1258d0eb0afd871/env/includes/settings/tk-multi-loader2.yml#L122)에 이를 추가하려면 다음 조각을 추가하면 됩니다.

```yaml
- caption: Asset Library
    hierarchy: [project, sg_asset_type, code]
    entity_type: Asset
    filters:
      - [project, is, {'type': 'Project', 'id': 207}]
```

`207`을 라이브러리 프로젝트의 ID로 바꿉니다.

현재 Maya의 샷 단계 환경에서 작업 중인 경우 이렇게 하면 해당 프로젝트에서 사용할 수 있는 모든 게시를 보여 주는 새 탭이 추가됩니다. 이 탭을 다른 엔진(Nuke, 3dsmax 등)의 로더에 추가하려면 해당하는 각 엔진에 대한 `tk-multi-loader2` 설정도 수정해야 합니다. 다른 환경에서 이를 활성화하려면 에셋 단계 환경, 그리고 해당 탭을 추가할 모든 다른 환경에서도 같은 단계를 수행해야 합니다. 조금 지루하겠지만 이렇게 해야 좀 더 미세하게 조정할 수 있습니다.

이렇게 설정하면 Loader 앱이 식별된 프로젝트의 게시가 나열된 탭을 표시해야 합니다.

---

{% include info title="참고" content="초기에 사용된 이 방방식은 Loader 내에서 식별된 프로젝트별로 다른 탭을 가질 수 있게 해 주므로 여전히 포함됩니다." %}

웹 기반의 프로젝트 간 에셋 링크에 대해 자세히 알아보려면 [프로젝트 간 에셋 링크 설명서](https://help.autodesk.com/view/SGSUB/KOR/?guid=SG_Administrator_ar_site_configuration_ar_cross_project_asset_linking_html)를 참조하십시오.
