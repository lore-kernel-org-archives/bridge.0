Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81ABF20E6EE
	for <bridge@lists.linux.dev>; Thu, 12 Dec 2024 09:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733995677; cv=none; b=bWOZC7e94DvjfGEyBZsxEP99O6DYdfxN0N2CRN3RsnOIIW5OX0nwAr+vOhH+s9FJVMWxQdBzavBhvdWNKDSboVtoNz/PRSZIkdC1CdRP8Vl6dp7ioKYyE4jOChVq/G4umEV/WL/RMQs/6w0WCPX0gr8weJBKgtQs0oT2VtriqmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733995677; c=relaxed/simple;
	bh=b9cdBCl6i8/Pg9BidsE6MaRf0sy/S53LsQhJ0yDDCcE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=To8fdnsfkSbSQB5V74i7SMdt7hjeJqWCXeukneDtt+wAA5GzXIABXZ6jlyixgZNwHY265Xn2Qpr3AzlXWyXP8Te47FsHmVHg55PWtR1mXsFTCm7bcLpfYIb8+v1wQSc12iV7Y3aNCzmItIo0Q7SH6JOm/q+Y1jxeLjw8EPqcY2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c87EtkV6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c87EtkV6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733995673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YQDLEldT18Fc0IWLf1h2y9YzeGe3KbZy7EnSjmgH5Ac=;
	b=c87EtkV6eYaUI8u387TMDiiFfhEPpYXq+7Js0ftv7XrrdVSAewFJozVdeBZipmXtche6+F
	lxsaMfZizWIo4ZpPWuLhJAcFhK37BMzxZ8vXmyeMC+Kvs5pqFJbsmOh13vs0vZxH2kXCWi
	M8Ns+xqwNWwAPX8HuKvFjRktYTnBV9Q=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-_F-OQ4ygOu-OyUBPdHsq1Q-1; Thu, 12 Dec 2024 04:27:52 -0500
X-MC-Unique: _F-OQ4ygOu-OyUBPdHsq1Q-1
X-Mimecast-MFC-AGG-ID: _F-OQ4ygOu-OyUBPdHsq1Q
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-434f387f346so2309935e9.1
        for <bridge@lists.linux.dev>; Thu, 12 Dec 2024 01:27:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733995671; x=1734600471;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YQDLEldT18Fc0IWLf1h2y9YzeGe3KbZy7EnSjmgH5Ac=;
        b=xDXrFAOrxb8HEIt5ifGCG8eVp1MNjTkyd/L3lz1Ki56qNy0eyYZoJZLoZgAQfqtFbf
         DF1BQPD04ydjx/NShnqifWt8NQG39dov1lSEehPVG27wisrFbTPP9tv5Z1oTY96X5oLT
         NaN1aF9FvXOvTdlBkllWIwgtSaaDhuIR5nr07YfUrILgMpUiA/5O31RVb+zAsF4sPLza
         Gj4FZGL5+2q1aToNi4i1YjbWqXFFp92oODdqbcs4BwkxInX5LjFg8uwE67UFq4FzPku/
         8JeOGJXmwGedVxrP6QadhUT7XAd0BYvpBvqn9/oo+g53RwyXJSQci62QZdoerQ8U1a3f
         tayQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPwwm2TqNXWFaCZ7swRzohC4Svs2VhIjue5JaogGYvyzubOdqdKNFH7G8IaApTEFDwEJMeVnU=@lists.linux.dev
X-Gm-Message-State: AOJu0YzHJV2ndo3DNGldF5kPwL9KBIBX4GxQadvbVuc64iyN8mmObKI1
	2WbsnKG/Ee+E4kygdhaqkOwaxl9jtin0lNudvzSu0oVEZRcWMKwweME9UwVNpSPjiFgrkFIt71j
	V4DC4+vcazO5Y6p7e4m7oQ20HLTntEN8JylVIeDJn1+0+kyWziM3ZHg==
X-Gm-Gg: ASbGncur76sPJjXPupXXRqDoph74eGCOnAQZ3w3kxnenRhqONfMLtDlAfOARiodt3kb
	jN2a5EjO7mqqDcyMBOA9Nha0S5AKnECwSfLv7/DZmsXBDHGOH9rEldM34B0QuZX44Dw5I5syeaZ
	8aPkUfz6T/OALN1HCsBlNhX7nR3y10v24K/1xAjrlaKbAjpqpj5L9sZ56cKXahDIFaKDc8iDk4D
	Jv+LmWqTOGLS8fGURYbvS/EitUb1MErSpKaxvEuLDtO+EmW3ZZCMYwMAZ8tGfmZUze+1CPq6pt1
	CFrZmu8=
X-Received: by 2002:a05:600c:548a:b0:434:f609:1afa with SMTP id 5b1f17b1804b1-43622823a9bmr23142075e9.4.1733995671090;
        Thu, 12 Dec 2024 01:27:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGfecq/fvmxWbZmLr9mwKSJq21xM6RVRZ1wSoCEsNQjvNePz0TX5CuMdaiXcW+mTqnLDcuA8w==
