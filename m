Message-ID: <20061031013543.24062.qmail@web56907.mail.re3.yahoo.com>
Date: Mon, 30 Oct 2006 17:35:42 -0800 (PST)
From: Douglas Chen <g5ranger@yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] problem with bridge on soho router,
	when lan interface down, all go down
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: bridge@lists.osdl.org

>The bridge disables by port, each port is a network device. If the network devices
>correctly implement carrier, then it can work with some down and some up.
>It sounds like either they are all coming on one device, or the device driver is
>buggy.

Thanks for your speedy reply!! Much appreciated ..

Before I dive in and start digging the source code, I want to confirm something.
I am not too well versed on STP and bridge yet.  Pardon me if this sounds weird or funny.

1. If STP is disabled, do these blocking/learning/forwarding... states still matter?
I guess I need to keep the bridge constantly in the forwarding states.  Any suggestions?

2. I also went back and read the spec one more time.  It seems that the switch (LAN) interface uses a special tagging mode similar to 802.1Q to identify the port numbers.  It is used for IGMP snooping and can be used by other applications as well.  But I guess, the current bridge code doesn't support this?  Or does it at least support the normal tagging mode?  Sorry if this doesn't make any sense.

Thanks!



