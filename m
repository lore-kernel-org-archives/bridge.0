Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794223697;
	b=s6k6scknELhn9Ra3gvZEPkNlIYGOc+mE6pH92vtpkbOeK+tSTIu/1LMEi+LnwPgrFv14
	 Hdv7zdPWKtGXAzAWJTL31IptQds2rWW/H3zWsB4r3fpLPr2+xBo7M68XDXNYEFRcXR1lT
	 ApaofQQ9ylOH573LjjCiNJqCT7N60pW4BoY3rKoWpTfTU+y1vsPkOkA97/EiEMq97sGx4
	 2jzTdgjjTffppfri++h/HGzPRBkrrgdHtyyjU38UpZkm2H+HBsjIBsvIjlL7gjPw8Cs+M
	 A0tqhJfVx8QIB8uUW1XssIXphj6ndjZMtrX4NTOrK07UyPSQ1OBfbysdB6a44tmqK7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794223697;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Dx7KFsIPXErMZRXQUE5h43fcnf5L/S+eJfYzlAG0V2Q=;
	b=w2G++0C93JlHzshllR7m/5WEgxygcGpNtkROfEdxyNU1cdVYuXjHAi8gv9t9RRcEL3lj
	 AC6r9Red5TpHgjTxLqCHXZ3RO3utqy2ErDvIC0MF/CScyFxZ106oML+6RTKGqOBc3UaZX
	 8J2GesfxcptpN6khS9pB4AMzOBGsRKFu1NnQmN4xE9ACdGUSJo9MgzbSJ+H0fTKb2g35B
	 Ku5P1b4rYllKfq4BTVy81ZbzJ6gXzBDQXdyYLyffDeQg+UYUK1NBtkqM/OZ8NE5+DHfy9
	 ++B2QSPO5pSlsFHHCc+pTfDM2WdOVH6xJtXbLJAlwB3nc0FIU0Wg90+u1y/H7VuRcpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YTEQczN4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B27606A31C;
	Mon,  9 Nov 2026 11:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YTEQczN4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A1B71F0089F;
	Mon,  9 Nov 2026 11:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794223696;
	bh=Dx7KFsIPXErMZRXQUE5h43fcnf5L/S+eJfYzlAG0V2Q=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=YTEQczN475Gpci88Kivql+GnqDsQ9KexuzAtryFP7GZKVxePQgWlIV3rGwVwxtB94
	 uS4WHpBNG56cYlBgRB5n2sUg8gUzUJjt1S6PWz/sTVxCVuIPYVn+P2e6A8S/RVcDjr
	 hJX44KcWDfLm5d7UoHszCEzXjXzmB9A8Jcujitq0XwAy08BkWdin2fGw0DPfk06XCI
	 /HRJQhclOSMI6nvtV4xZ3C/MTxNG7yOpdfcgYCeHs81jvSO++8OicS6kxUHfeVieVN
	 GiSn3KsAxBTPd2HT9HFuGAOytaGK8h5nr63jhybVo811HsbCltlwzB2WoRJ706VAtc
	 ghFKvQQVRiS0A==
Subject: Re: [PATCH net-next 1/2] net: bridge: switchdev: add
 br_switchdev_fdb_find_port()
From: netdev-bot+sashiko@kernel.org
To: julius@bairaktaris.de
Cc: razor@blackwall.org, idosch@nvidia.com, andrew@lunn.ch, olteanv@gmail.com,
 netdev@vger.kernel.org, bridge@lists.linux.dev, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-kernel@vger.kernel.org
Date: Mon, 09 Nov 2026 11:28:15 +0000
Message-ID: <179422369502.994134.8555421343624613660@kernel.org>
In-Reply-To: <92a9adba8020449a269bb8941698ea6849b4c372.1794134495.git.julius@bairaktaris.de>
References: <92a9adba8020449a269bb8941698ea6849b4c372.1794134495.git.julius@bairaktaris.de>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Post: <mailto:bridge@lists.linux.dev>
List-Help: <mailto:bridge+help@lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
List-Owner: <mailto:bridge+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] br_switchdev_fdb_find_port() has a kernel-doc that says it
  returns NULL when "switchdev is not notified of" the entry.
- [Low] Concern: br_switchdev_fdb_find_port() is exported, declared in
  include/linux/if_bridge.h and given a stub there, but nothing in the…

--

net: bridge: switchdev: add br_switchdev_fdb_find_port()

This commit adds br_switchdev_fdb_find_port(), an exported RCU lookup
that returns the port of a non-local bridge FDB entry that switchdev is
notified of. The filter in br_switchdev_fdb_notify() moves into a new
helper, br_switchdev_fdb_notifies(), and both functions use it.

> diff --git a/include/linux/if_bridge.h b/include/linux/if_bridge.h
> index 75673b8bffcb8..e050b7e698fc9 100644
> --- a/include/linux/if_bridge.h
> +++ b/include/linux/if_bridge.h
> @@ -201,6 +201,19 @@ static inline int br_mst_get_state(const struct net_device *dev, u16 msti,
>  }
>  #endif
>  
> +#if IS_ENABLED(CONFIG_BRIDGE) && IS_ENABLED(CONFIG_NET_SWITCHDEV)
> +struct net_device *br_switchdev_fdb_find_port(const struct net_device *br_dev,
> +					      const unsigned char *addr,
> +					      u16 vid);

[Severity: Low]
This isn't a bug, but nothing in this patch calls the newly exported
br_switchdev_fdb_find_port().

