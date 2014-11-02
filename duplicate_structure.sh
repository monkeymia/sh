#!/bin/sh
#
# https://github.com/monkeymia/
#
# Copyright (c) 2014, monkeymia, All rights reserved.
#
# This library is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public
# License as published by the Free Software Foundation; either
# version 3.0 of the License, or (at your option) any later version.
#
# This library is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public
# License along with this library
#

if [ ! -d "$1" ]; then
  echo "This script creates in target dir the same subdirectory "
  echo "and filenames (with zero bytes) and same timestamp"
  echo "as in reference dir"
  echo "BTW: You are a fool - do you think the computer can guess"
  echo "what you want ? Please start the script with arguments."
  echo "$0 <target dir> <reference dir>"
  exit 0;
fi

if [ ! -d "$2" ]; then
  echo "This script creates in target dir the same subdirectory "
  echo "and filenames (with zero bytes) and same timestamp"
  echo "as in reference dir"
  echo "BTW: You are a fool - do you think the computer can guess"
  echo "what you want ? Please start the script with arguments."
  echo "$0 <target dir> <reference dir>"
  exit 0;
fi

if [ $# == 3 ] ; then
  # arg 1 target dir
  # arg2 orginal path
  # arg3 current processed file in org path
  # mypath=`realpath -q -z --relative-to="$2" "$3"` ;
  mypath=`realpath -q -z --relative-to="$2" "$3"`;
  #echo $1 $2 $3 $mypath;
  touch --reference="$3" "$mypath";
  exit 0;
fi

target_dir="$1"
original_dir="$2"
echo "Create Directories"
find "$original_dir" -type d -exec realpath --relative-to="$original_dir" {}  \; | xargs mkdir -p
echo "set time"
find "$original_dir" -type d -print0 -exec $0 "$target_dir" "$original_dir" {} \;
echo "Create files"
find "$original_dir" -print0 -exec $0 "$target_dir" "$original_dir" {} \;
echo "Done"
