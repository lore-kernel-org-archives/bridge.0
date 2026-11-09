Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794223698;
	b=ThmCHtWg0q3idVBxAnzyu6pCJXOF8Gp/Sm0MLMAxD+8YIhycLNrcAUY1PC0XyGVU8izd
	 SZF0Ie0QLy5VlCWZorchNUOQ/VUTs2s6d6PYwMrd7l75WtMfSvKqIerRjlfvDQrhMgDEz
	 sy73TrGj5YG4+r1h2Sa0Mx01HiFjcK/etfBfDNpvAl6xtRVvH0CjVAW0QV+87qVenOqOC
	 ywmR0Vssci3KmwgezaXWueJ121POVknAsXm9QtQt6Zs7QO0Jc2mDQK27mpXfie9O2wXPg
	 x/OlwvcXn9wzrXjqC1H/pQW9Rreksyug5s3tLPbENIlSiFUABn08zrfq5UFk87+kb6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794223698;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=rcHTCLoiD18h20jwBJcPsaE78+LwRRn5ETg+aDeT7G8=;
	b=IpzhN5uKOq27sn4o2AOhtB1M2xFVZe5n/iHwCeUxreIua7i5/suKoPV5x2OY9/yNt57T
	 cIbHXq3dhbs8O8iCNu9dToUowm/8Y79DZcUDIArC0jYkhcEm05riauBqngdSaEg0xzjA+
	 +XdAGMLJUpWSggDCL+I9hrlm/msbNfc8jhYoqU2igzdc9RBqHDqPCd7dkOyrHePF+XV8G
	 26QATseHfyW3g1tD4jkZjQxWFafkv4RvvNbxQx5ThT8yjvOeY5mk75XpJEALexwonNELs
	 cPFdz3+I15UlebBpFskZBxs6duzy8BGzbeRBIvDld1GjVQ3gFAORoyNrX+MZ8Cc7pmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X64RRCJP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E33606A325;
	Mon,  9 Nov 2026 11:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X64RRCJP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C16D51F008A1;
	Mon,  9 Nov 2026 11:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794223697;
	bh=rcHTCLoiD18h20jwBJcPsaE78+LwRRn5ETg+aDeT7G8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=X64RRCJP62re2uL0lFLGz20ldOyg68ABu1z00Eugs+ThOgNHzAue9irvrb3aJQSXF
	 pC5+f4cHzy6Eyv/IW5IoroloTSmjDsR/o1IZm3HXhGjCnkOelDQG/aJNM1sQpCdHNM
	 g6IjVIRv0Vk44gGUsrRyAE9r0OMdoiR/l2e98BZYN0Mo/uCGM/vRrIZmmibjatJHjY
	 07pQ+Gd5nDxk4MER/skNW7IdwXIW7z2WvxNAqt8WLF3QfwUa78OEdyQTq0ikKxZFzR
	 wZhikygN/aUK8fdddriUaseNRk8e6HsL/ilNLNyIiva2tRVvOyAmkD4mPZzm/fWXU1
	 8qNBD0YdcQYTA==
Subject: Re: [PATCH net-next 2/2] net: dsa: fix host fdb refcount when a
 bridge fdb entry roams
From: netdev-bot+sashiko@kernel.org
To: julius@bairaktaris.de
Cc: razor@blackwall.org, idosch@nvidia.com, andrew@lunn.ch, olteanv@gmail.com,
 netdev@vger.kernel.org, bridge@lists.linux.dev, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-kernel@vger.kernel.org
Date: Mon, 09 Nov 2026 11:28:16 +0000
Message-ID: <179422369637.994134.1102331366106660794@kernel.org>
In-Reply-To: <682c2f99d3e5c61e620d768a31107b2cc7db51a6.1794134495.git.julius@bairaktaris.de>
References: <682c2f99d3e5c61e620d768a31107b2cc7db51a6.1794134495.git.julius@bairaktaris.de>
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

Thank you for your contribution! Sashiko AI review found 11 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 7 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix does not cover cross-tree bridges, although the commit
  message says it does.
- [High] The join rollback path out_rollback_unbridge now dereferences
  NULL in queued work.
- [Medium] The commit message says "Addresses local to the bridge do not
  roam and are still counted." That is wrong for `bridge fdb replace`.
- [Medium] dsa_user_bridge_host_fdb_sync() sends SWITCHDEV_FDB_OFFLOADED
  for every ADD where want is true, even when the host address was not…
