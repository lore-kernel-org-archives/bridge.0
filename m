Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF72A7D3F2
	for <bridge@lists.linux.dev>; Wed, 31 Jan 2024 13:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706708052; cv=none; b=ru6PBSArdlX/TL1+ZMWOiQxITngEB7gguzp5dtaBsahY+nY0CNb6gwwymaEe16taV8OuUJ2qa40dbRA25J3kX6JEdYj2f7gjeVPiM5/i2aceRAEB14tzs8NyCMWQbczrLaus7+Se3pEEanLbSoN5KEYOPHlgnJxkAshOMHX169s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706708052; c=relaxed/simple;
	bh=BqE8kepmCSBAbJZsSPek5z7wMZ4AHTFVQZB6ZfEaNmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RSsb3wMLy51sg0tLfRJvPT5ZXsegf6gCJRqiwZLitwdChBFc3BD3eKzchApN9OaCx8LeKFlTyUu/0g4EMQoFfdHxn4OrPr6flBIElkCp/2JbuZM3CbyFiZ8PZV2DWVa59ncU9R9pyAxYJANdfvGKIG32Z0lAmhxukIMrRE6YIds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QZxARBND; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZxARBND"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40fafae5532so12779895e9.1
        for <bridge@lists.linux.dev>; Wed, 31 Jan 2024 05:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706708049; x=1707312849; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vp400XzZiWIixz3QGayYH59DObE0PQbKczBXQSNwlEM=;
        b=QZxARBND0a4NfxNsCUhKw9Id1baW//fj/jmsnRt9e6/aB8c4RLvtituqxVTSu08HjS
         affr51GAVIHomOkTES4ZTuSKHtIUergnyFEmZ1WiE2qsMUdchVrwfq/xNA47/zIMeexX
         hBRQhaXat4ziwLlrn0CHWNvkMcnPw0QkpELJeH4TfGVAJ5DB36iLYvhxdrPihXEh9Lf7
         jVnvdwo3gFs5Lny0Qy0fyO17rPF6yLtubfyoceUh4TSR14qJEwvQjfPQ8t0RStMNJ1Fr
         LEX2lniCKlKubqwJfZ4kDE65C8w6EG4vwQoYKQFklQy+0ACXmBdXkls1BIRPL6ruKGlN
         I6RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706708049; x=1707312849;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vp400XzZiWIixz3QGayYH59DObE0PQbKczBXQSNwlEM=;
        b=cdu9Zab3ug4svJU7QR72hHINBdF694pmkcts5E0t4xlR8iZWCUJ0rRO+xI7XhC/yhq
         U9M7KtECtgpKHdJ7FqPM8GGmietBQsR1YMa3x90YJCDMudM+eU8DdwJu0k+snItLivH3
         OOKwZwJOePT3vY2bWy9mKb3qqf0gqozQdetFHOxoFSdq//DFvB3vVqFYh3k03pNgNuR9
         AT10ZoFPr7HEA55+GDlKXAt4W77oXSQZU6pVs19Ns8ZvTO3byHds8pCR4QzE/dt1U5Hp
         FvTgtv5dnDvIFsWeF9JvwIhDcDo1eMejPHzOsO/JscjYre7Kc2Uc6lY8zddqg8L4uU0E
         TuZA==
X-Gm-Message-State: AOJu0Yzzc1CWPyVUtGxT+zeHy/mFPX5HxCU0Gq8VEr+C0WlgO/JoXjzY
	abngNG0EuLxDuk8yMldfKUGqJKsRhMcZb0RqqyNXaKZEzmR5rkfQ
X-Google-Smtp-Source: AGHT+IFty9dZG8cdWeueaizA9X3AmtgpCPE3cJCpiH9R7tdkbcIuU6WlHB2qTsD83OIJ3b9pdrW7Og==
X-Received: by 2002:a05:600c:1f19:b0:40e:fbd2:af50 with SMTP id bd25-20020a05600c1f1900b0040efbd2af50mr1292848wmb.26.1706708048754;
        Wed, 31 Jan 2024 05:34:08 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVJm7Szp5kidqjcwvR847s+ic3hyKk6wNf/sPpFBC6MY/gk/kZMhZvzkNAgnwgt+jSwIPPIPw3dj+c/9zPSycqEckIBkw4dkFz7LvC0TpCNJMojTipS0kH2vXwRA2ZQcwE0PhO6DiWwlb5Cjomga6YZ5IGcoUpl+aoxBTfJtBs52yXVUcZYcizMKMCBfl+xQvsbKB0Jlq0nZ6ov5/J+P7Pq0X6qeyq7o3o5lQ3QH5hfSsIqqalOKiU97dTsUw==
Received: from skbuf ([188.25.173.195])
        by smtp.gmail.com with ESMTPSA id r17-20020a05600c459100b0040e527602c8sm1637294wmo.9.2024.01.31.05.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 05:34:08 -0800 (PST)
Date: Wed, 31 Jan 2024 15:34:06 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: davem@davemloft.net, kuba@kernel.org, roopa@nvidia.com,
	razor@blackwall.org, bridge@lists.linux.dev, netdev@vger.kernel.org,
	jiri@resnulli.us, ivecera@redhat.com
Subject: Re: [PATCH net 1/2] net: switchdev: Add helper to check if an object
 event is pending
Message-ID: <20240131133406.v6zk33j43wy2j7fa@skbuf>
References: <20240131123544.462597-1-tobias@waldekranz.com>
 <20240131123544.462597-2-tobias@waldekranz.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131123544.462597-2-tobias@waldekranz.com>