X-Received: by 2002:a05:600c:548a:b0:434:f609:1afa with SMTP id 5b1f17b1804b1-43622823a9bmr23141765e9.4.1733995670687;
        Thu, 12 Dec 2024 01:27:50 -0800 (PST)
Received: from [192.168.88.24] (146-241-48-67.dyn.eolo.it. [146.241.48.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436256b42a3sm10746345e9.28.2024.12.12.01.27.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 01:27:50 -0800 (PST)
Message-ID: <2b89667d-ccd6-40b7-b355-1c71e159d14f@redhat.com>
Date: Thu, 12 Dec 2024 10:27:48 +0100
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 3/5] rtnetlink: Decouple net namespaces in
 rtnl_newlink_create()
To: Xiao Liang <shaw.leon@gmail.com>, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>,
 Jakub Kicinski <kuba@kernel.org>, Donald Hunter <donald.hunter@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Ido Schimmel <idosch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Jiri Pirko <jiri@resnulli.us>, Hangbin Liu <liuhangbin@gmail.com>,
 linux-rdma@vger.kernel.org, linux-can@vger.kernel.org,
 osmocom-net-gprs@lists.osmocom.org, bpf@vger.kernel.org,
 linux-ppp@vger.kernel.org, wireguard@lists.zx2c4.com,
 linux-wireless@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org,
 bridge@lists.linux.dev, linux-wpan@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241209140151.231257-1-shaw.leon@gmail.com>
 <20241209140151.231257-4-shaw.leon@gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241209140151.231257-4-shaw.leon@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -ouRUkYYTDPIyIDl4MQr8BGJJcdFh7-QDShOrRAH5gs_1733995671
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/9/24 15:01, Xiao Liang wrote:
> There are 4 net namespaces involved when creating links:
> 
>  - source netns - where the netlink socket resides,
>  - target netns - where to put the device being created,
>  - link netns - netns associated with the device (backend),
>  - peer netns - netns of peer device.
> 
> Currently, two nets are passed to newlink() callback - "src_net"
> parameter and "dev_net" (implicitly in net_device). They are set as
> follows, depending on netlink attributes.
> 
>  +------------+-------------------+---------+---------+
>  | peer netns | IFLA_LINK_NETNSID | src_net | dev_net |
>  +------------+-------------------+---------+---------+
>  |            | absent            | source  | target  |
>  | absent     +-------------------+---------+---------+
>  |            | present           | link    | link    |
>  +------------+-------------------+---------+---------+
>  |            | absent            | peer    | target  |
>  | present    +-------------------+---------+---------+
>  |            | present           | peer    | link    |
>  +------------+-------------------+---------+---------+
> 
> When IFLA_LINK_NETNSID is present, the device is created in link netns
> first. This has some side effects, including extra ifindex allocation,
> ifname validation and link notifications. There's also an extra step to
> move the device to target netns. These could be avoided if we create it
> in target netns at the beginning.
> 
> On the other hand, the meaning of src_net is ambiguous. It varies
> depending on how parameters are passed. It is the effective link or peer
> netns by design, but some drivers ignore it and use dev_net instead.
> 
> This patch refactors netns handling by packing newlink() parameters into
> a struct, and passing source, link and peer netns as is through this
> struct. Fallback logic is implemented in helper functions -
> rtnl_newlink_link_net() and rtnl_newlink_peer_net(). If is not set, peer
> netns falls back to link netns, and link netns falls back to source netns.
> rtnl_newlink_create() now creates devices in target netns directly,
> so dev_net is always target netns.
> 
> For drivers that use dev_net as fallback of link_netns, current behavior
> is kept for compatibility.
> 
> Signed-off-by: Xiao Liang <shaw.leon@gmail.com>

I must admit this patch is way too huge for me to allow any reasonable
review except that this has the potential of breaking a lot of things.

I think you should be splitted to make it more palatable; i.e.
- a patch just add the params struct with no semantic changes.
- a patch making the dev_change_net_namespace() conditional on net !=
tge_net[1]
- many per-device patches creating directly the device in the target
namespace.
- a patch reverting [1]

Other may have different opinions, I'd love to hear them.

> diff --git a/drivers/net/amt.c b/drivers/net/amt.c
> index 98c6205ed19f..2f7bf50e05d2 100644
> --- a/drivers/net/amt.c
> +++ b/drivers/net/amt.c
> @@ -3161,14 +3161,17 @@ static int amt_validate(struct nlattr *tb[], struct nlattr *data[],
>  	return 0;
>  }
>  
> -static int amt_newlink(struct net *net, struct net_device *dev,
> -		       struct nlattr *tb[], struct nlattr *data[],
> -		       struct netlink_ext_ack *extack)
> +static int amt_newlink(struct rtnl_newlink_params *params)
>  {
> +	struct net_device *dev = params->dev;
> +	struct nlattr **tb = params->tb;
> +	struct nlattr **data = params->data;
> +	struct netlink_ext_ack *extack = params->extack;
> +	struct net *link_net = rtnl_newlink_link_net(params);
>  	struct amt_dev *amt = netdev_priv(dev);
>  	int err = -EINVAL;

Minor nit: here and and many other places, please respect the reverse
xmas tree order.

Thanks,

Paolo

