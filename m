Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
	h=date:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=jQdnElDFu9djwJ8//igK5TWMQOehTO7KM79mIoRLSP8=;
	b=sb5b+VezaAv3NpPXo6umABnQ6+GnxgUzEwo7eeeP+rRPghN96TepnFD6/r+H+QBc/T
	AeFXpadw8za+Z3KALZ9N8qMWoehtq1rPQ6qXiXKSeSnT4F/dYhAlHuhZWP/LbOWAIsn4
	j2zHhGYvh1rdCo0G9zggX0vXpVYHQTGhXSI9KcsMAmGbY7eNA2mM9vE0z4euOkqsqOEz
	wRwcdvfDX6l9kgtlgzdeQrfgVdMkcrsjpHuDNu0AAhBCb11FxT0lmKErQUk6LaQO/6yz
	xc/CbOpjqLO59iV0asRRUY2c2NyMGiB1Qpi2yQTgp8cal8SRXrjtiOZA0dLrITETGHpa
	Lz+Q==
Date: Tue, 24 Jan 2017 10:10:41 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20170124101041.55c2ab39@xeon-e3>
In-Reply-To: <20170121200133.1864-1-linus.luessing@c0d3.blue>
References: <20170121200133.1864-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCH net-next v5] bridge: multicast to unicast
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Linus =?UTF-8?B?TMO8c3Npbmc=?= <linus.luessing@c0d3.blue>
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, Felix Fietkau <nbd@nbd.name>

On Sat, 21 Jan 2017 21:01:32 +0100
Linus L=C3=BCssing <linus.luessing@c0d3.blue> wrote:

> @@ -726,12 +729,32 @@ struct net_bridge_port_group *br_multicast_new_port=
_group(
>  	hlist_add_head(&p->mglist, &port->mglist);
>  	setup_timer(&p->timer, br_multicast_port_group_expired,
>  		    (unsigned long)p);
> +
> +	if (src)
> +		memcpy(p->eth_addr, src, ETH_ALEN);
> +	else
> +		memset(p->eth_addr, 0xff, ETH_ALEN);
> +
>  	return p;
>  }

Maybe use ether_addr_copy here, but is not performance critical
