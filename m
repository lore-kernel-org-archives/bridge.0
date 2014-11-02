Return-Path: <herbert@gondor.apana.org.au>
Date: Mon, 3 Nov 2014 06:01:46 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
Message-ID: <20141102220145.GA25604@gondor.apana.org.au>
References: <1411342364-4791-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1411342364-4791-1-git-send-email-linus.luessing@web.de>
Subject: Re: [Bridge] [PATCH] bridge: fix netfilter/NF_BR_LOCAL_OUT for own,
 locally generated queries
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Linus =?iso-8859-1?Q?L=FCssing?= <linus.luessing@web.de>
Cc: Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org

On Mon, Sep 22, 2014 at 01:32:44AM +0200, Linus Lüssing wrote:
> Ebtables on the OUTPUT chain (NF_BR_LOCAL_OUT) would not work as expected
> for both locally generated IGMP and MLD queries. The IP header specific
> filter options are off by 14 Bytes for netfilter (actual output on
> interfaces is fine).
> 
> NF_HOOK() expects the skb->data to point to the IP header, not the
> ethernet one (while dev_queue_xmit() does not). Luckily there is an
> br_dev_queue_push_xmit() helper function already - let's just use that.
> 
> Introduced by eb1d16414339a6e113d89e2cca2556005d7ce919
> ("bridge: Add core IGMP snooping support")
> 
> Ebtables example:
> 
> $ ebtables -I OUTPUT -p IPv6 -o eth1 --logical-out br0 \
> 	--log --log-level 6 --log-ip6 --log-prefix="~EBT: " -j DROP
> 
> before (broken):
> 
> ~EBT:  IN= OUT=eth1 MAC source = 02:04:64:a4:39:c2 \
> 	MAC dest = 33:33:00:00:00:01 proto = 0x86dd IPv6 \
> 	SRC=64a4:39c2:86dd:6000:0000:0020:0001:fe80 IPv6 \
> 	DST=0000:0000:0000:0004:64ff:fea4:39c2:ff02, \
> 	IPv6 priority=0x3, Next Header=2
> 
> after (working):
> 
> ~EBT:  IN= OUT=eth1 MAC source = 02:04:64:a4:39:c2 \
> 	MAC dest = 33:33:00:00:00:01 proto = 0x86dd IPv6 \
> 	SRC=fe80:0000:0000:0000:0004:64ff:fea4:39c2 IPv6 \
> 	DST=ff02:0000:0000:0000:0000:0000:0000:0001, \
> 	IPv6 priority=0x0, Next Header=0
> 
> Signed-off-by: Linus Lüssing <linus.luessing@web.de>

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
