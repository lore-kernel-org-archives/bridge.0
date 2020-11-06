Return-Path: <dsahern@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=wFLtKUwT5ZvmDcv5zrEJNSopht3kHGBwLH6MG+aoAb8=;
 b=Vg5nKxDZu895ttIHrDM477LtUq2tTMuNvYBCp/tR8Xl2m2lIeak6kqji6iOpxtSjmb
 KU+29HSyzpytGLDR2uJVWBSnhoeLDlYTUaoiNnRn5xm2PN0uP6DqN0ixhKt2vtzFjyeE
 8XW7IDHpaKvXbEt701jGTvOdmPV9XPpkcXO9Mf8rqKlDB9/mVgff8oK17QXddT80Zm0Z
 PAqj8LqYsRNzh+iJ1Go36LS+ou5dbAtAqEx+jwIwA+QvuEtVpXL5Yo5uv/99RUZ/Skgd
 vo+s9Jk8zg+VJOEToB4bUnjRjt9v2kedXGY0n8hSQnHegamgwRMZY4O5FgzvN6TqatV0
 8tkQ==
References: <20201029222828.2149980-1-olteanv@gmail.com>
From: David Ahern <dsahern@gmail.com>
Message-ID: <2f127ed7-a816-bb13-0be2-68b19eef78fb@gmail.com>
Date: Fri, 6 Nov 2020 09:40:12 -0700
MIME-Version: 1.0
In-Reply-To: <20201029222828.2149980-1-olteanv@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v2 iproute2-next] bridge: add support for L2
 multicast groups
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <olteanv@gmail.com>, David Ahern <dsahern@gmail.com>, Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, bridge@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: andrew@lunn.ch, f.fainelli@gmail.com, idosch@idosch.org, jiri@mellanox.com, vivien.didelot@gmail.com

On 10/29/20 4:28 PM, Vladimir Oltean wrote:
> @@ -168,9 +176,14 @@ static void print_mdb_entry(FILE *f, int ifindex, const struct br_mdb_entry *e,
>  	print_string(PRINT_ANY, "port", " port %s",
>  		     ll_index_to_name(e->ifindex));
>  
> +	if (af == AF_INET || af == AF_INET6)
> +		addr = inet_ntop(af, grp, abuf, sizeof(abuf));
> +	else
> +		addr = ll_addr_n2a(grp, ETH_ALEN, 0, abuf, sizeof(abuf));
> +

The above can be replaced with a single call to rt_addr_n2a_r.

>  	print_color_string(PRINT_ANY, ifa_family_color(af),
> -			    "grp", " grp %s",
> -			    inet_ntop(af, grp, abuf, sizeof(abuf)));
> +			    "grp", " grp %s", addr);
> +
>  	if (tb && tb[MDBA_MDB_EATTR_SOURCE]) {
>  		src = (const void *)RTA_DATA(tb[MDBA_MDB_EATTR_SOURCE]);
>  		print_color_string(PRINT_ANY, ifa_family_color(af),

I think the rest is ok.
