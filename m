Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794804215;
	b=NSwMIabSn8rfjtzLtzH1gjwB9bJo1qOJ6ye5aQmGP37kpnZ8dc0WTGoh+Q8ZRR4bvOp2
	 8flW5G5yw3m7tThmEtDhKOuubCkMa/OHLQTvv9i9N6Z0Mf8DxX/iCsdraJKu2H6jjyCqD
	 aFFzrWlsVVVaYfBe2d2taEnOwzZVy2wvO44EXvZonxiGONYJIbn7DvwSWiVTHPp6zl217
	 +7r3r+ODg88BmqCXufraxeFAHOqzUoe99sfUjlUsKd7rlA05ta6RTqOl24ILogTC9Splv
	 WJjMnlASTbwZloygVSsNkf9eQXqfgYeuo7X0u+Jn4x3IiZzn75kUijdXhPLmTCPgNYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794804215;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=66ESRN+oMv3Hw3AOFuySPhe2wrzEOHjbqZUPjWl1LQo=;
	b=IfmFuUiurUyFnU9CIWhgW4xyPteIwndUu+r9eAog4h5sP3HOR0v3x8eaCqyRUElU8gTi
	 CO1hso6lC7l6NDazIEI+swXZZ9rRUuaj7aG0ev2aPV6BeAmv7cpJvXssnsQyiAVMusWMS
	 v2PWC2Qp1ds/MTbCAAXV6G1tUqCXSLj+RhpheCikT7U8xOZrVHSl6bDEXsnLN5yKYMOMX
	 8wm0b8kj3qr85DmmxUXraL3hWQVGa5rNHiC0peAxomx/i8C3iQ8vvxnJccELyPkhEiq2/
	 Rx6EtATIUZyf9YTZK3/vN7yCT8uUptylHSmXRGcq0tgCDkygCNtLVEjh9I0d/rrreZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="PUu/DW6Y";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E779B606A884;
	Mon, 16 Nov 2026 04:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PUu/DW6Y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA7E51F000CE;
	Mon, 16 Nov 2026 04:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794804214;
	bh=66ESRN+oMv3Hw3AOFuySPhe2wrzEOHjbqZUPjWl1LQo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=PUu/DW6YlWQuqIjs/cSYC7e5d7D+t94RV4J3MFysjpZIFSVyF98cxRYrzOXtK3jmX
	 pfMLPvWt+xrfCdzhWQLovmiWMf/ZaxNK4vjesn5EWVc4e7CL21c4nprniFsd7Nek33
	 xn0neYx/X+UR5nvYk/KULRuY8tduvmjKSiJaArw5ZIbyQ0Z0/DyTPT9Hs688sBP66A
	 HzoCuT+Z0ayE5cT626aT+ilJ6bqITF5uTXdm5DzYVECPS23585QKNtNQjCY2rSF1oU
	 3NEvujP+hjSgoPdLFFR/drtEvwIWnZmcAR+6lPdd2kBpE5SKczIc98donntPN0B4Y0
	 wjsw4/TGZnBHg==
Subject: Re: [PATCH net-next v2 2/2] net: dsa: fix host fdb refcount when a
 bridge fdb entry roams
From: netdev-bot+sashiko@kernel.org
To: julius@bairaktaris.de
Cc: razor@blackwall.org, idosch@nvidia.com, andrew+netdev@lunn.ch,
 olteanv@gmail.com, netdev@vger.kernel.org, bridge@lists.linux.dev,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 16 Nov 2026 04:43:33 +0000
Message-ID: <179480421335.3136.15795220009190349154@kernel.org>
In-Reply-To: <bf1624a8295e435bfbe75534f51c9c87809378c7.1794696609.git.julius@bairaktaris.de>
References: <bf1624a8295e435bfbe75534f51c9c87809378c7.1794696609.git.julius@bairaktaris.de>
X-sashiko-severity: High
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

Thank you for your contribution! Sashiko AI review found 9 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 5 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Work items are queued to dsa_owq from atomic notifier context
  after a lockless READ_ONCE(dp->bridge) check, and nothing orders that…
- [High] The patch adds a new lockless dereference of dp->bridge in
  atomic switchdev notifier (RCU read-side) context on a hot path.
- [Medium] A GFP_ATOMIC allocation failure in the new release path leaves
  a host address held on the CPU port, the leak this patch says it…
