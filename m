Date: Wed, 13 Dec 2006 10:14:42 -0800
From: Stephen Hemminger <shemminger@osdl.org>
Message-ID: <20061213101442.058d4968@dxpl.pdx.osdl.net>
In-Reply-To: <200612101909.39202.mail@patrick-nagel.net>
References: <200612101909.39202.mail@patrick-nagel.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Man-in-the-middle scenario within vmware - problem
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Patrick Nagel <mail@patrick-nagel.net>
Cc: bridge@lists.osdl.org

On Sun, 10 Dec 2006 19:09:27 +0100
Patrick Nagel <mail@patrick-nagel.net> wrote:

> Hi there,
> 
> I'm trying to set up a man-in-the-middle scenario within a VMWare Workstation 
> team, using brctl. What I want is the following:
> 
> PC1 eth0 >---LAN-segment-1---< eth0 PCMITM eth1 >---LAN-segment-2---< eth0 PC2
> 
> Now I did the following on PCMITM (PC man in the middle):
> 
> ifconfig eth0 down
> ifconfig eth1 down
> brctl addbr lnxbr0
> brctl addif lnxbr0 eth0
> brctl addif lnxbr0 eth1
> ifconfig eth0 0.0.0.0
> ifconfig eth1 0.0.0.0
> ifconfig lnxbr0 up
> 
> All commands exit successfully and I get eth0, eth1 and lnxbr0 listed in 
> ifconfig.
> brctl show says:
> 
> bridge name	bridge id		STP enabled	interfaces
> lnxbr0		8000.000c296df055	no		eth1
> 							eth0
> 
> which also seems alright to me.
> 
> But now the problem: although PC1 and PC2 are in the same IP subnet (addresses 
> 192.168.222.1 and 192.168.222.2), a ping doesn't pass the bridge. By 
> starting "ping pc2" on PC1 and "ping pc1" on PC2, I ensure that both machines 
> are transmitting data frequently, and thus should show up in "brctl 
> showmacs", but
> brctl showmacs lnxbr0 says:
> 
> port no	mac addr		is local?	ageing timer
>   1	00:0c:29:6d:f0:55	yes		   0.00
>   2	00:0c:29:6d:f0:5f	yes		   0.00
>   2	00:0c:29:97:e3:a6	no		   0.14
> 
> So there is one NIC missing - that one of PC1.
> 
> Does anyone have an explanation? I don't know what could be wrong in my setup, 
> I don't even know where to start... Any help is appreciated.
> 
> By the way: The LAN segments within VMWare seem to be working. If I give each 
> NIC on PCMITM an IP address (with no bridge on PCMITM), I can transfer data 
> from PC1 to PCMITM (and vice versa) and from PC2 to PCMITM (and vice versa).
> 
> Patrick.

Did you wait until after the "forwarding delay" expired (30 seconds) or set
turn forwarding delay off?

It may be that the ehternet driver doesn't support promiscious mode
and/or doesn't expect non-local source adresses. You need to see where packets
are being dropped, could be the ethernet driver, or switch with network access
control or inside the bridge.

Also check that the drivers correctly report carrier state.

brctl show lnxbr0

Should show both devices in forwarding atate.
