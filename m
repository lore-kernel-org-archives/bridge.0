Return-Path: <davem@davemloft.net>
Date: Thu, 18 Feb 2016 15:35:42 -0500 (EST)
Message-Id: <20160218.153542.67284853154438064.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1455502026-23144-1-git-send-email-linus.luessing@c0d3.blue>
References: <1455502026-23144-1-git-send-email-linus.luessing@c0d3.blue>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCH] net: fix bridge multicast packet checksum
	validation
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: linus.luessing@c0d3.blue
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, sgunderson@bigfoot.com, tom@herbertland.com

From: Linus L=FCssing <linus.luessing@c0d3.blue>
Date: Mon, 15 Feb 2016 03:07:06 +0100

> @@ -4084,10 +4089,22 @@ struct sk_buff *skb_checksum_trimmed(struct s=
k_buff *skb,
>  	if (!pskb_may_pull(skb_chk, offset))
>  		goto err;
>  =

> -	__skb_pull(skb_chk, offset);
> +	ip_summed =3D skb->ip_summed;
> +	csum_valid =3D skb->csum_valid;
> +	csum_level =3D skb->csum_level;
> +	csum_bad =3D skb->csum_bad;
> +	csum =3D skb->csum;
> +
> +	skb_pull_rcsum(skb_chk, offset);
>  	ret =3D skb_chkf(skb_chk);
>  	__skb_push(skb_chk, offset);
>  =

> +	skb->ip_summed =3D ip_summed;
> +	skb->csum_valid =3D csum_valid;
> +	skb->csum_level =3D csum_level;
> +	skb->csum_bad =3D csum_bad;
> +	skb->csum =3D csum;
> +

There really has to be a better way to fix this :-/
