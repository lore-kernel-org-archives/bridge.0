Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9958A134A1
	for <bridge@lists.linux-foundation.org>; Mon, 18 Dec 2023 10:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="JI5vImzR"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 14B9060ACD
	for <bridge@lists.linux-foundation.org>; Mon, 18 Dec 2023 10:08:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 14B9060ACD
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=JI5vImzR
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cKFzTAvxtmqb for <bridge@lists.linux-foundation.org>;
	Mon, 18 Dec 2023 10:08:53 +0000 (UTC)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
	by smtp3.osuosl.org (Postfix) with ESMTPS id AA6B160A5A
	for <bridge@lists.linux-foundation.org>; Mon, 18 Dec 2023 10:08:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AA6B160A5A
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-336641e9cf1so867863f8f.0
        for <bridge@lists.linux-foundation.org>; Mon, 18 Dec 2023 02:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1702894132; x=1703498932; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cgeuubteA4g8KPHC7Y210Emoi+OTT8dlwnrip9u/P0g=;
        b=JI5vImzRc82gXcKHhrUbOhbYXQlxLKg/Em/T1zPNszwgX3ASJSQpv95B/BX/5dNvgf
         9EyjrHChA2YAYxQIjSIhFvzRszC/lKUMgpaFhNUfTsGZCH/hXZCeFcXOz7kFDdkZtW+W
         tSgS1rpkvpu/SDS64TFDI8CCPtGSk6c5Fqog0/xBGRqXTuncNIE9Vf8wmB/QoYM5iJGs
         XYBVqp+qPvwm+8kJr09WIuYIpuKNbToLPQqs9B3pYPNZMU/kflem6QXrOr3tnXgaq1we
         +abbLq2fFWsg6L+lUIrKA61B177kbzKlxfJBVbNeqViUJBlHOpJtYu4YhQSEEGxUb8zp
         yRcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702894132; x=1703498932;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cgeuubteA4g8KPHC7Y210Emoi+OTT8dlwnrip9u/P0g=;
        b=NrGdNKfk+NrX86tl5eb/Vceuyfls4smQwvkv8DXMgGwiGW0DXChuutIzYgOQ4MgX9y
         jQSPJsRQ0LhkhW4XKI3EKbXP8zu6D5huMX180/9jnqMz/O8LdbnJT+YF8Y3UsVJ8EoQ9
         u90xSxQfwRj5cyzhhH/EOcJjVX1J+teEpsOyTAw5fDche8R9gfHlA9qQ4vsuhw1Pswm+
         2fT9rYS+uYEgqCWj7hL56HBgmysQ/6x1QFpuuTAoDjxCEtiMhNlZOjIWRr+Tjjhp+4yB
         YaPKP2mMCnDyeZcmp1LeTnnKhxQS/C9r0FGBVEY8IN8+NQazRQYuYTSQrY5RCbeujmVJ
         Khfw==
X-Gm-Message-State: AOJu0Yx3apGUU333E1ZsVFm1+c6aD2l9WfFZqdXbFGVkwNFPOUyHy+zN
	jFgpXDYOQhKX0EPmros/ZuiOd9NUnLl8LlwYYBs=
X-Google-Smtp-Source: AGHT+IGuhVTWohofK+CQ4e7TdTNrFjg8p1GSsokc4DG26V0bC28w4wxOKdctA19fa0FYVu0tIGeTtw==
X-Received: by 2002:a05:600c:1c01:b0:40b:380e:2c9e with SMTP id j1-20020a05600c1c0100b0040b380e2c9emr6890650wms.34.1702894131549;
        Mon, 18 Dec 2023 02:08:51 -0800 (PST)
Received: from [192.168.51.243] ([78.128.78.220])
        by smtp.gmail.com with ESMTPSA id bi8-20020a05600c3d8800b0040c43be2e52sm33818365wmb.40.2023.12.18.02.08.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 02:08:51 -0800 (PST)
Message-ID: <bf187ae3-5e5c-4259-87df-62a011e426f8@blackwall.org>
Date: Mon, 18 Dec 2023 12:08:50 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/9] net: Add MDB bulk deletion device operation
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
 bridge@lists.linux-foundation.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, roopa@nvidia.com, petrm@nvidia.com
References: <20231217083244.4076193-1-idosch@nvidia.com>
 <20231217083244.4076193-4-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231217083244.4076193-4-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/12/2023 10:32, Ido Schimmel wrote:
> Add MDB net device operation that will be invoked by rtnetlink code in
> response to received 'RTM_DELMDB' messages with the 'NLM_F_BULK' flag
> set. Subsequent patches will implement the operation in the bridge and
> VXLAN drivers.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> ---
>   include/linux/netdevice.h | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 1b935ee341b4..75c7725e5e4f 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -1329,6 +1329,9 @@ struct netdev_net_notifier {
>    * int (*ndo_mdb_del)(struct net_device *dev, struct nlattr *tb[],
>    *		      struct netlink_ext_ack *extack);
>    *	Deletes the MDB entry from dev.
> + * int (*ndo_mdb_del_bulk)(struct net_device *dev, struct nlattr *tb[],
> + *			   struct netlink_ext_ack *extack);
> + *	Bulk deletes MDB entries from dev.
>    * int (*ndo_mdb_dump)(struct net_device *dev, struct sk_buff *skb,
>    *		       struct netlink_callback *cb);
>    *	Dumps MDB entries from dev. The first argument (marker) in the netlink
> @@ -1611,6 +1614,9 @@ struct net_device_ops {
>   	int			(*ndo_mdb_del)(struct net_device *dev,
>   					       struct nlattr *tb[],
>   					       struct netlink_ext_ack *extack);
> +	int			(*ndo_mdb_del_bulk)(struct net_device *dev,
> +						    struct nlattr *tb[],
> +						    struct netlink_ext_ack *extack);
>   	int			(*ndo_mdb_dump)(struct net_device *dev,
>   						struct sk_buff *skb,
>   						struct netlink_callback *cb);

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

