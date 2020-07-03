#!/usr/bin/env bash

tools=${ANDROID_SDK_HOME}/build-tools/${ANDROID_BUILD_TOOLS}

sign()
{
  originApk=$1 
  ksPath=$2
  ksPw=$3
  keyAlias=$4
  keyPw=$5

  trimed=${originApk%${SIGN_FILE_PATTERN}}
  signed=${trimed}-signed.apk

  # zipalign
  zipaligned=${trimed}-zipalign.apk
  ${tools}/zipalign -f 4 "${originApk}" "${zipaligned}"
  result=$?
  if [[ $result != 0 ]]; then
    exit $result
  fi

  # apksigner
  ${tools}/apksigner sign \
    --out "${signed}" \
    --ks ${ksPath} \
    --ks-pass pass:${ksPw} \
    --ks-key-alias ${keyAlias} \
    --key-pass pass:${keyPw} \
    ${zipaligned}

  result=$?
  if [[ $result != 0 ]]; then
    exit $result
  fi

  rm ${zipaligned}
  echo "'${signed}' signed"
}

srcDir=$(dirname $BASH_SOURCE)
secretInfo=$(python3 ${srcDir}/load.py)
echo ${secretInfo} | { 
  read ksPath ksPw keyAlias keyPw; 
  find /Users/yang/work/SampleHelloworld -type f -name "${SIGN_FILE_PATTERN}" | while read file; do sign $file $ksPath $ksPw $keyAlias $keyPw; done
}