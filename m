Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793095375;
	b=aLr63dzd74URnlCts7KQ9XTK0DUmH/9vKhkPBmhdw5JUSTdqHv74daDoHTCWNGH5E4iN
	 l+QWlFRbL0pZMy3Hu3bcJpy8kwhkdQBL6MvOW+4+vY3K3vmiSJ2L9Uj24AKbbuiN3/7l6
	 TK/iYv3xX2NHLm//WvPgmnnmUNOvZUUWsiy8tLK6aLswLdUoVwhOazYLk6Ll+2S1ydMjn
	 KKYkdOYNe7Stfa7FlRct87fJg9GpaCLzloOZv519Ys9jzepwsdwL9bjE108jyo3efrX84
	 M3Dn/H0pIoK6tMOcNfSpZ65hIkt1EP72LMG6s1riQZJc3OgO3sANj+UxCzw45nB5TUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793095375;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:Content-Language:To:Cc:References:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=Q9lVN24nJh91Od/QYZ2Ns5Zk2L2QYYH7vXm1pHzeCnk=;
	b=kRyAxxE6NI97JYxiujTFDUSOijqUKVJr4GB4mEXqnFUO7BaB7OItMd2IbFSW9sR7cgio
	 vzB6e2ZR/g/cUTLuzO930gBVAcZTiwx4T1Xqzo7hofyV5iFKYhIuVibL/CPDNeZzyUP/u
	 lwaGW9JmAvGHTJV3vQ9EqC+xjF3c7ISTHTwy0LNsFlCgWo6dLXWg9J6uOSDV7T+oal57Q
	 vRhlN+1O8oah0Usa6uiDVZWZKKASan1hgB7KFvFedKK4ryDhJbOMhMASUBQHUQi+OIy7G
	 paA4FqxbmStYho/G2SyRk6qOu/7F3JpjKRFn/neOw3BGebio+nsfr4dlhlyRa5RGunQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=blackwall.org;
	spf=none smtp.mailfrom=blackwall.org;
	dkim=pass header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=SFNOiIvm;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C993606A31D
	for <bridge@lists.linux.dev>; Tue, 27 Oct 2026 10:02:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C993606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=SFNOiIvm
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a35d5d4a20so27758865e9.2
        for <bridge@lists.linux.dev>; Tue, 27 Oct 2026 03:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1793095373; x=1793700173; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q9lVN24nJh91Od/QYZ2Ns5Zk2L2QYYH7vXm1pHzeCnk=;
        b=SFNOiIvmyy+3GlQmhQY6pwAyTx+zadbzdvdua1D0t/pdG65Dvyx43m50TI3ODcM6wx
         0fJj/LxRhWP+DMa960KyxT+DuCFTrgd//HF/LeNIH5/Z54PTR2hLbMcz0suppGvfP+ZS
         FdxTwPWZZZ/Yv66X6T5CXfuMZ0ApmVGKn8hbhC/gPeeB4juPPuJzVpE0lfciuPWPoGOp
         /YB5zplzF9GFOysw1TpdapOsTRzJu3OA7mN4+CdH3cpjoRORqYQZkQpqqPSroHMUdUqT
         Z6l+PQdB8S2L0JUpGGDwJjKZ7+MoMrLappZY6HPSyOs5mGvnTFGt66PIm6yOdtlSeXu1
         tjtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793095373; x=1793700173;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q9lVN24nJh91Od/QYZ2Ns5Zk2L2QYYH7vXm1pHzeCnk=;
        b=VTyuN94vobk6l7fbPxCzPbhSWJ4MSgHdKJRCnxTbzSh/Dbr5BddkfE4VhHLCEPgo5Q
         CrS+D5jc8v7sUAkbVLe/qzCtyclCPI/5glg5GQtAJGF0/btBKSAh9l8kXSyvYwVjv1JN
         mcv9jgzikQwYvtnBhN30POObZTxFckVRGIlTzkkTOHmlDFVGJC89EtdqAlwZ3fcvPSKN
         WQxkOcryno+wIuUZqg/uVt64a738LrY6W2ozQG5QX1Gw6/3lMhtdJpGy716q/mKwMbX5
         Slyh4jPhTxmJdCXVgo+mwZij5kVeyvPEYO4plIzfHG0xbICcul2GaXz4ha0JTbcqKtK0
         UprQ==
X-Gm-Message-State: AFq9FYKgq87fpd9QRp9116/aFG0vKg1qfeh9fJ/XNxXrFDjFRCAe64se
	sL/QyH60CgCK725MYZM4jDrVdt/ZGJJjqVhMx57ly8MTYoo/PYACnF97h6AEZRCuuI0=
