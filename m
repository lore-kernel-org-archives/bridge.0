Date: Mon, 10 Jan 2005 21:09:22 +0100
From: Gergely Madarasz <gorgo@broadband.hu>
Message-ID: <20050110200922.GO7529@thunderchild.debian.net>
References: <20050110140638.GH7529@thunderchild.debian.net>
	<41E299D4.2010605@redhat.com>
	<20050110154506.GJ7529@thunderchild.debian.net>
	<41E2A7A7.3060109@redhat.com>
	<20050110161855.GK7529@thunderchild.debian.net>
	<41E2BE29.8090800@redhat.com>
	<20050110191133.GM7529@thunderchild.debian.net>
	<41E2DA6E.8090703@redhat.com>
	<20050110194914.GN7529@thunderchild.debian.net>
	<41E2DD26.2070301@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41E2DD26.2070301@redhat.com>
Subject: [Bridge] Re: tg3 bridge problems
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Neil Horman <nhorman@redhat.com>
Cc: linux-net@vger.kernel.org, bridge@lists.osdl.org

On Mon, Jan 10, 2005 at 02:53:10PM -0500, Neil Horman wrote:
> Gergely Madarasz wrote:
> >On Mon, Jan 10, 2005 at 02:41:34PM -0500, Neil Horman wrote:
> >
> >>Gergely Madarasz wrote:
> >>
> >>>On Mon, Jan 10, 2005 at 12:40:57PM -0500, Neil Horman wrote:
> >>>
> >>>
> >>>>Gergely Madarasz wrote:
> >>>>
> >>>>
> >>>>>On Mon, Jan 10, 2005 at 11:04:55AM -0500, Neil Horman wrote:
> >>>>>
> >>>>>
> >>>>>
> >>>>>>Strange.  My concern was that the tg3 interface has its hardware 
> >>>>>>reset whenever its set to be up, and part of that is a resetting of 
> >>>>>>its receive mode.  If for some reason IFF_PROMISC was cleared after 
> >>>>>>you set it using brctl, the interface might be taken out of promisc 
> >>>>>>mode.  Do you have any iptables rules running that might drop bpdus?
> >>>>>
> >>>>>
> >>>>>No iptables rules az all. Btw iptables wouldn't prevent tcpdump from
> >>>>>seeing the packets, would it?
> >>>>>Could it be that the driver perhaps has a problem setting promisc mode
> >>>>>when resetting the hardware?
> >>>>>
> >>>>
> >>>>Not really sure about this.  One experiment is worth a thousand guesses 
> >>>>I suppose.......  I'll try and let you know. :)
> >>>
> >>>
> >>>I did some other checks, like adding an explicit ifconfig eth0 promisc,
> >>>then looking at tcpdump output - I didn't see any stray packets like I
> >>>usually do, just ethernet broadcasts and unicasts to my mac, this also
> >>>points to a problem that the ethernet interface is actually not in
> >>>promisc, while the driver thinks it is.
> >>>
> >>>And it is probably not a driver-only issue. I've got older machines with
> >>>tg3 running fine with bridge (with an older tg3 driver), and eth1 on the
> >>>same machine also runs fine. On another machine I tested today, an IBM
> >>>x326, the same thing happens - eth0 broken, eth1 fine. Would access to 
> >>>one
> >>>of these machines help? :)
> >>>
> >>>Greg
> >>
> >>I've got a tg3 card here.  I'll try re-create it as soon as I have time. 
> >
> >
> >Sounds great, but I expect it will not occur with a random tg3 card,
> >explained above... 
> >
> Mmmmm....post your lspci -vvv entry for your broken tg3 card?

on the ibm x346:

0000:05:00.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5721 Gigabit Ethernet PCI Express (rev 01)
        Subsystem: IBM: Unknown device 02c6
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size: 0x10 (64 bytes)
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at cfff0000 (64-bit, non-prefetchable) [size=64K]
        Capabilities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=1 PME-
        Capabilities: [50] Vital Product Data
        Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3 Enable-
                Address: bfa4b67f4b6720bc  Data: aadf
        Capabilities: [d0] #10 [0001]

The other one looks the same, just bus 06 instead of 05 and different
Region 0 and Address lines. 

Same problem, other machine (ibm x326):

0000:02:01.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5704 Gigabit Ethernet (rev 03)
        Subsystem: IBM: Unknown device 02a6
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (16000ns min), Cache Line Size: 0x10 (64 bytes)
        Interrupt: pin A routed to IRQ 24
        Region 0: Memory at fe010000 (64-bit, non-prefetchable) [size=64K]
        Region 2: Memory at fe000000 (64-bit, non-prefetchable) [size=64K]
        Capabilities: [40]      Capabilities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable+ DSel=0 DScale=1 PME-
        Capabilities: [50] Vital Product Data
        Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3 Enable-
                Address: 3aaf3ffdeb65f8f4  Data: b0db

Greg
