Message-ID: <564DE4477544D411AD2C00508BDF0B6A1EA88A2D@USAHM018.amer.corp.eds.com>
From: "Small, Jim" <jim.small@eds.com>
Subject: RE: [Bridge] Sparc Bridge problems
Date: Thu, 1 Apr 2004 09:27:35 -0500 
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Santiago Leon <santil@us.ibm.com>
Cc: bridge@osdl.org

Santiago,

I appreciate your offer.  I'm not really a kernel hacker, however I do know
C and I would be willing to try if you point me in the right direction.
Here is my first attempt using Debian running on an UltraSPARC:
debian{root}:/root<512>strace -f -F -v brctl addbr br0
execve("/usr/sbin/brctl", ["brctl", "addbr", "br0"], [/* 16 vars */]) = 0
debian{root}:/root<513>strace -f -F -v brctl addif br0 eth1
execve("/usr/sbin/brctl", ["brctl", "addif", "br0", "eth1"], [/* 16 vars
*/]) = 0
debian{root}:/root<514>
debian{root}:/root<514>uname -a
Linux debian 2.4.25 #3 SMP Mon Mar 8 20:03:58 EST 2004 sparc64 GNU/Linux
debian{root}:/root<515>
debian{root}:/root<515>which brctl
/usr/sbin/brctl
debian{root}:/root<516>file /usr/sbin/brctl
/usr/sbin/brctl: ELF 64-bit MSB executable, SPARC V9, version 1 (SYSV), for
GNU/Linux 2.4.18, dynamically linked (uses shared libs), stripped

I compiled bridging into the kernel, statically (right terminology?) not as
a module.

I am using bridge-utils64:
debian{root}:/root<532>dpkg -s bridge-utils64
Package: bridge-utils64
Status: install ok installed
Priority: optional
Section: net
Installed-Size: 148
Maintainer: Santiago Garcia Mantinan <manty@debian.org>
Source: bridge-utils
Version: 0.9.6-5
Replaces: bridge-utils
Depends: libc6-sparc64 (>= 2.3.2.ds1-4), ifupdown (>= 0.6.0)
Conflicts: bridge-utils
Conffiles:
 /etc/network/if-pre-up.d/bridge e099ee6444ea38e3fef1a2b32b918343
 /etc/network/if-post-down.d/bridge 4c1d2c2bf27a2cec9416b821d4291bcd
Description: Utilities for configuring the Linux 2.4 bridge
 This package contains utilities for configuring the Linux ethernet
 bridge. The Linux ethernet bridge can be used for connecting multiple
 ethernet devices together. The connecting is fully transparent: hosts
 connected to one ethernet device see hosts connected to the other
 ethernet devices directly.

Note that I tried this with the original 2.4.18 kernel and it didn't work.
It was recommended that I try upgrading to the 2.4.25 kernel which I did,
but it still doesn't work.

I am willing to try anything, just let me know!

Thanks,
   <> Jim

> -----Original Message-----
> From: Santiago Leon [mailto:santil@us.ibm.com]
> Sent: Wednesday, March 31, 2004 12:33 PM
> To: Small, Jim
> Cc: D@7@k|N&; bridge@osdl.org
> Subject: Re: [Bridge] Sparc Bridge problems
> 
> I had the exact same problem a while ago on a 64-bit PowerPC and hacked
> my way around it... (can't seem to find the patch now, though)...  The
> first thing you want to do is run:
> brctl addbr br0
> strace brctl addif br0 eth0
> 
> and look for what ioctl fails... Post that output and I might be able to
> point you to the solution...
> 
> --
> Santiago A. Leon
> Power Linux Development
> IBM Linux Technology Center

