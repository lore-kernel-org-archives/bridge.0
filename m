Date: Thu, 7 Jul 2005 16:43:16 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] Linux bridge on linksys WRT54GS running OpenWRT
Message-ID: <20050707164316.143f043f@dxpl.pdx.osdl.net>
In-Reply-To: <42CDA29F.80904@fokus.fraunhofer.de>
References: <42CD5A33.10604@fokus.fraunhofer.de>
	<20050707105957.36d5098e@dxpl.pdx.osdl.net>
	<42CDA29F.80904@fokus.fraunhofer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Olaf Menzel <olaf.menzel@fokus.fraunhofer.de>
Cc: Hugo Santos <hsantos@av.it.pt>, bridge@lists.osdl.org

On Thu, 07 Jul 2005 23:46:07 +0200
Olaf Menzel <olaf.menzel@fokus.fraunhofer.de> wrote:

> Hello again,
> 
> see my comments inline
> 
> 
> Stephen Hemminger wrote:
> 
> >On Thu, 07 Jul 2005 18:37:07 +0200
> >Olaf Menzel <olaf.menzel@fokus.fraunhofer.de> wrote:
> >
> >  
> >
> >>Hello,
> >>
> >>I am experimenting with delivering IPv6 multicast traffic over the
> >>WRT54GS, running OpenWRT. OpenWrt is currently running linux-2.4.30 for
> >>the mipsel architecture and the OpenWRT distribution has bridged the 4
> >>port LAN switch (vlan0) with the WLAN interface (eth1) by default.  On
> >>the IP layer both devices are represented via the br0 interface. The
> >>bridge work fine for IPv4 Unicast and Multicast and for IPv6 Unicast but
> >>not for IPv6 multicast.
> >>
> >>I went into a problem with forwarding the MLDv2_report message over the
> >>bridge from a mobile client, connected over WLAN. The MLDv2 report
> >>messages are received in in the eth1 (WLAN IF), but not in the eth0 nore
> >>in the br0 interface. Does the bridge support IPv6 multicast compliant
> >>MAC addresses, starting with 3333+LowByte(Ipv6 MulticastAddress) ?
> >>    
> >>
> >
> >The bridge handles IEEE multicast mac addresses
> >
> For IPv6 Multicast the RFC 2464 
> (http://www.rfc-editor.org/rfc/rfc2464.txt) describes,
> how an IPv6 multicast compliant MAC address will be created.
> I hope this RFC is compatible with the IEEE multicast mac standard.
> 
> > 
> >(ie. least significant bit of first byte of address is set).
> >What is a an example Ethernet MAC address of a MLDv2 message?
> >  
> >
> a MLD report has the IPv6 link local multicast destination aaddress:
> FF02::16(all mldv2 router) and will map to 33:33:00:00:00:16,
> while a MLD query with FF02::1 (all local nodes) has to be mapped to
> 33:33:00:00:00:01.

That is an Ethernet Multicast so it should get forwarded. It could
be hardware issues try running code on a desktop linux box with two
NIC's first.  Does the wlan interface ever hand a multicast to the bridge
code? The bigger issue with wlan is that most hardware doesn't allow
source address to be set, so every packet looks like it came from
the bridge rather than the originating host.

Assuming wired client on Ethernet has Mac Address A
         bridge eth0 has Mac Address E
         bridge wlan has Mac Address W
        
Packets going through the bridge from A to other client (B) on the wireless
side should have:
	Src = A	Dst = B
but most wireless hardware will always send
	Src = W Dst = B
The problem is that the client B will the send back to bridge and not
to the original client! The bridge will see it and toss it as junk.
