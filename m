Date: Wed, 20 Oct 2010 14:16:31 +0800
From: Herbert Xu <herbert@gondor.hengli.com.au>
Message-ID: <20101020061631.GA21679@gondor.apana.org.au>
References: <4CB9EBC3.4070905@freenet.de>
	<20101018161656.GA2403@gondor.apana.org.au>
	<4CBCB014.9080108@freenet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4CBCB014.9080108@freenet.de>
Subject: Re: [Bridge] 2.6.36-rc7: net/bridge causes temporary network I/O
	lockups [2]
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Patrick Ringl <patrick_@freenet.de>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org

On Mon, Oct 18, 2010 at 10:37:40PM +0200, Patrick Ringl wrote:
>
> Anything else I could possibly provide? :-)

Yes, testing :)

First of all I'd like to rule out (or in) the IPv6 query code,
which is clearly generating a bogus packet (wrong payload_len).

So can you apply this patch and see if it makes the problem
go away? Please take packet dumps so we know that the IPv6 query
is no longer being sent.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
--
diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index eb5b256..66f39d7 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -832,11 +832,6 @@ static void br_multicast_send_query(struct net_bridge *br,
 	br_group.proto = htons(ETH_P_IP);
 	__br_multicast_send_query(br, port, &br_group);
 
-#if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
-	br_group.proto = htons(ETH_P_IPV6);
-	__br_multicast_send_query(br, port, &br_group);
-#endif
-
 	time = jiffies;
 	time += sent < br->multicast_startup_query_count ?
 		br->multicast_startup_query_interval :
