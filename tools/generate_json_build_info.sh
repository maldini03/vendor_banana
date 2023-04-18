#!/bin/bash
if [ "$1" ]
then
  file_path=$1
  file_name=$(basename "$file_path")
  DEVICE=$(echo $TARGET_PRODUCT | sed 's/banana_//g')
  if [ -f $file_path ]; then
    device_name=$(echo $file_name | cut -d'-' -f4)
    file_size=$(stat -c%s $file_path)
    md5=$(cat "$file_path.md5sum" | cut -d' ' -f1)
    datetime=$(grep ro\.build\.date\.utc ./out/target/product/$DEVICE/system/build.prop | cut -d= -f2);
    id=$(sha256sum $file_path | awk '{ print $1 }');
    maintainer_name=$(grep ro\.banana\.maintainer\= ./out/target/product/$DEVICE/system/build.prop | cut -d= -f2);
    echo '{
	"response": [
		{
			"datetime": "'$datetime'",
			"filehash": "'$md5'",
			"filename": "'$file_name'",
			"id": "'$id'",
			"size": "'$file_size'",
			"maintainer": '$maintainer_name',
		}
	]
    }' >> $file_path.json
    rm -rf "./$DEVICE.json"
    mv "${file_path}.json" "./$DEVICE.json"
  fi
fi
