From: Bart De Schuymer <bdschuym@pandora.be>
Subject: Re: [Bridge] Re: [more info] Re: [2.4.22] bad interaction between e100 and bridge: BUG at dev.c:991!
Date: Tue, 2 Sep 2003 20:23:16 +0200
References: <p05111b01bb728bc8972e@[10.96.96.13]> <20030830190100.4eac4504.davem@redhat.com> <20030902104545.3c321c24.shemminger@osdl.org>
In-Reply-To: <20030902104545.3c321c24.shemminger@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309022023.16397.bdschuym@pandora.be>
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
To: Stephen Hemminger <shemminger@osdl.org>, "David S. Miller" <davem@redhat.com>
Cc: Hannes Schulz <schulz@schwaar.com>, scott.feldman@intel.com, jgarzik@pobox.com, bridge@osdl.org

On Tuesday 02 September 2003 19:45, Stephen Hemminger wrote:
> > Looks like bridging is taking an input packet, transmitting it but not
> > initializing skb->csum, skb->ip_summed, and other fields before doing
> > so.
> >
> > Definitely a bridging bug.
>
> It is actually a bridging-filter bug, since the bridge layer is at level 2
> it doesn't know anything about IP.

A message ([Bridge] Re: [2.4.22] bad interaction between e100 and bridge: BUG 
at dev.c:991!) on the bridge list said this:

<quote>
> setup & how to reproduce:
> HP Netserver 2000 with 2 onboard e100 NICs. Both are connected to the same 
hub.
> Add both eth0 and eth1 to the same bridge. Pull the plug on eth0. 
> Wait till the bridge is about to enter forwarding state on eth1.
> 
> I have reproduced this with earlier kernels (2.4.20+) too but they 
> were heavily patched. This is a pristine 2.4.22.
> 
> Strange but true: This works when using eepro100 insted of e100.
<unquote>

A pristine 2.4.22 doesn't have bridge-netfilter. I don't see how 
bridge-netfilter would be involved anyway, altering a packet doesn't 
automagically trigger checksum recalculation.

cheers,
Bart

