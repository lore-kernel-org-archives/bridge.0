Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795418885;
	b=gmjGUb7kD5K6uG+u/yKujhtZZ5G2clsNGRqg8n9G/LvTt1CEVMQYVFeWxy0/WBojVLt/
	 8vT9nIDPm4ZkI4pw/ZWf35XxINXux36mLf65AgCdhUY9vgr6ksASytMs2PfexC7FNxm0J
	 G5BUfkb0duihdk8Rh6mjPDCwLHhvKqH+eIzybH6cDYhR0EJlxlM3oW49Dkh5B3NeslRx1
	 ZLivL9oojvdxd0A/HaGu6e2Y+IF3oYKfKwLytBcKHgs9dKiy1y4RR9PYVjn9HSjKE4K/G
	 2QVR3KCbjYQK/I7YKvXCnzkdLM3TkuhCGkb8f1xx2iEVFOhhX1BzWpPuSPQ6q4VRQBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795418885;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=BFjNFEEl1ZT74xqErJR3pC77rX17KqsrmpJsd3ndC1c=;
	b=yFGh9qYpXtLYAhzuixkm7deWJp7qu2k6aFsc3jL9EpvHXcvr+diJpVWvmg1LcluGty90
	 pc4FF9BgcsQ7Dmh/EQiL4xi9QE4+FgFEWu+rNBE5ihspiU1AqSbRpKjQaMam2Z6rrNusa
	 QtWyVhT/kO3OpUujZy2Y6kvJhUD4Q/XrDak38snAprF3hEOwAlqYcxGyTdZryPjOIFtKR
	 ha/tWD7vX3NPuhL3/FUEfpTgEJN5fuPx91I4XiQm0puwJf1kzGhmo5lz/C07fkO3B6Fhl
	 zQcxc1swDjl20l//l9WNexKU3I899oHgu/7TvS8f+OKX7Nqy9exajcgmZXr8EY4HobQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Txo8TGOe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48054606A32E;
	Mon, 23 Nov 2026 07:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Txo8TGOe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D6CF1F000CF;
	Mon, 23 Nov 2026 07:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795418884;
	bh=BFjNFEEl1ZT74xqErJR3pC77rX17KqsrmpJsd3ndC1c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Txo8TGOeVw2zWIThv5bGWVZsmXDaNUK+q6gnWiORIoXhewj9czojPiJYAqgmcuvzM
	 fMk8LX9Pmds7/cH6qbiiIzYP5lHPVx6vcHJr2/gNTOO1YfL9oeDzTziRT5mO782ulC
	 44n3rtgnziBhKi97kCfmRkgv/gkqVSD3YXLWJ9aw6qd24upSWWw6IiK4m0JoDYMAU5
	 QQKtHbcwqKN0lT0r5H5uJzfX2v3KA7Y6+ulWoeTrDjc9aR59qGSvFIGz0T0viHnGpU
	 1jReja7KeCtGsU/ahGIZbuyLWeTagJCOSw8s7mUNEayOlUJ+gpKpZTzi7V2+Ci9pKW
	 eg8NVlDwgjsQg==
Subject:
 Re: [PATCH net 2/2] selftests: bridge_mdb: Test failed source list replace
From: netdev-bot+sashiko@kernel.org
To: idosch@nvidia.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@kernel.org, willemb@google.com, horms@kernel.org,
 razor@blackwall.org, dsahern@kernel.org, shuah@kernel.org,
 bridge@lists.linux.dev, linux-kselftest@vger.kernel.org,
 kyuwoncho18@gmail.com
Date: Mon, 23 Nov 2026 07:28:03 +0000
Message-ID: <179541888360.3135.4706984344785286288@kernel.org>
In-Reply-To: <20261122072504.2623702-2-idosch@nvidia.com>
References: <20261122072504.2623702-2-idosch@nvidia.com>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] A failed (*, G) replace still leaves the existing sources
  partly changed, and the new test cannot see it.

--

selftests: bridge_mdb: Test failed source list replace

This commit adds a test case to __cfg_test_port_ip_star_g() in
bridge_mdb.sh for the fix in "bridge: mcast: Fix source list rollback on
failure". The replace request lists an existing source twice, then a new
source, then an invalid source. The test checks that after the failed
replace the existing (S, G) entries are still present and the new one was
not created.

> diff --git a/tools/testing/selftests/net/forwarding/bridge_mdb.sh b/tools/testing/selftests/net/forwarding/bridge_mdb.sh
> index e86d779465853..712b9a5a0e5fe 100755
> --- a/tools/testing/selftests/net/forwarding/bridge_mdb.sh
> +++ b/tools/testing/selftests/net/forwarding/bridge_mdb.sh