X-Gm-Gg: AYBFou1Sy6cYTrtRA+GyGlM5cAnbAJbGJEDueggleD2gT8jvIzTq5hpwiBDUkX/E4Uq
	sL/YgOJBInp2KreOLb7e00vDRlhbofw7bDEdwGqglodb/CGYm5uRk+bzTrGSmjfaDOZPs7MvCeE
	C7J8Wx9jMgUggRlnOj0NKMkpSUw1xh2HAVLGz0y/NoBVJOipTXxatypS1WPkw7+LIPaPY7WNH/I
	h+65DC4cJPhJnTGmAYgSBSuDAVZaKlzXNnaaIDpA7TDeJuJVUpy44RWfUmKXe1fnQiM8n+3O5NE
	0hU5TdjFab9sEDMN8AR23CD1wBuc2X5fjARbRwptZe3prRC3OQAQBxCAtqyc1hSOOVL8MEOHY7e
	8x/q9ZKoxWig9/tVj5ncR/1PmG1ny8ETKS/PtJErJ4XGh2MmoNj1XqocilLwj+9Iwm601Q5THNR
	w0IaHbKk5kWGz3pry8QcUuqUA+y1tu2+KcC7il3TzCTRjUwZ5myaEJa85knvXEfG2WXjntIB1jN
	vHXI3lUJlebYdy7CJWR5PCu78DwACqyDkr5m71P+YVbnXy6UWgDRKz2u2nkBce+FoIRlbKWTUb3
	3+yvpDPJ3Q2vo0OJRSbKvOh+yUk7lnE=
X-Received: by 2002:a05:600d:82c5:b0:4a5:75d2:c104 with SMTP id 5b1f17b1804b1-4a7ca0f7e06mr41589645e9.22.1793095372108;
        Tue, 27 Oct 2026 03:02:52 -0700 (PDT)
Received: from [192.168.0.161] (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a0aa0bcsm318071495e9.4.2026.10.27.03.02.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 03:02:51 -0700 (PDT)
Message-ID: <2774953b-daa3-4f24-8515-906b691bf5c1@blackwall.org>
Date: Tue, 27 Oct 2026 12:02:50 +0200
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Post: <mailto:bridge@lists.linux.dev>
List-Help: <mailto:bridge+help@lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
List-Owner: <mailto:bridge+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: bridge: netlink: do not clear the vlan info dump
 error
Content-Language: en-US, bg
To: Linkui Xiao <xiaolinkui@126.com>, idosch@nvidia.com, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Cc: bridge@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Linkui Xiao <xiaolinkui@kylinos.cn>
References: <20261027085200.1501599-1-xiaolinkui@126.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20261027085200.1501599-1-xiaolinkui@126.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/10/2026 10:52, Linkui Xiao wrote:
> From: Linkui Xiao <xiaolinkui@kylinos.cn>
> 
> br_fill_ifinfo() assigns the result of br_fill_vlan_tunnel_info() over
> the result of br_fill_ifvlaninfo() or br_fill_ifvlaninfo_compressed()
> instead of only running the second helper when the first one succeeded.
> 
> When the vlan information no longer fits in the skb but the port has no
> vlan mapped to a tunnel dst, br_fill_vlan_tunnel_info() walks the vlan
> list and returns 0 without touching the skb. The -EMSGSIZE is lost,
> br_fill_ifinfo() completes a message whose IFLA_AF_SPEC is truncated,
> and the dump carries on to the next interface instead of stopping, so
> userspace silently sees an incomplete vlan list.
> 
> Only fill the tunnel information when the vlan information was filled
> successfully.
> 
> This was flagged as a pre-existing issue in the Sashiko review of the
> net-next series, which noted that the VLAN fill result is overwritten
> before it is tested (see the Link tag below).
> 
> Fixes: efa5356b0d97 ("bridge: per vlan dst_metadata netlink support")
> Link: https://lore.kernel.org/bridge/ed1de95e-e112-4076-93f0-6f7668e657ad@blackwall.org/T/#u#5
> Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
> ---
>   net/bridge/br_netlink.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
> index b2cd4e39326d..8ed86bf71a00 100644
> --- a/net/bridge/br_netlink.c
> +++ b/net/bridge/br_netlink.c
> @@ -540,7 +540,7 @@ static int br_fill_ifinfo(struct sk_buff *skb,
>   		else
>   			err = br_fill_ifvlaninfo(skb, vg);
>   
> -		if (port && test_bit(BR_VLAN_TUNNEL_BIT, &port->flags))
> +		if (!err && port && test_bit(BR_VLAN_TUNNEL_BIT, &port->flags))
>   			err = br_fill_vlan_tunnel_info(skb, vg);
>   		rcu_read_unlock();
>   		if (err)

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
