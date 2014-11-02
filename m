Return-Path: <linus.luessing@c0d3.blue>
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20141102153733.GA23084@odroid>
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
Date: Sun, 02 Nov 2014 15:45:07 -0000
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, bridge@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>, Herbert Xu <herbert@gondor.apana.org.au>

On Mon, Sep 22, 2014 at 01:32:44AM +0200, Linus Lüssing wrote:
> Ebtables on the OUTPUT chain (NF_BR_LOCAL_OUT) would not work as expected
> for both locally generated IGMP and MLD queries. The IP header specific
> filter options are off by 14 Bytes for netfilter (actual output on
> interfaces is fine).
> 
> NF_HOOK() expects the skb->data to point to the IP header, not the
> ethernet one (while dev_queue_xmit() does not). Luckily there is an
> br_dev_queue_push_xmit() helper function already - let's just use that.

bump
