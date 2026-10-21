Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792611322;
	b=wc21OCOvUGY4JNc0CgCXWMjZuRPsdVAioXS/wtHFRNZUUSU98f6japWar+yie2JlVthq
	 nRBIDbJFSjzTTh7BFk8SByFkMyt/NV4FTDRFvWUNSELPBmzxN6WZHP0eeYjuo6ICmsH2C
	 wZ7knS1pCJ+HmA5dS37dnvciqCe8E+Bz06Yw2KAhqGEprqVmdOysPVCkyc1IWraq3YWEz
	 o+3aS8HSySIup11LP0EqQBsWUSRaUxCRYi++3dGRIMYXSrFj+u1PVzFczoLBY8QnnwhNp
	 QscohFBbsP9CjdjnXuYHFErr8rPbnYZsr8uWrl8CWy4gWz07/YvAUlrfvRCy2fbLreg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792611322;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=8mOlKY38CaqqsXX6hCu9uSO+ENgj+XOaLp+dwJtx33w=;
	b=J6Y4y6yN3copRxMm7KzW/fC5xLeXP3jXQvqXzQrV9FmjLnpNHe69JeUE8Rz3H0p5/kxx
	 3ewWdeLiCxGecCz49Q3hEH0o05Lxg8IZQCa5fSVFTFPuFUFc6I95OHzKk8rSK6tgbDdpp
	 Zgrf7r+XEcNbRL5hvkEMzViwba1gtKZiM/ofQFU0cWyVviT6GpuDH/YXB6/mwB+kW9tdC
	 q3fewTbioMYRI92prZYMeVtDCCmfpTyQK2GtBEsirX9Udx5gbuMt/456ekIYDGLkwGBCt
	 y9NF1VwQNHSx6J8wS2EqjylK1B3ZiVi2g80mIY+aUDxowRIuUhpCbAQWEWhRwYD8l5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--aojea.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=cw7piBq8;
	arc=none smtp.remote-ip=209.85.218.70
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52723606A31B
	for <bridge@lists.linux.dev>; Wed, 21 Oct 2026 19:35:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52723606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aojea.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=cw7piBq8
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c42f98f3571so111388066b.3
        for <bridge@lists.linux.dev>; Wed, 21 Oct 2026 12:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792611320; x=1793216120; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8mOlKY38CaqqsXX6hCu9uSO+ENgj+XOaLp+dwJtx33w=;
        b=cw7piBq8YbI/CgYbfMLDsG8dcl5xM1CaVQp0YGb7cLuMs9yR4c5dyCSAJTuRCZkxrH
         uE02KiKGubtpk2HK794Jk9UGy9ZPAaR0A6dCu0hkHPddhW2XVdmZxJ6zwQdNSm7jghB4
         HwDt4OBNPXOYDygIZik6wPF0SM3i9DtzrawvDpV7SnjrrRiMJCyW+VIA7/ma5I0xqiKa
         CBVcyDpbYDhdY71lZ3RvIs6MYFGlEGc1xWCZsQrflnbRKuVvyi9RF/uxDH/xtu5e1fj7
         L6phy88/I6xmoHfgUGbr0HaG8LlI9nkD4sFFehcPn9UQvxIDuqlmcOZLJxg8RxXkSdGc
         nLAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792611320; x=1793216120;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8mOlKY38CaqqsXX6hCu9uSO+ENgj+XOaLp+dwJtx33w=;
        b=qGEsznmoxsZ0vE0VjYoMglweEdHdJ5c2dWp82qEGEPeewktISI38Beh9l7eYcgRpfs
         GHFPcQm5mL1SAqk5k/JzORRDXK77zbLmE4cNz/n13epbi7UzIYCerxIW/QxPumLqqBgk
         9WeZFI17vcHCG3rfsjcx5ACF03dlqfTD18u3A4SlLj5bxONwdQLd5H1Ed0LAi380+O0I
         aZOeuGcxrugEZBDbLhVB0gcajJwTCEsofOtvOdQlgE4Zjic8WI7CDp+cD5wqkHewq0HQ
         vMbYiOWvbezrbMTp64cji4plLneuOhxZ2Oqna39EB+dTQvkpmvLk2B2WYCS/lw1BA9rR
         c1aA==
