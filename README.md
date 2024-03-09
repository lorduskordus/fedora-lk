# Fedora LK &nbsp; [![build-ublue](https://github.com/lorduskordus/fedora-lk/actions/workflows/build.yml/badge.svg)](https://github.com/lorduskordus/fedora-lk/actions/workflows/build.yml)

Custom Linux OS images built with ease using the [BlueBuild](https://blue-build.org/) project. BlueBuild is a collection of tools and documentation that allows to easily build custom images, without having to know about stuff like containerfiles, that are common to image building. You can [make your own](https://blue-build.org/how-to/setup/) !

These images are built on top of the 'minimal' [Fedora Generic](https://github.com/lorduskordus/fedora-generic) images and personalized to my liking, I daily drive these.

## ISO

Get it [here](https://github.com/lorduskordus/fedora-lk/releases/tag/auto-iso).

## Images

##### GNOME
```
ostree-image-signed:docker://ghcr.io/lorduskordus/fedora-lk-gnome
```
##### KDE
```
ostree-image-signed:docker://ghcr.io/lorduskordus/fedora-lk-kde
```