Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31061EC009
	for <bridge@lists.linux.dev>; Fri, 21 Mar 2025 08:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742545188; cv=none; b=IJOeytJfiJ/TVOcQX9hcD5IThAhUTLIgBWytHmJj/mp/ed+AMq6XiB09hT3lJqHuP+MawfL4WYyupzHuLoMt5HJfebGsSR6iyJZubAxmMAHzKsbbw9NKtttjruKMi4NLpJkQAClwNo3BkJ1L+Ull+vtLSDvbeT4RgtGxQSy8JYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742545188; c=relaxed/simple;
	bh=nBV0rhKS0xwWV81nt7VVhHciBFvCdsWmzY+TP+fKKGg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ytzvb2aAIMMjudP1AnIDtvIKJ5ZynytERWZpK2e6LG3ECjbwHMHDI6rX3/WaxJVWTo3YtQ6cLJEK5uwPZYeSJ1TWw+fp0J8tFqLvvGJdyFWZGoXhPllZrQ2BOEAd3n8LXHO+LitH6NgbabyJCRQhYp845PPRtHmH38kW5AJuVTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=IMR7XOWz; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="IMR7XOWz"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-39141ffa9fcso1502443f8f.0
        for <bridge@lists.linux.dev>; Fri, 21 Mar 2025 01:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1742545184; x=1743149984; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S1AzRi6eHoS6ZWFDX/LO1TVYvjTJRBljJTiN5ZXvzYc=;
        b=IMR7XOWzsfTuHAZFfoEU3+m8paeJZbqGH5NOZqS/LSHV1M7rjjnYLIqjmJF1655W5g
         twmYw2+XaNIOgRZymZXJYOscFWEFcViHE959HS7kn6yXeWILSHwg7AbTwGikgovxARyH
         gwme5B1gPgHdXN4eM9bmZjx4nJQqVUQkbB7V5U3xQv7GZkV0tg0Bkd3VG44UbdsB+ypG
         qxw30kqHIxbMw4LXRFwJo0+dwXAzq3qwHn8Hm0nptGzwyJ8nzIPt0oGbitWd724xQkaM
         3AOT3vxZskcj/WL4VAsdXoM5aVDRMBKZw8RHd7EUSD/yErlHT+zXJzCOhZeE/bHXet06
         EoRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742545184; x=1743149984;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S1AzRi6eHoS6ZWFDX/LO1TVYvjTJRBljJTiN5ZXvzYc=;
        b=ligKs3+C7OxqLBGWTYynGi7P5xLxzCeN8A7/m5hYGUopt5d4CwIT5gXqAqbNqJveGW
         yIkHG7SqCIb4edOOKifIBvXZU1m1VzAUsqbxXdxvT+VVNbLhymqE7sw4NVqizKPYDKT5
         hikGKJopcC+OthRp4prAsUhkG5+PMRcbIKa3aZj+BBxee6BePLeMU/+wzX6t+RW9avhZ
         XQ4s4mnjI1S30JtUwplkyKjWKsXCd6N7cl08L70+Lu6v3dGRYvAUiZ9RrkZ5YKfO8NMt
         RQPWvbgJ+b0GaFDiZ6tYm8PGn1GDsRP8C+2B1SdN5AMTKDcZKmrjvypyT4l1KsE0usRK
         1o4A==
X-Forwarded-Encrypted: i=1; AJvYcCXMDpQURX8IxGY5H0NExF7/DsjHAFyBsVuDDaBtxxGnHtAOkEcAnHAVM2/P2RzCu++22xtpQvI=@lists.linux.dev
X-Gm-Message-State: AOJu0Yz8SJyj9bZ2ofAvuyJ0WskjOg/HfVsCT/UN/BMplXb/UdBS7+Hm
	z6f03wX/CDjOt1viI7EoiAy2LXeuivCiNYKpfsD/tW6ikzjX0CSdjrg+5xJmedE=
X-Gm-Gg: ASbGncutJiQpFbbwDM0yZygjYwDUqEvx7Fs009VPenR4jQw/8mb3VC7T+Jr8CWPwb33
	EUuYEhHA056skKk2O+daiLQWhGEBz2EVGAeOcLPHgnIwadbAu9FCbzK9K191HzLQQm17ofPa+sz
	EqYi5+Iz2vgW2lFaoK6TmlpeOFFNo2yenIuOcVVL9FVUA2hZ7PYQQ1dnKJfS7y5e82hgPePxoxx
	3KWcOrdekaNvSSu9qtrnJBTsfnDkMQgV1QHc03v04TaZ6ZT8jQ62u19+1Xegq4yYzBpkCXpjIib
	P+OhfwzUyPQlDif08pTxU/vpL67kkWEHauTxPW7oAZVE0VgL/o0lti+u5xSZBsk1fcvs6GfuVU+
	F
X-Google-Smtp-Source: AGHT+IE0vn5XmRw18AJGFhtJXtjIWLR4HgtKdHsBoT+HKQO/7WMl2yfPtRbZKEhKlsvQrsE1URNu0A==
X-Received: by 2002:a05:6000:1a87:b0:391:23e6:f08c with SMTP id ffacd0b85a97d-3997f941973mr2350929f8f.47.1742545183874;
        Fri, 21 Mar 2025 01:19:43 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43f43ed6sm70133835e9.13.2025.03.21.01.19.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Mar 2025 01:19:43 -0700 (PDT)
Message-ID: <c90151bc-a529-4f4e-a0b9-5831a6b803f7@blackwall.org>
Date: Fri, 21 Mar 2025 10:19:42 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch net-next 1/3] net: bridge: mcast: Add offload failed mdb
 flag
