#!/bin/sh

rm -rf ./build
mkdir build

xcodebuild archive -project platform/xcode/love.xcodeproj -destination 'generic/platform=iOS' -scheme love-ios -archivePath ./build/Balatro.xcarchive CODE_SIGNING_REQUIRED=NO CODE_SIGNING_ALLOWED=NO CODE_SIGN_IDENTITY= CODE_SIGN_ENTITLEMENTS= GCC_OPTIMIZATION_LEVEL=s SWIFT_OPTIMIZATION_LEVEL=-O

cd build
mkdir -p Payload
mv ./Balatro.xcarchive/Products/Applications/Balatro.app Payload/
zip -r Balatro.ipa Payload