- [Medium] dsa_user_bridge_host_fdb_set() treats a failed
  dsa_port_bridge_host_fdb_add() as 'nothing installed'.
- [Medium] Before this patch, dsa_user_fdb_event() returned 0 straight
  away for dynamically learned entries on the port's own bridge port.
- [Medium] net: dsa: host FDB desync and leak in
  dsa_user_bridge_host_fdb_release_work()
- [Medium] net: dsa: host FDB leak in dsa_user_bridge_host_fdb_wanted()
  on foreign LAG
- [Low] This is a fix ('net: dsa: fix host fdb refcount ...') for
  failures users can see on released kernels: 'port N failed to delete…
- [Low] The patch also fixes a separate NULL dereference / use-after-free
  in the current kernel, but the commit message does not say so clearly.

--

net: dsa: fix host fdb refcount when a bridge fdb entry roams

DSA user ports used to count host FDB references for bridge entries on
foreign ports. This patch drops the counting: each user port now keeps a
record of the host addresses it holds and checks it against the bridge
FDB on every event. When an entry moves onto a user port, work items
release the holds on the other user ports, and dsa_port_bridge_destroy()
now flushes the DSA workqueue and purges the records before the bridge is
freed.

> Signed-off-by: Julius Bairaktaris <julius@bairaktaris.de>

[Severity: Low]
This fixes problems that users can see on released kernels: the "failed
to delete ... from fdb: -2" error, a host address left on the CPU port,
and the oops in dsa_user_switchdev_event_work() when a bridge join fails.
The only trailer is Signed-off-by, though.

Should there be a Fixes: tag naming the commit that added event-counted
host FDB references for foreign entries? Should another one name the
commit that added the join rollback without a workqueue flush? Is this
meant for net and stable?

> diff --git a/net/dsa/port.c b/net/dsa/port.c
> index 1f5536c0dffc2..1ec2c79387150 100644
> --- a/net/dsa/port.c
> +++ b/net/dsa/port.c

[ ... ]

