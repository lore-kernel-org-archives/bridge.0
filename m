Date: Tue, 16 Mar 2004 11:07:02 -0800
From: Stephen Hemminger <shemminger@osdl.org>
Message-Id: <20040316110702.589a76e8@dell_ss3.pdx.osdl.net>
In-Reply-To: <20040316082837.1797.qmail@daitarn.register.it>
References: <20040316082837.1797.qmail@daitarn.register.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Re: Strange DHCP behaviour with bridging
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: a.fiorino@chibacity.it, bridge@osdl.org

On Tue, 16 Mar 2004 09:28:37 +0100
<a.fiorino@chibacity.it> wrote:
> I sent this message to the briding mailing list, but I didn't get any answer and I can't find how to subscribe;
> I think you are the mailing list manager so I send this hoping for better luck.

http://lists.osdl.org/mailman/listinfo/bridge

> Here is the scenario: I have one server with kernel 2.4.24 with a
> bridge br0 made of 2 interfaces, eth0 and tap0 (the last is an OpenVPN
> tunnel), and one remote computer connetting through tap0. 
> 
> If I assign a static IP to the remote computer, the bridge works perfecly 
> (so I think the problem is not OpenVPN-related). If I start a DHCPd on the
> server and I configure the remote client to get the IP from it,
> something strange happens: if I "sniff" on the br0 interface, I can
> see the DHCP requests coming from the client (from 0.0.0.0.bootpc to
> 255.255.255.bootps) and the DHCPd answers going back from
> ip.of.the.server.bootps to 255.255.255.255.bootpc; also sniffing on
> eth0 gives the same result, but if I sniff on the tap0 interface, I
> don't see the replies! So the client never get its own IP. What I'm
> doing wrong? To add some mistery, sometimes (one try out of 10) the
> reply flows correctly to the remote client. All the three interfaces
> (eth0, br0, tap0) doesn't have firewalling enabled, and under /proc
> ip_forwarding is enabled and rp_filter is disabled for all
> interfaces. brctl showmacs br0 correctly shows the remote virtual
> interface MAC address as not local.Both eth0 and tap0 have been
> configured with ifconfig 0.0.0.0 promisc up.

So the packet makes it into the tap0 device, but the bridge doesn't know
where to send the output.  Are you running spanning tree protocol or not?
Look at the contents of the forwarding table (brctl showmacs br0)
Spanning tree does take a while to settle on startup so it could be that
you need to wait about a minute till the bridge starts running.

Or may the tap device doesn't have a real hardware mac
address is confusing it.

