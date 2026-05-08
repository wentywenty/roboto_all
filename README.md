# RoboParty Meta-Packages (`roboto_all`)

This repository provides a unified Debian metapackage designed to effortlessly install the complete RoboParty software stack. A metapackage does not contain code itself; instead, it declares dependencies on all the necessary sub-modules, allowing you to set up your entire robot environment with a single `apt install` command.

## Available Packages

* **`roboto-all`**: The universal metapackage that applies to all RoboParty hardware platforms (including RoboPi1, RoboPi2, RoboPi3, and x86 development environments).

## Installed Components

Installing the metapackage will automatically pull in the latest versions of the following core modules via the APT dependency resolution:

* `roboto-base` (Core runtime and rules)
* `roboto-description` (URDF, Mesh, and MJCF models)
* `roboto-bms` (Battery Management System drivers)
* `roboto-imu` (IMU drivers)
* `roboto-motors` (Motor controllers and interfaces)
* `roboto-inference` (AI inference capabilities)
* `roboto-example` (Demonstration scripts and nodes)
* `roboto-deploy` (Deployment configurations and startup scripts)

## Installation

Ensure you have added the `apt.roboparty.com` source to your system, then run:

```bash
sudo apt update
sudo apt install roboto-all
```
