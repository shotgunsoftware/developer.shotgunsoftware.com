---
layout: default
title: 您正从位于以下位置的工作流配置加载 Toolkit 平台
pagename: tankinit-error-pipeline-config-location
lang: zh_CN
---

# TankInitError: 您正从位于以下位置的工作流配置加载 Toolkit 平台

## 用例

运行某些代码以从应用发布文件时，有时文件属于其他项目。

能否解决 `TankInitError: You are loading the Toolkit platform from the pipeline configuration located in` 错误？

理想情况下，可以从路径中查找上下文以正确注册这些文件（即使它们属于其他项目）。

## 如何修复

使用以下函数：

```
def get_sgtk(proj_name, script_name):
    """ Load sgtk path and import module
    If sgtk was previously loaded, replace include paths and reimport
    """
    project_path = get_proj_tank_dir(proj_name)

    sys.path.insert(1, project_path)
    sys.path.insert(1, os.path.join(
        project_path,
        "install", "core", "python"
    ))

    # unload old core
    for mod in filter(lambda m: m.startswith("sgtk") or m.startswith("tank"), sys.modules):
        sys.modules.pop(mod)
        del mod

    if "TANK_CURRENT_PC" in os.environ:
        del os.environ["TANK_CURRENT_PC"]

    import sgtk
    setup_sgtk_auth(sgtk, script_name)
    return sgtk
```
该键从 `sys.modules` 中删除与 sgtk 相关的所有模块，并从环境中移除 `TANK_CURRENT_PC`。有关概述信息，请参见[如何使用 shotgunEvent 进程加载不同的 Toolkit 核心模块？](https://developer.shotgridsoftware.com/zh_CN/3520ad2e/)

## 相关链接

[在社区中查看完整主题](https://community.shotgridsoftware.com/t/tankiniterror-loading-toolkit-platform-from-a-different-project/9342)