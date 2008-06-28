Sender: fulvio@zeroshell.net
From: "Fulvio Ricciardi" <fulvio.ricciardi@zeroshell.net>
Date: Sat, 28 Jun 2008 21:50:33 +0200
Message-id: <48669609.123.61e8.180046555@webmaildh2.aruba.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Subject: Re: [Bridge] 802.1q packets
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@vyatta.com>, Fulvio Ricciardi <fulvio.ricciardi@zeroshell.net>
Cc: bridge@linuxfoundation.org


> > > Hi,
> > > 
> > > I notice that with the Kernel 2.6.25.9 the 802.1q VLAN
> > > tagged packets larger than 1470 bytes are not
> > > forwarded at all by a bridge.
> > > I think there is a bad interaction between bridge and
> > > netfilter codes. Any chance to a have a patch to solve
> > > this problem that limit the possibility to use the
> > > Linux bridges in a environment with VLANs?
> > 
> > With the following command it works:
> > 
> > echo 0 > /proc/sys/net/bridge/bridge-nf-call-iptables
> > 
> > but this disable the iptables support that it's
> > important for obtaining complex bridge-firewall
> > scenarios. 
> > Regards
> > Fulvio Ricciardi
> 
> Your iptables need to know about VLAN's as well.
> I bet your default action is to DROP.
> 
No, the default policy is ACCEPT for the FORWARD chain. In
any case the problem takes place only with large packets.
For example if I try

ping -s 1472 192.168.99.74

it works, but

ping -s 1473 192.168.99.74

it does not.
I am sure that the network cards are VLAN 802.1q aware
because only the forwarding process is broken. If instead I
just ping the IP of the bridge interface it works fine.

Regards
Fulvio

--------------------------------------------------------------------
Fulvio Ricciardi
web: http://www.zeroshell.net/eng/
skype: zeroshellnet
Phone: +3908321835630
