Return-Path: <eric.dumazet@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding;
	bh=YKJ/bSTYzSYJxPmyQ75BSXdqlBzPU2l+548Wy/gWtEg=;
	b=htxgTdkv9CI7RSiDD9mr9zWPHEqJKOvbRzIgwS5TwazHkKkrarRw3lvlBtNBJPJsc9
	v5EG9gFsNfULlfKDMq5d+r0AnlQ4l9/mKTETasNwenDInRTQiGLgqkcciOj4jOGd63m4
	/ATgurR//Zx0DXaGuMzWVADs5mPW7M0bTe4KfM6xxlpiVzAKi0nUwum1QsCZs/mhadAL
	dZRdRiCkEgUY2N98TXGp0JiAppwhxKl++XpPlv0URoIHLdobbVLpqHHBTFj6WeVM7iFY
	Ub6lk6kN1gS6UX5KIvd14+ZLXuRaxJLTEpNPhupUpdaagZvEKlMsKqV5unWEsRIs4n8t
	Pm9A==
Message-ID: <1436181400.25714.10.camel@edumazet-glaptop2.roam.corp.google.com>
From: Eric Dumazet <eric.dumazet@gmail.com>
Date: Mon, 06 Jul 2015 13:16:40 +0200
In-Reply-To: <559A5A0B.4040700@citrix.com>
References: <1435946491-11148-1-git-send-email-julien.grall@citrix.com>
	<20150703204213.GM16529@breakpoint.cc> <559A5A0B.4040700@citrix.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] net/bridge: Add missing in6_dev_put in
	br_validate_ipv6
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Julien Grall <julien.grall@citrix.com>
Cc: wei.liu2@citrix.com, ian.campbell@citrix.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org, Bernhard Thaler <bernhard.thaler@wvnet.at>, xen-devel@lists.xenproject.org, davem@davemloft.net, Pablo Neira Ayuso <pablo@netfilter.org>

On Mon, 2015-07-06 at 11:35 +0100, Julien Grall wrote:

> __in6_dev_get requires to hold rcu_read_lock or RTNL. My knowledge on
> this code is very limited. Are we sure that one this lock is hold? At
> first glance, I wasn't able to find one.

You could play it safe ;)

diff --git a/net/bridge/br_netfilter_ipv6.c b/net/bridge/br_netfilter_ipv6.c
index 6d12d2675c80..90e8ccc21cc5 100644
--- a/net/bridge/br_netfilter_ipv6.c
+++ b/net/bridge/br_netfilter_ipv6.c
@@ -104,10 +104,12 @@ int br_validate_ipv6(struct sk_buff *skb)
 {
 	const struct ipv6hdr *hdr;
 	struct net_device *dev = skb->dev;
-	struct inet6_dev *idev = in6_dev_get(skb->dev);
+	struct inet6_dev *idev;
 	u32 pkt_len;
 	u8 ip6h_len = sizeof(struct ipv6hdr);
 
+	rcu_read_lock();
+	idev = __in6_dev_get(dev);
 	if (!pskb_may_pull(skb, ip6h_len))
 		goto inhdr_error;
 
@@ -140,11 +142,13 @@ int br_validate_ipv6(struct sk_buff *skb)
 	/* No IP options in IPv6 header; however it should be
 	 * checked if some next headers need special treatment
 	 */
+	rcu_read_unlock();
 	return 0;
 
 inhdr_error:
 	IP6_INC_STATS_BH(dev_net(dev), idev, IPSTATS_MIB_INHDRERRORS);
 drop:
+	rcu_read_unlock();
 	return -1;
 }
 


