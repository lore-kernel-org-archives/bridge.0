Date: Mon, 8 Oct 2007 12:19:57 -0500
From: Michael Jinks <mjinks@uchicago.edu>
Subject: Re: [Bridge] Simple bridge, something's wrong
Message-ID: <20071008171957.GX22818@uchicago.edu>
References: <20071008075042.GW22818@uchicago.edu>
	<20071008083640.6db9f926@freepuppy.rosehill>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20071008083640.6db9f926@freepuppy.rosehill>
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

On Mon, Oct 08, 2007 at 08:36:40AM -0700, Stephen Hemminger wrote:
> On Mon, 8 Oct 2007 02:50:42 -0500
> Michael Jinks <mjinks@uchicago.edu> wrote:
> 
> > Hi, list.
> > 
> > I'm trying to set up a bridging VPN and having trouble.  The VPN part
> > seems to be working well, but for some reason bridging doesn't.
> > 
> > To make things as simple as possible for tracking down what I'm doing
> > wrong, I've set up a test network with three Linux machines connected to
> > two ethernet segments, no VPN stuff involved:
> > 
> >  Host A                    Host B                   Host C
> > 10.1.1.15--[segment 1]--[br0, no IP]--[segment 2]--10.1.1.16
> >                         (eth1, eth2)
> 
> Does Host B have an IP address or is it a pure bridge?

No IP, pure bridge.

Early on I tried giving it an IP and found that A and C could both ping
B if I set it to 10.1.1.17.

> > On Host B:
> > 
> >   $ /sbin/brctl show
> >   bridge name     bridge id               STP enabled     interfaces
> >   br0             8000.000c299eefe7       no              eth1
> >                                                           eth2
> 
> Did you wait for the forwarding delay (30 sec) to expire after
> setting up bridge?
> 
> /sbin/brctl showstp br0

Yes, that's one of the things I thought might be causing problems, but
after leaving it overnight with one host pinging, still no joy.  Here's
what showstp looks like currently:

$ /sbin/brctl showstp br0
br0
 bridge id              8000.000c299eefe7
 designated root        8000.000c299eefe7
 root port                 0                    path cost                  0
 max age                  20.00                 bridge max age            20.00
 hello time                2.00                 bridge hello time          2.00
 forward delay            15.00                 bridge forward delay      15.00
 ageing time             300.00
 hello timer               1.91                 tcn timer                  0.00
 topology change timer     0.00                 gc timer                   0.06
 flags  


eth1 (0)
 port id                0000                    state                forwarding
 designated root        8000.000c299eefe7       path cost                100
 designated bridge      8000.000c299eefe7       message age timer          0.00
 designated port        8001                    forward delay timer        0.00
 designated cost           0                    hold timer                 0.91
 flags  

eth2 (0)
 port id                0000                    state                forwarding
 designated root        8000.000c299eefe7       path cost                100
 designated bridge      8000.000c299eefe7       message age timer          0.00
 designated port        8002                    forward delay timer        0.00
 designated cost           0                    hold timer                 0.91
 flags 


<snip>
> Have you setup filter rules?? or just plan to in future.

Initially I didn't set any filter rules (at least, not with ebtables; I
do have iptables rules on this box).  My plan eventually is to give
machines on either end of the bridge as much access as they'd have if
they were on the same network segment, so currently I don't plan to do
any filtering.

Here's the present output from ebtables, first for the broute table:

  $ sudo /sbin/ebtables -t broute -L
  Bridge table: broute

  Bridge chain: BROUTING, entries: 1, policy: DROP
  --log-level debug --log-prefix "ebtables-broute" --log-ip --log-arp -j ACCEPT 

then for the filter table:

  $ sudo /sbin/ebtables -t filter -L
  Bridge table: filter

  Bridge chain: INPUT, entries: 1, policy: ACCEPT
  --log-level debug --log-prefix "ebtables-in" --log-ip --log-arp -j
  ACCEPT 

  Bridge chain: FORWARD, entries: 1, policy: ACCEPT
  --log-level debug --log-prefix "ebtables-forward" --log-ip --log-arp
  -j ACCEPT 

  Bridge chain: OUTPUT, entries: 1, policy: ACCEPT
  --log-level debug --log-prefix "ebtables-out" --log-ip --log-arp -j
  ACCEPT

I put in all those log directives to see if I could tell what was
happeninng as packets cross the machine, but it just reinforced what I'd
already found, that packets appear to reach the bridge, they traverse
the "broute", "forward", and "input" chains, but they're never output
again.

Here's a typical three-line log snippet, generated when .16 sends a
single ping packet to .15:

  Oct  8 12:16:52 frail ebtables-broute IN=eth1 OUT= MAC source = 00:0c:29:d9:59:d8 MAC dest = ff:ff:ff:ff:ff:ff proto = 0x0806 ARP HTYPE=1, PTYPE=0x0800, OPCODE=1 ARP MAC SRC=00:0c:29:d9:59:d8  ARP IP SRC=10.1.1.16 ARP MAC DST=00:00:00:00:00:00  ARP IP DST=10.1.1.15
  Oct  8 12:16:53 frail ebtables-broute IN=eth1 OUT= MAC source = 00:0c:29:d9:59:d8 MAC dest = ff:ff:ff:ff:ff:ff proto = 0x0806 ARP HTYPE=1, PTYPE=0x0800, OPCODE=1 ARP MAC SRC=00:0c:29:d9:59:d8  ARP IP SRC=10.1.1.16 ARP MAC DST=00:00:00:00:00:00  ARP IP DST=10.1.1.15
  Oct  8 12:16:54 frail ebtables-broute IN=eth1 OUT= MAC source = 00:0c:29:d9:59:d8 MAC dest = ff:ff:ff:ff:ff:ff proto = 0x0806 ARP HTYPE=1, PTYPE=0x0800, OPCODE=1 ARP MAC SRC=00:0c:29:d9:59:d8  ARP IP SRC=10.1.1.16 ARP MAC DST=00:00:00:00:00:00  ARP IP DST=10.1.1.15

My iptables setup is a lot more extensive, but mostly applies to eth0, a
public-facing interface.  Still, just in case something I'd overlooked
might be getting in the way, I tried flushing all my rules and setting
all defaults to ACCEPT, with no effect.  I also tried adding log
directives similar to the ones I'm currently using with ebtables, and
they showed the same stuff: arp requests come in, but they don't go back
out again.

I've tried adding and removing "promisc" from both interfaces, and on
the bridge device itself, again no effect that I saw.  Based on
someone's web page, currently I'm running both NICs in promiscuous mode,
but the bridge is not.

Thanks,
-m
