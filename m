Message-ID: <03d801c45ece$5e3aeb10$8805640a@internal.watertech.com>
From: "Chris Saw" <chriss@watertech.com>
Subject: Re: [Bridge] MTU Question
Date: Wed, 30 Jun 2004 11:16:30 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Reply-To: Chris Saw <chriss@watertech.com>
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

forgot to CC the list on this one...

> * also, the mtu of the bridge itself will always appear as 1500, but
>   you could change that with ifconfig.  Thought about having bridge mtu
>   appear as min(ports mtu), but don't think that is in the current version

I tried changing the MTU > 1500 on the bridge and I get "SIOCSIFMTU: Invalid
argument" (I'm using 2.4.24 W/ latest ebtables) but if I understand you
correctly that dosen't really matter anyway.

> The bridge does not care about frame size at all. It should be able
> to handle large frames, provided:
> * all interfaces in the bridge can handle the same big mtu, there is
>   no way a bridge can fragment.

That's kinda what I was afraid of... If I understand you correctly, if I
have some 100Mbit NICs in the same bridge, then even if I change the MTU of
the 1Gig NICs the MTU of packets coming in/out of the bridge will be that of
the slowest NIC (1500bytes) correct?

The reason I even care is that I am getting horrible speeds from the gigabit
NICs. In the neighborhood of about 150-200Mbps from the gigabit NICs when
doing a netcat between systems using /dev/zero -> /dev/null... That's just
crappy... even from 33Mhz PCI I should be getting like around 40-50MB/sec or
more I would think with RAM -> RAM. They're good NICs too, both EEPRO1000
using NAPI.

I can't really break up the bridges by speed either because you can't
enslave the same NICs to different bridges and I only have 1 cable modem ;)

I may have to just live with it because the bridge is working beautifully
as-is, firewalling cable modem traffic like a champ and serving files
perfectly through SAMBA too. I just don't like to leave things alone :)

Thank you for your quick reply on the last message, hopefully my questions
aren't too dumb... :)

    -Chris



----- Original Message -----
From: <shemminger@osdl.org>
To: "Chris Shaw" <chriss@watertech.com>
Cc: <bridge@lists.osdl.org>
Sent: Tuesday, June 29, 2004 9:22 PM
Subject: Re: [Bridge] MTU Question


> > I have a bridge that has gigabit interfaces. The machine in question has
> > the
> > fun job of being a Bridge, Firewall and SMB server. Both of the Gigabit
> > interfaces are connected to workstations directly via Xover cable (well
> > MDI-X to be exact). My question is, if I enable jumbo frames on the
> > gigabit
> > interfaces will that make any difference in overall transfer rate of the
> > bridge? I was thinking it might because even though the NIC is enslaved,
> > it
> > IS the device that the workstations communicate to. But also it might
not
> > because when applications talk to the network they're using BR(n) at
> > 1500bytes.. can a bridging guru shed some light on this for me?
> >
> > -Thank you in advance
> > Chris
>
> The bridge does not care about frame size at all. It should be able
> to handle large frames, provided:
> * all interfaces in the bridge can handle the same big mtu, there is
>   no way a bridge can fragment.
> * also, the mtu of the bridge itself will always appear as 1500, but
>   you could change that with ifconfig.  Thought about having bridge mtu
>   appear as min(ports mtu), but don't think that is in the current
version.
>
>
> _______________________________________________
> Bridge mailing list
> Bridge@lists.osdl.org
> http://lists.osdl.org/mailman/listinfo/bridge


Chris Shaw
IS Manager
Water Tech Industries
Phone: (888)-254-8412
Fax: (503)-261-9118
E-Mail: chriss@watertech.com