> @@ -457,7 +457,13 @@ static void dsa_port_bridge_destroy(struct dsa_port *dp,
>  {
>  	struct dsa_bridge *bridge = dp->bridge;
>  
> -	dp->bridge = NULL;
> +	WRITE_ONCE(dp->bridge, NULL);
> +
> +	/* Wait for the FDB events that still see the bridge, then release the
> +	 * host addresses the port holds, before the drivers are told it left.
> +	 */
> +	dsa_flush_workqueue();
> +	dsa_user_bridge_host_fdb_purge(dp, bridge);
>  
>  	if (!refcount_dec_and_test(&bridge->refcount))
>  		return;
> @@ -528,7 +534,9 @@ int dsa_port_bridge_join(struct dsa_port *dp, struct net_device *br,
>  					&dsa_user_switchdev_blocking_notifier);
>  	dsa_flush_workqueue();
>  out_rollback_unbridge:
> +	dsa_port_bridge_destroy(dp, br);
>  	dsa_broadcast(DSA_NOTIFIER_BRIDGE_LEAVE, &info);
> +	return err;
>  out_rollback:
>  	dsa_port_bridge_destroy(dp, br);
>  	return err;

[Severity: Low]
This isn't a bug, but this reordering, together with the flush added to
dsa_port_bridge_destroy(), seems to fix a separate crash in the current
kernel. The commit message only hints at it.

Without this patch, switchdev_bridge_port_offload() can fail partway
through br_fdb_replay(). out_rollback_unbridge then runs
dsa_port_bridge_destroy() with no flush, so replayed work items that are
already queued do this:

dsa_user_switchdev_event_work()
  dsa_port_fdb_add() / dsa_port_bridge_host_fdb_add()
    .bridge = *dp->bridge    <- dp->bridge is NULL or freed

A normal leave has the same window, between the flush in
dsa_port_pre_bridge_leave() and dsa_port_bridge_destroy().

The only mention in the commit message is:

  the previous version oopses in dsa_user_switchdev_event_work() in 2 of
  2 boots

This could refer to v1 of this patch or to the unpatched kernel.

Could the NULL dereference on the join error path be stated outright?
Could it also go in its own patch with its own Fixes: tag?

[ ... ]

> diff --git a/net/dsa/user.c b/net/dsa/user.c
> index 041f9060c8ef0..24f9914296660 100644
> --- a/net/dsa/user.c
> +++ b/net/dsa/user.c

[ ... ]

> @@ -3639,6 +3657,270 @@ dsa_fdb_offload_notify(struct dsa_switchdev_event_work *switchdev_work)

[ ... ]

> +	if (want != DSA_HOST_FDB_NONE) {
> +		a = kzalloc_obj(*a);
> +		if (!a)
> +			return false;
> +
> +		err = dsa_port_bridge_host_fdb_add(dp, bridge, addr, vid);
> +		if (err) {
> +			dev_err(dp->ds->dev,
> +				"port %d failed to add %pM vid %d to fdb: %d\n",
> +				dp->index, addr, vid, err);
> +			kfree(a);
> +			return false;
> +		}

[Severity: Medium]
Is it safe to treat a failed dsa_port_bridge_host_fdb_add() as if nothing
was installed?

DSA_NOTIFIER_HOST_FDB_ADD goes through dsa_tree_notify(), which calls
raw_notifier_call_chain(). The chain stops at the first switch that
returns an error and does not undo the switches before it. Within one
switch, dsa_switch_host_fdb_add() also stops at the first per-port error:

net/dsa/switch.c:dsa_switch_host_fdb_add() {
    ...
	dsa_switch_for_each_port(dp, ds) {
		if (dsa_port_host_address_match(dp, info->dp)) {
			...
			if (err)
				break;
		}
	}
    ...
}

In a daisy-chained tree, dsa_port_host_address_match() matches the
upstream CPU/DSA port on every switch between this port and its CPU port.
If a later switch fails (full FDB table, MDIO error, -ENOMEM), the earlier
switches keep refcounted host entries.

With the old counting scheme, a later DEL still released those partial
references. Here the record is freed and no delete is ever sent for this
address on this port. dsa_user_bridge_host_fdb_purge() won't find it
either.

A later successful hold then only raises the stale refcount to 2, and
releasing that hold brings it back to 1.

Does this leave the upstream switches with a CPU-directed entry until
teardown, or with a refcount that thinks one exists? The commit message
says a failed host address add is handled. Only the conduit unicast
reference is undone in dsa_port_bridge_host_fdb_add(), though.

[ ... ]

> +static int dsa_user_bridge_host_fdb_release_one(struct net_device *lower,
> +						struct netdev_nested_priv *priv)
> +{
> +	struct dsa_user_release_ctx *ctx = (void *)priv->data;
> +	struct dsa_switchdev_event_work *switchdev_work;
> +	struct dsa_user_priv *p;
> +
> +	if (!dsa_user_dev_check(lower))
> +		return 0;
> +
> +	/* A learned entry cannot replace a local one, so only the addresses
> +	 * held for foreign entries can be affected
> +	 */
> +	p = netdev_priv(lower);
> +	if (!READ_ONCE(p->dp->bridge) ||
> +	    !atomic_read(ctx->dynamic ? &p->bridge_host_fdbs_foreign_n :
> +					&p->bridge_host_fdbs_n))
> +		return 0;
> +
> +	switchdev_work = kzalloc_obj(*switchdev_work, GFP_ATOMIC);
> +	if (!switchdev_work) {
> +		ctx->err = -ENOMEM;
> +		return 0;
> +	}

[Severity: Medium]
What happens to this port's hold when this GFP_ATOMIC allocation fails?

The walk goes on and release work is still queued for the other ports.
This port keeps its record and its CPU host entry, and nothing is logged.

Back in dsa_user_fdb_event(), the error makes the non-host ADD return
before the user port's own work is queued:

	if (!host_addr && event == SWITCHDEV_FDB_ADD_TO_DEVICE) {
		int err = dsa_user_bridge_host_fdb_release(dev, fdb_info->addr,
							   fdb_info->vid,
							   false);

		if (err)
			return err;
	}

br_switchdev_fdb_notify() ignores the notifier return value, so nothing
retries.

Later events for an entry on a user port go only to that port. So the
port that failed never gets an event that would release its hold. The
stale CPU host entry stays until dsa_user_bridge_host_fdb_purge() runs at
bridge leave.

During replay, the dynamic own-bridge-port branch now returns the result
of dsa_user_bridge_host_fdb_release(), where it used to return 0. This
-ENOMEM can therefore abort br_fdb_replay() and fail a bridge or LAG
join.

Separately, when kzalloc_obj() fails in dsa_user_bridge_host_fdb_set(),
it returns false without a message. A host address that should be
installed is skipped silently, where the previous code printed a
dev_err() on -ENOMEM.

> +
> +	INIT_WORK(&switchdev_work->work, dsa_user_bridge_host_fdb_release_work);
> +	switchdev_work->dev = lower;
> +	ether_addr_copy(switchdev_work->addr, ctx->addr);
> +	switchdev_work->vid = ctx->vid;
> +
> +	dsa_schedule_work(&switchdev_work->work);

[Severity: High]
Can this work item outlive the netdev it points to?

The bridge of another port is checked locklessly from atomic notifier
context, and work is then queued with switchdev_work->dev = lower. No
reference is held on lower, and dsa_port_bridge_destroy() for that port
flushes only once:

CPU1 (RX on port X)
dsa_user_fdb_event()
  dsa_user_bridge_host_fdb_release()
    dsa_user_bridge_host_fdb_release_one(Y)
      READ_ONCE(p->dp->bridge) != NULL

CPU2 (tearing down port Y)
dsa_user_destroy()
  unregister_netdevice(Y)
    br_del_if() ... dsa_port_bridge_leave()
      dsa_port_bridge_destroy()
        WRITE_ONCE(dp->bridge, NULL);
        dsa_flush_workqueue();    <- nothing queued yet
        dsa_user_bridge_host_fdb_purge()

CPU1
      dsa_schedule_work(&switchdev_work->work);

CPU2
  free_netdev(Y)

dsa_user_destroy() does not flush dsa_owq before free_netdev().
dsa_tree_teardown_ports() flushes only after every user port has been
torn down.

When dsa_user_bridge_host_fdb_release_work() runs,
dsa_user_to_port(dev) reads the freed netdev.
dsa_user_bridge_host_fdb_set() may then list_del() and kfree() through
it.

dsa_user_fdb_event() has the same check-then-queue gap for the port's own
events. dsa_port_change_conduit() leaves and rejoins within one RTNL
section, so a stale non-host event queued after the flush can also run
against the new dsa_bridge.

The commit message says:

  dsa_port_bridge_destroy() clears dp->bridge before it flushes the
  workqueue and releases the records, so the bridge is not freed under a
  running event.

The READ_ONCE() and dsa_schedule_work() in the notifier are not atomic
with respect to that store and flush. Is something needed here, such as
a dev_hold() on lower, or waiting for the notifier's RCU read side before
the flush?

> +
> +	return 0;
> +}
> +
> +/* Called under rcu_read_lock() */
> +static int dsa_user_bridge_host_fdb_release(struct net_device *dev,
> +					    const unsigned char *addr, u16 vid,
> +					    bool dynamic)
> +{
> +	struct dsa_user_release_ctx ctx = {
> +		.addr = addr, .vid = vid, .dynamic = dynamic,
> +	};
> +	struct netdev_nested_priv priv = { .data = &ctx };
> +	struct net_device *br = dsa_port_bridge_dev_get(dsa_user_to_port(dev));

[Severity: High]
Can struct dsa_bridge be freed while this runs?

This adds a lockless dp->bridge->dev dereference from atomic switchdev
notifier context. It runs for every dynamically learned ADD on the port's
own bridge port and for every non-host ADD. dsa_port_bridge_dev_get()
does:

	const struct dsa_bridge *bridge = READ_ONCE(dp->bridge);

	return bridge ? bridge->dev : NULL;

Meanwhile, under RTNL, dsa_port_bridge_destroy() does
WRITE_ONCE(dp->bridge, NULL), flushes the workqueue, and then calls
kfree(bridge) with no RCU grace period. The flush only covers workqueue
readers.

Suppose a notifier on another CPU has loaded the old pointer and stalls
before it reads ->dev. It would then pass a garbage pointer to
netdev_walk_all_lower_dev_rcu().

This looks reachable while the port is still a live, learning bridge
port. dsa_port_change_conduit() calls dsa_port_bridge_leave() and later
dsa_port_bridge_join() on an active bridged port, and a failed re-join
rollback also frees the bridge.

On the publishing side, dsa_port_bridge_create() initializes a freshly
kzalloc'd bridge and publishes it with WRITE_ONCE(). WRITE_ONCE() has no
release semantics, so on weakly ordered CPUs a concurrent notifier could
see the pointer before the initialization.

Would rcu_assign_pointer() and rcu_dereference() be needed here instead
of READ_ONCE() and WRITE_ONCE(), with kfree_rcu() or synchronize_rcu()
before the free?

[ ... ]

> @@ -3718,12 +3997,16 @@ static int dsa_user_fdb_event(struct net_device *dev,
>  	if (ctx && ctx != dp)
>  		return 0;
>  
> -	if (!dp->bridge)
> +	if (!READ_ONCE(dp->bridge))
>  		return 0;
>  
>  	if (switchdev_fdb_is_dynamically_learned(fdb_info)) {
>  		if (dsa_port_offloads_bridge_port(dp, orig_dev))
> -			return 0;
> +			return event == SWITCHDEV_FDB_ADD_TO_DEVICE ?
> +				dsa_user_bridge_host_fdb_release(dev,
> +								 fdb_info->addr,
> +								 fdb_info->vid,
> +								 true) : 0;

[Severity: Medium]
Could this turn every learned address into one atomic allocation and one
work item per user port?

This branch used to return 0 straight away. Now every dynamically learned
ADD on the port's own bridge port walks all lower devices of the bridge.

For each user port with a non-zero bridge_host_fdbs_foreign_n,
dsa_user_bridge_host_fdb_release_one() makes a GFP_ATOMIC allocation and
queues work on the single ordered dsa_owq. There is no limit on pending
items. The check is whether the port holds any foreign address, not this
particular one.

Each work item then calls br_switchdev_fdb_find_port() and scans that
port's bridge_host_fdbs list in dsa_user_bridge_host_fdb_set().

A remote sender on any user port can send frames with random source MACs,
and the bridge learns them (fdb_max_learned is unlimited by default).
With assisted learning or static foreign entries, such as a bridge with
WiFi ports, each new MAC costs N allocations and N work items. That is
O(N*M) list scanning in total, for N qualifying ports and M held foreign
addresses.

The backlog on dsa_owq would also delay normal FDB programming for every
DSA switch.

[ ... ]

> @@ -3639,6 +3657,270 @@ dsa_fdb_offload_notify(struct dsa_switchdev_event_work *switchdev_work)
>  				 switchdev_work->orig_dev, &info.info, NULL);
>  }
>  
> +/* The bridge notifies a roaming entry without a lock, so with two CPUs the
> + * deletion from the old port and the addition on the new one can arrive
> + * twice or out of order. Hold the host address while the bridge has the
> + * entry on a foreign port or as a local entry. A deletion that still finds
> + * the entry on its own port was sent before the bridge changed the port. An
> + * entry on a user port, also one of another tree, is notified only to that
> + * port.
> + */
> +enum dsa_host_fdb_want {
> +	DSA_HOST_FDB_NONE,
> +	DSA_HOST_FDB_FOREIGN,
> +	DSA_HOST_FDB_LOCAL,
> +};
> +
> +static enum dsa_host_fdb_want
> +dsa_user_bridge_host_fdb_wanted(struct net_device *dev,
> +				const struct dsa_bridge *bridge,
> +				const unsigned char *addr, u16 vid,
> +				const struct net_device *leaving)
> +{
> +	struct dsa_port *dp = dsa_user_to_port(dev);
> +	enum dsa_host_fdb_want want = DSA_HOST_FDB_NONE;
> +	struct net_device *brport;
> +	bool by_user = false;
> +
> +	rcu_read_lock();
> +	brport = br_switchdev_fdb_find_port(bridge->dev, addr, vid, &by_user);
> +	if (brport == bridge->dev)
> +		want = DSA_HOST_FDB_LOCAL;
> +	/* Learned entries on foreign ports only count with assisted learning,
> +	 * as in dsa_user_fdb_event()
> +	 */
> +	else if (brport && brport != leaving && !dsa_user_dev_check(brport) &&

[Severity: Medium]
Does this count an entry on a LAG offloaded by another DSA tree as
foreign?

Only the bridge port itself is checked with dsa_user_dev_check().
Suppose the entry is on bond0, whose lowers are user ports of a
different tree. br_switchdev_fdb_find_port() returns bond0.

For a user port of this tree, dsa_user_dev_check(bond0) is false.
dsa_foreign_dev_check(dev, bond0) is true, because this tree does not
offload bond0. So the lookup returns DSA_HOST_FDB_FOREIGN, where a bare
user port of the other tree would give DSA_HOST_FDB_NONE.

When an entry moves onto bond0, the bond members get the event in
dsa_user_fdb_event() and call dsa_user_bridge_host_fdb_release(), which
queues dsa_user_bridge_host_fdb_release_work() on this tree's ports.
Those work items then keep the hold, or add one, instead of dropping
it.

The later delete may never reach this tree. For an event on bond0,
__switchdev_handle_fdb_event_to_device() delivers it to the bond
members. It then uses switchdev_lower_dev_find_rcu() on the bridge to
pick the first DSA user port under it, and checks whether the entry is
foreign to that port.

If bond0 sits before this tree's ports in the bridge's lower list, the
port picked is a bond0 member. The entry is not foreign to it, so the
event is not passed on to the other user ports.

The dsa_user_host_fdb record, the host FDB entry on the CPU port and
the dev_uc_add() reference on the conduit then stay until the port
leaves the bridge.

Should dsa_user_bridge_host_fdb_wanted() also return
DSA_HOST_FDB_NONE when brport is a LAG whose lowers are DSA user
ports, matching the check for bare user ports?

> +		 dsa_foreign_dev_check(dev, brport) &&
> +		 (by_user || dp->ds->assisted_learning_on_cpu_port))
> +		want = DSA_HOST_FDB_FOREIGN;
> +	rcu_read_unlock();
> +
> +	return want;
> +}
> +
> +/* Hold, release or retag the host address; return whether it is held
> + * afterwards
> + */
> +static bool dsa_user_bridge_host_fdb_set(struct net_device *dev,
> +					 const struct dsa_bridge *bridge,
> +					 const unsigned char *addr, u16 vid,
> +					 enum dsa_host_fdb_want want)
> +{
> +	struct dsa_user_priv *p = netdev_priv(dev);
> +	struct dsa_port *dp = p->dp;
> +	struct dsa_user_host_fdb *a, *held = NULL;
> +	bool local = want == DSA_HOST_FDB_LOCAL;
> +	int err;
> +
> +	list_for_each_entry(a, &p->bridge_host_fdbs, list) {
> +		if (ether_addr_equal(a->addr, addr) && a->vid == vid) {
> +			held = a;
> +			break;
> +		}
> +	}
> +
> +	if (want != DSA_HOST_FDB_NONE && held) {
> +		if (held->local != local) {
> +			held->local = local;
> +			atomic_add(local ? -1 : 1,
> +				   &p->bridge_host_fdbs_foreign_n);
> +		}
> +		return true;
> +	}
> +
> +	if (want == DSA_HOST_FDB_NONE && !held)
> +		return false;
> +
> +	if (want != DSA_HOST_FDB_NONE) {
> +		a = kzalloc_obj(*a);
> +		if (!a)
> +			return false;
> +
> +		err = dsa_port_bridge_host_fdb_add(dp, bridge, addr, vid);
> +		if (err) {
> +			dev_err(dp->ds->dev,
> +				"port %d failed to add %pM vid %d to fdb: %d\n",
> +				dp->index, addr, vid, err);
> +			kfree(a);
> +			return false;
> +		}
> +
> +		ether_addr_copy(a->addr, addr);
> +		a->vid = vid;
> +		a->local = local;
> +		list_add(&a->list, &p->bridge_host_fdbs);
> +		atomic_inc(&p->bridge_host_fdbs_n);
> +		if (!local)
> +			atomic_inc(&p->bridge_host_fdbs_foreign_n);
> +		return true;
> +	}
> +
> +	/* The conduit's unicast filter is released before the switch entry, so
> +	 * the record goes even when the latter fails.
> +	 */
> +	err = dsa_port_bridge_host_fdb_del(dp, bridge, addr, vid);
> +	if (err)
> +		dev_err(dp->ds->dev,
> +			"port %d failed to delete %pM vid %d from fdb: %d\n",
> +			dp->index, addr, vid, err);
> +
> +	list_del(&held->list);
> +	atomic_dec(&p->bridge_host_fdbs_n);
> +	if (!held->local)
> +		atomic_dec(&p->bridge_host_fdbs_foreign_n);
> +	kfree(held);
> +
> +	return false;
> +}
> +
> +static void
> +dsa_user_bridge_host_fdb_sync(struct dsa_switchdev_event_work *switchdev_work)
> +{
> +	bool del = switchdev_work->event == SWITCHDEV_FDB_DEL_TO_DEVICE;
> +	const struct net_device *leaving =
> +		del ? switchdev_work->orig_dev : NULL;
> +	struct net_device *dev = switchdev_work->dev;
> +	const unsigned char *addr = switchdev_work->addr;
> +	u16 vid = switchdev_work->vid;
> +	enum dsa_host_fdb_want want = DSA_HOST_FDB_NONE;
> +	const struct dsa_bridge *bridge;
> +	bool held;
> +
> +	/* Cleared before the workqueue is flushed and the bridge is freed */
> +	bridge = READ_ONCE(dsa_user_to_port(dev)->bridge);
> +	if (!bridge)
> +		return;
> +
> +	if (!(del && switchdev_work->replay))
> +		want = dsa_user_bridge_host_fdb_wanted(dev, bridge, addr, vid,
> +						       leaving);
> +
> +	held = dsa_user_bridge_host_fdb_set(dev, bridge, addr, vid, want);
> +
> +	if (held) {
> +		/* Pairs with the barrier in dsa_user_bridge_host_fdb_release():
> +		 * either it sees the record, or the entry has moved by the time
> +		 * it is looked up again.
> +		 */
> +		smp_mb();
> +		want = dsa_user_bridge_host_fdb_wanted(dev, bridge, addr, vid,
> +						       leaving);
> +		held = dsa_user_bridge_host_fdb_set(dev, bridge, addr, vid,
> +						    want);
> +	}
> +
> +	if (held && !del)
> +		dsa_fdb_offload_notify(switchdev_work);
> +}
> +
> +/* Only the user port an entry is on gets its events, so when the entry roams
> + * there, release it on the ports of the bridge that still hold it.
> + */
> +static void dsa_user_bridge_host_fdb_release_work(struct work_struct *work)
> +{
> +	struct dsa_switchdev_event_work *switchdev_work =
> +		container_of(work, struct dsa_switchdev_event_work, work);
> +	const unsigned char *addr = switchdev_work->addr;
> +	struct net_device *dev = switchdev_work->dev;
> +	u16 vid = switchdev_work->vid;
> +	const struct dsa_bridge *bridge;
> +	enum dsa_host_fdb_want want;
> +
> +	bridge = READ_ONCE(dsa_user_to_port(dev)->bridge);
> +	if (bridge) {
> +		want = dsa_user_bridge_host_fdb_wanted(dev, bridge, addr, vid,
> +						       NULL);
> +		dsa_user_bridge_host_fdb_set(dev, bridge, addr, vid, want);
> +	}
> +
> +	kfree(switchdev_work);
> +}
> +
> +struct dsa_user_release_ctx {
> +	const unsigned char *addr;
> +	u16 vid;
> +	bool dynamic;
> +	int err;
> +};
> +
> +static int dsa_user_bridge_host_fdb_release_one(struct net_device *lower,
> +						struct netdev_nested_priv *priv)
> +{
> +	struct dsa_user_release_ctx *ctx = (void *)priv->data;
> +	struct dsa_switchdev_event_work *switchdev_work;
> +	struct dsa_user_priv *p;
> +
> +	if (!dsa_user_dev_check(lower))
> +		return 0;
> +
> +	/* A learned entry cannot replace a local one, so only the addresses
> +	 * held for foreign entries can be affected
> +	 */
> +	p = netdev_priv(lower);
> +	if (!READ_ONCE(p->dp->bridge) ||
> +	    !atomic_read(ctx->dynamic ? &p->bridge_host_fdbs_foreign_n :
> +					&p->bridge_host_fdbs_n))
> +		return 0;
> +
> +	switchdev_work = kzalloc_obj(*switchdev_work, GFP_ATOMIC);
> +	if (!switchdev_work) {
> +		ctx->err = -ENOMEM;
> +		return 0;
> +	}
> +
> +	INIT_WORK(&switchdev_work->work, dsa_user_bridge_host_fdb_release_work);
> +	switchdev_work->dev = lower;
> +	ether_addr_copy(switchdev_work->addr, ctx->addr);
> +	switchdev_work->vid = ctx->vid;
> +
> +	dsa_schedule_work(&switchdev_work->work);
> +
> +	return 0;
> +}
> +
> +/* Called under rcu_read_lock() */
> +static int dsa_user_bridge_host_fdb_release(struct net_device *dev,
> +					    const unsigned char *addr, u16 vid,
> +					    bool dynamic)
> +{
> +	struct dsa_user_release_ctx ctx = {
> +		.addr = addr, .vid = vid, .dynamic = dynamic,
> +	};
> +	struct netdev_nested_priv priv = { .data = &ctx };
> +	struct net_device *br = dsa_port_bridge_dev_get(dsa_user_to_port(dev));
> +
> +	if (!br)
> +		return 0;
> +
> +	/* Pairs with the barrier in dsa_user_bridge_host_fdb_sync() */
> +	smp_mb();
> +	netdev_walk_all_lower_dev_rcu(br, dsa_user_bridge_host_fdb_release_one,
> +				      &priv);
> +
> +	return ctx.err;
> +}
> +
> +void dsa_user_bridge_host_fdb_purge(struct dsa_port *dp,
> +				    const struct dsa_bridge *bridge)
> +{
> +	struct dsa_user_priv *p = netdev_priv(dp->user);
> +	struct dsa_user_host_fdb *a, *tmp;
> +	int err;
> +
> +	list_for_each_entry_safe(a, tmp, &p->bridge_host_fdbs, list) {
> +		err = dsa_port_bridge_host_fdb_del(dp, bridge, a->addr, a->vid);
> +		if (err)
> +			dev_err(dp->ds->dev,
> +				"port %d failed to delete %pM vid %d from fdb: %d\n",
> +				dp->index, a->addr, a->vid, err);
> +		list_del(&a->list);
> +		atomic_dec(&p->bridge_host_fdbs_n);
> +		if (!a->local)
> +			atomic_dec(&p->bridge_host_fdbs_foreign_n);
> +		kfree(a);
> +	}
> +}
> +
>  static void dsa_user_switchdev_event_work(struct work_struct *work)
>  {
>  	struct dsa_switchdev_event_work *switchdev_work =

[Severity: Medium]
Can dsa_user_bridge_host_fdb_release_work() add or keep a hold, when
it is only meant to release one?

It hands whatever dsa_user_bridge_host_fdb_wanted() returns straight to
dsa_user_bridge_host_fdb_set(). If the entry has moved on to a foreign
port, or been replaced by a local entry, by the time the work runs,
want is FOREIGN or LOCAL. The hold is then kept, or newly installed
through dsa_port_bridge_host_fdb_add().

dsa_user_fdb_event() queues the release work ahead of the user port's
own non-host work item. Take an entry going foreign -> lan1 -> foreign
while dsa_owq is backed up behind slow MDIO, SPI or I2C FDB ops. The
queue can run like this:

  release_work(lan2)          want == FOREIGN, hold kept or added
  event_work(lan1, ADD)       dsa_port_fdb_add() on lan1
  sync(lan2, ADD, host_addr)  record found, returns true

On switches that keep one entry per {MAC, VID}, the dsa_port_fdb_add()
for lan1 overwrites the CPU-directed entry. The later host_addr sync on
lan2 finds its record in bridge_host_fdbs, and
dsa_user_bridge_host_fdb_set() returns true without reprogramming
anything.

The software then records the address as held on the CPU port. The
hardware points it at lan1, or has removed it if a DEL for lan1 also
ran. The new comment in dsa_user_fdb_event() says the early release
exists to avoid exactly this overwrite.

Should the release work only act when want is DSA_HOST_FDB_NONE, and
leave adding holds to the host_addr events?

The release work also skips the smp_mb() and second lookup done in
dsa_user_bridge_host_fdb_sync(). __fdb_update() sends RTM_DELNEIGH
before br_fdb_dst_write(). A release work running in that window sees
the old foreign port and adds a hold.

The record and bridge_host_fdbs_foreign_n only become visible after
dsa_port_bridge_host_fdb_add() returns, which can be slow. Suppose the
roaming CPU writes fdb->dst and reaches
dsa_user_bridge_host_fdb_release() before then. Then
dsa_user_bridge_host_fdb_release_one() sees a zero counter and skips
this port. The hold leaks until the port leaves the bridge.

dsa_user_bridge_host_fdb_sync() has a similar gap. If the first lookup
sees a local entry, bridge_host_fdbs_foreign_n is not raised. If the
lookup after smp_mb() then sees a foreign port, the retag in
dsa_user_bridge_host_fdb_set() raises the counter after the barrier,
with no further barrier and recheck. A concurrent dynamic release can
read 0 and skip this port.

Does the retag from local to foreign need the same barrier and
re-lookup as a new hold?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1794696608.git.julius%40bairaktaris.de
