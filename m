From: "Alexander Stolle" <alexlists@web.de>
Date: Mon, 18 Jul 2005 21:40:32 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
In-Reply-To: <200507111901.j6BJ09jC011023@smtp.osdl.org>
Message-Id: <E1DubTc-0003tw-00@smtp08.web.de>
Sender: alexlists@web.de
Subject: [Bridge] Problem with bond interface in bridge
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

Hi @all,

I have a strange problem. Here is the setup: I have a bridging linux box
with 3 NICs (Intel e1000). 1 NIC (eth0) connected to the internet interface
and the other both (eth1 and eth2) are each connected to a different switch
in the bridged network.

I setup bonding (bond0) with active failover for eth1 and eth2. Then I added
eth0 and bond0 to br0 and brought it up with an ip. I am able to ping into
the internet and I can also ping servers in the bridged network from my
bridging linux box.

internet---bridging box---bridged network
		   br0
		eth0  bond0

But if I try to ping from the internet via the bridging box to the bridged
network, I get a "host not reachable". Looks like the bridge does not
forward anything. Has anybody ever had an equal problem or are there other
possible solutions for my setup? I have tried to add the 3 interfaces to the
br0, but this did not work either (amnd as far as I kniow there is no auto
failover for bridge ports).

Could someone please advise me or give me some tips, so that I can track
down the problem?
Thanks in advance :)

Best, Alex

Versions:
Dist debian sarge
Bonding Driver, v2.6.0
Kernel 2.4.31
bridge-utils, 1.0.4

