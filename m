Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795418884;
	b=teeR6JI5Sil9VG6k/XjBBnssaBvq/j4P9Kz3ixTBKj5sEaKkoMhe2uLXT1pKGNbrhmuu
	 oafPGb0oXgbTBOm6zelb4Aq9+GA5PTuDA8hKW8rmfw/8dIjMuwwyvl2By6TaMv8rUu8p5
	 1OwEKXgESNlunI34d7dP0m2ZkkpxYdYfGF6jCo5NBmMUxjHJ5aGXNF83r8zdDgeLPwCwZ
	 zdGocxWm+SgVFMa+fdxgsDMdLxJtw7GyqKLfnPw6en4dx7QGyE6XoMv1az5efJGWxJ4Lb
	 KoKn7bybdeHPXx78QvMuh8EUbuNe7+cRC86F61HOv7mgK+LRQRtmCp7GksetPraQUdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795418884;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=JR6Iu4izND+o7EkZgh6TIoF3sPp+Q9MpVOR8wNz04Uk=;
	b=LA+bylAdwUG4JxpfxtaBgS5bxc4xn+ZOxBglq6V2j45kEdlYSNUOoKbiS9rB3Bj2aXmj
	 yq0290MQUKSLxO/5tVY5fq93R6c9BqOlaDO7UwIhUFSlufdZU+7ifFv9tDlZOsAC+qmCF
	 YFYLKLhKqgASKOJQCqUH/85aKNPGTfdhHWZJYF7yCLzezuGq1tpe4cv9M9HVb0s0PUAud
	 gSWCUQ/ugwPl2N6TjRm5BWH3Y6ypTRoLKI7eQ7hcvoKkIXimbAKbst+ikxGc1ng59TIVG
	 x7MUNapW9Y6dirw4td196zkT/prGc/YwJkYwvzDu2vTKCZC77miYoKyMTxmdz8+1teg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=foSVDFke;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050A4606A31A;
	Mon, 23 Nov 2026 07:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=foSVDFke
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 992C51F000C4;
	Mon, 23 Nov 2026 07:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795418883;
	bh=JR6Iu4izND+o7EkZgh6TIoF3sPp+Q9MpVOR8wNz04Uk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=foSVDFkecBOEdYbs2RnoyFmZTnjyVcZsZQCq+mwgFP5ttgsQ6WOFEzDU9RR8clAa7
	 7ftxPNYYCag35HYYoYtL+MUnqYZk0jHBauhdLQNhJogxVM1yMvng32rpQdvz+0sOpJ
	 apWWJV5V/VM/aWpSSMahVTKmIQh4AxfHwmyUgWBERAtR8cCCcPDeVJK535S0Z5in8q
	 I+eY+c1kM0o3igqnb9Qcs3rPcA7hQ2hZ97f/lUzdNtLPqlvawi3ahGgZ4FJU9ZTJtt
	 PkYoj3QNEXi1Ffka1Agbo+kJWl++asitPHNa0PUO+w9kd+6CbMnt1oan+UToaT3ndK
	 Q5y/TA1rEWu5g==
Subject:
 Re: [PATCH net 1/2] bridge: mcast: Fix source list rollback on failure
From: netdev-bot+sashiko@kernel.org
To: idosch@nvidia.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@kernel.org, willemb@google.com, horms@kernel.org,
 razor@blackwall.org, dsahern@kernel.org, shuah@kernel.org,
 bridge@lists.linux.dev, linux-kselftest@vger.kernel.org,
 kyuwoncho18@gmail.com
Date: Mon, 23 Nov 2026 07:28:02 +0000
Message-ID: <179541888207.3135.7176816464038643772@kernel.org>
In-Reply-To: <20261122072504.2623702-1-idosch@nvidia.com>
References: <20261122072504.2623702-1-idosch@nvidia.com>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] This patch makes a failed `NLM_F_REPLACE` keep the (*, G) source
  entries that existed before the request, but it keeps them in the…

--

bridge: mcast: Fix source list rollback on failure

This commit changes the rollback in br_mdb_add_group_srcs(). On failure, it
now deletes only the source entries that the current add or replace
operation created, marked with a new BR_SGRP_F_NEW flag. Source entries
that existed before an NLM_F_REPLACE request are kept, which also avoids a
WARN_ON_ONCE() when a source appears more than once in the list.

Closes: https://lore.kernel.org/netdev/179489219555.3099318.10297266282803881244@gmail.com/

> diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
> index 0adcd1524ab24..be65976c2f32f 100644
> --- a/net/bridge/br_mdb.c
> +++ b/net/bridge/br_mdb.c

[ ... ]