[ ... ]

> @@ -487,6 +488,23 @@ __cfg_test_port_ip_star_g()
>  
>  	bridge mdb del dev br0 port $swp1 grp $grp vid 10
>  
> +	# Check that a failed replace does not change the source list.
> +	bridge mdb add dev br0 port $swp1 grp $grp temp vid 10 \
> +		filter_mode exclude source_list $src1,$src2
> +
> +	bridge mdb replace dev br0 port $swp1 grp $grp temp vid 10 \
> +		filter_mode exclude source_list $src1,$src1,$src3,$invalid_src \
> +		&> /dev/null
> +	check_fail $? "Managed to replace source list with an invalid source"
> +	bridge -d mdb get dev br0 grp $grp src $src1 vid 10 &> /dev/null
> +	check_err $? "(S, G) entry for source $src1 deleted after failed replace"
> +	bridge -d mdb get dev br0 grp $grp src $src2 vid 10 &> /dev/null
> +	check_err $? "(S, G) entry for source $src2 deleted after failed replace"
> +	bridge -d mdb get dev br0 grp $grp src $src3 vid 10 &> /dev/null
> +	check_fail $? "(S, G) entry for source $src3 created after failed replace"

[Severity: Medium]
The add and the failed replace both use temp, filter_mode exclude and the
default proto. The test then only checks whether the (S, G) entries exist.
Would a partly applied replace of an existing source be caught here?

In net/bridge/br_mdb.c the replace path is:

br_mdb_replace_group_star_g()
  br_mdb_replace_group_srcs()
    br_mdb_add_group_srcs()
      br_mdb_add_group_src()    <- once per source, in order

For a source that already exists, br_mdb_add_group_src() changes its timer
and replaces its (S, G) entry before the later sources are processed:

net/bridge/br_mdb.c:br_mdb_add_group_src() {
    ...
	if (cfg->filter_mode == MCAST_INCLUDE &&
	    cfg->entry->state == MDB_TEMPORARY)
		mod_timer(&ent->timer, now + br_multicast_gmi(brmctx));
	else
		timer_delete(&ent->timer);

	/* Install a (S, G) forwarding entry for the source. */
	err = br_mdb_add_group_src_fwd(cfg, &src->addr, brmctx, extack);
    ...
}

br_mdb_add_group_src_fwd()->br_mdb_add_group_sg()->br_mdb_replace_group_sg()
then rewrites the existing (S, G) port group and notifies userspace:

net/bridge/br_mdb.c:br_mdb_replace_group_sg() {
    ...
	pg->flags = flags;
	pg->rt_protocol = cfg->rt_protocol;
	...
	br_mdb_notify(cfg->br->dev, mp, pg, RTM_NEWMDB);
    ...
}

A later source can fail. In this test that is 0.0.0.0 or ::, where
br_multicast_new_group_src() returns NULL and the call returns -ENOSPC.
The rollback then only removes BR_SGRP_F_NEW entries and clears
BR_SGRP_F_DELETE:

br_mdb_add_group_srcs():
err_del_group_srcs:
	hlist_for_each_entry_safe(ent, tmp, &pg->src_list, node) {
		if (ent->flags & BR_SGRP_F_NEW)
			br_multicast_del_group_src(ent, false);
	}
	return err;

br_mdb_replace_group_srcs():
err_clear_delete:
	hlist_for_each_entry(ent, &pg->src_list, node)
		ent->flags &= ~BR_SGRP_F_DELETE;
	return err;

br_mdb_replace_group_star_g() then returns early. The (*, G) port group
keeps its old flags, filter_mode and protocol. Its existing sources and
their (S, G) entries keep the new settings.

For example:

  bridge mdb add ... temp filter_mode include source_list S1
  bridge mdb replace ... permanent filter_mode include source_list S1,0.0.0.0

Does this delete S1's source timer, so the temporary INCLUDE entry never
ages out? Does it also leave the (S, G) entry PERMANENT while the (*, G)
entry is still temporary? Userspace would also get an RTM_NEWMDB
notification for a request that failed.

Before this series, the rollback deleted every source it had processed, so
the changed state did not survive. "bridge: mcast: Fix source list rollback
on failure" now keeps the existing entries, which leaves the changed state
in place.

Should that fix also restore the timer and (S, G) state of the existing
sources? Could the replace in this test also use different attributes, for
example permanent, filter_mode include or a different proto? It could then
check that the existing (S, G) entries keep their original flags, protocol
and timer.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261122072504.2623702-1-idosch%40nvidia.com
