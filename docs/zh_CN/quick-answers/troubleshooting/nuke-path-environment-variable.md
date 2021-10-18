---
layout: default
title: 当我设置 NUKE_PATH 环境变量时为什么 Nuke 集成无法启动？
pagename: nuke-path-environment-variable
lang: zh_CN
---

# 当我设置 NUKE_PATH 环境变量时为什么 Nuke 集成无法启动？

启动 NUKE 时，我们的集成会设置 `NUKE_PATH` 环境变量，以便引导脚本在 NUKE 启动过程中运行。[`tk-multi-launchapp`](https://developer.shotgridsoftware.com/zh_CN/1b9c259a/#set-environment-variables-and-automate-behavior-at-launch) 在执行 [`before_launch_app.py`](https://github.com/shotgunsoftware/tk-multi-launchapp/blob/6a884aa144851148e8369e9f35a2471087f98d16/hooks/before_app_launch.py) 挂钩之前专门定义了 `NUKE_PATH`。

如果在启动过程中使用 `os.environ['NUKE_PATH'] = "/my/custom/path"` 等设置此环境变量，{% include product %} 集成将无法启动，因为您已从环境变量删除我们的启动脚本路径。

请在 `tank.util` 中使用此功能，以便将路径附加到 `NUKE_PATH` 环境变量，同时保留 Toolkit 引导的路径：

```python
tank.util.append_path_to_env_var("NUKE_PATH", "/my/custom/path")
```

此外，也可以使用 `prepend_path_to_env_var()` 附加路径。