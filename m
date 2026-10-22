Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792661290;
	b=vHGzX39BwIYafuiv6AeHxI9SLjx4CjUW/z41FTmVziNzJDH/v5khlJ6chiEHZgNXGuOX
	 1z+/cR+CWpFctyaTnrG0kafZa2cp9tNuISb+EMQdzNIbReCJeeholZwLoEVA6IHy40x9I
	 kCvfBBLZBBj4dZY6BeHBdqje1urSkTLAZ3V+3wsIkt0S1WTq4YbQLRe+qjGWu3BNnFBzi
	 u4FGFGpFuoQ0d4yKDHwf2yz9veDwcQ8x8mhLXRu3p2k93SHCpj1ACtSINEOc/YKIx7TiV
	 Rx5G37zv0PKweDWNUUVv7xaZuKnqyX0k4qVQgzs699zKEH73JwbO5Q9UlVmcOiWcdsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792661290;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=b16AqzWrmx6PCjjmVkdtVIc26QQOCuhEY/Lbc4sfw0A=;
	b=QL+P8aHVGjZf8k9FYIgswEfbAKbvJvR4gw8NQ/c+fQzSYZqDJ6SsXyDea7NtDG/WS+2b
	 PsRN2xX1WKNQ08f6fffJv3Z28w/lewNvDSuTyPInN0DRr1lKOCX0+MCzfUesIgIhNcMXP
	 lttvWf9U/o3aUwXts1wc14ph7A+E+TLsHJ10/Jk245rNT8wzIN9F5U1sz8OfHBlFg/6lE
	 w8LwJ6CRWeWOxWdnozUpduF7CIZxNw1JLD9uZAtzKo24e3Alh/7b9JNDlvb9z2Cgg8YHA
	 5yT/9sf4erjq2XSqdFDC0KINX0Bgg7lKOmoYpzROyzCBWUCLYFBEtKyT52S8DjaX99w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SOqbMHwP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1D1606A323
	for <bridge@lists.linux.dev>; Thu, 22 Oct 2026 09:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SOqbMHwP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAEB21F000CA
	for <bridge@lists.linux.dev>; Thu, 22 Oct 2026 09:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792661289;
	bh=b16AqzWrmx6PCjjmVkdtVIc26QQOCuhEY/Lbc4sfw0A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=SOqbMHwPQWFi2YRT3gLRpyy8kS0AYPzz7YKl/yzqATxW9ta/dm6RhhDSfjkwA4amX
	 g/tTTeX5NXjQnfQXtbIdL97EgeJq8IXdqtOOa5JnfqBigVr6pNhdGOuuWPwSbz63k/
	 tzAI3vIllHt2tYqlzyshzMJqPwtb+J2xw3KrFEZukUufJA4RMwksRmiIuhvWeJiZ7n
	 dJEb0T+pg13rQbtKwNBIYyy6lJ+Y5zmiHhjAy6iq19ZsOI4Wu2NfzwyeiIXICAF/at
	 we1+CP0j/Mm1Rb3ASiPxyWArpqwlgckHqGZ6ES2hB/uQhc5NakCOEyEzwHSN5RIoxb
	 wni9+cctFAlYg==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-48e2d5a69c4so846019fac.3
        for <bridge@lists.linux.dev>; Thu, 22 Oct 2026 02:28:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwR92ai2HJfIxsydf/TXTGQ2uj1Xnb781ZBOttasxq28m13/M7sQd5UfwGOSkrnDSHxOf05pHM=@lists.linux.dev
X-Gm-Message-State: AFq9FYLJjdDroGQMk2WqNYj7OK3a/mvaLqlDZWgX3qfIxQCKnf7YQJKk
	Zt+bl91c+uaqXV+vUHlrlXCRXVBx5eayCg0OeMiRp4QDi1cO/JySQ6mb3SIpNfLjW/XcnXbWMkg
	0gLYVXAi77lw93qRTsxBNioFRBu1Rju8=
