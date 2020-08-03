Return-Path: <davem@davemloft.net>
Date: Mon, 03 Aug 2020 15:58:35 -0700 (PDT)
Message-Id: <20200803.155835.1186341109955245993.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20200802125039.648571-1-nikolay@cumulusnetworks.com>
References: <39736ed8-8565-ab64-5163-da6f2acba68a@cumulusnetworks.com>
 <20200802125039.648571-1-nikolay@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net v2] net: bridge: clear skb private space on
 bridge dev xmit
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: nikolay@cumulusnetworks.com
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, dsahern@gmail.com

From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Sun,  2 Aug 2020 15:50:39 +0300

> We need to clear all of the bridge private skb variables as they can be
> stale due to the packet having skb->cb initialized earlier and then
> transmitted through the bridge device. Similar memset is already done on
> bridge's input. We've seen cases where proxyarp_replied was 1 on routed
> multicast packets transmitted through the bridge to ports with neigh
> suppress and were getting dropped. Same thing can in theory happen with the
> port isolation bit as well. We clear only the struct part after the bridge
> pointer (currently 8 bytes) since the pointer is always set later.
> We can now remove the redundant zeroing of frag_max_size.
> Also add a BUILD_BUG_ON to make sure we catch any movement of the bridge
> dev pointer.
> 
> Fixes: 821f1b21cabb ("bridge: add new BR_NEIGH_SUPPRESS port flag to suppress arp and nd flood")
> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

Nikolay, I applied v1 already as I'm not at all against the full clear.
