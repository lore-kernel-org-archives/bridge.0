Message-ID: <404394AE.9050803@nortelnetworks.com>
Date: Mon, 01 Mar 2004 11:53:18 -0800
From: Abhijit Kumbhare <abhijitk@nortelnetworks.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010904070202050201080600"
Subject: [Bridge] Re: i need some help with compiling bridge module
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org, software-team@wp.pl
Cc: rubini@linux.it

This is a multi-part message in MIME format...

--------------010904070202050201080600
Content-Type: multipart/alternative;
	boundary="----------=_1078170810-27351-194"
Content-Transfer-Encoding: binary
MIME-Version: 1.0
X-Mailer: MIME-tools 5.411 (Entity 5.404)

This is a multi-part message in MIME format...

------------=_1078170810-27351-194
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I ran into the same problem as you did - and am also a linux newbee. I modified the make 
files from the book "Linux Device Drivers" by Alessandro Rubini to compile the bridge module
separately in different directory from the linux source (it worked for me on linux 2.4 on a
normal Pentium 450 MHz - I think he has taken care of most of the version dependent stuff).

You need to do the following to use that way:

1) Create a directory somewhere - say <your_dir>
2) Create a sub-directory in <your_dir> called bridge (say) - so you have <your_dir>/bridge
3) Copy over the bridge code into <your_dir>/bridge
4) Copy the file Rules.make (attached) to <your_dir>
5) Copy the Makefile to <your_dir>/bridge
6) Change the variable KERNELDIR in Rules.make to your linux source path - I am using Red Hat
   Linux so my variable was /usr/src/linux-2.4
7) Don't remember whether this is required for bridge module or it complained when I was compiling
   some other module - but I had to copy my machine config to $KERNELDIR/.config (for me it was
   the file /usr/src/linux-2.4/configs/kernel-2.4.20-i686.config).
8) Compile in the <your_dir>/bridge directory using make (all, clean, etc.)

You can avoid using a different directory and put Rules.make in the same directory by changing the
Makefile - but you can use the same infrastructure to compile different types of modules (I started
off trying to reuse the bridge module code but later on switched to writing a totally different
module). 

Alessandro Rubini has used this generic infra-structure approach - and its very nice and
borrowable approach - the code samples are at:

http://examples.oreilly.com/linuxdrive2/ 



>> I am trying to improve bridge module towards 802.1w (RSTP) but I am new to kernel and modules 
>> programming. I dont want to compile the whole modules every time I make some changes. Could 
>> you give me some clues how to set up environment to compile only selected module (bridge 802.1d)
>> for a given kernel version, written in Makefile like:
>> VERSION = 2
>> PATCHLEVEL = 4
>> SUBLEVEL = 20
>> EXTRAVERSION =-8 etc.
>> How to make a Makefile so the bridge module could be compiled separately for that kernel (or another)?
>> Thanks for any specyfic help.
>> Software Team

------------------------------------------------------------------------

------------=_1078170810-27351-194
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html;charset=ISO-8859-1">
  <title></title>
</head>
<body>
<pre>I ran into the same problem as you did - and am also a linux newbee. I modified the make 
files from the book "Linux Device Drivers" by Alessandro Rubini to compile the bridge module
separately in different directory from the linux source (it worked for me on linux 2.4 on a
normal Pentium 450 MHz - I think he has taken care of most of the version dependent stuff).

You need to do the following to use that way:

1) Create a directory somewhere - say &lt;your_dir&gt;
2) Create a sub-directory in &lt;your_dir&gt; called bridge (say) - so you have &lt;your_dir&gt;/bridge
3) Copy over the bridge code into &lt;your_dir&gt;/bridge
4) Copy the file Rules.make (attached) to &lt;your_dir&gt;
5) Copy the Makefile to &lt;your_dir&gt;/bridge
6) Change the variable KERNELDIR in Rules.make to your linux source path - I am using Red Hat
  &nbsp;Linux so my variable was /usr/src/linux-2.4
7) Don't remember whether this is required for bridge module or it complained when I was compiling
   some other module - but I had to copy my machine config to $KERNELDIR/.config (for me it was
   the file /usr/src/linux-2.4/configs/kernel-2.4.20-i686.config).
8) Compile in the &lt;your_dir&gt;/bridge directory using make (all, clean, etc.)

You can avoid using a different directory and put Rules.make in the same directory by changing the
Makefile - but you can use the same infrastructure to compile different types of modules (I started
off trying to reuse the bridge module code but later on switched to writing a totally different
module). 

Alessandro Rubini has used this generic infra-structure approach - and its very nice and
borrowable approach - the code samples are at:

<a class="moz-txt-link-freetext" href="http://examples.oreilly.com/linuxdrive2/">http://examples.oreilly.com/linuxdrive2/</a> 



&gt;&gt; I am trying to improve bridge module towards 802.1w (RSTP) but I am new to kernel and modules 
&gt;&gt; programming. I dont want to compile the whole modules every time I make some changes. Could 
&gt;&gt; you give me some clues how to set up environment to compile only selected module (bridge 802.1d)
&gt;&gt;&nbsp;for a given kernel version, written in Makefile like:
&gt;&gt; VERSION = 2
&gt;&gt; PATCHLEVEL = 4
&gt;&gt; SUBLEVEL = 20
&gt;&gt; EXTRAVERSION =-8 etc.
&gt;&gt; How to make a Makefile so the bridge module could be compiled separately for that kernel (or another)?
&gt;&gt; Thanks for any specyfic help.
&gt;&gt; Software Team
</pre>
<!--endarticle-->      
<hr>
</body>
</html>

