Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209CC317173
	for <bridge@lists.linux.dev>; Fri, 13 Mar 2026 10:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773399286; cv=none; b=iSSjQDTXzB5QUOmY6afvd+oJeMGasFkhpryPW5of0VH0DmpwZgD4qiKUg4E5RI5lWTSJYYmkFzlmGdOH20zCm4EGZXvTBRRHLppDfD1nwOFnDuMR+hKm+1JPD2MzLYVH05Q6niFwM3ANLOF1V68y+YP8Eg+SIimpLaNKUwTAnBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773399286; c=relaxed/simple;
	bh=w3zxUJSjuu2ZTxg+olsZhOhgZVG2CW5eudoaxy9c3g8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=El3Z1k1VTZWb8epKRz0gK0aOsvJ7i0SnI4unTUVhr8pGciCF9V+7PjiCXCyPZlOAHqf1SpGpW77Tjit7EWvmW6Fgeki1WdxdN1sXtYh8wcJspuGEc3iPrBU/AjUIMEZdI8o2QZvd+rInpzBOImQNg/EuwjCEDgfwn6wdFgjxrTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=CAW50R9R; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="CAW50R9R"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-485392de558so12849155e9.1
        for <bridge@lists.linux.dev>; Fri, 13 Mar 2026 03:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1773399281; x=1774004081; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Xz+lAQTHg1ZrCDfzAJVJz3UjVKFh4n4P3F1q/hGkrl0=;
        b=CAW50R9RxiaSG7/UXuUmU98qtiDGYkO476cBdVrkc98XNIzOEGNupVBpK0wFYdiYI6
         vOsFKQJio4Qlp8r5O3HI3aYPpWfHmblV+OfLxLs9fFPcY3GOShx0U4cgA9MmyUK7h3y2
         BxqYTwGhrOHMrBVot4OiOZmFvi4sY+EU/aAmRVF6HwUuMe170/AV03Ce2qHOo1JR/9jU
         K6CBc5/wZQvIHx4p3kQLN+//Oyl33QQD1s2EoII8z6UU5PWQvztX0HxPq2RaQ4xZNFMu
         Kugv4VhN5uBrTvgkk1ZMW3rZP2KaxV/qKk4IwIz/jgB23AkXKTvQEk0ACIKVqbOWmd+6
         Ityg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773399281; x=1774004081;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xz+lAQTHg1ZrCDfzAJVJz3UjVKFh4n4P3F1q/hGkrl0=;
        b=Av6b0HFnZOAp2WiUg31hcEcBhRMp/2sdGJuGyC+9yrAINEMiCby+t9JVY+cVfFmX2H
         F2/at3hPkeE0+ey9HltcJ3tSw5YGs1Si8T2rSHeornC9XQrIpUtCp6cTTlZby0fjRFTH
         qdXxtBxbwYhxVnEuiphmaimLr8hyv/IGiYy5BFcqi3LYhYlbXmFKMKsOwYIaGDCZBbyD
         +xuTfBcr9XFGX/iUlrRNSHV/IwfZuM5k49giENKO1wV4t1MpTBhKbEWL6RV6yk5bLvJf
         1MJR0GC5vzGF9ws60224qQ2NsnzLbdzKcWM9gSPO/Z43JtDXOa+KghzOmCi42luGZrzh
         dQKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQHXTZ+2/XQUOL6pWQ1FovlNruaQhpZvlS14909PpkDlhFHGsVkcUDmWgitqEqStH6bzVe2AA=@lists.linux.dev
X-Gm-Message-State: AOJu0Yy+jaxyYoSllzd2Xrn2WFFwi6DDxjLhIbbVAN9muoMoN4wH9qRg
	YgSE03YxQbTERVWHFi6Ll9CKpl3YpddQIgcF3cpX+lV8P/vz9C+PdG4rrcQf65R3U7U/Gmk0LtS
	ESFl7ZWxpvkgOk8BF0sx5dh7j63jzZvxWgtWoY3Jy0495ID5D56E=
