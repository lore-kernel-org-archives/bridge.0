Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282A720E715
	for <bridge@lists.linux.dev>; Thu, 13 Feb 2025 09:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739438282; cv=none; b=ZBGuhFr8vi3LxjdCGoYlo189WlVwRfwXb3uIQW8HWtVgbXfC9cKOlyQSIAsmj1YvtzQ20ORlJ1vLuDa/aGsCy1SPlqw3HIxBcXLrGWs8MSxb7SJvDKSgH6RoTz6cbi+/mtW8VeaUEP2NLu3oubSJs9bkhKOL7LAt05rAgjnxfK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739438282; c=relaxed/simple;
	bh=tZFHp6UCOiU6zKu3uGe+iZ5zxsFxAKP2QH0K61+Dvo8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KJ0Ht4u9RoyGnFttO8oI1do0KFRvewkAdDEGHXOcQxKxBDJF54bTNDTWvja7Oq7ngeSy35NUmX5gWyzXVh/DOtasKLoP+wHSTUQQQjqE4K2ez8RhEw2JiqzR6IYLaU4AJSr4Pte8ww26ATFmuRyxmb6M0PfmHLcPPvmIXhrMXb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PDS3twiU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PDS3twiU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739438278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gyhNP3qOlJ39umXMZfckH2nuz/m9WI3f5NG3i+yZUF4=;
	b=PDS3twiUXT7kG3kZRHfQHEf3ZlRWS5CRBFp/KaL629RmVEHFAOi39oMMqTAXw00+/87XkL
	jqd9hb7qGOVUwxhGwFxixjlfibJUbSlaRwFnzlHrHFvDAOXYtlqsyVj5J0uKHYdd9KF4Yy
	6mOD3XvdCz9ORg3DRanl1O0iTpAVirs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-NLlNHG7VNraieyZQEcU0tg-1; Thu, 13 Feb 2025 04:17:56 -0500
X-MC-Unique: NLlNHG7VNraieyZQEcU0tg-1
X-Mimecast-MFC-AGG-ID: NLlNHG7VNraieyZQEcU0tg
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-38dd1bdf360so270808f8f.3
        for <bridge@lists.linux.dev>; Thu, 13 Feb 2025 01:17:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739438275; x=1740043075;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gyhNP3qOlJ39umXMZfckH2nuz/m9WI3f5NG3i+yZUF4=;
        b=KXeBz2uSWkxOLY9GbEZIFBEwr2M4Q7U/N/MqPX7mwWII1QuHiO0ojusi//9jZjR7ts
         E8DooVh8H8n6Y10A1bY1vUkyk9m640Bp9LMSUjKTxS+ot44N3rwMpCVrgmO1QW62dq3y
         ge5L4L2OaCFEGCSBQud91djZXFwqRMhrhw1PHZEeDrwfb+LSMQbKGfxqRXVZwoes7wtw
         0o2nLaCu3PyuGpFbIlZ9Fk/0J3zS/F0MekIlh+K+atj7iCEKII2JSXwquGfBq2+33q+n
         ZSEOVefyGpQylAYoKLyMdZvF5FugYh2XaNOR+KHI4P1jyWWTBPctDhzqc3bLBozcxNPQ
         17ag==
X-Forwarded-Encrypted: i=1; AJvYcCWqCq+75fksvE/1eHXKbkibXSDoyAKZd+z4qk7ja6lXWsyKFkfadRWW2k/1YwUVN7W14PyKGkQ=@lists.linux.dev
X-Gm-Message-State: AOJu0Yx/VmqzIHNODWmWj7PEmb+TWlPfVOAqtJeqP7BxVG7Cr37pfZ8h
	HPvzgPQDw86ddl1BigQW1+QylF2kBxOKVx48IKR5tU9JB//34zd0ZAiHpdsh15rmB1fjR7ol2Fm
	pCYXaE1mkgKnP9ZWH3li1SkI72iDU6HQ6+5PvInZuNdZatp2ZEwQ6zw==
X-Gm-Gg: ASbGncu9uTg44RrxV52mq2cFSxVMDDnFAeoXALhLZMoZTCu1+e4L+KmeyT+Ewqjsw4w
	XM9mBj/t/S5hubnS0RPCNjKbJkuna5lNxrSh586XVgWWXDeeQfR99Rj0ScLFySo0VG59H3F/f18
	FC5u7alaiLjuRa1eyQax1nRqCHjehMUkW5iIpGo72Jj2mUrv4x0cxUSzszosT4IIIwXdsfF8xY7
	ZQ0zisbmioNFoP615Y/mIFlqIR+PTVGDnxJ6cvdRALdGBmM0s+o7jxTL4yMoLehFEEZ0iw2Afcx
	gbGIF0HXnTbiQITV99FX2Dgo+FUeXusl/gA=
