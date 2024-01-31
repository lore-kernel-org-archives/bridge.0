Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FAE84A27
	for <bridge@lists.linux.dev>; Wed, 31 Jan 2024 14:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706712491; cv=none; b=mJnMFnVz9wNeA1O45+gyyaAl48MM+OgkfzthFb2Q//1792a4hvy+jbgY7ZFPsaifLdwq23eNbf2/kRVP2f4Iz5TrECcy0NVX1aJL8LTchiyH0JIzy4CDAM6uVkOiP7nDrkfhp81pS/dk6TWi6DWUUGL4Q9X2ISsHxqjU5zNHf5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706712491; c=relaxed/simple;
	bh=9ZSp1nKH6bd1QXmIctIR923WuNvNuOyYN2W9HmueKqw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=G8la3TolSOaZ/natKiVmqL3ZeLcyW1SSHlKwVeGi6T/EdEWqDM+WQh8e0dxqOXLO6c7dVI2MFY9SsT4Uv85x746khvwtz8KJWRSbDQXfOFi6H/AvLwnO2/D7e6hgvysv4Ms3Qc8bzzIxUD85VC8xdZViuIzLQtUs7LjSUxBtqg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=Cn/j1dMA; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="Cn/j1dMA"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-511206d1c89so2065158e87.1
        for <bridge@lists.linux.dev>; Wed, 31 Jan 2024 06:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1706712487; x=1707317287; darn=lists.linux.dev;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=X8eTqDD2TC/DO+W2k0eOWEMg+bbbRfkbFFvB6iWeMD0=;
        b=Cn/j1dMA0LRyqdwmEggHxBiQglzi2Cx9RuiV6JhZjgZQE7qTnOct/qHVJkdsR5WV+/
         5BhyJq3xMsW29qBfa5w6VoUNHsXR4/B6BulTflliMa7j8lE1NWiwxrpprvQ8vy2BAof7
         DHEOXpeEh9WgFQcNREMR7/XsR2JH3+XV+3M+2ifzjvECCGQs+TEEjCEboAxfO1zTxVVW
         dBPuFjJZ3ibeUkcDWXvkQ8jQeR5NRzrVJ6XSNkAmcB8WjIgCfbtm7xHYGuqGkqCd7vyo
         RVT5cWvv/XSe3EXN+LKZnD58//sFgofZJuojunoY/iJr5+SsbeC6kAj1UQFS+WpnJZV1
         wOiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706712487; x=1707317287;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X8eTqDD2TC/DO+W2k0eOWEMg+bbbRfkbFFvB6iWeMD0=;
        b=WyVpYQ/e2A3/Kd+6wKcqRIfgCMNsHNvdhhWf9kps/Clv8MsRbMX64h25DY4yW0bPAR
         JQgTHUD46bJbBFi3OTLLIux2Qc7QLtXdQ/1gij+qePGyuYGeF9O2JztEnsk2kV4t4y/R
         iHBDbRMX3Xh7gL0LC084sej5EAU1vgq3CNo+e1qC+niEdr6n7WrIy78ZPSsL8Jz0G+7y
         EbClsbSox7KxWqjuLNEhmE4i2DyUi0mefJBeW5X7gJO0xrNAgsaeHolJ9Y3FGsNiRtdP
         WdKeZlaWt5T/pBLGPSeJrqE0un8+G4FmeB2nRb4cQlQQIqiI1yVIYBmy3uPRlYmeaCXp
         S43A==
X-Gm-Message-State: AOJu0Yz8jgniK+IyiNPB8VtgE55yT9U3ksSlQJBfESDun6rmT1BdYRv8
	ASEPvXDUhVTA3wy1w2PIPExVg5rkxm1YHsOVoqwyTPgI9V2owSmRUkmJAXM6yb0=
