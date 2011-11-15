Return-Path: <shemminger@vyatta.com>
Date: Tue, 15 Nov 2011 10:09:14 -0800
From: Stephen Hemminger <shemminger@vyatta.com>
Message-ID: <20111115100914.0c9540be@nehalam.linuxnetplumber.net>
In-Reply-To: <4EC23EE7.2010606@intel.com>
References: <CAM1AHpSuruDx3CxzK=Med0iyxxwu7wxgRZib7yhBMiCVKXqzeA@mail.gmail.com>
	<4EC23EE7.2010606@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] [RFT] bridge: checksum not updated after pull
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: Martin Volf <martin.volf.42@gmail.com>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "wcang@sfc.wide.ad.jp" <wcang@sfc.wide.ad.jp>, "davem@davemloft.net" <davem@davemloft.net>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>

I think this is what is necessary, please test.

Subject: bridge: correct IPv6 checksum after pull

Bridge multicast snooping of ICMPv6 would incorrectly report a checksum problem
when used with Ethernet devices like sky2 that use CHECKSUM_COMPLETE.
When bytes are removed from skb, the computed checksum needs to be adjusted.

Signed-off-by: Stephen Hemminger <shemminger@vyatta.com>


--- a/net/bridge/br_multicast.c	2011-11-09 13:55:00.028012483 -0800
+++ b/net/bridge/br_multicast.c	2011-11-15 10:05:06.171314194 -0800
@@ -1501,7 +1501,9 @@ static int br_multicast_ipv6_rcv(struct
 
 	__skb_pull(skb2, offset);
 	skb_reset_transport_header(skb2);
-
+	skb_postpull_rcsum(skb2, skb_network_header(skb2),
+			   skb_network_header_len(skb2));
+
 	icmp6_type = icmp6_hdr(skb2)->icmp6_type;
 
 	switch (icmp6_type) {
