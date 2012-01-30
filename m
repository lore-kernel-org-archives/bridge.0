Return-Path: <haunma@keteu.org>
Date: Mon, 30 Jan 2012 14:01:55 -0800
From: Mark Haun <haunma@keteu.org>
Message-ID: <20120130220155.GE3528@keteu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Bridge] Stuck on bridge config for UDP broadcasts (UPNP)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hi bridge-people,

I'm posting here after having tried everything else I can think of to get
UPNP discovery (SSDP) working over my bridged home network.  My network
topology has been working fine until now; it looks like this:

+---------+           +----------+
| Desktop |-----------|  Bridge  |--------> laptop, smartphone, etc.
+---------+      eth0 |   br0    | wlan0
                      +----|-----+
                      |   ARM    |
                      |  server  |
                      +----+-----+
                           | eth1
                           |
                           v
                      the internet

I am trying to achieve free passage of SSDP broadcasts (UDP packets with
dest ip 239.255.255.250 port 1900) both (a) across the bridge, and (b) from
the ARM server itself out both sides of the bridge.  I've played around with
the bridge igmp snooping params, and also established that my iptables rules
are not the problem.

I finally hit upon "sendip" as a diagnostic tool to forge SSDP packets on
demand, running tcpdump sessions on the desktop and the ARM server.  I am
seeing an asymmetry that baffles me: SSDP broadcasts from the desktop show
up in both tcpdumps, i.e. they make it through the bridge pseudo-interface
br0.  But SSDP broadcasts *from* the ARM server don't make it out in the
other direction--they don't reach the desktop.

BTW, with the kernel icmp multicast responses enabled, I *am* able to ping
224.0.0.1 from both the desktop and ARM server, and get responses from both
sides.  So, ICMP multicast is making it through in both directions, but not
UDP multicast.

I don't currently have linux clients on the wireless side of the bridge, so
I haven't network-snooped there yet.  If there is symmetry, I suspect I will
find that UDP broadcasts are traversing the bridge from eth0->wlan0 and
wlan0->eth0 (and can be heard on br0 by the server), but UDP broadcasts
originating on br0 are not being sent out to eth0 and wlan0.

Is there a bridging expert who could shed some light on this?  What am I
missing?

Thanks in advance,

Mark
