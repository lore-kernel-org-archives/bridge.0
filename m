Date: Mon, 28 Jun 2004 09:38:46 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Message-Id: <20040628093846.6b417369@dell_ss3.pdx.osdl.net>
In-Reply-To: <web-127174921@intranet.ru>
References: <web-127174921@intranet.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Subject: [Bridge] Re: hang on PPC
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: arkady-parabel@ngs.ru
Cc: bridge@osdl.org

On Sun, 27 Jun 2004 15:43:30 +0700
<arkady-parabel@ngs.ru> wrote:

> Hi.
> 
> I'm using a powerpc-based board (CPU - Motorolla 82855, 50
> Mhz) with 32 Mb of RAM, Big Endian.
> Linux kernel - 2.4.22, bridge - statically linked & as a
> module
> brctl - 0.9.6
> Ethernet - fec (arch/ppc/8xx_io/fec.c)
> All this was compiled with gcc version 3.2.2 20030217
> (Yellow Dog Linux 3.0 3.2.2-2a_1)) with math emulation
> enabled in gcc and in kernel.
> 
> When I do
> # ifconfig eth0 0.0.0.0
> # brctl addbr br0
> # brctl addif br0 eth0
> eth0: Promiscuous mode enabled.
> device eth0 entered promiscuous mode
> # brctl show
> bridge name     bridge id               STP enabled
> interfaces
> br0             8000.ce3dfa010010       no              eth0
> # ifconfig br0 up
> 
> I get
> br0: port 1(eth0) entering learning state
> br0: port 1(eth0) entering forwarding state
> br0: topology change detected, propagating
> 
> Now brctl is sleeping, forever...
Any brctl or which command? The usual way of debugging this is
to enable SysRq in kernel and hit SysRq-t to see what is happening.
Also SysRq-p to show processes.

> On i386 with 2.4.24 I've tested the same - bridge works
> fine.

The 2.4 code hasn't changed much in a long time. It could be a PPC issue
You could rebuild a kernel with just an update of the the bridge code (net/bridge)
from 2.4.27. 


> Can anybody advice me a solution ?
> 
> I have enough experience in kernel development to fix it
> myself. The question is where ?
> 
> Please, reply to pavel[AT]parabel.inc.ru
> OSDL rejected my mail with:
> Failed to deliver to 'shemminger@osdl.org'
> SMTP module(domain osdl.org) reports:
>  message text rejected by smtp.osdl.org:
>  554 5.7.1 Your server (195.161.113.6) is not listed as an
> IP for the domain 'da.ru' -- please have your
> misconfiguration corrected


OSDL does anti-spam detection by doing a reverse DNS lookup of incoming
mail. Since most spammers use bogus addresses, it filters about 10% of spam.


> Thanks in advance.
> 
> BTW: My final task is make a patch for kernel to make bridge
> working with cisco-hdlc devices (hdlc_cisco.c will have type
> = ARPHRD_ETHER, and do appropriate encapsulation). Maybe
> someone already made this, but I don't know ?
> 
> Kernel boot log:
> 
> Linux package found at 200000
> Kernel size 777k (compressed)
> Ramdisk size 2913k (compressed)
> Decompressing kernel...ok
> Linux version 2.4.22 (root@knight) (gcc version 3.2.2
> 20030217 (Yellow Dog Linux
> 3.0 3.2.2-2a_1)) #30 Sun Jun 27 13:31:17 NOVST 2004
> On node 0 totalpages: 8192
> zone(0): 8192 pages.
> zone(1): 0 pages.
> zone(2): 0 pages.
> Kernel command line: root=/dev/ram rw ramdisk_size=8000
> init=/sbin/fl
> Decrementer Frequency = 184320000/60
> Calibrating delay loop... 48.84 BogoMIPS
> Memory: 27560k available (1372k kernel code, 440k data, 84k
> init, 0k highmem)
> Dentry cache hash table entries: 4096 (order: 3, 32768
> bytes)
> Inode cache hash table entries: 2048 (order: 2, 16384 bytes)
> Mount cache hash table entries: 512 (order: 0, 4096 bytes)
> Buffer cache hash table entries: 1024 (order: 0, 4096 bytes)
> Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
> POSIX conformance testing by UNIFIX
> Linux NET4.0 for Linux 2.4
> Based upon Swansea University Computer Society NET3.039
> Initializing RT netlink socket
> Starting kswapd
> CPM UART driver version 0.03
> ttyS00 at 0x0280 is a SMC
> pty: 256 Unix98 ptys configured
> Generic RTC Driver v1.07
> DLCI driver v0.35, 4 Jan 1997, mike.mclagan@linux.org.
> eth0: FEC ENET Version 0.2, FEC irq 9, MII irq 10, addr
> ce:3d:fa:01:00:10
> RAMDISK driver initialized: 16 RAM disks of 8000K size 1024
> blocksize
> loop: loaded (max 8 devices)
> PPP generic driver version 2.4.2
> PPP Deflate Compression module registered
> Cronyx Ltd, Synchronous PPP and CISCO HDLC (c) 1994
> Linux port (c) 1998 Building Number Three Ltd & Jan "Yenya"
> Kasprzak.
> LAPB Ethernet driver version 0.01
> NET4: Linux TCP/IP 1.0 for NET4.0
> IP Protocols: ICMP, UDP, TCP, IGMP
> IP: routing cache hash table of 512 buckets, 4Kbytes
> TCP: Hash tables configured (established 2048 bind 4096)
> IPv4 over IPv4 tunneling driver
> ip_conntrack version 2.1 (256 buckets, 2048 max) - 292 bytes
> per conntrack
> ip_tables: (C) 2000-2002 Netfilter core team
> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> NET4: Ethernet Bridge 008 for NET4.0
> X.25 for Linux. Version 0.2 for Linux 2.1.15
> NET4: LAPB for Linux. Version 0.01 for NET4.0
> 802.1Q VLAN Support v1.8 Ben Greear
> <greearb@candelatech.com>
> All bugs added by David S. Miller <davem@redhat.com>
> RAMDISK: Compressed image found at block 0
> Freeing initrd memory: 2913k freed
> VFS: Mounted root (ext2 filesystem).
> Freeing unused kernel memory: 84k init
> 
> -- 
> Regards
> Pavel
> 
> ______ "______________"
> web: http://parabel.inc.ru/
> mail: pavel[AT]parabel.inc.ru
> phone: +7 (3832) 13-87-07
> ---------------------------------------------------------
> http://relax.ngs.ru - ______ __ ____________ __ ________________________ __ ________________________!
> 
> 
> 
> 

