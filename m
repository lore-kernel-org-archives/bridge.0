Return-Path: <davem@davemloft.net>
Date: Tue, 16 Apr 2019 20:36:00 -0700 (PDT)
Message-Id: <20190416.203600.2232027213794144887.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20190411105639.7358-1-nikolay@cumulusnetworks.com>
References: <20190411105639.7358-1-nikolay@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net] net: bridge: fix per-port af_packet sockets
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: nikolay@cumulusnetworks.com
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, fw@strlen.de

From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Thu, 11 Apr 2019 13:56:39 +0300

> When the commit below was introduced it changed two visible things:
>  - the skb was no longer passed through the protocol handlers with the
>    original device
>  - the skb was passed up the stack with skb->dev = bridge
> 
> The first change broke af_packet sockets on bridge ports. For example we
> use them for hostapd which listens for ETH_P_PAE packets on the ports.
> We discussed two possible fixes:
>  - create a clone and pass it through NF_HOOK(), act on the original skb
>    based on the result
>  - somehow signal to the caller from the okfn() that it was called,
>    meaning the skb is ok to be passed, which this patch is trying to
>    implement via returning 1 from the bridge link-local okfn()
> 
> Note that we rely on the fact that NF_QUEUE/STOLEN would return 0 and
> drop/error would return < 0 thus the okfn() is called only when the
> return was 1, so we signal to the caller that it was called by preserving
> the return value from nf_hook().
> 
> Fixes: 8626c56c8279 ("bridge: fix potential use-after-free when hook returns QUEUE or STOLEN verdict")
> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
> ---
> I plan to make a selftest for this one too. Once we agree on the fix.

This seems reasonable, applied and queued up for -stable, thanks Nikolay.