- [Medium] Retrying a failed host delete drops the conduit's unicast-
  filter reference twice.
- [Medium] Every dynamically learned ADD on a DSA user port now costs a
  GFP_ATOMIC allocation and a work item, on every DSA switch.
- [Medium] On a "bridge fdb replace" of an address from a foreign port
  onto a DSA user port, the user's new static entry is erased from…
- [Medium] net: dsa: dsa_user_bridge_host_fdb_wanted() ignores
  assisted_learning_on_cpu_port
- [Medium] net: dsa: dsa_user_fdb_event() skips host FDB release on LAG
  without lag_fdb_add
- [Low] The patch fixes a user-visible bug (`port N failed to delete ...
  from fdb: -2` and host addresses left on the CPU port) but has no…
- [Low] The patch turns dp->bridge into a lockless clear-then-flush
  protocol: WRITE_ONCE(dp->bridge, NULL), then dsa_flush_workqueue(),…

--

net: dsa: fix host fdb refcount when a bridge fdb entry roams

This replaces the counted host address handling for bridge FDB entries
on foreign ports with a per-user-port list of held addresses. The list
is re-evaluated against the bridge FDB on every event. Additions on a
user port schedule a release of the address on the other ports of the
bridge, and dsa_port_bridge_destroy() now flushes the workqueue and
purges the held records.

> are released. Addresses local to the bridge do not roam and are still
> counted. The software bridge is not changed.

[ ... ]

> Signed-off-by: Julius Bairaktaris <julius@bairaktaris.de>

[Severity: Low]
This fixes a user-visible error ("port 1 failed to delete ... from fdb:
-2") and a host address left on the CPU port, but there is no Fixes:
tag. Could one be added so stable and backporters can tell where this
applies?

The fix also depends on br_switchdev_fdb_find_port(), which
dsa_user_bridge_host_fdb_wanted() calls. That helper is added by the
preceding bridge commit ("net: bridge: switchdev: add
br_switchdev_fdb_find_port()").

Given "The software bridge is not changed" in the message, could that
dependency be stated explicitly?

> diff --git a/net/dsa/port.c b/net/dsa/port.c
> index 1f5536c0dffc2..e270a0c5e6641 100644
> --- a/net/dsa/port.c
> +++ b/net/dsa/port.c
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

[Severity: High]
Can the pending FDB works dereference a NULL bridge on this rollback
path?

out_rollback_unbridge is reached when switchdev_bridge_port_offload()
fails, and nothing unoffloads or flushes first. Its FDB replay
(br_switchdev_fdb_replay()) delivers every bridge FDB entry with
ctx = dp. Local entries such as the bridge and port MACs reach
dsa_user_fdb_event() with is_local set, so they get host_addr = true
and sync = false. A plain dsa_user_switchdev_event_work() item is
queued for each one.

If a later replayed entry fails, the replay stops and the error comes
back here. One way this happens is the GFP_ATOMIC allocation in
dsa_user_fdb_event(). Another is the new
dsa_user_bridge_host_fdb_release(), which returns -ENOMEM after a work
item has already been queued.

dsa_port_bridge_destroy() now does WRITE_ONCE(dp->bridge, NULL) before
dsa_flush_workqueue(). So every work still pending runs with
dp->bridge == NULL, and only the new sync branch checks for that. The
non-sync ADD branch does:

dsa_user_switchdev_event_work()
  dsa_port_bridge_host_fdb_add(dp, addr, vid)
    __dsa_port_bridge_host_fdb_add(dp, dp->bridge, addr, vid)
      .bridge = *bridge,

dsa_port_fdb_add() also evaluates *dp->bridge.

The commit message says the workqueue is flushed when the port "fails
to join" the bridge. Does the non-sync path need a NULL bridge check
too, or should the flush happen before dp->bridge is cleared?

[ ... ]

> diff --git a/net/dsa/user.c b/net/dsa/user.c
> index 041f9060c8ef0..7f18c7885b9c5 100644
> --- a/net/dsa/user.c
> +++ b/net/dsa/user.c

[ ... ]

> @@ -3639,6 +3658,171 @@ dsa_fdb_offload_notify(struct dsa_switchdev_event_work *switchdev_work)
>  				 switchdev_work->orig_dev, &info.info, NULL);
>  }
>  

[ ... ]

