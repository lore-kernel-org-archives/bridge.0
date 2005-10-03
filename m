Date: Mon, 3 Oct 2005 11:25:53 +0200 (CEST)
From: Bartek Kania <bartek@scandichosting.com>
Message-ID: <Pine.LNX.4.62.0510031118030.1429@bartek.icepage.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: [Bridge] Bridging with STP seems to learn mac-address on wrong ports
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

I have two multi-port bridges connected together with a lot of cables.
Current setup is as follows:

     --------eth0-------
    |                   |
[Bridge A] <-eth1-> [Bridge B]
    |                   |
     --------eth5-------

Bridge A is root-bridge, and eth0 is set to lowest path-cost.
Consequently on Bridge B interfaces eth1 and eth5 are in blocking state.

However, when looking at the mac-address table on bridge B I see that it has
learned the mac-address of bridge A on the eth1-port (which is in
blocking state) and tries to use that port to communicate with 
bridge A, and since the port is blocking this fails.

It seems that the STP-bpdu's are responsible for the bridge learning
the mac-address on the wrong port.
This is tested with kernel 2.6.11.12 and 2.6.13.2, and both exhibit
this problem.

The following fix solved it for me on 2.6.11.12:
In net/bridge/br_stp_bpdu.c, in function br_stp_handle_bpdu i changed
         br_fdb_insert(p->br, p, eth_hdr(skb)->h_source,0);
to
         if (!br->stp_enabled || p->state == BR_STATE_LEARNING
             || p->state == BR_STATE_FORWARDING)
             br_fdb_insert(p->br, p, eth_hdr(skb)->h_source, 0);

/B
