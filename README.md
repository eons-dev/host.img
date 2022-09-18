# Host Image

This image is intended to be run on [KubeVirt](https://kubevirt.io/) and provide a base for running [guest images](https://github.com/infrastructure-tech/img_guest).

Our goal with this image is to provide just enough support to the guest images and let them take full control over the virtual machine provided by this host. Using this image as a virtual machine and running docker containers on it provides a means of shimming in a full operating system kernel to containers.

## Optimization

This image is currently built using [Arch Linux](https://archlinux.org/). Arch is reasonably small but also well integrated and should run on KubeVirt and other systems without much, if any, need for reconfiguration.

Here, we've traded some size for some performance (Arch is larger than Alpine by default) and some performance for some size (Arch does not have as many utilities out of the box as Ubuntu, for example). This middle-of-the-road approach will be refined as the image gets used in more in more environments; meaning, please recommend additions and deletions!

## Usage

To deploy a guest image on a host (in Kubernetes), use the [helm_virtual chart](https://github.com/infrastructure-tech/helm_virtual).