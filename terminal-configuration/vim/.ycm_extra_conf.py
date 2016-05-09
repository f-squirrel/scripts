#!/usr/bin/env python
#
# Copyright (C) 2014  Google Inc.
#
# This file is part of YouCompleteMe.
#
# YouCompleteMe is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# YouCompleteMe is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with YouCompleteMe.  If not, see <http://www.gnu.org/licenses/>.

import os
import ycm_core
import glob

# These are the compilation flags that will be used in case there's no
# compilation database set (by default, one is not set).
# CHANGE THIS LIST OF FLAGS. YES, THIS IS THE DROID YOU HAVE BEEN LOOKING FOR.

flags = [
'-Wall',
'-Wextra',
'-Wc++98-compat',
'-Wno-long-long',
'-Wno-variadic-macros',
'-fexceptions',
'-fno-rtti',
'-fno-strict-aliasing',
'-fPIE',
'-fpic',
'-DNDEBUG',
'-DANDROID',
'-DUSE_CLANG_COMPLETER',
'-std=c++11',
'-x', 'c++',
'-I', '.',
'-I', './include'
]

def AddDirsRecursively( flagsRec, predicatFlag ):
    global flags
    new_flags = []
    for flag in flagsRec: 
        for d in glob.glob(flag):
            if os.path.isdir(d):
                new_flags.append(predicatFlag)
                new_flags.append(d)

    flags += new_flags 

if (os.getenv('NDK_ROOT')):
    android_build_top = os.getenv('NDK_ROOT');
    #ndkIncludes = [
    #'I', os.path.join(android_build_top, 'sources/cxx-stl/llvm-libc++/libcxx/include'),
    #'I', os.path.join(android_build_top, 'sources/boost/1.58.0/include'),
    #'I', os.path.join(android_build_top, 'sources/boost/1.58.0/include/boost/') 
    #]
    #flags += ndkIncludes

    ndkIncludes = [
    os.path.join(android_build_top, 'sources/cxx-stl/llvm-libc++/libcxx/include/'),
    os.path.join(android_build_top, 'sources/boost/1.58.0/include/'),
    os.path.join(android_build_top, 'sources/boost/1.58.0/include/boost/*') 
    ]
    #AddDirsRecursively(ndkIncludes, '-isystem');

tinyandroid_build_top = None
if (os.getenv('ANDROID_SRC')):
    android_build_top = os.getenv('ANDROID_SRC');
    androidCoreIncludes = [
         os.path.join(android_build_top, 'system/core/include'),
         os.path.join(android_build_top, 'hardware/libhardware/include'),
         os.path.join(android_build_top, 'hardware/libhardware_legacy/include'),
         os.path.join(android_build_top, 'hardware/ril/include'),
         os.path.join(android_build_top, 'libnativehelper/include'),
         os.path.join(android_build_top, 'bionic/libc/arch-arm/include'),
         os.path.join(android_build_top, 'bionic/libc/include'),
         os.path.join(android_build_top, 'bionic/libc/kernel/common'),
         os.path.join(android_build_top, 'bionic/libc/kernel/arch-arm'),
        # We dp not want to use bionic
        # os.path.join(android_build_top, 'bionic/libstdc++/include'),
        # os.path.join(android_build_top, 'bionic/libstdc++/include'),
         os.path.join(android_build_top, 'bionic/libm/include'),
         os.path.join(android_build_top, 'bionic/libm/include/arm'),
         os.path.join(android_build_top, 'bionic/libthread_db/include'),
         os.path.join(android_build_top, 'frameworks/native/include'),
         os.path.join(android_build_top, 'frameworks/native/opengl/include'),
         os.path.join(android_build_top, 'frameworks/av/include'),
         os.path.join(android_build_top, 'frameworks/base/include'),
         os.path.join(android_build_top, 'kernel/include/uapi') 
    ]
    AddDirsRecursively(androidCoreIncludes, '-isystem');
    
    stdlibIncludes = [
        os.path.join(android_build_top, 'external/stlport/stlport')
    ]
    AddDirsRecursively(stdlibIncludes, '-isystem');

    tinyandroid_build_top = os.path.join(android_build_top, 'tinyandroid');
elif (os.getenv('TINYANDROID_SRC')):
    tinyandroid_build_top = os.getenv('TINYANDROID_SRC');

