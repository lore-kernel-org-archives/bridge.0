Return-Path: <phil@nwl.cc>
Date: Mon, 29 Jul 2013 18:53:57 +0200
From: Phil Sutter <phil@nwl.cc>
Message-ID: <20130729165357.GA23134@orbit.nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Bridge] packet_mmap, 802.1Q and bridges
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Ben Greear <greearb@candelatech.com>, bridge@lists.linux-foundation.org, Stephen Hemminger <shemminger@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>

Hello everyone,

I have found a situation where sending of VLAN tagged packets via
packet_mmap over a bridge creates MTU problems.

The setup is as follows:
- physical interface eth0 (mv643xx)
- bridge interface br0 contains just eth0
- packet_mmap sender bound to br0, socket() called with SOCK_RAW and
  ETH_P_ALL as arguments, PACKET_VERSION set to TPACKET_V2
- MTU is 1500 on all involved interfaces

When userspace sends a full frame, it will pass tpacket_snd which will
reject it unless there is a small patch of mine applied (for patch and
related discussion, see: http://patchwork.ozlabs.org/patch/67422/).
Tpacket_snd creates an SKB around the passed data, with 'protocol' field
set to whatever was specified at socket() stage (in this case,
ETH_P_ALL). Eventually, dev_queue_xmit() is called.

The SKB created in af_packet.c is passed to the bridge code, while the
interesting part is the function br_dev_queue_push_xmit() in
net/bridge/br_forward.c. This function checks the frame's length against
the device's MTU, therefore calling packet_length() which in turn does
look at the SKB's protocol field for whether to account for an
additional VLAN header or not. In this case, br_dev_queue_push_xmit()
will drop the frame since ETH_P_ALL != ETH_P_8021Q.

Using tcpdump, I could observe the packet occurs on br0, but not eth0.
Changing packet_length() to also subtract VLAN_HLEN if skb->protocol is
htons(ETH_P_ALL) fixed the problem.

While preparing this email, I read again the discussion referenced above
and found it surprisingly adequate for the problem described here. If I
am not mistaken, the consensus was whether we should parse the given
buffer in order to extract the real ethernet protocol or just account
for four extra bytes, regardless of the actual packet.

IMHO the problem described above is a strong argument for the first
option. There is code which depends on skb->protocol's content to be
correct, so af_packet should stick to it.

Comments are highly appreciated. In the meantime, I will have a look at
how to parse the packet_mmap buffer. If you got anything in that
direction already, please feel free to come forward.

Best wishes, Phil
