Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F6E20468E
	for <bridge@lists.linux.dev>; Fri, 20 Dec 2024 12:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734697674; cv=none; b=OihdraVL9NG8AM8eF/D9iU+RtkQO71Au5nZDlKy9Hjf/op6kmvjC+pKoaRTBDhVYN8UphHXHKBIae5qkMfLm7JU2weuwwLefAGhyobkp3bSo5iZ9nLe+N4Qt7vnJvE4NHYq2dSZ+vyzRBaK5NcEqMFYD9RzeWhe2MQHd6zks3Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734697674; c=relaxed/simple;
	bh=UyKAbgsSEXUWiOLE9p5qmzCi0/kmAl2PwW1U+D/X3MY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YzNQwhMvVwzeRUGth7zrpRZvKq84VomDT7sAP1+nF9UllfGHGZcIJAGbEjjoz1oJHGYPM5eoXENo+AIkSCNwtzI2BoxgO6V3gSgkp13dDDhcREEBb2hUJjKS3vP/QEIGi63IJ0QnTw8d/BPZdJgCZ1Y/W+u1WyNd3qdCZXsyW2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=M4Fh8U/K; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="M4Fh8U/K"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4361d5dcf5bso19958155e9.3
        for <bridge@lists.linux.dev>; Fri, 20 Dec 2024 04:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1734697671; x=1735302471; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2n0pTYd3GnP9ybgNvOAYflbV+iXtau5YHCxFN+NO/bA=;
        b=M4Fh8U/KmLiMmog++70fLzwbwatwasn+OwML+L/xwYrOvJWMWxvSOp6Yb7OOgot24H
         DQk/2MSpJ7VK7OTtbKcq9eXyYmBYssaZ4FEiJJs3XmYDtOartGkszjE8C+b8k6ixKQAk
         nyC7WXSTCQ86HoB6u869+LAKpOVkUCZBek6AuGrCcOJ3BxHgVvwGtpLlQ0G1OrcPJ97P
         jIEw3p6INUCtGhBohCTh+AuO+Kafdpqt85gr2+eIlWwnDrBTfHIj4USRhGsOeJk/TMKX
         9/TECQfR7iDiKikcBw0g5eJ9haIPHZ/JCtKWsVzkodzXuYQDDgw5QKb6I1NuV7DYvUmZ
         bZuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734697671; x=1735302471;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2n0pTYd3GnP9ybgNvOAYflbV+iXtau5YHCxFN+NO/bA=;
        b=CvqotPt2wB7GhZ1JAdLa8xLIw+OUiV4jSIzAAEU6cws/W5Ze/RAQ4o1f4Qul4j4lb0
         c7yG5SLq5o5mwZgeeBQoZGRbjEAcnd/m+jHyXUchfrHS0v9fFUWs0jS1HRwOOCZOMPZq
         3QRiyLJnlzAMuuLtYrmhW1BlckqNAoSxN/+JEsMMZKdUgoEbzi4owsbjSgeW4vmvjdE+
         bBBqfaVAlxHuRKxRcfL73zR0vWxH5bsaUV27IKc6zo+e71+dLvsjAB1Y9XPlJSYLfCrr
         4dJyG4fGFix0ToJ7JRN2h8wVWSAJPXKi8LHIxl7iWKi9oCmWBion02dO726UJnSO+RQf
         F1Mw==
X-Forwarded-Encrypted: i=1; AJvYcCU7Ml7lEEWY9UIs2LJnJWdwCiCSQH1JWmpW4N3EsellHGRx+qUSMovo7HhrhBg7pd9ASyhAJJQ=@lists.linux.dev
X-Gm-Message-State: AOJu0YxwLip4zsTDWFgn+jAGZ0k9RCT7PcvJBRZqOa6LnAbcs74qfaZG
	w1peWlpSgpJG4fV/jnPdvNfWICWiUb6K5DiTQUWm8j2dWmFeuLAVdTS0DYCW/0w=
X-Gm-Gg: ASbGncsfgx0KVHRUaMvyHBea+Qjknh2X28tNPCGegnFyfMf+CcLgCnC5i87xRuwfET0
	Ccq+jSnou8ms1aFZRYCGdMsErYv360xIIgeGvMdMD++fbHz5qDZ6GkgQvEz3FzWo9oDfj/OIY3g
	NmEENsTmke3T3tfVkZ05UGcSL46cGrlACfnDgo/h0x6ZPDai2yt5YQtMNEekTIysJ8QY1Jl2kXE
	JrT7fJOao5DT7ftXnZ6fJEkTcg4bKHR7/MMFj4dRzxwU9QZJjiVBXjimfrI0POR02wUn1nFVU9h
	QNkXyKy6gUKe
X-Google-Smtp-Source: AGHT+IE+Gos9bSZ9a7k/LJ5d7kDZCo5p5Bf0vZDa14+GVao/OEtbGoJLXS2vEiRRJOggbUXAgy3Htw==
X-Received: by 2002:a05:600c:4f0d:b0:432:cbe5:4f09 with SMTP id 5b1f17b1804b1-43671247b46mr2269625e9.4.1734697671238;
        Fri, 20 Dec 2024 04:27:51 -0800 (PST)