X-Forwarded-Encrypted: i=1; AKwUvBygott+av2e6+/e57npWqbuCidzi7VCogi8LRjjTzfALjeFS5MvKY1a9ti9MLRCsJcBepjMY7s=@lists.linux.dev
X-Gm-Message-State: AFq9FYIzYJyX1k9cJnKh0x9NchmG66TcpbzZwTxr2g7nqk1fx5hB68OX
	hL9AtLMCV5myqta6V/ltpm3UbZFRMyyQSRDHC4/BdAy/RYxuRT+iQbBIBIhJGGy9Ok+d4nTSQgL
	BtA==
X-Received: from ejdq8.prod.google.com ([2002:a17:906:3888:b0:c3f:6152:2d8])
 (user=aojea job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:3e89:b0:c40:36ca:9d1b
 with SMTP id a640c23a62f3a-c46796eb68emr257680466b.40.1792611319463; Wed, 21
 Oct 2026 12:35:19 -0700 (PDT)
Date: Wed, 21 Oct 2026 19:35:08 +0000
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Post: <mailto:bridge@lists.linux.dev>
List-Help: <mailto:bridge+help@lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
List-Owner: <mailto:bridge+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.218.g1ec904b173-goog
Message-ID: <20261021193512.2302587-1-aojea@google.com>
Subject: [PATCH nf-next 0/4] netfilter: nf_queue: follow-ups to the hook drop
 flush change
From: Antonio Ojea <aojea@google.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>
Cc: netfilter-devel@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, 
	Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux.dev, Antonio Ojea <aojea@google.com>
Content-Type: text/plain; charset="UTF-8"

Follow-up to commit 72ac1c0937df ("netfilter: nf_queue: limit the hook
drop flush to the unregistered hook point"), merged into net-next with
the nf-next-26-10-18 pull request, as requested in the review of that
pull request. The series is based on net-next main, which has that
commit; nf-next main does not have it yet.

The hook drop flush now only covers the hook point of the hook being
unregistered. Two module exit paths relied on the old flush of every
queued packet and need an explicit one:

- br_netfilter queues packets from the ip, ip6 and arp forward and
  postrouting hook points with an okfn inside the module, so a verdict
  after rmmod br_netfilter jumps into freed module text (patch 1). The
  hook removal moves to a pre_exit callback so that the grace period
  the pernet core runs before exit separates it from the flush. The
  patch also moves the nf_queue_nf_hook_drop() declaration to
  nf_queue.h so that code outside net/netfilter can call it.

- packets queued from forward keep their conntrack reference, so
  rmmod nf_conntrack blocks in nf_conntrack_cleanup_net_list() until
  userspace sends a verdict (patch 2).

Patches 3 and 4 address the review comments on the nft_queue.sh test
added with that commit. Patch 3 fixes a pre-existing problem that
affects the whole script: test_queue() resets the failure flag, so a
failure in any test that runs before the bridge tests leaves the exit
status at 0. Patch 4 makes test_hook_drop_scope fail when its setup
does not complete and adds the keep cases that tell the family check
and the hook check apart.

Both kernel changes were reproduced in virtme-ng with the modules built
as modules, before and after; the details are in each patch.
nft_queue.sh passes with all four patches applied.

Review of the pull request:
https://lore.kernel.org/netfilter-devel/179237288267.3135.9555179349652175002@kernel.org/
https://lore.kernel.org/netfilter-devel/179237288374.3135.9473018103688224106@kernel.org/
Request for the follow-up:
https://lore.kernel.org/netfilter-devel/athscka5B9UmNsJz@strlen.de/

Antonio Ojea (4):
  netfilter: br_netfilter: flush nfqueue entries when the hooks are
    removed
  netfilter: conntrack: flush nfqueue entries before waiting for the
    conntrack count
  selftests: netfilter: nft_queue.sh: fix the exit status on failure
  selftests: netfilter: nft_queue.sh: harden test_hook_drop_scope

 include/net/netfilter/nf_queue.h              |  5 +++
 net/bridge/br_netfilter_hooks.c               | 21 +++++++--
 net/netfilter/nf_conntrack_core.c             |  7 +++
 net/netfilter/nf_internals.h                  |  3 --
 net/netfilter/nft_ct.c                        |  1 +
 .../selftests/net/netfilter/nft_queue.sh      | 45 +++++++++++++------
 6 files changed, 63 insertions(+), 19 deletions(-)


base-commit: 279d5c8afcd38bd841832a39bfe1aa4f8518d98e
-- 
2.56.0.218.g1ec904b173-goog