X-Received: by 2002:a05:6871:6681:b0:49d:c3f6:4191 with SMTP id
 586e51a60fabf-4a7dc15cb9emr2583880fac.18.1792661289186; Thu, 22 Oct 2026
 02:28:09 -0700 (PDT)
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Post: <mailto:bridge@lists.linux.dev>
List-Help: <mailto:bridge+help@lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
List-Owner: <mailto:bridge+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261022090431.3641707-1-teel4res@gmail.com>
In-Reply-To: <20261022090431.3641707-1-teel4res@gmail.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Thu, 22 Oct 2026 11:27:57 +0200
X-Gmail-Original-Message-ID: <CAL4Wiip9-oGNjrgQV-VSkDR_hfq35d_+ymX_itYk29u9scY=Mg@mail.gmail.com>
X-Gm-Features: AclHuK-mJUESD7RYwjo_wmXzNyLsWvwMRTYfXqXRI4IDUC_o01XXw1PdqN8O9Bg
Message-ID: <CAL4Wiip9-oGNjrgQV-VSkDR_hfq35d_+ymX_itYk29u9scY=Mg@mail.gmail.com>
Subject: Re: [BUG] net: bridge: late FDB learning can outlive an MRP port
To: Cheng Yongkang <teel4res@gmail.com>
Cc: Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, bridge@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeu. 22 oct. 2026 =C3=A0 11:04, Cheng Yongkang <teel4res@gmail.com> a =
=C3=A9crit :
>
> Hi all,
>
> An MRP-aware bridge port can remain in BR_STATE_FORWARDING during
> del_nbp().  The terminal br_fdb_delete_by_port() runs before
> netdev_rx_handler_unregister(), so a frame received in that window can
> learn a new FDB entry whose dst is the port being deleted.  No second
> FDB sweep follows.  The port is then RCU-freed, leaving the FDB entry
> with a stale net_bridge_port pointer.
>
> Observed on Linux v7.3, commit
> 08ab31164c55f20c7a2653de3186ae333470e2c1, with KASAN+UBSAN:
>
>   BUG: KASAN: slab-use-after-free in br_forward+0x55/0x3c0
>   Read of size 8
>     br_forward
>     br_handle_frame_finish
>     br_handle_frame
>   Allocated by:
>     new_nbp
>     br_add_if
>   Freed by:
>     kfree
>     kobject_put
>     rcu_core
>
> The failing sequence is:
>
>   br_stp_disable_port() leaves the MRP-aware port forwarding
>   br_mrp_del_impl() restores BR_STATE_FORWARDING
>   br_fdb_delete_by_port()
>   ... late ingress frame learns fdb->dst =3D=3D p ...
>   netdev_rx_handler_unregister()
>   call_rcu(&p->rcu, destroy_nbp_rcu)
>   later frame -> br_forward(stale dst)
>
> This reproduced in three independent VM boots.  The target bridge code
> was unchanged.  Because the test VM has no driver that accepts
> SWITCHDEV_OBJ_ID_MRP, a small diagnostic switchdev endpoint claimed the
> MRP object and widened the already-existing post-FDB-flush/pre-unregister
> window.  It did not replace bridge logic, modify FDB entries, or alter
> net_bridge_port lifetime.
>
> The deletion path should stop new RX processing before the final FDB
> sweep, or drain the deferred/FDB state after the RX handler is
> unregistered and before queueing the port for RCU free.
>
> I found no matching upstream fix.  Candidate BR-007, BR-040 and BR-058
> are consequences of this same root cause.  BR-040 gives the forwarding
> window; BR-058 independently describes the stale-FDB lifetime.
>
> The reproducer, module source, and complete serial logs are available
> on request.
>
> This was found with AI-assisted source analysis and fuzzing; the kernel
> behavior above was reproduced under KASAN.
>
> Thanks,
> Cheng Yongkang

I suggest you stop sending these emails, we all have LLM you know.

What is the point, if you do not send patches?
