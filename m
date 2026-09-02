Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012EE49C4A7;
	Wed,  2 Sep 2026 12:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788353009; cv=none; b=aatptoW+CzeWyA5xsPi81Z0rXYGN3NrhBKDkiRojQp3A4kx0IDaX2Zfqf4vsudJ+KYhbHLdlaLXc79LD7KXfNBR0Jzrsq9Zd4cWry0s/PDWCou8NcsO6tp99hHram3dWOPIyA8CNH5DS77SUXIi4c23AHDxF33J8IyCZU2+e6X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788353009; c=relaxed/simple;
	bh=5CtQQq3XWbeHIudUffqd6YPe4qW8AR3TxMMMUOUMgSo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UYi0ghLS3z2PwnTWeIib0skKJJZpndtxPEHB8bG7Z5+DclmxWt9RBLYDL14qtZVg1U2fNx74uHkerrlKZRR7Bt8uPcoVD8nVSj1xPFHM+qxPR4jRKYx1i8zQ9lwHOWbLqXjIBKzYqHonAjstWs+4XpADBKn2LhWLoAbxeuHKky8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J3QwljFZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J3QwljFZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C6111F000E9;
	Wed,  2 Sep 2026 12:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788353007;
	bh=twr5Rx+a8xKJd79O1IckSWqX0pX/9iWXTVKBEqBmtXQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=J3QwljFZCSs4Y7WY6DHCdDQ2nSFZ6qGbrYDcESIIRCnTj4ZVBDYQXHJqQS1hnI8T8
	 FMe14TFlUDTbqQfzX0CX77J1Yl84tgb262x+7/9XxgLo1mRrbDoIG91lBlbQtuSOfR
	 bDZBPNE3GVCDun75l2V1e+mbc+2L4venHMx1nLhawGjJR6abXZdoeKVFfLIDMcajj1
	 84hmbPmms20wyZABlne80OdpNXSSorvRcZYBTkM+NY+rwUTXGejhM7xiIwFNlGXC3q
	 DqlcFcF9MXfswJ6/wrc44BFsj8ARM3rGzKhqI1ss/M6vvvIx/AaKt8vvhx66y26Wtf
	 ftYDtisuZPc3A==
Subject: Re: [net,v2] net: bridge: mcast: fix br_multicast_list_adjacent rcu
 walk of mglist
From: netdev-bot+sashiko@kernel.org
To: razor@blackwall.org
Cc: netdev@vger.kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linus.luessing@c0d3.blue, bridge@lists.linux.dev
Date: Wed, 02 Sep 2026 12:43:26 +0000
Message-ID: <178835300671.3394541.1735736223580358438@kernel.org>
In-Reply-To: <20260901074046.316190-1-razor@blackwall.org>
References: <20260901074046.316190-1-razor@blackwall.org>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 0

- [Medium] net/bridge/br_multicast.c:br_multicast_list_adjacent() now
  performs the entire per-port mglist walk, including one…

--

net: bridge: mcast: fix br_multicast_list_adjacent rcu walk of mglist

The patch converts the mglist walk in br_multicast_list_adjacent() from an
RCU walk to one done under the bridge's multicast_lock, since mglist was
never converted to RCU.  It also makes the function return -ENOMEM on
allocation failure and documents that in the kdoc.

Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260826014200.362304-1-littleddfu%40gmail.com

> diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
> index 3ef5d8bbf552e..97686984de6d5 100644
> --- a/net/bridge/br_multicast.c
> +++ b/net/bridge/br_multicast.c

[ ... ]

> @@ -4967,15 +4969,20 @@ int br_multicast_list_adjacent(struct net_device *dev,
>  		if (!port->dev || port->dev == dev)
>  			continue;
>  
> -		hlist_for_each_entry_rcu(group, &port->mglist, mglist) {
> +		spin_lock_bh(&br->multicast_lock);
> +		hlist_for_each_entry(group, &port->mglist, mglist) {
>  			entry = kmalloc_obj(*entry, GFP_ATOMIC);
> -			if (!entry)
> +			if (!entry) {
> +				spin_unlock_bh(&br->multicast_lock);
> +				count = -ENOMEM;
>  				goto unlock;
> +			}
>  
>  			entry->addr = group->key.addr;
>  			list_add(&entry->list, br_ip_list);
>  			count++;
>  		}
> +		spin_unlock_bh(&br->multicast_lock);
>  	}

[Severity: Medium]
How long can this critical section get?  The whole per-port mglist walk,
including one kmalloc_obj(*entry, GFP_ATOMIC) per port group, now runs with
br->multicast_lock held and bottom halves disabled.

The number of allocations inside the section equals the length of
port->mglist, which is only bounded by br->hash_max in
br_multicast_new_group():

net/bridge/br_multicast.c:br_multicast_new_group() {
	...
	if (atomic_read(&br->mdb_hash_tbl.nelems) >= br->hash_max) {
	...
}

hash_max defaults to BR_MULTICAST_DEFAULT_HASH_MAX (4096) and can be set to
any u32 without validation via netlink
(br->hash_max = nla_get_u32(data[IFLA_BR_MCAST_HASH_MAX]) in br_netlink.c)
or via set_hash_max() in br_sysfs_br.c.  The list contents themselves are
populated by IGMP/MLD reports from hosts on the bridged L2 domain.

While the lock is held, every other CPU that needs br->multicast_lock spins
for it, including the br_multicast_rcv() receive path, the group and query
expiry timers and br_multicast_port_group_rexmit().  Before this change the
loop only held rcu_read_lock(), so a long mglist slowed the caller but did
not block bridge multicast processing.

The caller is periodic, so this is not a one-off:

batadv_mcast_mla_update()
  __batadv_mcast_mla_update()
    batadv_mcast_mla_bridge_get()
      br_multicast_list_adjacent()

which runs every BATADV_MCAST_WORK_PERIOD (500 ms) from the batman-adv
workqueue.

Would it be preferable to bound the section, for example by pre-allocating
the entries outside the lock, or by dropping and re-taking the lock in
batches, rather than holding a bh-disabling spinlock across up to hash_max
slab allocations?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260901074046.316190-1-razor%40blackwall.org
