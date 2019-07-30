Return-Path: <rdong.ge@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=s5yWI2xfBi7yZUvh5vbuUYKfiAIOr2+n9/J+pTBAvvA=;
	b=oNRi4RrqZcCHcv3ihpvxRh05FVUCJujtgcfihPqzEIhibrVSyvLxH6ou+KPX3QcJW1
	8odyqmb9Xy6OZW3Akl4mhb8QXyeta1TByczNxiawqeZqlsAEQgeNH4zWnRQNZjNaanng
	0uyuZIy+8zTVFFxa0Ya/KrP2BWiVnBI9uP6oyFln1SImZYqFXKVsPFuT21tgQZ7JxlFX
	Fs+CbA/+uEvCQ0ZUgz9IPY356ERlad9t/WiFeJ2j53Gucbi1JlQ9yIBQgH0c0Te24k7b
	EffDwc1jhPKoAalhRJA+XcovRIjMe2TsRZptfp0V8HA2/1B5SE8WZ8hszhzXBdu/7690
	DokQ==
From: Rundong Ge <rdong.ge@gmail.com>
Date: Tue, 30 Jul 2019 12:25:34 +0000
Message-Id: <20190730122534.30687-1-rdong.ge@gmail.com>
Subject: [Bridge] [PATCH] bridge:fragmented packets dropped by bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: davem@davemloft.net
Cc: rdong.ge@gmail.com, yoshfuji@linux-ipv6.org, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, fw@strlen.de, linux-kernel@vger.kernel.org, kadlec@netfilter.org, nikolay@cumulusnetworks.com, coreteam@netfilter.org, netfilter-devel@vger.kernel.org, kuznet@ms2.inr.ac.ru, pablo@netfilter.org

Given following setup:
-modprobe br_netfilter
-echo '1' > /proc/sys/net/bridge/bridge-nf-call-iptables
-brctl addbr br0
-brctl addif br0 enp2s0
-brctl addif br0 enp3s0
-brctl addif br0 enp6s0
-ifconfig enp2s0 mtu 1300
-ifconfig enp3s0 mtu 1500
-ifconfig enp6s0 mtu 1500
-ifconfig br0 up

                 multi-port
mtu1500 - mtu1500|bridge|1500 - mtu1500
  A                  |            B
                   mtu1300

With netfilter defragmentation/conntrack enabled, fragmented
packets from A will be defragmented in prerouting, and refragmented
at postrouting.
But in this scenario the bridge found the frag_max_size(1500) is
larger than the dst mtu stored in the fake_rtable whitch is
always equal to the bridge's mtu 1300, then packets will be dopped.

This modifies ip_skb_dst_mtu to use the out dev's mtu instead
of bridge's mtu in bridge refragment.

Signed-off-by: Rundong Ge <rdong.ge@gmail.com>
---
 include/net/ip.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/net/ip.h b/include/net/ip.h
index 29d89de..0512de3 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -450,6 +450,8 @@ static inline unsigned int ip_dst_mtu_maybe_forward(const struct dst_entry *dst,
 static inline unsigned int ip_skb_dst_mtu(struct sock *sk,
 					  const struct sk_buff *skb)
 {
+	if ((skb_dst(skb)->flags & DST_FAKE_RTABLE) && skb->dev)
+		return min(skb->dev->mtu, IP_MAX_MTU);
 	if (!sk || !sk_fullsock(sk) || ip_sk_use_pmtu(sk)) {
 		bool forwarding = IPCB(skb)->flags & IPSKB_FORWARDED;
 
-- 
1.8.3.1

