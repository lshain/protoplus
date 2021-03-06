#!/usr/bin/env bash
# 设置GOPATH

CURR_DIR=`pwd`
cd ../../../../../
export GOPATH=`pwd`
BIN_DIR=`pwd`/bin

#----------------------------------------------------------------------
#if false;then
if true;then


# 设置Go编译的参数
if [ `uname -s` == "Darwin" ];then
	echo "Platform: MacOS"
	export GOARCH=amd64
	export GOOS=darwin
elif [ `uname -s` == "Linux" ];then
	echo "Platform: Linux"
	export GOARCH=amd64
	export GOOS=linux
else
	echo "Platform: Windows"
	export GOARCH=amd64
	export GOOS=windows
fi



echo "编译协议生成器..."
go build -v -p 4 -o ${BIN_DIR}/protoplusgen github.com/davyxu/protoplus/tests
if [ $? -ne 0 ] ; then read -rsp $'Errors occurred...\n' ; fi

fi


cd ${CURR_DIR}


#----------------------------------------------------------------------

#--json_out=./msg.json \

if true;then

echo "生成协议...."
${BIN_DIR}/protoplusgen \
--go_out=./msg.go \
--AutoMsgIDCacheFile=automsgidcache.json \
--ShowOverWriteCacheFileWarning \
--CheckDuplicateMsgID \
`source ./filelist.sh`
if [ $? -ne 0 ] ; then read -rsp $'Errors occurred...\n' ; fi

fi


#----------------------------------------------------------------------


if true; then

echo "生成建议消息ID...."
${BIN_DIR}/protoplusgen --GenSuggestMsgID=true \
--SuggestMsgIDStart=8000 \
`source ./filelist.sh`

if [ $? -ne 0 ] ; then read -rsp $'Errors occurred...\n' ; fi


fi


#----------------------------------------------------------------------





read -rsp $''

