Message-ID: <20040915134345.77495.qmail@web25105.mail.ukl.yahoo.com>
Date: Wed, 15 Sep 2004 14:43:45 +0100 (BST)
From: liam sharp <piccalo_clark@yahoo.co.uk>
Subject: Re: [Bridge] Transparently bridge Vlans to eth0
In-Reply-To: <20040914095620.7cb835ae@dell_ss3.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: bridge@lists.osdl.org

If filtering with ebtables is whats required, then I
will do that.

I don't think I want the bridge to have an IP address.
What I really would like is for all Vlans to be
forwarding to eth0, which maintains its IP address.
I'd like it simply to see all data coming from each
Vlan, without the vlan tags.

Imagine a LAN with gateway 10.0.0.1 and no vlans. All
clients have either static of dynamic IP address on
the 10.0.0.0 network.

Now I want to prevent hosts the 10.0.0.0 network
talking with any other host other than 10.0.0.1. I
have no control over the clients. 

What I have done is configure each port in the network
to be on a unique Vlan. This now prevents any pier to
pier communication.

However the gateway, 10.0.0.1 is plugged into a trunk
port which transports all Vlans to the network
interface, eth0. To read this data I can configure
many sub interfaces, one for each vlan.

The problem is as it stand I belive each must have its
own IP, which I don't want to have to do. I'd like to
somehow bridge each Vlan, to eth0 transparently. This
way I don't have to change my dhcp server of anything
else, just set up the Vlans and bridge them (I hope).

Has anyone ever done this or something similar ?

Many thanks for reading !
Piccalo

 --- Stephen Hemminger <shemminger@osdl.org> wrote: 
> On Tue, 14 Sep 2004 14:48:58 +0100 (BST)
> liam sharp <piccalo_clark@yahoo.co.uk> wrote:
> 
> > Hi,
> > 
> > I'm using Vlans in my network as a way of
> preventing
> > pier to pier communication - I only want nodes in
> the
> > network to talk to the gateway (a linux box).
> > 
> > I have successfully set up lots of sub interfaces
> > using the vconfig too, one for each vlan. What I
> would
> > like to be able to do is remove the ip address
> from
> > each of these subinterfaces eth0.x and bridge them
> to
> > eth0. I have successfully worked through the
> HOWTO,
> > but cannot see how to adapt this to my situation. 
> > 
> > I want the network to appear to eth0 as if all the
> > nodes are on the same network - like if I didn't
> use
> > any Vlans at all.
> 
> That isn't going to work.  eth0 is the needed to
> provide the
> tagged interface, the eth0.x are just pseudo
> interfaces that
> have tags.
> 
> You can bridge the vlan's but unless you do
> filtering with ebtables
> to restrict what flows why bother? If you do bridge
> a bunch of vlan's
> then the original eth0 interface on the bridge
> should be left alone.
> If you need the bridge to have an IP address assign
> it to the bridge
> pseudo network device (br0).
>  


	
	
		
___________________________________________________________ALL-NEW Yahoo! Messenger - all new features - even more fun!  http://uk.messenger.yahoo.com
