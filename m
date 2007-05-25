Date: Fri, 25 May 2007 09:24:45 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Subject: Re: [Bridge] My bridge is broken
Message-ID: <20070525092445.31064cdb@freepuppy>
In-Reply-To: <325018.994.qm@web37001.mail.mud.yahoo.com>
References: <325018.994.qm@web37001.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Swedo Rama <swedorama@yahoo.com>
Cc: bridge@lists.linux-foundation.org

On Fri, 25 May 2007 09:05:11 -0700 (PDT)
Swedo Rama <swedorama@yahoo.com> wrote:

> Hi,
> 
> I'm not sure if requests for help are appropriate for this list. If not, I apologize.
> 
> My ISP (bredbandsbolaget) here in Sweden delivers my broadband by ethernet. I get up to five IP:s through DHCP. I figured it would be a good idea to actually use these IP:s instead of going for a NAT/PAT/masquerading thing. So, bridging firewall, right?


Are you trying to do bridging or routing. If you want separate IP's you probably need to route
not using bridging.

> 
> I can't seem to get it to work. Worse, I'm too much of a newbie to even diagnose the problem.
> 
> Here's my setup:
> 
> |ISP    |    | firewall |
> |DHCP|----|eth1  eth2|----|switch|----|computers|
> 
> The switch is a cheapo 3com 3CGSU05-ME gigabit thing.
> 
> Here's the firewall box:
> 
> aker:~# lspci | grep Eth
> 00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 7c)
> 04:04.0 Ethernet Controller: Intel Corporation 82541PI Gigabit Ethernet Controller (rev 05)
> 04:05:0 Ethernet  Controller: Intel Corporation 82541PI Gigabit Ethernet Controller
> 
> I want to use the two Intel PRO/1000 GT NICs for the bridge.
> 
> aker:~# uname -sr
> Linux 2.6.18-4-486
> 
> It's Debian Etch with a standard kernel.
> 
> aker:~# brctl --version
> bridge-utils, 1.2
> 
> I did this:
> 
> aker:~# ifconfig eth1 promisc up
> device eth1 entered promiscuous mode
> audit(1180131751.392.2): dev=eth1 prom=256 old_prom=0 auid=4294967295
> e1000: eth1: e1000_watchdog: NIC Link is Up 1000 Mbps Full Duplex
> 
> aker:~# ifconfig eth2 promisc up
> device eth2 entered promiscuous mode
> audit(1180131923.963.3): dev=eth2 prom=256 old_prom=0 auid=4294967295
> e1000: eth2: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex


Don't set promisc. I don't where people get the idea you need to do this
with bridging, but you don't!  The bridge code enables promiscuous on the
device as needed.

> aker:~# brctl addbr br0
> Bridge firewalling registered
> 
> aker:~# brctl addif br0 eth1
> aker:~# brctl addif br0 eth2
> 
> aker:~# brctl setfd br0 0
> 
> aker:~#  echo "1" > /proc/sys/net/ipv4/ip_forward

If you are pure bridging, then you don't need this.

> 
> aker:~# brctl show br0
> bridge name    bridge id                        STP enabled      interfaces
> br0                 8000.000e0cdd3b12       no                       eth1
>                                                                                    eth2
> 
> Both NICs have links. eth2 has a 100 mbit FD link to ISP. eth1 a gig FD link to the switch.
> 
> Now I figure I should be ready to run my DHCP client on one of the computers, but that doesn't work. if I run "brctl showmacs br0" afterwards it only lists the MACs of the two NICs in the bridge. Seems like no traffic has gone through.

Did the startup scripts assign IP addresses to eth devices on bridge?


> 
> I tried setting all the /proc/sys/net/bridge/bridge-nf* values to 0. No difference.
> 
> I'm pretty new to linux, and to networking, and I don't really know how to figure out what I'm doing wrong. Any help would be greatly appreciated. And again, sorry if this is off-topic (is there somewhere else more appropriate for this kind of question?)
> 
> /Swedo
>        
> ---------------------------------
> Take the Internet to Go: Yahoo!Go puts the Internet in your pocket: mail, news, photos & more. 

-- 
Stephen Hemminger <shemminger@linux-foundation.org>
