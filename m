Return-Path: <herbert@gondor.apana.org.au>
Date: Fri, 8 Mar 2013 10:47:26 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
Message-ID: <20130308024726.GA27319@gondor.apana.org.au>
References: <1362708423-23932-1-git-send-email-amwang@redhat.com>
	<20130308023151.GA27155@gondor.apana.org.au>
	<1362710646.9773.25.camel@cr0>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1362710646.9773.25.camel@cr0>
Subject: Re: [Bridge] [Patch net] bridge: do not expire mdb entry when
 bridge still uses it
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Cong Wang <amwang@redhat.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>, Adam Baker <linux@baker-net.org.uk>

On Fri, Mar 08, 2013 at 10:44:06AM +0800, Cong Wang wrote:
>
> This is a good question. It is due to inside br_handle_frame_finish() we
> use 'skb2' to decide if we deliver packets to bridge itself, and in this
> case 'skb2' is non-NULL only when:
> 
>                 if (mdst || BR_INPUT_SKB_CB_MROUTERS_ONLY(skb)) {
>                         if ((mdst && mdst->mglist) ||
>                             br_multicast_is_router(br))
>                                 skb2 = skb; //        <======== HERE
>                         br_multicast_forward(mdst, skb, skb2);
> 
> For other ports, br_multicast_forward() will always forward 'skb' to
> them.

Yes but the point is that other ports should also expire after the
timeout and thus be removed from mdst.  So why is this only happening
for the bridge aka mdst->mglist?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
