Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2062E224D6
	for <bridge@lists.linux.dev>; Mon, 14 Oct 2024 06:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728886932; cv=none; b=HHa43+w4eOS8L8wC7fwHEFm4s+yggvaBpnBR2efjULcTObr9pBrZLDShiZqHon4SO07h9Hbaz3PX6pHy1/U6KkbmtQfX1j+F0rF7NB9cJZldItuA0VWlo4rtsdGVC4RO/cCxA+0uvC4kR3N2JBEtkRueRtbaMUnw7g0AMji6UTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728886932; c=relaxed/simple;
	bh=nK0LzvmwgliCXQsEMTkAl3C+q8LITusoWA60LSfPQtg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=UoUWj+7fMie7KIhQNY4tiuvcsvc05G+mh2y+nsUeihjglgIlFM79lXGwq/DsdUr+xV+9cmstv4vsmHsxNF3DzPB6BRspL8oD+hJxDOtR0OvhtVxOlBg4/1oKCu/vv3K9liVZPG0C5ZyTEBRVNzPxnrvPyRcbsjTMdIWStDrtfeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=YcNCvC1e; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="YcNCvC1e"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a99650da839so685728966b.2
        for <bridge@lists.linux.dev>; Sun, 13 Oct 2024 23:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1728886929; x=1729491729; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LGGL1J/PYpfVQt9U8v/NWEtE6h5sWLzedGtSBPsspeY=;
        b=YcNCvC1e2yNP7Tv0jud4oHqy2S6cSkBPskt+8/PZODccfZmRLFBJxH2Vp9bdKwzDjh
         sUe0zxAIluP584ghWEMxGOxTTaYsjYjJA4ORRPB3/Mp+Qq3E4V33tPNZ+2/LOi0wghDE
         96SRntUMtFs37+3d8qM9wxMiB2o1MqSspTfC9rjUpPUp4saoqDBmalSGLKvH9nXD2jpa
         GWqHeFUqg0KUb2QKcDzeVJX/e8wvi93Vovkja/P4Ib5eBAmBOWX3LiwjjyXLpCTVuBZW
         xhlSfqEINqQ+StdY/BZ0i+CtgfBSEJcqALZwfzuXqDmoiP9L0ZeRLw9b3uNdvstDqnfJ
         ovTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728886929; x=1729491729;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LGGL1J/PYpfVQt9U8v/NWEtE6h5sWLzedGtSBPsspeY=;
        b=BaR3EtC+GljyD8FgWVBrM6uRcLot3ZsEsTpRNaP+dPsqG/6DHbliEKCkroPw9b89AY
         fO9ku+/WH4WJqKX0wlWzhZcUv651p8HJZ01iDOsFuLdAwD2OuyJn80XRl0+PtyAwF2x8
         EKKt6C1yhAIBfU6impdTkKVcdtKwXn9w+hCB/YygV6PAVCcsRz+E9y3hMQh9uC2VAkRk
         6j1yIPrF9ucb5YfwbAA3LrrTeUGKEFUsc91spa/qTP0wlaw+vFHIsRWSoCOy6q3/FSAH
         797w6u8oezRLV3TMaPSUFKuKZ4I6HlSG0wdOjsFq1dz3EBJkEmVGfsKxa4oN15opHuss
         +5Gw==
X-Forwarded-Encrypted: i=1; AJvYcCU7gmZCTgQ+ANegJg2KsVfHdVBLVvJAM3XZEZ6idhSNLP/lvTy+chata1zeDjm26ggNYy1XWFo=@lists.linux.dev
X-Gm-Message-State: AOJu0YxG/mWWM1oN96SckgMhkExpDdeee0uXSKRGEd0U8PkEVa+YM2li
	BqQbfFJLObdCA3UjZmIW4pDfjirFr5+csci1YDVuOYQqxrN+VSirIJ53E2c4d2s=
X-Google-Smtp-Source: AGHT+IHVur/aV2xDIG/Y4Ciomygy3p/dpFh9piHKROvSG20M9nxSRBAcVlry/ihfS/LPn7d/B70JrQ==
X-Received: by 2002:a17:907:7296:b0:a91:158f:6693 with SMTP id a640c23a62f3a-a99e39cfc56mr689668266b.9.1728886929350;
        Sun, 13 Oct 2024 23:22:09 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99f085fb70sm264862666b.7.2024.10.13.23.22.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Oct 2024 23:22:08 -0700 (PDT)
Message-ID: <6209405e-7100-43f9-b415-3be8fbcc6352@blackwall.org>
Date: Mon, 14 Oct 2024 09:22:07 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v1 net-next 11/12] bridge:
 br_vlan_fill_forward_path_mode no _UNTAG_HW for dsa
From: Nikolay Aleksandrov <razor@blackwall.org>
To: Eric Woudstra <ericwouds@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Pablo Neira Ayuso <pablo@netfilter.org>,
 Jozsef Kadlecsik <kadlec@netfilter.org>, Roopa Prabhu <roopa@nvidia.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Jiri Pirko <jiri@resnulli.us>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Frank Wunderlich <frank-w@public-files.de>,
 Daniel Golle <daniel@makrotopia.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 bridge@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20241013185509.4430-1-ericwouds@gmail.com>
 <20241013185509.4430-12-ericwouds@gmail.com>
 <281cce27-c832-41c8-87d0-fbac05b8e802@blackwall.org>