> +static void dsa_user_bridge_host_fdb_set(struct net_device *dev,
> +					 const struct dsa_bridge *bridge,
> +					 const unsigned char *addr, u16 vid,
> +					 bool want)
> +{

[ ... ]

> +	} else {
> +		err = __dsa_port_bridge_host_fdb_del(dp, bridge, addr, vid);
> +		if (err) {
> +			dev_err(dp->ds->dev,
> +				"port %d failed to delete %pM vid %d from fdb: %d\n",
> +				dp->index, addr, vid, err);
> +			return;
> +		}

[Severity: Medium]
After a failed delete the record is kept. Can that call dev_uc_del()
on the conduit more than once for a single dev_uc_add()?

__dsa_port_bridge_host_fdb_del() does:

	if (conduit->priv_flags & IFF_UNICAST_FLT) {
		err = dev_uc_del(conduit, addr);
		if (err)
			return err;
	}

	return dsa_port_host_fdb_del(dp, addr, vid, db);

Suppose dev_uc_del() succeeds and dsa_port_host_fdb_del() fails, for
example with a driver port_fdb_del() error. The dev_uc_del() is not
undone, but the record stays on bridge_host_fdbs. A later want == false
event, or dsa_user_bridge_host_fdb_purge(), then repeats the whole
delete, including another dev_uc_del().

The conduit uc list is refcounted per MAC and shared across VIDs,
bridges and other host address users. The extra delete can drop
another holder's reference.

When that holder later releases, dev_uc_del() returns -ENOENT, and
__dsa_port_bridge_host_fdb_del() returns before the switch delete.
dsa_user_bridge_host_fdb_purge() then logs the error and frees the
record anyway:

	err = __dsa_port_bridge_host_fdb_del(dp, bridge, a->addr,
					     a->vid);
	if (err)
		dev_err(...);
	list_del(&a->list);
	kfree(a);

Would the CPU port FDB entry then stay programmed, with nothing left
to remove it?

> +
> +		list_del(&a->list);
> +		kfree(a);
> +	}
> +}
> +
> +static void
> +dsa_user_bridge_host_fdb_sync(struct dsa_switchdev_event_work *switchdev_work)
> +{

[ ... ]

> +	dsa_user_bridge_host_fdb_set(dev, bridge, switchdev_work->addr,
> +				     switchdev_work->vid, want);
> +	if (want && !del)
> +		dsa_fdb_offload_notify(switchdev_work);
> +}

[Severity: Medium]
Is SWITCHDEV_FDB_OFFLOADED sent here even when the host address was not
installed?