X-Google-Smtp-Source: AGHT+IFEKZNJatfYIRUHIY8zbbZfzQrM5VnO87XKsXNWSHfLF5VbKuLq+4n2oGpZq94NSyN21FajHA==
X-Received: by 2002:ac2:5df3:0:b0:511:f2d:367d with SMTP id z19-20020ac25df3000000b005110f2d367dmr1369110lfq.65.1706712486648;
        Wed, 31 Jan 2024 06:48:06 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU8HhA8z9YilwpUpmcGobXO2vdY8Pmm/SrHDIJJEq5A1Xepqg7wCCk+ZH+JPBaSUJtA6a81msKhKfHspoplaB0jcEMC1VoJ+vtnD+e6oyiJDklT52NjT4dRMNk357Lkg9pIxpCCOQBdGpvkGVIMTAM9hkfulLu0uvdqYSvA5ijsL+rnMQLqAPZTnpEYWh1EjqFM+8QGaGDKVxX7kJQLo8z2G/jRMRUMbFPEOEw31nmsuuhS496RcX7DGHZW6g==
Received: from wkz-x13 (a124.broadband3.quicknet.se. [46.17.184.124])
        by smtp.gmail.com with ESMTPSA id y27-20020ac255bb000000b0051011c5712bsm1844018lfg.262.2024.01.31.06.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 06:48:06 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, roopa@nvidia.com,
 razor@blackwall.org, bridge@lists.linux.dev, netdev@vger.kernel.org,
 jiri@resnulli.us, ivecera@redhat.com
Subject: Re: [PATCH net 1/2] net: switchdev: Add helper to check if an
 object event is pending
In-Reply-To: <20240131133406.v6zk33j43wy2j7fa@skbuf>
References: <20240131123544.462597-1-tobias@waldekranz.com>
 <20240131123544.462597-2-tobias@waldekranz.com>
 <20240131133406.v6zk33j43wy2j7fa@skbuf>
Date: Wed, 31 Jan 2024 15:48:05 +0100
Message-ID: <87a5oltv8a.fsf@waldekranz.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

On ons, jan 31, 2024 at 15:34, Vladimir Oltean <olteanv@gmail.com> wrote:
> On Wed, Jan 31, 2024 at 01:35:43PM +0100, Tobias Waldekranz wrote:
>> When adding/removing a port to/from a bridge, the port must be brought
>> up to speed with the current state of the bridge. This is done by
>> replaying all relevant events, directly to the port in question.
>> 
>> In some situations, specifically when replaying the MDB, this process
>> may race against new events that are generated concurrently.
>> 
>> So the bridge must ensure that the event is not already pending on the
>> deferred queue. switchdev_port_obj_is_deferred answers this question.
>> 
>> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
>
> I don't see great value in splitting this patch in (1) unused helpers
> (2) actual fix that uses them. Especially since it creates confusion -
> it is nowhere made clear in this commit message that it is just
> preparatory work.

It was one commit until the last minute, I'll squash them back together.

>> ---
>>  include/net/switchdev.h   |  3 ++
>>  net/switchdev/switchdev.c | 61 +++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 64 insertions(+)
>> 
>> diff --git a/include/net/switchdev.h b/include/net/switchdev.h
>> index a43062d4c734..538851a93d9e 100644
>> --- a/include/net/switchdev.h
>> +++ b/include/net/switchdev.h
>> @@ -308,6 +308,9 @@ void switchdev_deferred_process(void);
>>  int switchdev_port_attr_set(struct net_device *dev,
>>  			    const struct switchdev_attr *attr,
>>  			    struct netlink_ext_ack *extack);
>> +bool switchdev_port_obj_is_deferred(struct net_device *dev,
>> +				    enum switchdev_notifier_type nt,
>> +				    const struct switchdev_obj *obj);
>
> I think this is missing a shim definition for when CONFIG_NET_SWITCHDEV
> is disabled.

Even though the only caller is br_switchdev.c, which is guarded behind
CONFIG_NET_SWITCHDEV?

