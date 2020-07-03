# android-signing

## Description

Sign android apks by secret

## Inputs

- `ANDROID_SDK_HOME`: android sdk version, for example: `28`
- `ANDROID_BUILD_TOOLS` : sdk build tool version, for example: `28.0.2`
- `SIGN_SECRET`: `secret` name should be created from `Settings > Secret > +`
- `SIGN_FILE_PATTERN` (optional): the pattern of how to find unsinged apk, default value is `*-unsigned.apk`

> `ANDROID_SDK_HOME` and `ANDROID_BUILD_TOOLS` will be exported from `android-sdk` plugin if it is applied

## How to use it

```yml
steps:
- name: setup android sdk
  docker:
    image: openjdk:8-jdk
  envs:
    ANDROID_COMPILE_SDK: "28"
    ANDROID_BUILD_TOOLS: "28.0.2"
  plugin: android-sdk-setup

- name: sign apk
  envs:
    SIGN_FILE_PATTERN: '*-unsigned.apk'
    SIGN_SECRET: android-debug
  docker:
    image: openjdk:8-jdk
  plugin: android-signing

```
