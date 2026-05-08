# RoboParty 软件全家桶元包 (`roboto_all`)

本仓库用于构建统一的 Debian 元包（Metapackage），旨在提供一键式安装整个 RoboParty 软件栈的能力。元包本身不包含任何代码或二进制文件，而是通过系统级的包依赖声明，将机器人所需的各个独立模块一次性拉取并配置到位。

## 可用包架构

* **`roboto-all`**: 全局通用的元包。适用于所有硬件平台（包括 RoboPi1、RoboPi2、RoboPi3 以及 x86 仿真与开发环境）。

## 自动安装的核心组件

通过安装此元包，APT 包管理器会自动为您拉取并安装以下核心组件的最新版本：

* `roboto-base` (核心运行环境与系统权限规则)
* `roboto-description` (URDF 描述文件、外观网格及 MJCF 仿真模型)
* `roboto-bms` (电源管理系统驱动)
* `roboto-imu` (惯性导航单元驱动)
* `roboto-motors` (多协议关节电机驱动库)
* `roboto-inference` (AI 模型推理与步态控制)
* `roboto-example` (官方测试案例与 Demo)
* `roboto-deploy` (一键启动脚本与网络配置等)

## 安装方法

请确保系统已经配置了 `apt.roboparty.com` 仓库源，然后执行一键安装：

```bash
sudo apt update
sudo apt install roboto-all
```
