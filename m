From: Torsten Luettgert <t.luettgert@pressestimmen.de>
Content-Type: text/plain
Message-Id: <1083253016.24333.39.camel@scaramouche>
Mime-Version: 1.0
Date: Thu, 29 Apr 2004 17:36:56 +0200
Content-Transfer-Encoding: 7bit
Subject: [Bridge] NAT on a bridge
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

Hello all,

I can't get "invisible" NAT on a bridge to work.
What I wanted to do is redirecting HTTP requests to
another machine (or the same machine, that'd be
good enough, too).

I set up a bridge. It worked fine just bridging.
Then I added the following iptables rule:

iptables -t nat -A PREROUTING -m physdev --physdev-in eth0 -p tcp \
	--dport 80 -j DNAT --to (new address)

This resulted in the frames just disappearing in the bridge.
So, I thought, perhaps there's some problem with the address, what
with the bridge not knowing where it is and so on (both interfaces
are 0.0.0.0), perhaps I'll just try

iptables -t nat -A PREROUTING -m physdev --physdev-in eth0 -p tcp \
	--dport 80 -j REDIRECT --to-ports 80

so everything should just go to my local machine, that's good enough.
The effect was the same, the SYN frame just disappears.

I tried this with linux 2.4.25 with the bridging patches and with
2.6.5. Same effect.

If I configure the machine as a router, it works perfectly.

What am I doing wrong?

-Torsten

