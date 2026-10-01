Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6360E2BE053
	for <bridge@lists.linux.dev>; Thu,  1 Oct 2026 07:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790839743; cv=none; b=rA8OfD/oICvpXoH8SOiH1JpzoY+S0ZEHczJW5VA5Z9VM5AIRgQQ7MBIw3cLmBqupd/LES8BZ599XYQqewj/mxRiuO+EZ5VirFqgeIoxMO+lHMqhBAD+e5AUaE3s5nzWEoIPkmespQpjaaCnJMYVMOGiltJj6lCRwJ+Fz39mypEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790839743; c=relaxed/simple;
	bh=tRluMRBXxJbh/k3JWn7GfDrnEwmGeDFeheI0LkBxX9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NQnRAAiGhIY3xc6q6mQ64wkO3w6QfbggqXhhJZttlN8tfCT4qXyjIrm18n9o0A6p0x5SNjDY9cEOevg1v1gzIFzRu6T2MfpNOf8dg6MysOWbpzG0lPx1TIVSjfUZAz6J0llqdY+/9WkWbAH6DNQdNETdTROomTYUOn8nnRYahH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=TUdBbHmk; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="TUdBbHmk"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48b02a2359aso267221f8f.0
        for <bridge@lists.linux.dev>; Thu, 01 Oct 2026 00:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1790839731; x=1791444531; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RJYmC2LSrFG1TGV4Ig18y/TsY0buRGK6MkL+GzI3BWI=;
        b=TUdBbHmkaa6nXnXALQFp7sLrViBNsQnm7GMjlhbV/XAZHRRS6rbOs0u6ylsKjzq+wM
         WWvTXzhEBm3YIM2DzmWspgR90rXfRVVF9U1yX3yWGiDJNwni/Eh0vQtz0LCBuOOnweSs
         u+ziw4DBfwL3NkH059ZLuNOoW/Y7H2NHIlyv7J1L6mUxPjFfPgWJT7IZq6BULSV8l4/t
         EMjgx0/CDhW6/+dvb8+VfcW7OCYsb1RyHXjlOtf+vLJVg41A6GerJuOrpf4dpS1C7p2a
         wLzuBJsD4QxLRVFe1XnPU2oOuwPiXiwRo5VzKr6KT5F5lfbY08ZN6p6++Lkqg1Myhq6T
         mlWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790839731; x=1791444531;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RJYmC2LSrFG1TGV4Ig18y/TsY0buRGK6MkL+GzI3BWI=;
        b=oY4VEpnNWPI2L3CKhZz+yjJACTEdw+znKd9dvv2xxQ3+ZCIvZo3iVle8SHWajeAvFm
         jbolvBnW4ut673IbbIhSZAWNa1Lbew1axVKA+7YAC4h+f/krYejGcayFJihZGVDMNmAq
         C0qQcDspLGZ6Dp7tJsbCZFVn9FzczmipNf4szqsdWT9O0iULItvxNep/P5qSDNqjqyJM
         qTxW/Y8KWcyEnUFQ3dgNwyr1SumRmgcd1zh4A6ur/Kl6BnPntTyz0mVeiVcCiYhkHQKM
         LZXSpjFDOO4paCaAifK/KS9TvpdFfozGz2s17s6X79MD3J06/v58NYWVEWsAPDciSqJN
         l4zg==
X-Forwarded-Encrypted: i=1; AKwUvBxNmAXwK5slqoA0x54C+DlVVWg0Ayj/TK/syugDuCpQCMetYnsk8Vmsej6wFyiHhO3X/OVlkhQ=@lists.linux.dev
X-Gm-Message-State: AFq9FYLjREEF0tvvrFUVMVtMTPOQ4tmuP1cOsPif9/I1UoqM7mInDDBC
	W1R7qyA0QIHKT73JRLHeO+bNneGIlFEEHf7nBJ5sIRVNxW+J9sBs0eTnHQXHJohJyWA=
X-Gm-Gg: AYBFou3eJTBrvH9DIwjWaLVKQr4bKewic4twVCJD10pHsD+QAkvdFu5j4bytjOLAawz
	3IMwQc0Q29lCwNoI3vDD4okPxN8IQMJMMcoQ2DiZwH/VqgO0p4TmVsp2qIGcPkLldL9H4gYDpFl
	Uk6Ez65KstDtMvh+rJXlfX39qtSjvoQ80dJtfqyN8bJRzmPGSQnbbGIT3+tteGoF8UO0gsO/KAD
	vgenD/P1rR2PjEvYwiOZQV7wd4gwlj4qPxZMzm0CNgO1qRk1EqikZi2u2BjOcKRoNltguKLAwz4
	9TZq/+QJDD+PTL8QXY8J5f4bXqigyU8V3H7zdYTmIQE1FhGierJIHjdHBerSgkqTl/BFXpKFchH
	UilqFy6sh2TAP1+na8XcIYUhH9xqflVeloMzdUBlRSeyIB3Ea4Zg5Vmlo1I8KQWut4sm8fVKk5D
	bFjj36NFfAYGHsuAQLBnLhYmpwDfZF5+gkG2bVA/AWINsj2GPnNwBT7PxymkLjmyiWe0H/zg5kK
	4vpM5NOcwT/BkuwZZQy+9oP6F+N
