#!/usr/bin/perl

use warnings;
use strict;
use File::Basename qw(dirname);
use File::Copy qw(move);
use File::Path qw(mkpath rmtree);
use File::Spec qw(rel2abs);
use lib File::Spec->rel2abs(dirname(__FILE__)) . '/perl';
use PrepareAndroidSDK;

PrepareAndroidSDK::GetAndroidSDK('android-21', undef, 'r18b');

die('ANDROID_NDK_ROOT environment variable is not set') unless $ENV{ANDROID_NDK_ROOT};
chdir(File::Spec->rel2abs(dirname(__FILE__)));

if (-d 'builds')
{
	rmtree('builds') or die('Failed to delete builds directory');
}

if (-d 'lib')
{
	rmtree('lib') or die('Failed to delete lib directory');
}

if (-d 'obj')
{
	rmtree('obj') or die('Failed to delete obj directory');
}

my $ndkBuild = $ENV{ANDROID_NDK_ROOT} . '/ndk-build';
my $ndkDebug = 0;
system($ndkBuild, "NDK_DEBUG=$ndkDebug", 'clean');
system($ndkBuild, "NDK_DEBUG=$ndkDebug", '-j8');

mkpath('builds/arm64-v8a') or die('Failed to create builds/arm64-v8a directory');
move('obj/local/arm64-v8a/libunwind.a', 'builds/arm64-v8a/libunwind.a') or die('Failed to move arm64-v8a/libunwind.a');
File::Copy::Recursive::dircopy('../include', 'builds/include') or die('Failed to copy include directory');

chdir('builds') or die('Failed to change directory to builds');
system('zip', '-r', 'builds.zip', '.') and die ('Failed to zip builds directory');