On Wed, Jan 31, 2024 at 01:35:43PM +0100, Tobias Waldekranz wrote:
> When adding/removing a port to/from a bridge, the port must be brought
> up to speed with the current state of the bridge. This is done by
> replaying all relevant events, directly to the port in question.
> 
> In some situations, specifically when replaying the MDB, this process
> may race against new events that are generated concurrently.
> 
> So the bridge must ensure that the event is not already pending on the
> deferred queue. switchdev_port_obj_is_deferred answers this question.
> 
> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>

I don't see great value in splitting this patch in (1) unused helpers
(2) actual fix that uses them. Especially since it creates confusion -
it is nowhere made clear in this commit message that it is just
preparatory work.

> ---
>  include/net/switchdev.h   |  3 ++
>  net/switchdev/switchdev.c | 61 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 64 insertions(+)
> 
> diff --git a/include/net/switchdev.h b/include/net/switchdev.h
> index a43062d4c734..538851a93d9e 100644
> --- a/include/net/switchdev.h
> +++ b/include/net/switchdev.h
> @@ -308,6 +308,9 @@ void switchdev_deferred_process(void);
>  int switchdev_port_attr_set(struct net_device *dev,
>  			    const struct switchdev_attr *attr,
>  			    struct netlink_ext_ack *extack);
> +bool switchdev_port_obj_is_deferred(struct net_device *dev,
> +				    enum switchdev_notifier_type nt,
> +				    const struct switchdev_obj *obj);

I think this is missing a shim definition for when CONFIG_NET_SWITCHDEV
is disabled.

>  int switchdev_port_obj_add(struct net_device *dev,
>  			   const struct switchdev_obj *obj,
>  			   struct netlink_ext_ack *extack);
> diff --git a/net/switchdev/switchdev.c b/net/switchdev/switchdev.c
> index 5b045284849e..40bb17c7fdbf 100644
> --- a/net/switchdev/switchdev.c
> +++ b/net/switchdev/switchdev.c
> @@ -19,6 +19,35 @@
>  #include <linux/rtnetlink.h>
>  #include <net/switchdev.h>
>  
> +static bool switchdev_obj_eq(const struct switchdev_obj *a,
> +			     const struct switchdev_obj *b)
> +{
> +	const struct switchdev_obj_port_vlan *va, *vb;
> +	const struct switchdev_obj_port_mdb *ma, *mb;
> +
> +	if (a->id != b->id || a->orig_dev != b->orig_dev)
> +		return false;
> +
> +	switch (a->id) {
> +	case SWITCHDEV_OBJ_ID_PORT_VLAN:
> +		va = SWITCHDEV_OBJ_PORT_VLAN(a);
> +		vb = SWITCHDEV_OBJ_PORT_VLAN(b);
> +		return va->flags == vb->flags &&
> +			va->vid == vb->vid &&
> +			va->changed == vb->changed;
> +	case SWITCHDEV_OBJ_ID_PORT_MDB:
> +	case SWITCHDEV_OBJ_ID_HOST_MDB:
> +		ma = SWITCHDEV_OBJ_PORT_MDB(a);
> +		mb = SWITCHDEV_OBJ_PORT_MDB(b);
> +		return ma->vid == mb->vid &&
> +			!memcmp(ma->addr, mb->addr, sizeof(ma->addr));

ether_addr_equal().

> +	default:
> +		break;

Does C allow you to not return anything here?

> +	}
> +
> +	BUG();
> +}
> +
>  static LIST_HEAD(deferred);
>  static DEFINE_SPINLOCK(deferred_lock);
>  
> @@ -307,6 +336,38 @@ int switchdev_port_obj_del(struct net_device *dev,
>  }
>  EXPORT_SYMBOL_GPL(switchdev_port_obj_del);
>  
> +bool switchdev_port_obj_is_deferred(struct net_device *dev,
> +				    enum switchdev_notifier_type nt,
> +				    const struct switchdev_obj *obj)

A kernel-doc comment would be great. It looks like it's not returning
whether the port object is deferred, but whether the _action_ given by
@nt on the @obj is deferred. This further distinguishes between deferred
additions and deferred removals.

> +{
> +	struct switchdev_deferred_item *dfitem;
> +	bool found = false;
> +
> +	ASSERT_RTNL();

Why does rtnl_lock() have to be held? To fully allow switchdev_deferred_process()
to run to completion, aka its dfitem->func() as well?

> +
> +	spin_lock_bh(&deferred_lock);
> +
> +	list_for_each_entry(dfitem, &deferred, list) {
> +		if (dfitem->dev != dev)
> +			continue;
> +
> +		if ((dfitem->func == switchdev_port_obj_add_deferred &&
> +		     nt == SWITCHDEV_PORT_OBJ_ADD) ||
> +		    (dfitem->func == switchdev_port_obj_del_deferred &&
> +		     nt == SWITCHDEV_PORT_OBJ_DEL)) {
> +			if (switchdev_obj_eq((const void *)dfitem->data, obj)) {
> +				found = true;
> +				break;
> +			}
> +		}
> +	}
> +
> +	spin_unlock_bh(&deferred_lock);
> +
> +	return found;
> +}
> +EXPORT_SYMBOL_GPL(switchdev_port_obj_is_deferred);
> +
>  static ATOMIC_NOTIFIER_HEAD(switchdev_notif_chain);
>  static BLOCKING_NOTIFIER_HEAD(switchdev_blocking_notif_chain);
>  
> -- 
> 2.34.1
> 
