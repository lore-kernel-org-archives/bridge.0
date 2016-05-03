Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
	h=date:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=MCrRu55b8X8LsfK+2A7txlXcLhqFKk9YY0k3X6th/1k=;
	b=g6inrKbE1KyeOVsFJyIFVDt4d/oWN/ZK6b5Xlt1t7BNIimkijnfLXroXk177Fp1V/z
	kpTtCCGCdH8fHG4DOMzZ02B0OF1BY66/bxw4jwQTPWRCtmnOthvJkU0M2xYepIFNEUat
	BohN8YFFUxh5D8Ackeg2aKwz8qDwTSTjUJGTnUqWW6O8X8/dR17VvZPZBxxth3W/xCMd
	OEa0kmZXsOOcvYFYc71cnCQwMWdvhmd06k+CFEXgqiOnZiWsX4P+lzkRL5B/obL1QWMK
	/1bRThwV0DisJzD0+OMDzQ0EX8mJ6L6DTIZz+lNMiU3hwpM0941ZBwKrX/xRipxgua2j
	lkYQ==
Date: Tue, 3 May 2016 13:26:23 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20160503132623.59cf54fb@xeon-e3>
In-Reply-To: <1462306734-4183-1-git-send-email-linus.luessing@c0d3.blue>
References: <1462306734-4183-1-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCH net] bridge: fix igmp / mld query parsing
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Linus =?UTF-8?B?TMO8c3Npbmc=?= <linus.luessing@c0d3.blue>
Cc: Simon Wunderlich <sw@simonwunderlich.de>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, "David S . Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org

On Tue,  3 May 2016 22:18:54 +0200
Linus L=C3=BCssing <linus.luessing@c0d3.blue> wrote:

> diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
> index 03661d9..7105cdf 100644
> --- a/net/bridge/br_multicast.c
> +++ b/net/bridge/br_multicast.c
> @@ -1271,6 +1271,7 @@ static int br_ip4_multicast_query(struct net_bridge=
 *br,
>  	unsigned long max_delay;
>  	unsigned long now =3D jiffies;
>  	__be32 group;
> +	int offset =3D skb_transport_offset(skb);
shouldn't this be unsigned?
