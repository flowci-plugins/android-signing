#!/usr/bin/env bash

tools=${ANDROID_SDK_HOME}/build-tools/${ANDROID_BUILD_TOOLS}

sign()
{
  origin=$1
  trimed=${origin%${SIGN_FILE_PATTERN}}

  zipaligned=${trimed}-zipalign.apk
  ${tools}/zipalign -f 4 "${origin}" "${zipaligned}"
  result=$?
  if [[ $result != 0 ]]; then
    exit $result
  fi

  signed=${trimed}-signed.apk

  ${tools}/apksigner sign \
    --out "${signed}" \
    --ks /test.jks \
    --ks-pass pass:xxxxxxxx \
    --ks-key-alias helloworld \
    --key-pass pass:xxxxxxxx \
    ${zipaligned}

  result=$?
  if [[ $result != 0 ]]; then
    exit $result
  fi

  rm ${zipaligned}
  echo "'${signed}' signed"
}

find . -type f -name "${SIGN_FILE_PATTERN}" | while read file; do sign "$file"; done