The only user seems to come in the next patch of the series, "net: dsa:
fix host fdb refcount when a bridge fdb entry roams". That patch calls it
from dsa_user_bridge_host_fdb_wanted() in net/dsa/user.c:

    brport = br_switchdev_fdb_find_port(bridge->dev, addr, vid);

Could the commit message name that consumer?

> +#else

[ ... ]

> diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
> index 10f3aea6a1f82..02ca1cbcfede0 100644
> --- a/net/bridge/br_switchdev.c
> +++ b/net/bridge/br_switchdev.c

[ ... ]

> @@ -156,9 +152,58 @@ br_switchdev_fdb_notify(struct net_bridge *br,
>  	 * Drivers don't know how to deal with these, so don't notify them to
>  	 * avoid confusing them.
>  	 */
> -	if (test_bit(BR_FDB_ADDED_BY_USER, &fdb->flags) &&
> -	    !test_bit(BR_FDB_STATIC, &fdb->flags) &&
> -	    !test_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags))
> +	return !test_bit(BR_FDB_ADDED_BY_USER, &fdb->flags) ||
> +	       test_bit(BR_FDB_STATIC, &fdb->flags) ||
> +	       test_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags);
> +}
> +
> +/**
> + * br_switchdev_fdb_find_port - find the port of an entry switchdev knows of
> + * @br_dev: the bridge device
> + * @addr: the MAC address of the entry
> + * @vid: the VLAN of the entry
> + *
> + * Must be called under RCU; the device is valid until the read-side critical
> + * section ends.
> + *
> + * Return: the port of the non-local entry for @addr and @vid, or NULL if
> + * there is none or switchdev is not notified of it.
> + */
> +struct net_device *br_switchdev_fdb_find_port(const struct net_device *br_dev,
> +					      const unsigned char *addr,
> +					      u16 vid)
> +{
> +	const struct net_bridge_port *p;
> +	struct net_bridge_fdb_entry *f;
> +
> +	RCU_LOCKDEP_WARN(!rcu_read_lock_held(), "suspicious use outside RCU");
> +
> +	if (!netif_is_bridge_master(br_dev))
> +		return NULL;
> +
> +	f = br_fdb_find_rcu(netdev_priv(br_dev), addr, vid);
> +	if (!f || test_bit(BR_FDB_LOCAL, &f->flags) ||
> +	    !br_switchdev_fdb_notifies(f))
> +		return NULL;
> +
> +	/* learned by a switchdev driver, which is not notified back */
> +	if (test_bit(BR_FDB_ADDED_BY_EXT_LEARN, &f->flags) &&
> +	    !test_bit(BR_FDB_ADDED_BY_USER, &f->flags))
> +		return NULL;

[Severity: Medium]
Does this filter match the kernel-doc above? The kernel-doc says NULL is
returned when "switchdev is not notified of" the entry.

The commit message also says the caller uses it to "ignore the entries
whose deletion it will not be notified of". Several cases seem to
contradict both statements.

The comment "learned by a switchdev driver, which is not notified back"
only holds for the addition. br_switchdev_fdb_notifies() returns true for
BR_FDB_ADDED_BY_EXT_LEARN entries. So a flush, a delete-by-port or
__br_fdb_delete() still sends SWITCHDEV_FDB_DEL_TO_DEVICE for them,
because those paths go through fdb_delete(br, f, true).

A software-learned entry has already had SWITCHDEV_FDB_ADD_TO_DEVICE
sent. Suppose a driver then reports the same addr/vid with
SWITCHDEV_FDB_ADD_TO_BRIDGE. The existing-entry branch of
br_fdb_external_learn_add() does:

    if (test_and_set_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags)) {

It leaves BR_FDB_ADDED_BY_USER clear. This helper then returns NULL for
an entry that switchdev already knows about.

Replay also skips the filter. br_switchdev_fdb_replay_one() notifies
every fdb_list entry without calling br_switchdev_fdb_notifies():

    br_switchdev_fdb_populate(br, &item, fdb, ctx);

    err = nb->notifier_call(nb, action, &item);

Locked entries and user "master dynamic" entries are therefore notified
on replay, but this helper reports them as not notified.

The opposite case looks more concerning. A user-added extern_learn entry
(bridge fdb add ... master extern_learn) goes through
__br_fdb_add()->br_fdb_external_learn_add(..., false, true). It gets
BR_FDB_ADDED_BY_USER | BR_FDB_ADDED_BY_EXT_LEARN and passes this filter.

Any switchdev driver can then delete that entry without a DEL_TO_DEVICE
notification:

br_switchdev_event(SWITCHDEV_FDB_DEL_TO_BRIDGE)
  br_fdb_external_learn_del(br, p, addr, vid, false)
    fdb_delete(br, fdb, false)

br_fdb_external_learn_del() only checks BR_FDB_ADDED_BY_EXT_LEARN, not
the port:

    if (fdb && test_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags))
        fdb_delete(br, fdb, swdev_notify);

With the DSA consumer from the next patch, consider a user port that
holds a host address for such an entry on a foreign port. Would it ever
get an event telling it to drop that address? The address seems to stay
on the CPU port until a later event for that addr/vid, or until the port
leaves the bridge.

Should the kernel-doc and commit message describe what the filter really
guarantees, or should the filter change to match the stated contract?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1794134495.git.julius%40bairaktaris.de
