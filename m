Date: Wed, 27 Aug 2003 13:28:10 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Message-Id: <20030827132810.65010eac.shemminger@osdl.org>
In-Reply-To: <p05111b01bb728bc8972e@[10.96.96.13]>
References: <p05111b01bb728bc8972e@[10.96.96.13]>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Re: [2.4.22] bad interaction between e100 and bridge: BUG at
 dev.c:991!
Sender: bridge-admin@lists.osdl.org
Errors-To: bridge-admin@lists.osdl.org
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge/>
To: Hannes Schulz <schulz@schwaar.com>
Cc: linux-net@vger.kernel.org, bridge@osdl.org

Could the problem be that the e100 can do IP receive checksumming on the board,
but the eepro driver doesn't enable it.  When the board is doing checksum
offload, then the csum field isn't set. 

Please try disabling receive checksumming on the e100 driver

	modprobe e100 XsumRX=0

If this is the problem, it exists both 2.4 and 2.6.


On Wed, 27 Aug 2003 18:24:57 +0200
Hannes Schulz <schulz@schwaar.com> wrote:

> setup & how to reproduce:
> HP Netserver 2000 with 2 onboard e100 NICs. Both are connected to the same hub.
> Add both eth0 and eth1 to the same bridge. Pull the plug on eth0. 
> Wait till the bridge is about to enter forwarding state on eth1.
> 
> I have reproduced this with earlier kernels (2.4.20+) too but they 
> were heavily patched. This is a pristine 2.4.22.
> 
> Strange but true: This works when using eepro100 insted of e100.
> 
> 
> details:
> uml:~# brctl addbr br0
> uml:~# brctl stp on
> uml:~# brctl addif br0 eth0
> uml:~# ip link set eth0 up
> uml:~# brctl addif br0 eth1
> uml:~# brctl setpathcost br0 eth1 1000
> uml:~# ip link set eth1 up
> uml:~# tail  /var/log/kern.log
> [junk deleted]
> Aug 27 17:07:44 uml kernel: device eth1 entered promiscuous mode
> Aug 27 17:08:43 uml kernel: br0: port 2(eth1) entering listening state
> Aug 27 17:08:44 uml kernel: eth0: received packet with  own address as source
> address
> Aug 27 17:08:44 uml kernel: br0: port 2(eth1) entering blocking state
> Aug 27 17:08:45 uml kernel: e100: eth1 NIC Link is Up 100 Mbps Half duplex
> 
> pull the plug on eth0
> 
> uml:~# tail -f /var/log/kern.log
> Aug 27 17:12:11 uml kernel: e100: eth0 NIC Link is Down
> Aug 27 17:12:30 uml kernel: br0: neighbour 8000.00:30:6e:12:dc:5d lost on port
> 2(eth1)
> [00:30:6e:12:dc:5d is the MAC-address of eth0]
> Aug 27 17:12:30 uml kernel: br0: port 2(eth1) entering listening state
> Aug 27 17:12:45 uml kernel: br0: port 2(eth1) entering learning state
> 
> and then:
> uml:~# ksymoops oops.txt
> ksymoops 2.4.8 on i686 2.4.22.  Options used
>       -V (default)
>       -k /proc/ksyms (default)
>       -l /proc/modules (default)
>       -o /lib/modules/2.4.22/ (default)
>       -m /boot/System.map-2.4.22 (default)
> 
> Warning: You did not tell me where to find symbol information.  I will
> assume that the log matches the kernel and modules that are running
> right now and I'll use the default options above for symbol resolution.
> If the current kernel and/or modules do not match the log, you can get
> more accurate output by telling me the kernel version and where to find
> map, modules, ksyms etc.  ksymoops -h explains the options.
> 
> kernel BUG at dev.c:991!
> invalid operand: 0000
> CPU:    0
> EIP:    0010:[<c0284b29>]    Not tainted
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010202
> eax: 0000822b   ebx: ce55d73c   ecx: dfcca25c   edx: 000000a8
> esi: 00008229   edi: c49ca830   ebp: cf00e000   esp: c038fde0
> ds: 0018   es: 0018   ss: 0018
> Process swapper (pid: 0, stackpage=c038f000)
> Stack: ce55d73c 0000000e 000000a8 dfcca25c cef50400 ce55d73c 00000000 c0284f25
>         ce55d73c cfec1274 cfd46034 00003122 00003122 00000296 ce55d73c ce55d73c
>         cefe64bc cf00e000 d0a112de ce55d73c 00000000 cef42c9c 00000000 d0a1132b
> Call Trace:    [<c0284f25>] [<d0a112de>] [<d0a1132b>] [<d0a11503>]
> [<d0a113d0>]
>    [<d0a115e7>] [<d0a113d0>] [<d0a12137>] [<d0a122d9>] [<c0285511>]
> [<c02856dd>]
>    [<c0285845>] [<c0127436>] [<c010b64d>] [<c0118de8>] [<c0107170>]
> [<c0107170>]
>    [<c010e458>] [<c0107170>] [<c010719c>] [<c0107232>] [<c0105000>]
> Code: 0f 0b df 03 cd 82 2f c0 89 c8 c1 e0 10 81 e1 00 00 ff ff 01
> 
> 
> >>EIP; c0284b29 <skb_checksum_help+59/a0>   <=====
> 
> >>ebx; ce55d73c <_end+e138f5c/105dc880>
> >>edi; c49ca830 <_end+45a6050/105dc880>
> >>ebp; cf00e000 <_end+ebe9820/105dc880>
> >>esp; c038fde0 <init_task_union+1de0/2000>
> 
> Trace; c0284f25 <dev_queue_xmit+3b5/430>
> Trace; d0a112de <[bridge]__dev_queue_push_xmit+2e/60>
> Trace; d0a1132b <[bridge]__br_forward_finish+1b/60>
> Trace; d0a11503 <[bridge]br_flood+53/e0>
> Trace; d0a113d0 <[bridge]__br_forward+0/60>
> Trace; d0a115e7 <[bridge]br_flood_forward+27/30>
> Trace; d0a113d0 <[bridge]__br_forward+0/60>
> Trace; d0a12137 <[bridge]br_handle_frame_finish+107/180>
> Trace; d0a122d9 <[bridge]br_handle_frame+129/1dc>
> Trace; c0285511 <netif_receive_skb+c1/200>
> Trace; c02856dd <process_backlog+8d/130>
> Trace; c0285845 <net_rx_action+c5/180>
> Trace; c0127436 <do_softirq+d6/e0>
> Trace; c010b64d <do_IRQ+19d/1d0>
> Trace; c0118de8 <smp_apic_timer_interrupt+128/130>
> Trace; c0107170 <default_idle+0/50>
> Trace; c0107170 <default_idle+0/50>
> Trace; c010e458 <call_do_IRQ+5/d>
> Trace; c0107170 <default_idle+0/50>
> Trace; c010719c <default_idle+2c/50>
> Trace; c0107232 <cpu_idle+52/70>
> Trace; c0105000 <_stext+0/0>
> 
> Code;  c0284b29 <skb_checksum_help+59/a0>
> 00000000 <_EIP>:
> Code;  c0284b29 <skb_checksum_help+59/a0>   <=====
>     0:   0f 0b                     ud2a      <=====
> Code;  c0284b2b <skb_checksum_help+5b/a0>
>     2:   df 03                     fild   (%ebx)
> Code;  c0284b2d <skb_checksum_help+5d/a0>
>     4:   cd 82                     int    $0x82
> Code;  c0284b2f <skb_checksum_help+5f/a0>
>     6:   2f                        das
> Code;  c0284b30 <skb_checksum_help+60/a0>
>     7:   c0 89 c8 c1 e0 10 81      rorb   $0x81,0x10e0c1c8(%ecx)
> Code;  c0284b37 <skb_checksum_help+67/a0>
>     e:   e1 00                     loope  10 <_EIP+0x10>
> Code;  c0284b39 <skb_checksum_help+69/a0>
>    10:   00 ff                     add    %bh,%bh
> Code;  c0284b3b <skb_checksum_help+6b/a0>
>    12:   ff 01                     incl   (%ecx)
> 
>   <0>Kernel panic: Aiee, killing interrupt handler!
> 
> 1 warning issued.  Results may not be reliable.
> 
> 
> uml:~# lspci
> 00:00.0 Host bridge: ServerWorks CNB20LE Host Bridge (rev 06)
> 00:00.1 Host bridge: ServerWorks CNB20LE Host Bridge (rev 06)
> 00:02.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 08)
> 00:07.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
> 00:08.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 08)
> 00:0f.0 ISA bridge: ServerWorks OSB4 South Bridge (rev 50)
> 00:0f.1 IDE interface: ServerWorks OSB4 IDE Controller
> 00:0f.2 USB Controller: ServerWorks OSB4/CSB5 OHCI USB Controller (rev 04)
> 01:02.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev
> 34)
> 01:03.0 Unknown mass storage controller: American Megatrends Inc. MegaRAID 428
> Ultra RAID Controller (rev 03)
> 01:05.0 SCSI storage controller: LSI Logic / Symbios Logic 53c1010 Ultra3 SCSI
> Adapter (rev 01)
> 01:05.1 SCSI storage controller: LSI Logic / Symbios Logic 53c1010 Ultra3 SCSI
> Adapter (rev 01)
> 
> when e100 loaded it said:
> Intel(R) PRO/100 Network Driver - version 2.3.18-k1
> Copyright (c) 2003 Intel Corporation
> 
> e100: selftest OK.
> e100: eth0: Intel(R) PRO/100 Network Connection
>    Hardware receive checksums enabled
>    cpu cycle saver enabled
> 
> e100: selftest OK.
> e100: eth1: Intel(R) PRO/100 Network Connection
>    Hardware receive checksums enabled
>    cpu cycle saver enabled
> 
> 
> uml:~# lsmod
> Module                  Size  Used by    Not tainted
> tun                     4864  23  (autoclean)
> ipt_LOG                 3640   4  (autoclean)
> iptable_mangle          2168   0  (autoclean) (unused)
> iptable_filter          1740   1  (autoclean)
> ip_tables              13408   3  [ipt_LOG iptable_mangle iptable_filter]
> 3c59x                  28944   1  (autoclean)
> ^^^^^ this is eth2
> e100                   54888   1  (autoclean)
> bridge                 22576   3  (autoclean)
> usb-ohci               21512   0  (unused)
> rtc                     9256   0  (autoclean)
> 
> 
> Any thoughts ?
> 
> Hannes
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-net" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