if (tinyandroid_build_top is not None):
    common = os.path.join(tinyandroid_build_top, 'Common');
    commonIncludes = [
        os.path.join(common, 'DroidUI/inc'),
        os.path.join(common, 'WMTUtil/inc'),
        os.path.join(common, 'WMTNet/inc'),
        os.path.join(common, 'wifi/inc'),
        os.path.join(common, 'cast/UpgradeService/inc'),
        os.path.join(common, 'cast/WebService'),
        os.path.join(common, 'UpgradeUtil/inc'),
        os.path.join(common, 'tiny_vold/inc'),
        os.path.join(common, 'tiny_power'),
        os.path.join(common, 'QREncode')
    ]

    tinyandroidIncludes = commonIncludes;

    mifi = os.path.join(tinyandroid_build_top, 'Mifi/FileSystem');
    mifiIncludes = [
        os.path.join(mifi, 'RilService/inc'),
        os.path.join(mifi, 'SysUtil/inc'),
        os.path.join(mifi, 'WebService'),
        os.path.join(mifi, 'MifiUI'),
        os.path.join(mifi, 'dreamrouter/dreamrouter/*'),
        os.path.join(mifi, 'dreamrouter/filesender/include'),
        os.path.join(mifi, 'dreamrouter/ntpclient/include'),
        os.path.join(mifi, 'dreamrouter/ThirdParty/curl/include'),
        os.path.join(mifi, 'dreamrouter/ThirdParty/uuid/include'),
        os.path.join(mifi, 'dreamrouter/ThirdParty/openssl/include'),
        os.path.join(mifi, 'dreamrouter/ThirdParty/vsp/include'),
        os.path.join(mifi, 'dreamrouter/ThirdParty/rapidjson'),
        os.path.join(mifi, 'dreamrouter/ThirdParty/sqlite/include')
    ]
    tinyandroidIncludes += mifiIncludes;
    AddDirsRecursively(tinyandroidIncludes, '-isystem');

#if (os.getenv('ANDROID_SRC_ROOT')):
#    android_build_top = os.getenv('ANDROID_SRC_ROOT');
#    androidIncludes = [
#        #add paths to Android sources
#    ]
#    flags = flags +  androidIncludes

# Set this to the absolute path to the folder (NOT the file!) containing the
# compile_commands.json file to use that instead of 'flags'. See here for
# more details: http://clang.llvm.org/docs/JSONCompilationDatabase.html
#
# Most projects will NOT need to set this to anything; you can just change the
# 'flags' list of compilation flags.
compilation_database_folder = ''

if os.path.exists( compilation_database_folder ):
  database = ycm_core.CompilationDatabase( compilation_database_folder )
else:
  database = None

SOURCE_EXTENSIONS = [ '.cpp', '.cxx', '.cc', '.c', '.m', '.mm' ]

def DirectoryOfThisScript():
  return os.path.dirname( os.path.abspath( __file__ ) )


def MakeRelativePathsInFlagsAbsolute( flags, working_directory ):
  if not working_directory:
    return list( flags )
  new_flags = []
  make_next_absolute = False
  path_flags = [ '-isystem', '-I', '-iquote', '--sysroot=' ]
  for flag in flags:
    new_flag = flag

    if make_next_absolute:
      make_next_absolute = False
      if not flag.startswith( '/' ):
        new_flag = os.path.join( working_directory, flag )

    for path_flag in path_flags:
      if flag == path_flag:
        make_next_absolute = True
        break

      if flag.startswith( path_flag ):
        path = flag[ len( path_flag ): ]
        new_flag = path_flag + os.path.join( working_directory, path )
        break

    if new_flag:
      new_flags.append( new_flag )
  return new_flags


def IsHeaderFile( filename ):
  extension = os.path.splitext( filename )[ 1 ]
  return extension in [ '.h', '.hxx', '.hpp', '.hh' ]


def GetCompilationInfoForFile( filename ):
  # The compilation_commands.json file generated by CMake does not have entries
  # for header files. So we do our best by asking the db for flags for a
  # corresponding source file, if any. If one exists, the flags for that file
  # should be good enough.
  if IsHeaderFile( filename ):
    basename = os.path.splitext( filename )[ 0 ]
    for extension in SOURCE_EXTENSIONS:
      replacement_file = basename + extension
      if os.path.exists( replacement_file ):
        compilation_info = database.GetCompilationInfoForFile(
          replacement_file )
        if compilation_info.compiler_flags_:
          return compilation_info
    return None
  return database.GetCompilationInfoForFile( filename )


# This is the entry point; this function is called by ycmd to produce flags for
# a file.
def FlagsForFile( filename, **kwargs ):
  if database:
    # Bear in mind that compilation_info.compiler_flags_ does NOT return a
    # python list, but a "list-like" StringVec object
    compilation_info = GetCompilationInfoForFile( filename )
    if not compilation_info:
      return None

    final_flags = MakeRelativePathsInFlagsAbsolute(
      compilation_info.compiler_flags_,
      compilation_info.compiler_working_dir_ )
  else:
    relative_to = DirectoryOfThisScript()
    final_flags = MakeRelativePathsInFlagsAbsolute( flags, relative_to )

  return {
    'flags': final_flags,
    'do_cache': True
  }
