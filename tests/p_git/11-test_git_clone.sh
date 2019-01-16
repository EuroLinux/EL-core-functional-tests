#!/bin/bash

# Author: Pratima Singh <prati.86@gmail.com>, Nilesh Bairagi <nileshbairagi@gmail.com>, Madhurranjan Mohaan <madhurranjan.mohaan@gmail.com>
#	  Christoph Galuschka <christoph.galuschka@chello.at>

t_Log "Running $0 - testing a local git clone operation"

if [ $el_ver == '6' ]
  then
  # Testing Git clone by comparing SHAs
  workpath=$(pwd)
  rm -rf /tmp/temprepo/ /tmp/cloned_repo/ /tmp/testing_clone_repo
  temp_repo="/tmp/temprepo"
  SHA1=`echo "hello world" | git hash-object --stdin`
  mkdir -p $temp_repo
  cd $temp_repo
  git init . --bare
  cd /tmp
  git clone $temp_repo cloned_repo
  cd cloned_repo
  git config user.email "centos@centos.org"
  git config user.name "t_functional tests"
  echo "hello world" > hello
  git add hello
  git commit -m "Temp commit"
  git push origin master

  git clone $temp_repo /tmp/testing_clone_repo
  cd /tmp/testing_clone_repo
  SHA2=`cat hello | git hash-object --stdin`
  expr $SHA1 == $SHA2 2>&1
  ret_val=$?
  cd $workpath
else
  t_Log "This test is skipped in CentOS5."
  ret_val=0
fi

t_CheckExitStatus $ret_val
