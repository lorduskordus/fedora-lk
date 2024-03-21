# Fedora LK &nbsp; [![build-ublue](https://github.com/lorduskordus/fedora-lk/actions/workflows/build.yml/badge.svg)](https://github.com/lorduskordus/fedora-lk/actions/workflows/build.yml)

Custom [Fedora Atomic Desktop](https://fedoraproject.org/atomic-desktops/) images based on [Universal Blue (uBlue)](https://universal-blue.org/), built with ease using [BlueBuild](https://blue-build.org/).

The **BlueBuild** project makes image building easy by allowing you to declare your modifications in a yaml file using modules with an easy to understand syntax, serving as an abstraction to a classic containerfile. The images are built daily by default using a GitHub Action.

The **Universal Blue (uBlue)** project, a.k.a. Fedora Atomic on steroids, takes Fedora Atomic OCI images and adds QoL changes on top, that Fedora itself can't, like NVIDIA drivers or codecs.

These images are built on top of the 'minimal' [Fedora Generic](https://github.com/lorduskordus/fedora-generic) images and personalized to my liking, I daily drive these.

## Images

##### GNOME
```
ostree-image-signed:docker://ghcr.io/lorduskordus/fedora-lk-gnome
```
##### KDE
```
ostree-image-signed:docker://ghcr.io/lorduskordus/fedora-lk-kde
```