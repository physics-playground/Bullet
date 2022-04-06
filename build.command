#!/bin/sh

cd "$(dirname "$0")" || true
cd "build" || true

./premake4_osx xcode4
open "xcode4/0_Bullet3Solution.xcworkspace"