>>  int switchdev_port_obj_add(struct net_device *dev,
>>  			   const struct switchdev_obj *obj,
>>  			   struct netlink_ext_ack *extack);
>> diff --git a/net/switchdev/switchdev.c b/net/switchdev/switchdev.c
>> index 5b045284849e..40bb17c7fdbf 100644
>> --- a/net/switchdev/switchdev.c
>> +++ b/net/switchdev/switchdev.c
>> @@ -19,6 +19,35 @@
>>  #include <linux/rtnetlink.h>
>>  #include <net/switchdev.h>
>>  
>> +static bool switchdev_obj_eq(const struct switchdev_obj *a,
>> +			     const struct switchdev_obj *b)
>> +{
>> +	const struct switchdev_obj_port_vlan *va, *vb;
>> +	const struct switchdev_obj_port_mdb *ma, *mb;
>> +
>> +	if (a->id != b->id || a->orig_dev != b->orig_dev)
>> +		return false;
>> +
>> +	switch (a->id) {
>> +	case SWITCHDEV_OBJ_ID_PORT_VLAN:
>> +		va = SWITCHDEV_OBJ_PORT_VLAN(a);
>> +		vb = SWITCHDEV_OBJ_PORT_VLAN(b);
>> +		return va->flags == vb->flags &&
>> +			va->vid == vb->vid &&
>> +			va->changed == vb->changed;
>> +	case SWITCHDEV_OBJ_ID_PORT_MDB:
>> +	case SWITCHDEV_OBJ_ID_HOST_MDB:
>> +		ma = SWITCHDEV_OBJ_PORT_MDB(a);
>> +		mb = SWITCHDEV_OBJ_PORT_MDB(b);
>> +		return ma->vid == mb->vid &&
>> +			!memcmp(ma->addr, mb->addr, sizeof(ma->addr));
>
> ether_addr_equal().
>
>> +	default:
>> +		break;
>
> Does C allow you to not return anything here?

No warnings or errors are generated by my compiler (GCC 12.2.0).

My guess is that the expansion of BUG() ends with
__builtin_unreachable() or similar.

>> +	}
>> +
>> +	BUG();
>> +}
>> +
>>  static LIST_HEAD(deferred);
>>  static DEFINE_SPINLOCK(deferred_lock);
>>  
>> @@ -307,6 +336,38 @@ int switchdev_port_obj_del(struct net_device *dev,
>>  }
>>  EXPORT_SYMBOL_GPL(switchdev_port_obj_del);
>>  
>> +bool switchdev_port_obj_is_deferred(struct net_device *dev,
>> +				    enum switchdev_notifier_type nt,
>> +				    const struct switchdev_obj *obj)
>
> A kernel-doc comment would be great. It looks like it's not returning
> whether the port object is deferred, but whether the _action_ given by
> @nt on the @obj is deferred. This further distinguishes between deferred
> additions and deferred removals.
>

Fair, so should the name change as well? I guess you'd want something
like switchdev_port_obj_notification_is_deferred, but that sure is
awfully long.

>> +{
>> +	struct switchdev_deferred_item *dfitem;
>> +	bool found = false;
>> +
>> +	ASSERT_RTNL();
>
> Why does rtnl_lock() have to be held? To fully allow switchdev_deferred_process()
> to run to completion, aka its dfitem->func() as well?

That is in effect what is does, yes. All we really would need is to
ensure that any individual item that has been removed from the list has
also executed its callback. But holding rtnl_lock was the most granular
way I could see that would ensure that.

>> +
>> +	spin_lock_bh(&deferred_lock);
>> +
>> +	list_for_each_entry(dfitem, &deferred, list) {
>> +		if (dfitem->dev != dev)
>> +			continue;
>> +
>> +		if ((dfitem->func == switchdev_port_obj_add_deferred &&
>> +		     nt == SWITCHDEV_PORT_OBJ_ADD) ||
>> +		    (dfitem->func == switchdev_port_obj_del_deferred &&
>> +		     nt == SWITCHDEV_PORT_OBJ_DEL)) {
>> +			if (switchdev_obj_eq((const void *)dfitem->data, obj)) {
>> +				found = true;
>> +				break;
>> +			}
>> +		}
>> +	}
>> +
>> +	spin_unlock_bh(&deferred_lock);
>> +
>> +	return found;
>> +}
>> +EXPORT_SYMBOL_GPL(switchdev_port_obj_is_deferred);
>> +
>>  static ATOMIC_NOTIFIER_HEAD(switchdev_notif_chain);
>>  static BLOCKING_NOTIFIER_HEAD(switchdev_blocking_notif_chain);
>>  
>> -- 
>> 2.34.1
>> 
