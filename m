Message-ID: <05da01c47fe4$878de170$8805640a@chriss>
From: "Chris Shaw" <chriss@watertech.com>
References: <20040811151631.GA12305@woobling.org>
	<20040811092851.43c57af7@dell_ss3.pdx.osdl.net>
Subject: Re: [Bridge] eth1394 interface support?
Date: Wed, 11 Aug 2004 13:48:17 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Reply-To: Chris Shaw <chriss@watertech.com>
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

I shudder at the thought.... but... if you want bridging between 1394 and
Ethernet or wireless interfaces, you can do it in W2K3 or WinXP...

Again I know.... gross... but it works if you can stand windows...

You can also use ProxyARP which is a kludge but it can work, provided that
1394 under linux can do ARP in the usual 802 way...

P.S. I don't know if this has been brought up and please don't take it as a
demand for features, just a query, but has support for bridging disparate
interface types been considered or attempted?

True hardware bridges/switches can bridge between wired/wireless,
tokenring/Ethernet FDDI/Ethernet HIPPI/Ethernet, etc etc etc... It would be
cool if linux could do it for the firewalling capabilities and because
hardware like that can be very expensive...

Does anyone know how windows is doing it? Is it more of a ProxyARP than a
bridge?

    -Chris

----- Original Message -----
From: "Stephen Hemminger" <shemminger@osdl.org>
To: "Yuval Kogman" <nothingmuch@woobling.org>
Cc: <bridge@lists.osdl.org>
Sent: Wednesday, August 11, 2004 9:28 AM
Subject: Re: [Bridge] eth1394 interface support?


> On Wed, 11 Aug 2004 18:16:31 +0300
> Yuval Kogman <nothingmuch@woobling.org> wrote:
>
> > I have a linux box which sits in the living room and plays
> > ti^H^Hfreevo.
> >
> > Among other things it also talks to the cable modem via interface
> > eth0, and does NAT transformations for eth1.
> >
> > Yesterday i was sitting in the living room with my laptop, thinking
> > about the fact that my wireless access point will only arrive next
> > week, and then remembered they both the laptop and the linux boxhave
> > firewire. The plot thickens.
> >
> > I enabled bridging support in the kernel, and i got to
> >
> > brctl addbr br0
> > brctl addif br0 eth1 # LAN interface
> > brctl addif br0 eth2 # firewire interface
> > br_add_interface: Invalid argument
> >
> > I reckon eth1394 is at fault, but I'd like to know what the bridge
> > code expects from it.
>
> It must use ethernet link encapsulation: 6 byte dst, 6 byte src, 2 byte
type.
> But 1394 uses 8 byte dst, 2 byte type.  Obviously this can't be bridged.
>
>
> The bridge checks this by looking at the device type (dev->type) to
> check if it is ARPHD_ETHER.  For 1394 this is set to ARPHRD_IEEE1394.
>


----------------------------------------------------------------------------
----


_______________________________________________
Bridge mailing list
Bridge@lists.osdl.org
http://lists.osdl.org/mailman/listinfo/bridge