Content-Language: en-US
In-Reply-To: <281cce27-c832-41c8-87d0-fbac05b8e802@blackwall.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/10/2024 09:18, Nikolay Aleksandrov wrote:
> On 13/10/2024 21:55, Eric Woudstra wrote:
>> In network setup as below:
>>
>>              fastpath bypass
>>  .----------------------------------------.
>> /                                          \
>> |                        IP - forwarding    |
>> |                       /                \  v
>> |                      /                  wan ...
>> |                     /
>> |                     |
>> |                     |
>> |                   brlan.1
>> |                     |
>> |    +-------------------------------+
>> |    |           vlan 1              |
>> |    |                               |
>> |    |     brlan (vlan-filtering)    |
>> |    |               +---------------+
>> |    |               |  DSA-SWITCH   |
>> |    |    vlan 1     |               |
>> |    |      to       |               |
>> |    |   untagged    1     vlan 1    |
>> |    +---------------+---------------+
>> .         /                   \
>>  ----->wlan1                 lan0
>>        .                       .
>>        .                       ^
>>        ^                     vlan 1 tagged packets
>>      untagged packets
>>
>> Now that DEV_PATH_MTK_WDMA is added to nft_dev_path_info() the forward
>> path is filled also when ending with the mediatek wlan1, info.indev not
>> NULL now in nft_dev_forward_path(). This results in a direct transmit
>> instead of a neighbor transmit. This is how it should be, But this fails.
>>
>> br_vlan_fill_forward_path_mode() sets DEV_PATH_BR_VLAN_UNTAG_HW when
>> filling in from brlan.1 towards wlan1. But it should be set to
>> DEV_PATH_BR_VLAN_UNTAG in this case. Using BR_VLFLAG_ADDED_BY_SWITCHDEV
>> is not correct. The dsa switchdev adds it as a foreign port.
>>
>> Use BR_VLFLAG_TAGGING_BY_SWITCHDEV to make sure DEV_PATH_BR_VLAN_UNTAG is
>> set when there is a dsa-switch inside the bridge.
>>
>> Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
>> ---
>>  net/bridge/br_private.h |  1 +
>>  net/bridge/br_vlan.c    | 18 +++++++++++++++++-
>>  2 files changed, 18 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
>> index 8da7798f9368..7d427214cc7c 100644
>> --- a/net/bridge/br_private.h
>> +++ b/net/bridge/br_private.h
>> @@ -180,6 +180,7 @@ enum {
>>  	BR_VLFLAG_MCAST_ENABLED = BIT(2),
>>  	BR_VLFLAG_GLOBAL_MCAST_ENABLED = BIT(3),
>>  	BR_VLFLAG_NEIGH_SUPPRESS_ENABLED = BIT(4),
>> +	BR_VLFLAG_TAGGING_BY_SWITCHDEV = BIT(5),
>>  };
>>  
>>  /**
>> diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
>> index 1830d7d617cd..b7877724b969 100644
>> --- a/net/bridge/br_vlan.c
>> +++ b/net/bridge/br_vlan.c
>> @@ -3,6 +3,7 @@
>>  #include <linux/netdevice.h>
>>  #include <linux/rtnetlink.h>
>>  #include <linux/slab.h>
>> +#include <net/dsa.h>
>>  #include <net/switchdev.h>
>>  
>>  #include "br_private.h"
>> @@ -100,6 +101,19 @@ static void __vlan_flags_commit(struct net_bridge_vlan *v, u16 flags)
>>  	__vlan_flags_update(v, flags, true);
>>  }
>>  
>> +static inline bool br_vlan_tagging_by_switchdev(struct net_bridge *br)
> 
> no inline in .c files and also constify br
> 
>> +{
>> +#if IS_ENABLED(CONFIG_NET_DSA)
>> +	struct net_bridge_port *p;
>> +
>> +	list_for_each_entry(p, &br->port_list, list) {
>> +		if (dsa_user_dev_check(p->dev))
> 
> I don't think this can change at runtime, so please keep a counter in
> the bridge and don't walk the port list on every vlan add.
> 

you can use an internal bridge opt (check br_private.h) with a private opt
that's set when such device is added as a port, no need for a full counter
obviously

>> +			return false;
>> +	}
>> +#endif
>> +	return true;
>> +}
>> +
>>  static int __vlan_vid_add(struct net_device *dev, struct net_bridge *br,
>>  			  struct net_bridge_vlan *v, u16 flags,
>>  			  struct netlink_ext_ack *extack)
>> @@ -113,6 +127,8 @@ static int __vlan_vid_add(struct net_device *dev, struct net_bridge *br,
>>  	if (err == -EOPNOTSUPP)
>>  		return vlan_vid_add(dev, br->vlan_proto, v->vid);
>>  	v->priv_flags |= BR_VLFLAG_ADDED_BY_SWITCHDEV;
>> +	if (br_vlan_tagging_by_switchdev(br))
>> +		v->priv_flags |= BR_VLFLAG_TAGGING_BY_SWITCHDEV;
>>  	return err;
>>  }
>>  
>> @@ -1491,7 +1507,7 @@ int br_vlan_fill_forward_path_mode(struct net_bridge *br,
>>  
>>  	if (path->bridge.vlan_mode == DEV_PATH_BR_VLAN_TAG)
>>  		path->bridge.vlan_mode = DEV_PATH_BR_VLAN_KEEP;
>> -	else if (v->priv_flags & BR_VLFLAG_ADDED_BY_SWITCHDEV)
>> +	else if (v->priv_flags & BR_VLFLAG_TAGGING_BY_SWITCHDEV)
>>  		path->bridge.vlan_mode = DEV_PATH_BR_VLAN_UNTAG_HW;
>>  	else
>>  		path->bridge.vlan_mode = DEV_PATH_BR_VLAN_UNTAG;
> 