Received: from [192.168.0.123] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c84ca21sm3977909f8f.63.2024.12.20.04.27.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2024 04:27:50 -0800 (PST)
Message-ID: <86bd1ecf-e7ea-4abb-869a-2fe6fdadcc13@blackwall.org>
Date: Fri, 20 Dec 2024 14:27:49 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/4] net: bridge: Handle changes in
 VLAN_FLAG_BRIDGE_BINDING
To: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>, Roopa Prabhu <roopa@nvidia.com>,
 bridge@lists.linux.dev, Ido Schimmel <idosch@nvidia.com>, mlxsw@nvidia.com
References: <cover.1734540770.git.petrm@nvidia.com>
 <90a8ca8aea4d81378b29d75d9e562433e0d5c7ff.1734540770.git.petrm@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <90a8ca8aea4d81378b29d75d9e562433e0d5c7ff.1734540770.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/18/24 19:15, Petr Machata wrote:
> When bridge binding is enabled on a VLAN netdevice, its link state should
> track bridge ports that are members of the corresponding VLAN. This works
> for newly-added netdevices. However toggling the option does not have the
> effect of enabling or disabling the behavior as appropriate.
> 
> In this patch, react to bridge_binding toggles on VLAN uppers.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  net/bridge/br.c         |  7 +++++++
>  net/bridge/br_private.h |  9 +++++++++
>  net/bridge/br_vlan.c    | 24 ++++++++++++++++++++++++
>  3 files changed, 40 insertions(+)
> 
> diff --git a/net/bridge/br.c b/net/bridge/br.c
> index 2cab878e0a39..183fcb362f9e 100644
> --- a/net/bridge/br.c
> +++ b/net/bridge/br.c
> @@ -51,6 +51,13 @@ static int br_device_event(struct notifier_block *unused, unsigned long event, v
>  		}
>  	}
>  
> +	if (is_vlan_dev(dev)) {
> +		struct net_device *real_dev = vlan_dev_real_dev(dev);
> +
> +		if (netif_is_bridge_master(real_dev))
> +			br_vlan_vlan_upper_event(real_dev, dev, event);
> +	}
> +
>  	/* not a port of a bridge */
>  	p = br_port_get_rtnl(dev);
>  	if (!p)
> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
> index 9853cfbb9d14..29d6ec45cf41 100644
> --- a/net/bridge/br_private.h
> +++ b/net/bridge/br_private.h
> @@ -1571,6 +1571,9 @@ void br_vlan_get_stats(const struct net_bridge_vlan *v,
>  void br_vlan_port_event(struct net_bridge_port *p, unsigned long event);
>  int br_vlan_bridge_event(struct net_device *dev, unsigned long event,
>  			 void *ptr);
> +void br_vlan_vlan_upper_event(struct net_device *br_dev,
> +			      struct net_device *vlan_dev,
> +			      unsigned long event);
>  int br_vlan_rtnl_init(void);
>  void br_vlan_rtnl_uninit(void);
>  void br_vlan_notify(const struct net_bridge *br,
> @@ -1802,6 +1805,12 @@ static inline int br_vlan_bridge_event(struct net_device *dev,
>  	return 0;
>  }
>  
> +static inline void br_vlan_vlan_upper_event(struct net_device *br_dev,
> +					    struct net_device *vlan_dev,
> +					    unsigned long event)
> +{
> +}
> +
>  static inline int br_vlan_rtnl_init(void)
>  {
>  	return 0;
> diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
> index b728b71e693f..d9a69ec9affe 100644
> --- a/net/bridge/br_vlan.c
> +++ b/net/bridge/br_vlan.c
> @@ -1772,6 +1772,30 @@ int br_vlan_bridge_event(struct net_device *dev, unsigned long event, void *ptr)
>  	return ret;
>  }
>  
> +void br_vlan_vlan_upper_event(struct net_device *br_dev,
> +			      struct net_device *vlan_dev,
> +			      unsigned long event)
> +{
> +	struct vlan_dev_priv *vlan = vlan_dev_priv(vlan_dev);
> +	struct net_bridge *br = netdev_priv(br_dev);
> +	bool bridge_binding;
> +
> +	switch (event) {
> +	case NETDEV_CHANGE:
> +	case NETDEV_UP:
> +		break;
> +	default:
> +		return;
> +	}
> +
> +	bridge_binding = vlan->flags & VLAN_FLAG_BRIDGE_BINDING;
> +	br_vlan_toggle_bridge_binding(br_dev, bridge_binding);
> +	if (bridge_binding)
> +		br_vlan_set_vlan_dev_state(br, vlan_dev);
> +	else if (!bridge_binding && netif_carrier_ok(br_dev))
> +		netif_carrier_on(vlan_dev);
> +}
> +
>  /* Must be protected by RTNL. */
>  void br_vlan_port_event(struct net_bridge_port *p, unsigned long event)
>  {

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

