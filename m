Date: Sat, 29 May 2004 03:50:13 +0200
From: Santiago Garcia Mantinan <manty@debian.org>
Message-ID: <20040529015012.GA5863@man.manty.net>
References: <1ge3one.1m2b8mcymi2u4M@geos.net.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ge3one.1m2b8mcymi2u4M@geos.net.eu.org>
Subject: [Bridge] Re: Linux bridging code bounces back frames?
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Georg Schwarz <geos@epost.de>
Cc: bridge@osdl.org

> eth0 is a BNC network, if that matters.

> Now the problem is that the bridge appears to sometimes "reflect" frames
> received on eth0 back to eth0. When I ping from one PC another PC on the

I was going to tell you to check the terminators, I've seen many weird
things in BNC nets because of terminator problems, but reading this...


> On the bridge with brctl showmacs br0 I can see where 00:A0:24:CF:E8:8E
> is supposed to be. It should be on port no. 1. Nevertheless,  
> brctl showmacs br0 sometimes shows the 00:a0:24:cf:e8:8e on port no. 2,
> i.e. eth1. This is when the duplicates/reflections occur.

The bridge should not learn that that mac is on port 2 if it is not, are you
shure there is no loop in the net, or another thing that could be causing
packages with that mac to be on port 2?

>   2     00:00:c0:0a:26:69       no                10.52
>   2     00:a0:24:cf:e8:8e       no                 0.37
> then after unplugging eth1 on the bridge and pinging from 192.168.0.1 to
> 192.168.0.39:
>   1     00:00:c0:0a:26:69       no                36.85
>   1     00:a0:24:cf:e8:8e       no                44.13

Note that not only one machine is changing the interface, I see two on the
output you sent, don't know if there can be even more at some other time.

> The bride does not work; I cannot ping through it; strangely though dhcp
> does work through it, as does arp resolution.
> My network is very simple. There's only that one bridge linking two
> ethernet collission domains.

After reading this I don't know what to say, I see no logic in any of this
things, I wouldn't blame the bridge, maybe a harware/driver problem, I
wouldn't know, I'm thinking in some interrupt sharing or something, but it
doesn't make sense at all.

> Unlike what /usr/share/doc/bridge-utils/README.Debian.gz says, STP seems
> to be disabled by default.

Yes, there was a change in the kernel default since I wrote that document,
and as the document says, they can change anytime.

> Any help on figuring out what's going wrong would be very much
> appreciated.

I'm sorry but I wouldn't know what to say about all this.

> completely puzzled, Georg

Me too, if you find what is going on... just post it on the list.

Regards...
-- 
Manty/BestiaTester -> http://manty.net