------------=_1078170810-27351-194--

--------------010904070202050201080600
Content-Type: text/plain;
 name="Rules.make"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="Rules.make"

# -*-makefile-*-
#
# This file is part of the sample code for the book "Linux Device Drivers",
# second edition. It is meant to be generic and is designed to be recycled
# by other drivers. The comments should be clear enough.
# It partly comes from Linux Makefile, and needs GNU make. <rubini@linux.it>

# TOPDIR is declared by the Makefile including this file.
ifndef TOPDIR
	TOPDIR = .
endif

# KERNELDIR can be speficied on the command line or environment
ifndef KERNELDIR
	KERNELDIR = /usr/src/linux-2.4
endif
# The headers are taken from the kernel
	INCLUDEDIR = $(KERNELDIR)/include

# We need the configuration file, for CONFIG_SMP and possibly other stuff
# (especiall for RISC platforms, where CFLAGS depends on the exact
# processor being used).
ifeq ($(KERNELDIR)/.config,$(wildcard $(KERNELDIR))/.config)
	include $(KERNELDIR)/.config
else
	MESSAGE := $(shell echo "WARNING: no .config file in $(KERNELDIR)")
endif

# ARCH can be speficed on the comdline or env. too, and defaults to this arch
# Unfortunately, we can't easily extract if from kernel configuration
# (well, we could look athe asm- symlink... don't know if worth the effort)
ifndef ARCH
  ARCH := $(shell uname -m | sed -e s/i.86/i386/ -e s/sun4u/sparc64/ \
		-e s/arm.*/arm/ -e s/sa110/arm/)
endif

# This is useful if cross-compiling. Taken from kernel Makefile (CC changed)
AS      =$(CROSS_COMPILE)as
LD      =$(CROSS_COMPILE)ld
CC      =$(CROSS_COMPILE)gcc
CPP     =$(CC) -E
AR      =$(CROSS_COMPILE)ar
NM      =$(CROSS_COMPILE)nm
STRIP   =$(CROSS_COMPILE)strip
OBJCOPY =$(CROSS_COMPILE)objcopy
OBJDUMP =$(CROSS_COMPILE)objdump

# The platform-specific Makefiles include portability nightmares.
# Some platforms, though, don't have one, so check for existence first
ARCHMAKEFILE = $(TOPDIR)/Makefile.$(ARCH)
ifeq ($(ARCHMAKEFILE),$(wildcard $(ARCHMAKEFILE)))
  include $(ARCHMAKEFILE)
endif

# CFLAGS: all assignments to CFLAGS are inclremental, so you can specify
# the initial flags on the command line or environment, if needed.

	CFLAGS +=  -Wall -D__KERNEL__ -DMODULE -I$(INCLUDEDIR)

ifdef CONFIG_SMP
	CFLAGS += -D__SMP__ -DSMP
endif

# Prepend modversions.h if we're running with versioning.
ifdef CONFIG_MODVERSIONS
	CFLAGS += -DMODVERSIONS -include $(KERNELDIR)/include/linux/modversions.h
endif

#Install dir
VERSIONFILE = $(INCLUDEDIR)/linux/version.h
VERSION     = $(shell awk -F\" '/REL/ {print $$2}' $(VERSIONFILE))
INSTALLDIR = /lib/modules/$(VERSION)/misc

--------------010904070202050201080600
Content-Type: application/x-java-applet;version=1.1.1;
 name="Makefile"
Content-Transfer-Encoding: base64
Content-Disposition: inline; filename="Makefile"

DQojIFRoaXMgTWFrZWZpbGUgaGFzIGJlZW4gc2ltcGxpZmllZCBhcyBtdWNo
IGFzIHBvc3NpYmxlLCBieSBwdXR0aW5nIGFsbA0KIyBnZW5lcmljIG1hdGVy
aWFsLCBpbmRlcGVuZGVudCBvZiB0aGlzIHNwZWNpZmljIGRpcmVjdG9yeSwg
aW50bw0KIyAuLi9SdWxlcy5tYWtlLiBSZWFkIHRoYXQgZmlsZSBmb3IgZGV0
YWlscw0KDQpUT1BESVIgIDo9ICQoc2hlbGwgY2QgLi47IHB3ZCkNCmluY2x1
ZGUgJChUT1BESVIpL1J1bGVzLm1ha2UNCg0KQ0ZMQUdTICs9IC1JLi4gLU8N
Cg0KT0JKUyA9IGJyaWRnZS5vDQoNCmFsbDogJChPQkpTKQ0KDQpicmlkZ2Uu
bzogIGJyLm8gYnJfZGV2aWNlLm8gYnJfZmRiLm8gYnJfZm9yd2FyZC5vIGJy
X2lmLm8gYnJfaW5wdXQubyBcDQoJICAgYnJfaW9jdGwubyBicl9ub3RpZnku
byBicl9zdHAubyBicl9zdHBfYnBkdS5vIFwNCgkgICBicl9zdHBfaWYubyBi
cl9zdHBfdGltZXIubw0KCSAgICQoTEQpIC1yICReIC1vICRADQoNCmluc3Rh
bGw6DQoJaW5zdGFsbCAtZCAkKElOU1RBTExESVIpDQoJaW5zdGFsbCAtYyAk
KE9CSlMpICQoSU5TVEFMTERJUikNCg0KY2xlYW46DQoJcm0gLWYgKi5vICp+
IGNvcmUNCg==

--------------010904070202050201080600--