X-Received: by 2002:a05:6000:3cd:b0:48b:a7:638f with SMTP id ffacd0b85a97d-48b067a77a4mr3969002f8f.7.1790839730392;
        Thu, 01 Oct 2026 00:28:50 -0700 (PDT)
Received: from [192.168.0.161] (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b06a2fc98sm4380736f8f.35.2026.10.01.00.28.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Oct 2026 00:28:49 -0700 (PDT)
Message-ID: <f1e507b7-94f5-4357-a437-aad7f8538146@blackwall.org>
Date: Thu, 1 Oct 2026 10:28:48 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 08/12] net: bridge: vlan: quiesce readers before
 freeing port VLANs
Content-Language: en-US, bg
To: netdev@vger.kernel.org
Cc: idosch@nvidia.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, bridge@lists.linux.dev
References: <20260930071411.2786201-1-razor@blackwall.org>
 <20260930071411.2786201-9-razor@blackwall.org>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260930071411.2786201-9-razor@blackwall.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30/09/2026 10:14, Nikolay Aleksandrov wrote:
> Later fdb entries will cache port-VLAN pointers so unpublish a VLAN, wait
> for a grace period (existing readers) and then purge or rewrite fdb
> references before releasing it. Cached destinations can continue forwarding
> until they are cleaned, that is acceptable so add a comment to document it.
> During port teardown unpublish the complete VLAN group first, clean the
> port fdbs and then release the VLANs. This lets all VLANs share one grace
> period.
> 
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
> ---
>   net/bridge/br_fdb.c     | 20 ++++++++++++++++----
>   net/bridge/br_if.c      |  7 +++++--
>   net/bridge/br_private.h | 12 ++++++++++--
>   net/bridge/br_vlan.c    | 21 +++++++++++++++------
>   4 files changed, 46 insertions(+), 14 deletions(-)
> 
> diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
> index 7c68b540b358..307f9c12914e 100644
> --- a/net/bridge/br_fdb.c
> +++ b/net/bridge/br_fdb.c
> @@ -883,7 +883,9 @@ void br_fdb_cleanup_by_dst(struct net_bridge *br,
>   
>   	spin_lock_bh(&br->hash_lock);
>   	hlist_for_each_entry_safe(f, tmp, &br->fdb_list, fdb_node) {
> -		if (br_fdb_dst_port(f) != p)
> +		struct net_bridge_dst dst = br_fdb_dst_read(f);
> +
> +		if (br_dst_port(dst) != p)
>   			continue;
>   
>   		if (vlan && f->key.vlan_id == vlan->vid &&
> @@ -894,12 +896,22 @@ void br_fdb_cleanup_by_dst(struct net_bridge *br,
>   			continue;
>   		}
>   
> -		if (!do_all)
> +		if (!do_all) {
> +			if (vid && f->key.vlan_id != vid)
> +				continue;
> +
>   			if (test_bit(BR_FDB_STATIC, &f->flags) ||
>   			    (test_bit(BR_FDB_ADDED_BY_EXT_LEARN, &f->flags) &&
> -			     !test_bit(BR_FDB_OFFLOADED, &f->flags)) ||
> -			    (vid && f->key.vlan_id != vid))
> +			     !test_bit(BR_FDB_OFFLOADED, &f->flags))) {
> +				/* The entry outlives the VLAN, so it must fall
> +				 * back to the raw port destination
> +				 */
> +				if (vlan && br_dst_vlan(dst) == vlan)
> +					br_fdb_dst_write(f,
> +							 br_port_to_dst(p));
>   				continue;
> +			}
> +		}
>   
>   		if (test_bit(BR_FDB_LOCAL, &f->flags))
>   			fdb_delete_local(br, p, f);
> diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
> index d94558a5e3e9..2c05ebc1299d 100644
> --- a/net/bridge/br_if.c
> +++ b/net/bridge/br_if.c
> @@ -333,8 +333,9 @@ static void update_headroom(struct net_bridge *br, int new_hr)
>    */
>   static void del_nbp(struct net_bridge_port *p)
>   {
> -	struct net_bridge *br = p->br;
> +	struct net_bridge_vlan_group *vg;
>   	struct net_device *dev = p->dev;
> +	struct net_bridge *br = p->br;
>   
>   	sysfs_remove_link(br->ifobj, p->dev->name);
>   
> @@ -354,8 +355,10 @@ static void del_nbp(struct net_bridge_port *p)
>   		update_headroom(br, get_max_headroom(br));
>   	netdev_reset_rx_headroom(dev);
>   
> -	nbp_vlan_flush(p);
> +	vg = nbp_vlan_group(p);
> +	nbp_vlan_group_unpublish(p);
>   	br_fdb_cleanup_by_dst(br, br_port_to_dst(p), 0, 1);
> +	nbp_vlan_flush(p, vg);
>   	switchdev_deferred_process();
>   	nbp_backup_clear(p);
>   
> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
> index a790368b69e9..951b6ac5f484 100644
> --- a/net/bridge/br_private.h
> +++ b/net/bridge/br_private.h
> @@ -1735,7 +1735,9 @@ int __br_vlan_set_default_pvid(struct net_bridge *br, u16 pvid,
>   int nbp_vlan_add(struct net_bridge_port *port, u16 vid, u16 flags,
>   		 bool *changed, struct netlink_ext_ack *extack);
>   int nbp_vlan_delete(struct net_bridge_port *port, u16 vid);
> -void nbp_vlan_flush(struct net_bridge_port *port);
> +void nbp_vlan_group_unpublish(struct net_bridge_port *port);
> +void nbp_vlan_flush(struct net_bridge_port *port,
> +		    struct net_bridge_vlan_group *vg);
>   int nbp_vlan_init(struct net_bridge_port *port, struct netlink_ext_ack *extack);
>   int nbp_get_num_vlan_infos(struct net_bridge_port *p, u32 filter_mask);
>   void br_vlan_get_stats(const struct net_bridge_vlan *v,
> @@ -1894,7 +1896,13 @@ static inline int nbp_vlan_delete(struct net_bridge_port *port, u16 vid)
>   	return -EOPNOTSUPP;
>   }
>   
> -static inline void nbp_vlan_flush(struct net_bridge_port *port)
> +static inline void nbp_vlan_group_unpublish(struct net_bridge_port *port)
> +{
> +}
> +
> +static inline void
> +nbp_vlan_flush(struct net_bridge_port *port,
> +	       struct net_bridge_vlan_group *vg)
>   {
>   }
>   
> diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
> index 8a914e249767..0675f74cf1b9 100644
> --- a/net/bridge/br_vlan.c
> +++ b/net/bridge/br_vlan.c
> @@ -1406,23 +1406,32 @@ int nbp_vlan_delete(struct net_bridge_port *port, u16 vid)
>   	v = br_vlan_find(vg, vid);
>   	if (!v)
>   		return -ENOENT;
> -	br_fdb_cleanup_by_dst(port->br, br_vlan_to_dst(v), vid, 0);
>   	__vlan_unpublish(vg, v);
> +	synchronize_net();

Sashiko says:
  Does this synchronize_net() call introduce an RTNL stall and IPI storm when
  processing a large VLAN range?
  When a user issues an RTM_DELLINK command specifying a large range of VLANs
  (e.g., vid 1-4094), br_process_vlan_info() iterates over the range sequentially:
  net/bridge/br_netlink.c:br_process_vlan_info() {
      ...
  		for (v = (*vinfo_last)->vid; v <= vinfo_curr->vid; v++) {
  			bool curr_change = false;
  			tmp_vinfo.vid = v;
  			err = br_vlan_info(br, p, cmd, &tmp_vinfo, &curr_change,
  					   extack);
      ...
  }
  This loop calls into br_vlan_info(), which then calls nbp_vlan_delete() for
  each VLAN. Because the global RTNL lock is held during this process,
  synchronize_net() translates to synchronize_rcu_expedited().
  Calling this iteratively up to 4094 times blocks the RTNL lock for several
  seconds and spams all CPUs with IPIs, causing a severe system-wide network
  configuration Denial of Service. This is reachable by any user with
  CAP_NET_ADMIN in the network namespace, which can often be obtained by
  unprivileged local users via user namespaces.
  Could these grace periods be batched or deferred when deleting multiple VLANs?

  - Yes, they can be batched and I had them batched initially but when I ran my tests I didn't
    notice any problems deleting a full VLAN range. It took 79ms on my host to delete 4k VLANs.
    As I've stated in my cover letter - the complexity is not worth it, so I dropped that patch.

> +	/* Traffic may still use v through cached fdb dsts until they are
> +	 * cleaned below. This is acceptable during vlan deletion. Above we
> +	 * drain the readers that could republish the dst before cleaning it
> +	 */
> +	br_fdb_cleanup_by_dst(port->br, br_vlan_to_dst(v), vid, 0);
>   	__vlan_del(vg, v);
>   
>   	return 0;
>   }
>   
> -void nbp_vlan_flush(struct net_bridge_port *port)
> +void nbp_vlan_group_unpublish(struct net_bridge_port *port)
>   {
> -	struct net_bridge_vlan_group *vg;
> -
>   	ASSERT_RTNL();
>   
> -	vg = nbp_vlan_group(port);
> -	__vlan_flush(port->br, port, vg);
>   	RCU_INIT_POINTER(port->vlgrp, NULL);
>   	synchronize_net();
> +}
> +
> +void nbp_vlan_flush(struct net_bridge_port *port,
> +		    struct net_bridge_vlan_group *vg)
> +{
> +	ASSERT_RTNL();
> +
> +	__vlan_flush(port->br, port, vg);
>   	__vlan_group_free(vg);
>   }
>   

