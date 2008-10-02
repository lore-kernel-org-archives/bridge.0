Date: Thu, 2 Oct 2008 14:04:13 -0500
From: lister@lihim.org
Message-ID: <20081002190413.GA12501@remington.svcroot.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Bridge] L2 forwarding/gateway
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Is it possible to bounce inbound packets back out to the wire
with a new MAC address without a Layer 3 IP address?

Not sure if ebtables can do this.

I'd like to sniff on the network inbound L2 packets, re-write the
destination MAC and send the packet back out without having to use
Layer 3 IP with forwarding enabled.

Basically a L2 forwarding gateway