X-Gm-Gg: ATEYQzzlSS8RELZgXgwIm5K7m82Gzg6xyx74gwwbCjoUeaetGYqQ0RFNdh0G1T83RkH
	aRAC+oqbc6PBiphEX5Bm1an7pb7Jpslo6HYtSsrr88GiX9K6poBdbypWw9YRaApJbHCcO7AKIvZ
	njG+ysc/vzPekaRpLMW1HEo/vtyACx4axzC0SsHzOpBrREsgcLSLMlYvBJf0pMkn6BYGqIP98/n
	V3cGgvGIXbb56IoP4qWNn6TkYCgQmozD4Io44KP6E+y75AevItz3S3HIqpn6l69SHJHN5XgYesK
	OyvM01ZjzI+1sNnq25aTKy1UFnmSTFZJ2tC2D/yTxpWoNWQerjhkr3/Bgc3obwckRcyyXYER1kB
	T6A5QTJ/gdaB1q7RBiDSJak/APwlek3r6+llcBx3x04Cz2DdjivjR4G+/Dk+f7C90W3lxOZavqt
	P3mqVe7VNCTNMpFFiGwfJGmDukhP4Yf0lEUXAelHjzVJBicA1WUYwItoKoI6GY6Q==
X-Received: by 2002:a05:600c:4e08:b0:485:3eba:ab96 with SMTP id 5b1f17b1804b1-485566ca967mr41162595e9.3.1773399281346;
        Fri, 13 Mar 2026 03:54:41 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:5172:7646:5893:2ac6? ([2001:67c:2fbc:1:5172:7646:5893:2ac6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe1b22e7sm16933971f8f.16.2026.03.13.03.54.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2026 03:54:40 -0700 (PDT)
Message-ID: <bb8b3433-f8be-4f0a-903a-1c179552658b@openvpn.net>
Date: Fri, 13 Mar 2026 11:54:38 +0100
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/10 net-next v2] drivers: net: drop ipv6_stub usage and
 use direct function calls
To: Fernando Fernandez Mancera <fmancera@suse.de>, netdev@vger.kernel.org
Cc: rbm@suse.com, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>, Zhu Yanjun <zyjzyj2000@gmail.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Boris Pismenny <borisp@nvidia.com>, Ido Schimmel <idosch@nvidia.com>,
 Petr Machata <petrm@nvidia.com>, Simon Horman <horms@kernel.org>,
 Edward Cree <ecree.xilinx@gmail.com>, Pablo Neira Ayuso
 <pablo@netfilter.org>, Harald Welte <laforge@gnumonks.org>,
 Sabrina Dubroca <sd@queasysnail.net>, Oliver Neukum <oliver@neukum.org>,
 David Ahern <dsahern@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Stanislav Yakovlev <stas.yakovlev@gmail.com>,
 Nikolay Aleksandrov <razor@blackwall.org>, Parav Pandit <parav@nvidia.com>,
 Edward Srouji <edwards@nvidia.com>, Vlad Dumitrescu
 <vdumitrescu@nvidia.com>, Kees Cook <kees@kernel.org>,
 Jianbo Liu <jianbol@nvidia.com>, Gal Pressman <gal@nvidia.com>,
 Guillaume Nault <gnault@redhat.com>, Cosmin Ratiu <cratiu@nvidia.com>,
 Carolina Jubran <cjubran@nvidia.com>, Alexandre Cassen
 <acassen@corp.free.fr>, Stanislav Fomichev <sdf@fomichev.me>,
 "open list:INFINIBAND SUBSYSTEM" <linux-rdma@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:NETRONOME ETHERNET DRIVERS" <oss-drivers@corigine.com>,
 "open list:SFC NETWORK DRIVER" <linux-net-drivers@amd.com>,
 "open list:GTP (GPRS Tunneling Protocol)"
 <osmocom-net-gprs@lists.osmocom.org>,
 "open list:USB CDC ETHERNET DRIVER" <linux-usb@vger.kernel.org>,
 "open list:WIREGUARD SECURE NETWORK TUNNEL" <wireguard@lists.zx2c4.com>,
 "open list:INTEL PRO/WIRELESS 2100, 2200BG, 2915ABG NETWOR..."
 <linux-wireless@vger.kernel.org>,
 "open list:ETHERNET BRIDGE" <bridge@lists.linux.dev>
References: <20260310153506.5181-1-fmancera@suse.de>
 <20260310153506.5181-6-fmancera@suse.de>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 xsFNBFN3k+ABEADEvXdJZVUfqxGOKByfkExNpKzFzAwHYjhOb3MTlzSLlVKLRIHxe/Etj13I
 X6tcViNYiIiJxmeHAH7FUj/yAISW56lynAEt7OdkGpZf3HGXRQz1Xi0PWuUINa4QW+ipaKmv
 voR4b1wZQ9cZ787KLmu10VF1duHW/IewDx9GUQIzChqQVI3lSHRCo90Z/NQ75ZL/rbR3UHB+
 EWLIh8Lz1cdE47VaVyX6f0yr3Itx0ZuyIWPrctlHwV5bUdA4JnyY3QvJh4yJPYh9I69HZWsj
 qplU2WxEfM6+OlaM9iKOUhVxjpkFXheD57EGdVkuG0YhizVF4p9MKGB42D70pfS3EiYdTaKf
 WzbiFUunOHLJ4hyAi75d4ugxU02DsUjw/0t0kfHtj2V0x1169Hp/NTW1jkqgPWtIsjn+dkde
 dG9mXk5QrvbpihgpcmNbtloSdkRZ02lsxkUzpG8U64X8WK6LuRz7BZ7p5t/WzaR/hCdOiQCG
 RNup2UTNDrZpWxpwadXMnJsyJcVX4BAKaWGsm5IQyXXBUdguHVa7To/JIBlhjlKackKWoBnI
 Ojl8VQhVLcD551iJ61w4aQH6bHxdTjz65MT2OrW/mFZbtIwWSeif6axrYpVCyERIDEKrX5AV
 rOmGEaUGsCd16FueoaM2Hf96BH3SI3/q2w+g058RedLOZVZtyQARAQABzSdBbnRvbmlvIFF1
 YXJ0dWxsaSA8YW50b25pb0BvcGVudnBuLm5ldD7Cwa0EEwEIAFcCGwMFCwkIBwMFFQoJCAsF
 FgIDAQACHgECF4AYGGhrcHM6Ly9rZXlzLm9wZW5wZ3Aub3JnFiEEyr2hKCAXwmchmIXHSPDM
 to9Z0UwFAmj3PEoFCShLq0sACgkQSPDMto9Z0Uw7/BAAtMIP/wzpiYn+Di0TWwNAEqDUcGnv
 JQ0CrFu8WzdtNo1TvEh5oqSLyO0xWaiGeDcC5bQOAAumN+0Aa8NPqhCH5O0eKslzP69cz247
 4Yfx/lpNejqDaeu0Gh3kybbT84M+yFJWwbjeT9zPwfSDyoyDfBHbSb46FGoTqXR+YBp9t/CV
 MuXryL/vn+RmH/R8+s1T/wF2cXpQr3uXuV3e0ccKw33CugxQJsS4pqbaCmYKilLmwNBSHNrD
 77BnGkml15Hd6XFFvbmxIAJVnH9ZceLln1DpjVvg5pg4BRPeWiZwf5/7UwOw+tksSIoNllUH
 4z/VgsIcRw/5QyjVpUQLPY5kdr57ywieSh0agJ160fP8s/okUqqn6UQV5fE8/HBIloIbf7yW
 LDE5mYqmcxDzTUqdstKZzIi91QRVLgXgoi7WOeLF2WjITCWd1YcrmX/SEPnOWkK0oNr5ykb0
 4XuLLzK9l9MzFkwTOwOWiQNFcxXZ9CdW2sC7G+uxhQ+x8AQW+WoLkKJF2vbREMjLqctPU1A4
 557A9xZBI2xg0xWVaaOWr4eyd4vpfKY3VFlxLT7zMy/IKtsm6N01ekXwui1Zb9oWtsP3OaRx
 gZ5bmW8qwhk5XnNgbSfjehOO7EphsyCBgKkQZtjFyQqQZaDdQ+GTo1t6xnfBB6/TwS7pNpf2
 ZvLulFbOOARoRsrsEgorBgEEAZdVAQUBAQdAyD3gsxqcxX256G9lLJ+NFhi7BQpchUat6mSA
 Pb+1yCQDAQgHwsF8BBgBCAAmFiEEyr2hKCAXwmchmIXHSPDMto9Z0UwFAmhGyuwCGwwFCQHh
 M4AACgkQSPDMto9Z0UwymQ//Z1tIZaaJM7CH8npDlnbzrI938cE0Ry5acrw2EWd0aGGUaW+L
 +lu6N1kTOVZiU6rnkjib+9FXwW1LhAUiLYYn2OlVpVT1kBSniR00L3oE62UpFgZbD3hr5S/i
 o4+ZB8fffAfD6llKxbRWNED9UrfiVh02EgYYS2Jmy+V4BT8+KJGyxNFv0LFSJjwb8zQZ5vVZ
 5FPYsSQ5JQdAzYNmA99cbLlNpyHbzbHr2bXr4t8b/ri04Swn+Kzpo+811W/rkq/mI1v+yM/6
 o7+0586l1MQ9m0LMj6vLXrBDN0ioGa1/97GhP8LtLE4Hlh+S8jPSDn+8BkSB4+4IpijQKtrA
 qVTaiP4v3Y6faqJArPch5FHKgu+rn7bMqoipKjVzKGUXroGoUHwjzeaOnnnwYMvkDIwHiAW6
 XgzE5ZREn2ffEsSnVPzA4QkjP+QX/5RZoH1983gb7eOXbP/KQhiH6SO1UBAmgPKSKQGRAYYt
 cJX1bHWYQHTtefBGoKrbkzksL5ZvTdNRcC44/Z5u4yhNmAsq4K6wDQu0JbADv69J56jPaCM+
 gg9NWuSR3XNVOui/0JRVx4qd3SnsnwsuF5xy+fD0ocYBLuksVmHa4FsJq9113Or2fM+10t1m
 yBIZwIDEBLu9zxGUYLenla/gHde+UnSs+mycN0sya9ahOBTG/57k7w/aQLc=
Organization: OpenVPN Inc.
In-Reply-To: <20260310153506.5181-6-fmancera@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/03/2026 16:34, Fernando Fernandez Mancera wrote:
> diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
> index 3716a1d82801..6dd11c71204b 100644
> --- a/drivers/net/ovpn/peer.c
> +++ b/drivers/net/ovpn/peer.c
> @@ -821,8 +821,7 @@ static struct in6_addr ovpn_nexthop_from_rt6(struct ovpn_priv *ovpn,
>   		.daddr = dest,
>   	};
>   
> -	entry = ipv6_stub->ipv6_dst_lookup_flow(dev_net(ovpn->dev), NULL, &fl,
> -						NULL);
> +	entry = ip6_dst_lookup_flow(dev_net(ovpn->dev), NULL, &fl, NULL);
>   	if (IS_ERR(entry)) {
>   		net_dbg_ratelimited("%s: no route to host %pI6c\n",
>   				    netdev_name(ovpn->dev), &dest);
> diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
> index 272b535ecaad..059e896b4a2f 100644
> --- a/drivers/net/ovpn/udp.c
> +++ b/drivers/net/ovpn/udp.c
> @@ -14,7 +14,6 @@
>   #include <net/addrconf.h>
>   #include <net/dst_cache.h>
>   #include <net/route.h>
> -#include <net/ipv6_stubs.h>
>   #include <net/transp_v6.h>
>   #include <net/udp.h>
>   #include <net/udp_tunnel.h>
> @@ -251,7 +250,7 @@ static int ovpn_udp6_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
>   		dst_cache_reset(cache);
>   	}
>   
> -	dst = ipv6_stub->ipv6_dst_lookup_flow(sock_net(sk), sk, &fl, NULL);
> +	dst = ip6_dst_lookup_flow(sock_net(sk), sk, &fl, NULL);
>   	if (IS_ERR(dst)) {
>   		ret = PTR_ERR(dst);
>   		net_dbg_ratelimited("%s: no route to host %pISpc: %d\n",

For ovpn:

Reviewed-by: Antonio Quartulli <antonio@openvpn.net>

Regards,

-- 
Antonio Quartulli
OpenVPN Inc.