> @@ -883,31 +884,24 @@ static int br_mdb_add_group_src(const struct br_mdb_config *cfg,
>  	if (err)
>  		goto err_del_sg;
>  
> -	ent->flags = BR_SGRP_F_INSTALLED | BR_SGRP_F_USER_ADDED;
> +	ent->flags = BR_SGRP_F_INSTALLED | BR_SGRP_F_USER_ADDED |
> +		     (ent->flags & BR_SGRP_F_NEW);
>  
>  	return 0;
>  
>  err_del_sg:
> -	__br_multicast_del_group_src(ent);
> +	if (ent->flags & BR_SGRP_F_NEW)
> +		__br_multicast_del_group_src(ent);
>  	return err;
>  }

[ ... ]

> @@ -917,11 +911,16 @@ static int br_mdb_add_group_srcs(const struct br_mdb_config *cfg,
>  			goto err_del_group_srcs;
>  	}
>  
> +	hlist_for_each_entry(ent, &pg->src_list, node)
> +		ent->flags &= ~BR_SGRP_F_NEW;
> +
>  	return 0;
>  
>  err_del_group_srcs:
> -	for (i--; i >= 0; i--)
> -		br_mdb_del_group_src(pg, &cfg->src_entries[i]);
> +	hlist_for_each_entry_safe(ent, tmp, &pg->src_list, node) {
> +		if (ent->flags & BR_SGRP_F_NEW)
> +			br_multicast_del_group_src(ent, false);
> +	}

[Severity: High]
With NLM_F_REPLACE, the pre-existing sources that are now kept on failure
were already changed by br_mdb_add_group_src() earlier in the loop. Is that
state ever restored?

For each pre-existing source in the new list, br_mdb_add_group_src() first
changes the source timer:

	if (cfg->filter_mode == MCAST_INCLUDE &&
	    cfg->entry->state == MDB_TEMPORARY)
		mod_timer(&ent->timer, now + br_multicast_gmi(brmctx));
	else
		timer_delete(&ent->timer);

Then this call chain rewrites the existing (S, G) port group and notifies
user space:

br_mdb_add_group_src_fwd()
  br_mdb_add_group_sg()
    br_mdb_replace_group_sg()

	pg->flags = flags;
	pg->rt_protocol = cfg->rt_protocol;
	...
	br_mdb_notify(cfg->br->dev, mp, pg, RTM_NEWMDB);

Finally, the ent->flags assignment above overwrites the source flags and
drops bits such as BR_SGRP_F_SEND.

If a later source fails, this loop deletes only the BR_SGRP_F_NEW entries.
br_mdb_replace_group_star_g() then returns before it updates the parent:

	err = br_mdb_replace_group_srcs(cfg, pg, brmctx, extack);
	if (err)
		return err;

	pg->flags = flags;
	pg->filter_mode = cfg->filter_mode;
	...

So the (*, G) keeps its old configuration, but the kept sources and their
(S, G) entries carry the new one. User space has also already received
RTM_NEWMDB for the (S, G) changes.

This failure is easy to trigger. A source of 0.0.0.0 or :: passes
is_valid_mdb_source(), but br_multicast_new_group_src() rejects it, so the
request fails with -ENOSPC. The selftest in the next patch ("selftests:
bridge_mdb: Test failed source list replace") uses this trigger. It only
checks that the (S, G) entries still exist, not their flags or timers.

Some states this can leave behind:

(a) A permanent INCLUDE (*, G) {S1} is replaced with a temporary INCLUDE
source list S1,0.0.0.0. S1's timer is now armed on a permanent pg, and
(S1, G) has lost MDB_PG_FLAGS_PERMANENT. After GMI,
br_multicast_group_src_expired() sees INCLUDE mode and does this:

	if (pg->filter_mode == MCAST_INCLUDE) {
		br_multicast_del_group_src(src, false);
		if (!hlist_empty(&pg->src_list))
			goto out;
		br_multicast_find_del_pg(br, pg);

That deletes S1 and its (S1, G) entry, and then the permanent (*, G) entry.

(b) A temporary INCLUDE (*, G) {S1} is replaced with a permanent
S1,0.0.0.0. S1's timer is deleted, and the pg timer is only armed in
EXCLUDE mode, so the temporary entry never ages out.

(c) An EXCLUDE (*, G) {S1} is replaced with INCLUDE S1,0.0.0.0. (S1, G)
loses MDB_PG_FLAGS_BLOCKED while (*, G) is still EXCLUDE with S1 listed.
Traffic from S1 is then forwarded to a port that should exclude it.

The commit message says this patch fixes the case where:

    sources from the new source list that already existed before the replace
    are deleted together with their (S, G) entries instead of being kept.

In case (a), aren't those sources and their (S, G) entries still deleted,
only one GMI later, together with the permanent (*, G) entry?

Could the replace path validate or allocate everything before it touches
existing entries? Alternatively, it could save the per-source and (S, G)
state and restore it on failure.

>  	return err;
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261122072504.2623702-1-idosch%40nvidia.com
