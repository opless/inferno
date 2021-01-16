# Directories common to all architectures.
# Build in order:
#	- critical libraries used by the limbo compiler
#	- the limbo compiler (used to build some subsequent libraries)
#	- the remaining libraries
#	- commands
#	- utilities

EMUDIRS=\
	lib9\
	libbio\
	libmp\
	libsec\
	libmath\
	utils/iyacc\
	limbo\
	libinterp\
	libkeyring\
	libdraw\
	libprefab\
	libtk\
	libfreetype\
	libmemdraw\
	libmemlayer\
	libdynld\
	utils/data2c\
	utils/ndate\
	emu\

KERNEL_DIRS=\
	os\
	os/boot/pc\

# mkconfig is included at this point to allow it to override
#the preceding declarations (particularly KERNEL_DIRS) if need be

<mkconfig

DIRS=\
	$EMUDIRS\
#	appl\

foo:QV:
	echo mk all, clean, install, installall or nuke

all:V:		all-$HOSTMODEL
clean:V:	clean-$HOSTMODEL
install:V:	install-$HOSTMODEL
installall:V:	installall-$HOSTMODEL
emu:V:	emu/all-$HOSTMODEL
emuinstall:V:	emu/install-$HOSTMODEL
emuclean:V:	emu/clean-$HOSTMODEL
emunuke:V:	emu/nuke-$HOSTMODEL
kernel:V:	kernel/all-$HOSTMODEL
kernelall:V:	kernel/all-$HOSTMODEL
kernelclean:V:	kernel/clean-$HOSTMODEL
kernelinstall:V:	kernel/install-$HOSTMODEL
kernelinstallall:V:	kernel/installall-$HOSTMODEL
kernelnuke:V:	kernel/nuke-$HOSTMODEL
nuke:V:		nuke-$HOSTMODEL

cleandist:V: clean
	echo ':::: cleandist'
	rm -f $ROOT/$OBJDIR/lib/lib*.a

nukedist:V: nuke
	echo ':::: nukedist'
	rm -f $ROOT/$OBJDIR/bin/*.exe
	rm -f $ROOT/$OBJDIR/lib/lib*.a
	
&-Posix:QV:
	echo ':::: ' $stem '-Posix'
	for j in $DIRS utils tools
	do
		echo "(cd $j; mk $MKFLAGS $stem)"
		(cd $j; mk $MKFLAGS $stem) || exit 1
	done

&-Nt:QV:
	echo ':::: ' $stem '-Nt'
	for (j in $DIRS utils tools)
	{
		echo '@{builtin cd' $j '; mk $MKFLAGS $stem}'
		@{builtin cd $j; mk.exe $MKFLAGS $stem }
	}

&-Inferno:QV:
	echo ':::: ' $stem '-Inferno'
	for (j in $DIRS utils)
	{
		echo '@{builtin cd' $j '; mk $MKFLAGS $stem}'
		@{builtin cd $j; mk $MKFLAGS $stem }
	}

&-Plan9:QV:
	echo ':::: ' $stem '-Plan9'
	echo ':::: DIRS=' $DIRS
	echo ':::: MKFLAGS=' $MKFLAGS
	for (j in $DIRS utils)
	{
		echo '@{builtin cd' $j '; mk $MKFLAGS $stem}'
		@{builtin cd $j; mk $MKFLAGS $stem }
	}

emu/&-Posix:QV:
	echo ':::: emu/' $stem '-Posix'
	for j in $EMUDIRS
	do
		echo "(cd $j; mk $MKFLAGS $stem)"
		(cd $j; mk $MKFLAGS $stem) || exit 1
	done

emu/&-Nt:QV:
	echo ':::: emu/' $stem '-Nt'
	for (j in $EMUDIRS)
	{
		echo '@{builtin cd' $j '; mk $MKFLAGS $stem}'
		@{builtin cd $j; mk $MKFLAGS $stem }
	}

emu/&-Plan9:QV:
	echo ':::: emu/' $stem '-Plan9'
	for (j in $EMUDIRS)
	{
		echo '@{builtin cd' $j '; mk $MKFLAGS $stem}'
		@{builtin cd $j; mk $MKFLAGS $stem }
	}

kernel/&-Posix:QV:
	echo ':::: kernel/' $stem '-Posix'
	for j in $KERNEL_DIRS
	do
		echo "(cd $j; mk $MKFLAGS $stem)"
		(cd $j; mk $MKFLAGS $stem) || exit 1
	done

kernel/&-Nt:QV:
	echo ':::: kernel/' $stem '-Nt'
	for (j in $KERNEL_DIRS)
	{
		echo '@{builtin cd' $j '; mk $MKFLAGS $stem}'
		@{builtin cd $j; mk $MKFLAGS $stem }
	}

kernel/&-Inferno:QV:
	echo ':::: kernel/' $stem '-Inferno'
	for (j in $KERNEL_DIRS)
	{
		echo '@{builtin cd' $j '; mk $MKFLAGS $stem}'
		@{builtin cd $j; mk $MKFLAGS $stem }
	}

kernel/&-Plan9:QV:
	echo ':::: kernel/' $stem '-Plan9'
	for (j in $KERNEL_DIRS)
	{
		echo '@{builtin cd' $j '; mk $MKFLAGS $stem}'
		@{builtin cd $j; mk $MKFLAGS $stem }
	}

# Convenience targets

Inferno-% inferno-% Inferno-386-% inferno-386-%:V:
	echo ':::: convenience target Inferno 386 ' $stem 
	mk 'SYSHOST=Inferno' 'OBJTYPE=386' $stem

Inferno-arm-% inferno-arm-%:V:
	echo ':::: convenience target Inferno arm ' $stem 
	mk 'SYSHOST=Inferno' 'OBJTYPE=arm' $stem

Plan9-% plan9-%:V:
	echo ':::: convenience target Plan9 386 ' $stem 
	mk 'SYSHOST=Plan9' 'OBJTYPE=386' $stem

Irix-% irix-%:V:
	echo ':::: convenience target Irix mips ' $stem 
	mk 'SYSHOST=Irix' 'OBJTYPE=mips' $stem

Linux-% linux-%:V:
	echo ':::: convenience target Linux 386 ' $stem 
	mk 'SYSHOST=Linux' 'OBJTYPE=386' $stem

NetBSD-% netbsd-%:V:
	echo ':::: convenience target NetBSD 386 ' $stem 
	mk 'SYSHOST=NetBSD' 'OBJTYPE=386' $stem

Nt-% nt-% Win95-% win95-%:V:
	echo ':::: convenience target Nt / Win95 386 ' $stem 
	mk 'SYSHOST=Nt' 'OBJTYPE=386' $stem

Solaris-% solaris-%:V:
	echo ':::: convenience target Solaris sparc ' $stem 
	mk 'SYSHOST=Solaris' 'OBJTYPE=sparc' $stem

mkdirs:V:	mkdirs-$SHELLTYPE

mkdirs-rc:V:
	echo ':::: mkdirs rc ' 
	mkdir -p `{cat lib/emptydirs}
	chmod 555 mnt/* n/client/* n/*

mkdirs-sh:V:
	echo ':::: mkdirs sh ' 
	mkdir -p `cat lib/emptydirs`
	chmod 555 mnt/* n/client/* n/*

mkdirs-nt:V:
	echo ':::: mkdirs nt ' 
	mkdir -p `{cmd /c type lib\emptydirs}
