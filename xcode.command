
cd `dirname $0`
cd build
./premake4_osx xcode4
open xcode4/0_Bullet3Solution.xcworkspace