dsa_user_bridge_host_fdb_set() returns void. It can return early
without installing anything:

	if (want) {
		a = kzalloc_obj(*a);
		if (!a)
			return;

It does the same when __dsa_port_bridge_host_fdb_add() fails.

The caller still calls dsa_fdb_offload_notify() whenever want is true,
so the bridge marks the entry offloaded. Before this patch, the error
path in dsa_user_switchdev_event_work() did a break and skipped the
notification.

Could dsa_user_bridge_host_fdb_set() report whether the address ended
up held, so the notification is only sent then?

> +
> +/* Only the user port an entry is on gets its events, so when the entry roams
> + * there, release it on the ports of the bridge that still hold it.
> + */
> +static void dsa_user_bridge_host_fdb_release_work(struct work_struct *work)
> +{
> +	struct dsa_switchdev_event_work *switchdev_work =
> +		container_of(work, struct dsa_switchdev_event_work, work);
> +	struct dsa_port *dp = dsa_user_to_port(switchdev_work->dev);
> +	const unsigned char *addr = switchdev_work->addr;
> +	const struct dsa_bridge *bridge = READ_ONCE(dp->bridge);
> +	u16 vid = switchdev_work->vid;
> +	struct dsa_port *other;
> +
> +	if (bridge) {
> +		dsa_tree_for_each_user_port(other, dp->ds->dst) {

[Severity: High]
Does this release reach the user ports of other trees in the same
bridge?

The commit message says an entry on a user port, "also one of another
tree", is not held. It also says "an addition there releases the
address on the other ports of the bridge". This loop only walks
dp->ds->dst, which is the tree of the port that got the ADD.

For an entry on a DSA user port,
__switchdev_handle_fdb_event_to_device() only delivers the event to
that port:

	if (check_cb(dev))
		return mod_cb(dev, orig_dev, event, info->ctx, fdb_info);

Take trees A and B in one bridge, with ADDR on a foreign port such as
a veth. Every user port of both trees holds ADDR. Then run this, where
swpB is a tree B user port:

  bridge fdb replace ADDR dev swpB master static

fdb_add_entry() only notifies RTM_NEWNEIGH. Only swpB gets the event,
and the release work only visits tree B. Tree A's ports never call
dsa_user_bridge_host_fdb_set(..., false).

Would ADDR stay on tree A's CPU port until those ports leave the
bridge, even after the entry is deleted? Should this walk every tree
in dsa_tree_list instead?

> +			if (dsa_port_offloads_bridge_dev(other, bridge->dev) &&
> +			    !dsa_user_bridge_host_fdb_wanted(other->user, bridge,
> +							     addr, vid, NULL))
> +				dsa_user_bridge_host_fdb_set(other->user, bridge,
> +							     addr, vid, false);

[Severity: Low]
Do these reads of the other ports' dp->bridge race with
dsa_port_bridge_destroy() on those ports?

dsa_port_bridge_destroy() clears dp->bridge with WRITE_ONCE() before it
flushes the workqueue. So this work can run while port "other" is
leaving the bridge.

dsa_port_offloads_bridge_dev() goes through dsa_port_bridge_dev_get():

	return dp->bridge ? dp->bridge->dev : NULL;

That is two plain loads. dsa_user_bridge_host_fdb_wanted() reaches
similar plain reads through dsa_foreign_dev_check() ->
dsa_tree_offloads_bridge_dev() / dsa_tree_offloads_bridge_port(). On
the writer side, dsa_port_bridge_create() still publishes with a plain
dp->bridge = bridge.

KCSAN would report these races. If the compiler reloads dp->bridge
between the check and the dereference, the dereference can see NULL.

Should the remaining dp->bridge accesses in this scheme be annotated
too?

> +		}
> +	}
> +
> +	kfree(switchdev_work);
> +}

[ ... ]

> @@ -3723,7 +3897,9 @@ static int dsa_user_fdb_event(struct net_device *dev,
>  
>  	if (switchdev_fdb_is_dynamically_learned(fdb_info)) {
>  		if (dsa_port_offloads_bridge_port(dp, orig_dev))
> -			return 0;
> +			return event == SWITCHDEV_FDB_ADD_TO_DEVICE ?
> +			       dsa_user_bridge_host_fdb_release(dev, fdb_info->addr,
> +								fdb_info->vid) : 0;

[Severity: Medium]
When ds->assisted_learning_on_cpu_port is not set, can this keep a
host address held that nothing will ever release?

dsa_user_fdb_event() drops dynamically learned entries on foreign
ports, both ADD and DEL, when assisted_learning_on_cpu_port is false.
User-added entries on foreign ports still go through
dsa_user_bridge_host_fdb_sync().

The lookup here does not make that distinction.
br_switchdev_fdb_find_port() returns the port of any non-local entry,
including one the bridge learned dynamically.

Consider a static entry for ADDR on veth0, where veth0 and veth1 are
both foreign ports of the bridge. Then run:

  bridge fdb del ADDR dev veth0 master

Suppose a frame from ADDR arrives on veth1 before the DEL work runs on
dsa_owq, and the bridge learns ADDR there. That ADD is dynamically
learned, so dsa_user_fdb_event() returns 0 for it.

When the DEL work then calls dsa_user_bridge_host_fdb_wanted(), brport
is veth1. veth1 is not leaving, is not a DSA user port, and is
foreign. So want is true and the record on bridge_host_fdbs is kept.

When the dynamic entry on veth1 ages out, its DEL is dropped by the
same assisted_learning_on_cpu_port check, so no sync work is queued.
The address stays on the CPU port until the user ports leave the
bridge.

Should dsa_user_bridge_host_fdb_wanted() apply the same filter as
dsa_user_fdb_event()? For example, the lookup could also report
whether the entry was dynamically learned. Or should DEL events for
addresses a port holds bypass that filter?

[Severity: Medium]
Does every dynamically learned ADD on a user port now cost a GFP_ATOMIC
allocation and a work item, on every DSA switch?

Before this patch, this branch returned 0 right away. It now runs
before the ds->assisted_learning_on_cpu_port check. So it applies even
when no port holds any bridge host address and the work has nothing to
do.

Each release work walks every user port of the tree. For each bridged
port it does an RCU FDB lookup and a linear scan of bridge_host_fdbs.
All of this runs on the single ordered dsa_owq. Non-host static ADDs
also queue two work items, the normal one and the release.

An L2 peer on a user port can send frames with changing source MACs.
The bridge learns each one, since the default fdb_max_learned of 0
means no limit. Each learn then queues work that competes with real
FDB programming on the ordered workqueue.

Is this cost intended for switches that never hold bridge host
addresses?

>  
>  		/* FDB entries learned by the software bridge or by foreign
>  		 * bridge ports should be installed as host addresses only if
> @@ -3768,9 +3944,15 @@ static int dsa_user_fdb_event(struct net_device *dev,
>  	ether_addr_copy(switchdev_work->addr, fdb_info->addr);
>  	switchdev_work->vid = fdb_info->vid;
>  	switchdev_work->host_addr = host_addr;
> +	switchdev_work->sync = host_addr && !fdb_info->is_local;

[Severity: Medium]
The commit message says "Addresses local to the bridge do not roam and
are still counted." Does that hold for bridge fdb replace?

In fdb_add_entry(), an existing entry on a foreign port can be turned
into a local br0 entry in place. fdb_update_dst() changes the
destination, NUD_PERMANENT sets BR_FDB_LOCAL, and only RTM_NEWNEIGH is
notified, with no deletion. The reverse change is also possible.

Here the local ADD has is_local set, so it gets sync = false. It goes
to the counted path, which never touches bridge_host_fdbs. Consider:

  bridge fdb replace ADDR dev br0 self local
  bridge fdb del ADDR dev br0 self

Only the counted reference is dropped. The records held from the
foreign phase keep ADDR on the CPU port until the ports leave the
bridge.

In the other direction, from local to static on a foreign port, the
counted reference from the local phase is never dropped.

Should this replace case be handled like the user port one?

> +	switchdev_work->replay = !!ctx;
>  
>  	dsa_schedule_work(&switchdev_work->work);
>  
> +	if (!host_addr && event == SWITCHDEV_FDB_ADD_TO_DEVICE)
> +		return dsa_user_bridge_host_fdb_release(dev, fdb_info->addr,
> +							fdb_info->vid);
> +

[Severity: Medium]
Can the release be skipped when a static entry moves onto a LAG?

Take a user-added entry on a LAG that the port offloads. orig_dev is
the LAG device, dsa_foreign_dev_check() returns false, and host_addr
stays false. dsa_user_fdb_event() then reaches this check, which comes
before the new call to dsa_user_bridge_host_fdb_release():

	if (dp->lag && !host_addr) {
		if (!ds->ops->lag_fdb_add || !ds->ops->lag_fdb_del)
			return -EOPNOTSUPP;

Drivers that offload LAGs but have no lag_fdb_add/lag_fdb_del, such
as mv88e6xxx and qca8k, return -EOPNOTSUPP there.

Suppose every user port of the bridge holds ADDR as a host address,
because the entry is on a foreign port such as a veth. Then run:

  bridge fdb replace ADDR dev bond0 master static

Here bond0 is an offloaded LAG of user ports. fdb_add_entry() only
notifies RTM_NEWNEIGH, so no DEL for the veth reaches DSA. The commit
message relies on the release for this replace case, but the release
is never scheduled. Nothing later re-evaluates the records either.
The address stays on the CPU port until the user ports leave the
bridge.

Dynamically learned ADDs on the LAG are not affected, since they take
the dsa_port_offloads_bridge_port() branch earlier. Should the release
be scheduled before the lag_fdb_add/lag_fdb_del check, so it does not
depend on whether the driver can install the entry itself?

[Severity: Medium]
On a bridge fdb replace from a foreign port onto a user port, can the
release erase the static entry that was just installed on the user
port?

The normal work queued above installs the entry on the user port
through ds->ops->port_fdb_add(). The release work runs after it on the
ordered dsa_owq. Dropping the last hold reaches ds->ops->port_fdb_del()
on the CPU port for the same MAC and VID.

On switches with a single unicast entry per {MAC, VID}, that delete
does not check which port owns the entry. b53_arl_op() does this for
unicast, with is_valid false on a delete:

	if (!is_multicast_ether_addr(addr)) {
		ent.port = port;
		ent.is_valid = is_valid;

mt7530_port_fdb_del() writes STATIC_EMP for the MAC/VID whatever the
owner:

	mt7530_fdb_write(priv, vid, port_mask, addr, -1, STATIC_EMP);

ocelot_fdb_del() takes no port argument:

	return ocelot_mact_forget(ocelot, addr, vid);

Would the static entry then be missing from hardware, even though the
bridge already received SWITCHDEV_FDB_OFFLOADED for it?

>  	return 0;
>  }

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1794134495.git.julius%40bairaktaris.de
