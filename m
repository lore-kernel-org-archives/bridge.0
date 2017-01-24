Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
	h=date:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=p/XfdFip30RoTnsv4G2HaNKpqyrr5Vhjb7XmyAhIhLg=;
	b=Q5yTP3a5upUsisRqN5cT+bqmXD6EpVUpXecNr1SCQ/ZdYKOIfMQhims+Gw+5E3Uj1/
	M3kYGkzwlOTE7terLCDrOgIEQGCd4dMg+2uvx2Jqwal4HHQWjVriIIcdwx36TvGRq6Eg
	k8dqGDfWUEUyYnpfqIywcfy29fpnOiUbcU4moF8yYjYnDEV+JxJyaiQnaAMnB18i+Vx4
	8tbM0l3NFlzDkVjklLkbpsKHssFefvqoe18YX3fZhJqq8vB82+yZ8TQGBduaGbwddaOc
	7yFM6EopCoZzklXuwcMYeTn9ew8qTPFX+f73MrH6kc6cVTzlmuLAGu+xO0zFYtc6noMz
	PLnQ==
Date: Tue, 24 Jan 2017 10:12:15 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20170124101215.4e3017b2@xeon-e3>
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

> +static bool br_port_group_equal(struct net_bridge_port_group *p,
> +				struct net_bridge_port *port,
> +				const unsigned char *src)
> +{
> +	if (p->port !=3D port)
> +		return false;
> +
> +	if (!(port->flags & BR_MULTICAST_TO_UNICAST))
> +		return true;
> +
> +	return ether_addr_equal(src, p->eth_addr);
> +}
> +

I prefer that argument to functions like this be const.
