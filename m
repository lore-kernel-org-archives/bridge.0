Sender: fulvio@zeroshell.net
From: "Fulvio Ricciardi" <fulvio.ricciardi@zeroshell.net>
Date: Sat, 28 Jun 2008 23:17:35 +0200
Message-id: <4866aa6f.27b.64f3.364538521@webmaildh1.aruba.it>
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
To: "richardvoigt@gmail.com" <richardvoigt@gmail.com>, Fulvio Ricciardi <fulvio.ricciardi@zeroshell.net>
Cc: Stephen Hemminger <shemminger@vyatta.com>, bridge@linuxfoundation.org


> > > > > Hi,
> > > > >
> > > > > I notice that with the Kernel 2.6.25.9 the 802.1q
> > > > > VLAN tagged packets larger than 1470 bytes are not
> > > > > forwarded at all by a bridge.
> > > > > I think there is a bad interaction between bridge
> > > > > and netfilter codes. Any chance to a have a patch
> > > > > to solve this problem that limit the possibility
> > > > > to use the Linux bridges in a environment with
> > > VLANs? >
> > > > With the following command it works:
> > > >
> > > > echo 0 >
> > > /proc/sys/net/bridge/bridge-nf-call-iptables >
> > > > but this disable the iptables support that it's
> > > > important for obtaining complex bridge-firewall
> > > > scenarios.
> > > > Regards
> > > > Fulvio Ricciardi
> > >
> > > Your iptables need to know about VLAN's as well.
> > > I bet your default action is to DROP.
> > >
> > No, the default policy is ACCEPT for the FORWARD chain.
> > In any case the problem takes place only with large
> > packets. For example if I try
> >
> > ping -s 1472 192.168.99.74
> >
> > it works, but
> >
> > ping -s 1473 192.168.99.74
> >
> > it does not.
> > I am sure that the network cards are VLAN 802.1q aware
> > because only the forwarding process is broken. If
> > instead I just ping the IP of the bridge interface it
> works fine.
> 
> 
> Are the other nodes directly connected to the netfilter
> bridge, or are there ethernet switches involved?   Are
> these switches managed, smart, or dumb? Are jumbo frames
> enabled on all devices in the path?
> 


One host is directly connected with a cross cable to the
bridge and the other one with an unmanaged switch that works
fine because if I issue the command

echo 0 > /proc/sys/net/bridge/bridge-nf-call-iptables

to disable the Netfilter action for the bridge there is no
problem for the large packets on VLAN.



--------------------------------------------------------------------
Fulvio Ricciardi
web: http://www.zeroshell.net/eng/
skype: zeroshellnet
Phone: +3908321835630
