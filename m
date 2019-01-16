Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
	h=date:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=D9Sb8SoKPOW5akR4jp6n2W1CGTPyKL+a3blZ/G6iKQk=;
	b=f+v+qgkzjqya+5HcnopwscvhxHzmEU0LaVSw2hTuEWkpJc1D5eeRSWQISTQLL4ymPL
	gU5ZJt0y/nuhSTOyccgDlywwibbAft40muoYGnqBtBE/zAi2umAGild1w/i90ffqpQnd
	5BvHhkkzkGbhTcTWU1gm+uRhGD7fnrX5lQ31kCU+8WXk3RI64b3GYPsLidNffkg2sx3x
	lMNcnBHsK98T0IKWU5Gd8tLfhFeNvQBd+UaSkmSDPUbR9OtkrUG8apLxwiQm3UmajToQ
	qC4T1ZuEysHOFiO+t/IVRIcTsZBieWpZ29xtofN9cLMVNqEYEjbpMLmz6fIsPrS7xlQ+
	xG4g==
Date: Wed, 16 Jan 2019 09:33:12 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20190116093312.5274776e@shemminger-XPS-13-9360>
In-Reply-To: <1547643861-15340-1-git-send-email-wangyunjian@huawei.com>
References: <1547643861-15340-1-git-send-email-wangyunjian@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net v3] net: bridge: Fix ethernet header
 pointer before check skb forwardable
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: wangyunjian <wangyunjian@huawei.com>
Cc: Nkolay Aleksandrov <nikolay@cumulusnetworks.com>, netdev@vger.kernel.org, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, xudingke@huawei.com

On Wed, 16 Jan 2019 21:04:21 +0800
wangyunjian <wangyunjian@huawei.com> wrote:

>  		if (unlikely(netpoll_tx_running(to->br->dev))) {
> +			skb_push(skb, ETH_HLEN);
>  			if (!is_skb_forwardable(skb->dev, skb)) {
>  				kfree_skb(skb);
>  			} else {
> -				skb_push(skb, ETH_HLEN);
>  				br_netpoll_send_skb(to, skb);
>  			}
>  			return;

The patch looks correct.

On minor style issue is that after moving skb_push out of the if statement,
both branches of the statement now contain a single line and therefore
the brackets are no longer necessary.  Suprised that checkpatch did
not complain about this.

