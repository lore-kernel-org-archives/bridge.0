Date: Thu, 1 Jul 2004 08:24:36 +1000
From: Cameron Hutchison <camh+lbr@xdna.net>
Message-ID: <20040630222436.GA14452@imladris>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Bridge] Non-forwarding bridge
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

Is it possible to set up a non-forwarding bridge? I have two interfaces
that I'd like to combine, where one is a fast main link and the other is
a slower backup. I'd like traffic to go out the fast link only, if it is
available, and failover to the backup if it is not available. I never
want to forward packets between the interfaces.

My specific setup is a laptop with a 100M ethernet and a 802.11g wireless
link, kernel 2.6.7. The two networks are already bridged with a linksys
WRT54G (running OpenWRT).

When I try to set up a bridge in my laptop, I'm getting a loop on my
network. I have STP enabled in both bridges and I have set the bridge
priority of the laptop to the lowest possible (65535) - the linksys is
still at the default 0x8000.

I dont seem to get all packets looped - it seems to be mostly samba
packets. I'm watching the link with ethereal and the packets stop when I
kill the bridge on the laptop.

One issue may be the 802.11g card on the laptop - a broadcom card
running with ndiswrapper (0.8). I'm not sure if this configuration
supports promiscuous mode and whether or not that is the cause of my
problem.

However, back to the original question: Can you setup a non-forwarding
bridge? My problem would go away if you could. Or is there another way
to configure networking to achieve the same functional result?

Thanks