X-Received: by 2002:a5d:59ad:0:b0:38d:d9bd:18a6 with SMTP id ffacd0b85a97d-38dea2e8252mr5537696f8f.42.1739438275342;
        Thu, 13 Feb 2025 01:17:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEvdEpVIGWCwTdkiFI9VeLvCiv6OrrtGDZTcFYpY+kBOdDZTqd8HRvUuOkaOwq9itdXLKF4sg==
X-Received: by 2002:a5d:59ad:0:b0:38d:d9bd:18a6 with SMTP id ffacd0b85a97d-38dea2e8252mr5537666f8f.42.1739438274976;
        Thu, 13 Feb 2025 01:17:54 -0800 (PST)
Received: from [192.168.88.253] (146-241-31-160.dyn.eolo.it. [146.241.31.160])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258cccdesm1314704f8f.26.2025.02.13.01.17.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 01:17:54 -0800 (PST)
Message-ID: <2c294c0a-26c4-4ec5-992d-a2fd98829b16@redhat.com>
Date: Thu, 13 Feb 2025 10:17:52 +0100
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 02/11] rtnetlink: Pack newlink() params into
 struct
To: Xiao Liang <shaw.leon@gmail.com>, Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: alex.aring@gmail.com, andrew+netdev@lunn.ch,
 b.a.t.m.a.n@lists.open-mesh.org, bpf@vger.kernel.org,
 bridge@lists.linux.dev, davem@davemloft.net, donald.hunter@gmail.com,
 dsahern@kernel.org, edumazet@google.com, herbert@gondor.apana.org.au,
 horms@kernel.org, kuba@kernel.org, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-ppp@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-wpan@vger.kernel.org,
 miquel.raynal@bootlin.com, netdev@vger.kernel.org,
 osmocom-net-gprs@lists.osmocom.org, shuah@kernel.org,
 stefan@datenfreihafen.org, steffen.klassert@secunet.com,
 wireguard@lists.zx2c4.com
References: <20250210133002.883422-3-shaw.leon@gmail.com>
 <20250213065348.8507-1-kuniyu@amazon.com>
 <CABAhCOTw+CpiwwRGNtDS3gntTQe7XESNzzi6RXd9ju1xO_a5Hw@mail.gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CABAhCOTw+CpiwwRGNtDS3gntTQe7XESNzzi6RXd9ju1xO_a5Hw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: feOnbhXBuENjmeuGQLPTVJUfdXrzU_u9PF_uXwP6av4_1739438275
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/13/25 9:36 AM, Xiao Liang wrote:
> On Thu, Feb 13, 2025 at 2:54 PM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> [...]
>>> diff --git a/include/linux/if_macvlan.h b/include/linux/if_macvlan.h
>>> index 523025106a64..0f7281e3e448 100644
>>> --- a/include/linux/if_macvlan.h
>>> +++ b/include/linux/if_macvlan.h
>>> @@ -59,8 +59,10 @@ static inline void macvlan_count_rx(const struct macvlan_dev *vlan,
>>>
>>>  extern void macvlan_common_setup(struct net_device *dev);
>>>
>>> -extern int macvlan_common_newlink(struct net *src_net, struct net_device *dev,
>>> -                               struct nlattr *tb[], struct nlattr *data[],
>>> +struct rtnl_newlink_params;
>>
>> You can just include <net/rtnetlink.h> and remove it from .c
>> files, then this forward declaration will be unnecessary.
> 
> OK. Was not sure if it's desirable to include include/net files from
> include/linux.

I think we are better of with the forward declaration instead of adding
more intra header dependencies, which will slow down the build and will
produces artifacts in the CI runs (increases of reported warning in the
incremental build, as any warns from the included header will be
'propagated' to more files).

>>> +extern int macvlan_common_newlink(struct net_device *dev,
>>> +                               struct rtnl_newlink_params *params,
>>>                                 struct netlink_ext_ack *extack);
>>>
>>>  extern void macvlan_dellink(struct net_device *dev, struct list_head *head);
>>
>>
>> [...]
>>> diff --git a/include/net/rtnetlink.h b/include/net/rtnetlink.h
>>> index bc0069a8b6ea..00c086ca0c11 100644
>>> --- a/include/net/rtnetlink.h
>>> +++ b/include/net/rtnetlink.h
>>> @@ -69,6 +69,42 @@ static inline int rtnl_msg_family(const struct nlmsghdr *nlh)
>>>               return AF_UNSPEC;
>>>  }
>>>
>>> +/**
>>> + *   struct rtnl_newlink_params - parameters of rtnl_link_ops::newlink()
>>
>> The '\t' after '*' should be single '\s'.
>>
>> Same for lines below.
> 
> This is copied from other structs in the same file. Should I change it?

https://elixir.bootlin.com/linux/v6.13.2/source/Documentation/process/maintainer-netdev.rst#L376

In this series, just use the good formatting for the new code.

Thanks,

Paolo