To: Joseph Huang <Joseph.Huang@garmin.com>, netdev@vger.kernel.org
Cc: Joseph Huang <joseph.huang.2024@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Roopa Prabhu <roopa@nvidia.com>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, bridge@lists.linux.dev
References: <20250318224255.143683-1-Joseph.Huang@garmin.com>
 <20250318224255.143683-2-Joseph.Huang@garmin.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250318224255.143683-2-Joseph.Huang@garmin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/19/25 00:42, Joseph Huang wrote:
> Add MDB_FLAGS_OFFLOAD_FAILED and MDB_PG_FLAGS_OFFLOAD_FAILED to indicate
> that an attempt to offload the MDB entry to switchdev has failed.
> 
> Signed-off-by: Joseph Huang <Joseph.Huang@garmin.com>
> ---
>  include/uapi/linux/if_bridge.h |  9 +++++----
>  net/bridge/br_mdb.c            |  2 ++
>  net/bridge/br_private.h        | 11 ++++++-----
>  net/bridge/br_switchdev.c      | 10 +++++-----
>  4 files changed, 18 insertions(+), 14 deletions(-)
> 
> diff --git a/include/uapi/linux/if_bridge.h b/include/uapi/linux/if_bridge.h
> index a5b743a2f775..f2a6de424f3f 100644
> --- a/include/uapi/linux/if_bridge.h
> +++ b/include/uapi/linux/if_bridge.h
> @@ -699,10 +699,11 @@ struct br_mdb_entry {
>  #define MDB_TEMPORARY 0
>  #define MDB_PERMANENT 1
>  	__u8 state;
> -#define MDB_FLAGS_OFFLOAD	(1 << 0)
> -#define MDB_FLAGS_FAST_LEAVE	(1 << 1)
> -#define MDB_FLAGS_STAR_EXCL	(1 << 2)
> -#define MDB_FLAGS_BLOCKED	(1 << 3)
> +#define MDB_FLAGS_OFFLOAD		(1 << 0)
> +#define MDB_FLAGS_FAST_LEAVE		(1 << 1)
> +#define MDB_FLAGS_STAR_EXCL		(1 << 2)
> +#define MDB_FLAGS_BLOCKED		(1 << 3)
> +#define MDB_FLAGS_OFFLOAD_FAILED	(1 << 4)
>  	__u8 flags;
>  	__u16 vid;
>  	struct {
> diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
> index 1a52a0bca086..0639691cd19b 100644
> --- a/net/bridge/br_mdb.c
> +++ b/net/bridge/br_mdb.c
> @@ -144,6 +144,8 @@ static void __mdb_entry_fill_flags(struct br_mdb_entry *e, unsigned char flags)
>  		e->flags |= MDB_FLAGS_STAR_EXCL;
>  	if (flags & MDB_PG_FLAGS_BLOCKED)
>  		e->flags |= MDB_FLAGS_BLOCKED;
> +	if (flags & MDB_PG_FLAGS_OFFLOAD_FAILED)
> +		e->flags |= MDB_FLAGS_OFFLOAD_FAILED;
>  }
>  
>  static void __mdb_entry_to_br_ip(struct br_mdb_entry *entry, struct br_ip *ip,
> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
> index 1054b8a88edc..cd6b4e91e7d6 100644
> --- a/net/bridge/br_private.h
> +++ b/net/bridge/br_private.h
> @@ -306,11 +306,12 @@ struct net_bridge_fdb_flush_desc {
>  	u16				vlan_id;
>  };
>  
> -#define MDB_PG_FLAGS_PERMANENT	BIT(0)
> -#define MDB_PG_FLAGS_OFFLOAD	BIT(1)
> -#define MDB_PG_FLAGS_FAST_LEAVE	BIT(2)
> -#define MDB_PG_FLAGS_STAR_EXCL	BIT(3)
> -#define MDB_PG_FLAGS_BLOCKED	BIT(4)
> +#define MDB_PG_FLAGS_PERMANENT		BIT(0)
> +#define MDB_PG_FLAGS_OFFLOAD		BIT(1)
> +#define MDB_PG_FLAGS_FAST_LEAVE		BIT(2)
> +#define MDB_PG_FLAGS_STAR_EXCL		BIT(3)
> +#define MDB_PG_FLAGS_BLOCKED		BIT(4)
> +#define MDB_PG_FLAGS_OFFLOAD_FAILED	BIT(5)
>  
>  #define PG_SRC_ENT_LIMIT	32
>  
> diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
> index 7b41ee8740cb..68dccc2ff7b1 100644
> --- a/net/bridge/br_switchdev.c
> +++ b/net/bridge/br_switchdev.c
> @@ -505,9 +505,6 @@ static void br_switchdev_mdb_complete(struct net_device *dev, int err, void *pri
>  	struct net_bridge_port *port = data->port;
>  	struct net_bridge *br = port->br;
>  
> -	if (err)
> -		goto err;
> -
>  	spin_lock_bh(&br->multicast_lock);
>  	mp = br_mdb_ip_get(br, &data->ip);
>  	if (!mp)
> @@ -516,11 +513,14 @@ static void br_switchdev_mdb_complete(struct net_device *dev, int err, void *pri
>  	     pp = &p->next) {
>  		if (p->key.port != port)
>  			continue;
> -		p->flags |= MDB_PG_FLAGS_OFFLOAD;
> +
> +		if (err)
> +			p->flags |= MDB_PG_FLAGS_OFFLOAD_FAILED;
> +		else
> +			p->flags |= MDB_PG_FLAGS_OFFLOAD;

These two should be mutually exclusive, either it's offloaded or it failed an offload,
shouldn't be possible to have both set. I'd recommend adding some helper that takes
care of that.

>  	}
>  out:
>  	spin_unlock_bh(&br->multicast_lock);
> -err:
>  	kfree(priv);
>  }
>  

