Message-ID: <4068A334.60605@sentex.net>
Date: Mon, 29 Mar 2004 22:29:08 +0000
From: Robert Dingman <rdingman@sentex.net>
MIME-Version: 1.0
Subject: Re: [Bridge] Problem loading bridge.o
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

I encountered the same problem when trying to compile the kernel and 
modules with the bridge.o option. (I was using kernel 2.4.25.)

I could not get past the unresolved symbol errors even with "make clean; 
make dep; make bzImage", etc.

I found this post: 
http://lists.osdl.org/pipermail/bridge/2004-March/000200.html. The 
recommendation was to use "make mrproper" (BUT first save your .config 
file somewhere safe!!).  This approach worked for me and the bridge.o 
module loads without complaint.

Good luck,
Bob Dingman

> *Stuart Luppescu* s-luppescu at uchicago.edu 
> <mailto:bridge%40lists.osdl.org?Subject=%5BBridge%5D%20Problem%20loading%20bridge.o&In-Reply-To=>
> /Tue Feb 10 11:22:32 PST 2004/
>
>     * Previous message: [Bridge] Two entries in forwarding database
>       <http://lists.osdl.org/pipermail/bridge/2004-February/000165.html>
>     * Next message: [Bridge] [RFC] bridge kernel API change
>       <http://lists.osdl.org/pipermail/bridge/2004-February/000167.html>
>     * *Messages sorted by:* [ date ]
>       <http://lists.osdl.org/pipermail/bridge/2004-February/date.html#166>
>       [ thread ]
>       <http://lists.osdl.org/pipermail/bridge/2004-February/thread.html#166>
>       [ subject ]
>       <http://lists.osdl.org/pipermail/bridge/2004-February/subject.html#166>
>       [ author ]
>       <http://lists.osdl.org/pipermail/bridge/2004-February/author.html#166>
>
>
> ------------------------------------------------------------------------
>
>Hello, I want to add wireless capability to my Gentoo-linux based
>firewall/router at home, so I bought a Netgear MA311 PCI and installed
>the hostap package. I load the hostap_pci module and the wlan0 interface
>comes up fine. I can detect the signal from a wireless enabled laptop.
>
>Now I'm thinking I'm going to bridge the wlan0 interface and the eth1
>interface, and run the firewall with br0 as the internal interface. I
>compiled the kernel (2.4.23) with
>CONFIG_BRIDGE=m
>but when I modprobe bridge, I get this stuff:
>
>/lib/modules/2.4.23-ck1/kernel/net/bridge/bridge.o: unresolved symbol br_ioctl_hook
>/lib/modules/2.4.23-ck1/kernel/net/bridge/bridge.o: unresolved symbol br_handle_frame_hook
>/lib/modules/2.4.23-ck1/kernel/net/bridge/bridge.o: insmod /lib/modules/2.4.23-ck1/kernel/net/bridge/bridge.o failed
>/lib/modules/2.4.23-ck1/kernel/net/bridge/bridge.o: insmod bridge failed
>
>I can't figure it out. Do I need to patch the kernel? (I thought 2.4.21
>and beyond needed no patches.) Do I need to configure something else?
>
>Thanks in advance.
>-- 
>Stuart Luppescu -=- s-luppescu .at. uchicago.edu        
>University of Chicago -=- CCSR 
>才文と智奈美の父 -=-    Kernel 2.6.1-gentoo                
>Wishing without work is like fishing without bait. 
> -- Frank Tyger 
> 
>
>-------------- next part --------------
>A non-text attachment was scrubbed...
>Name: not available
>Type: application/pgp-signature
>Size: 189 bytes
>Desc: This is a digitally signed message part
>Url : http://lists.osdl.org/pipermail/bridge/attachments/20040210/367f5a50/attachment.bin
>  
>
> ------------------------------------------------------------------------
>
>     * Previous message: [Bridge] Two entries in forwarding database
>       <http://lists.osdl.org/pipermail/bridge/2004-February/000165.html>
>     * Next message: [Bridge] [RFC] bridge kernel API change
>       <http://lists.osdl.org/pipermail/bridge/2004-February/000167.html>
>     * *Messages sorted by:* [ date ]
>       <http://lists.osdl.org/pipermail/bridge/2004-February/date.html#166>
>       [ thread ]
>       <http://lists.osdl.org/pipermail/bridge/2004-February/thread.html#166>
>       [ subject ]
>       <http://lists.osdl.org/pipermail/bridge/2004-February/subject.html#166>
>       [ author ]
>       <http://lists.osdl.org/pipermail/bridge/2004-February/author.html#166>
>
>



