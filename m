Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792659881;
	b=tQ8J8VbagxbZXLMvh1umLJ+hxoD5lblXg5qE4hOkIv2EyfyPhF+uwGoipSsvNdS7ABJ1
	 m6VOSh6C3SGOGhF7mLTdUszxFC+HNrSAwc3/3JDAjIHxvIn1zG9Cql+LNeRKD3Ql1xSI+
	 yD+6l7MSI/bsuaNeeypKsyF4wZB248OJ6vzZpOqYaB6RYEzVTkwz6vXzRKnRTOZQGtdkD
	 lsXpEpzOhcOZIudjm+TVNfay63wAQxPXPsthj5xknwyftommnat1UQ0Dv1m79l+C0AeRG
	 wh1ybpu2/eVC5RDptF3OUG4w7P/WmwT2Ulic1NGLPw/P8LMyojPY1UdDjtYgbTyAY4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792659881;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ppDEP6lrPx9xfq6MNzv2Y3tsqjuRimolFRwRFB5o2fM=;
	b=eclw/qrffd22DXWfphQ4d7IPsx7TGptGaWy97fvyP625c/XbSVSeeykiE5Rw8ceVM/Dj
	 GTciG2pc+b5ntYNvtXsJd79YTUSCGXWMbyjFJgBV9Z1ehKE3o/3b8EraTMvHmD/sVQP+I
	 kq6tKxa4b+l7tqRUf2dzTuKxl0iCjNH2DNDruljx1KjS7HxATrkcZ+RnWcWUtv9RWGE0p
	 XnKAu9rhpOL6hR0SJ7jOL8VnsLpd2Qj3aJgFyOmXYt3D3Y856z+/uz9fk+STzPBTicmAs
	 8BEM+KtPEFfObhEIYJtemn+m3/fQO5QjMowE1gqF5D5Yp6O1dVgnw/ap2cCL6dnD0ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QSoNjrfk;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABAF606A31E
	for <bridge@lists.linux.dev>; Thu, 22 Oct 2026 09:04:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AABAF606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QSoNjrfk
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-35b2c599f43so3630104eec.0
        for <bridge@lists.linux.dev>; Thu, 22 Oct 2026 02:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792659880; x=1793264680; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ppDEP6lrPx9xfq6MNzv2Y3tsqjuRimolFRwRFB5o2fM=;
        b=QSoNjrfkakWjzcWsY41skl+RL9rD6Re667U0PI9x5qT6fIJgJybIe/KS3D2xJu7I0p
         hFzc6o+bjTBMESJpK0jmUmvgbmJrg/WeOVyMOdqNk8OFYdyhamGXujaoxIWasWaddQOy
         oAVoKMqG8PIFuKzQqbPKaeql+/z+HFZ3JrZS8I4afLtw9S+ghMlEB+ap+0aDGXujNefh
         K+W475AEkt9dLLZm+rydQUbss4N0sSM4mXc2xBepSPwi7t7OJX4pbLUG1ddcfhIxo1kL
         IQdvDAGqhDSFUVwAtJZjEAdgidjmUXCg/aUY7GJDgo2rmwkc/z1jFWfcc4UEYLcAanJo
         mQZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792659880; x=1793264680;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ppDEP6lrPx9xfq6MNzv2Y3tsqjuRimolFRwRFB5o2fM=;
        b=nXkRJv2yebbnGIlHayuHSmxEcI7NaZWzgT7h7sQCJqGtjl2CjxGEIBtR8q6VDNqRyV
         TmAnpjxES+3Korpjnerb89hYeRST52akaRYHgSXpvd7YNBvLbLUaViajm/hnfH4npYKL
         wSVhGIfZyYvrSN4rUutgHCW/fubqBgJCER3o/T30WqZ3RZkxjmxkODohMU4q7EU6Vmm8
         ofJBwdPRjtFgzsG3WdfW2ZPwxSvY4mdln7knHaJWLvbsMlE3A7Ar+TP+dqvBmh/RSGRp
         c78kPeDRvekPPkOAaRV8E6buwtCVAbYlNdWjufhRZBsbzTfFNRbcdocLFGXSYyLkSpvF
         yk4Q==
X-Forwarded-Encrypted: i=1; AKwUvBzW6R7tNhihJD/L1zxcXj1lfEcKXX0spOkJpBEh52vUkxdGgT3yu1bcWc9vqJAb+55DixOfr1Y=@lists.linux.dev
X-Gm-Message-State: AFq9FYLtQDHb5t/Q+erpSbCfiH5ohySL/vqd1npCnPtdAmLruyZ1WgBD
	q0Z4hNnO+oGfFUxpJwPt3PjP+jLU4hMR4eg5I0ANOdJat/5AS5eh2F9d
X-Gm-Gg: AYBFou38lSXiCkR6uZWpiQi2BpE1j1MJ6M9/XdNy291dEom9zWInSWOorKoCve9c+zI
	Xji9AzR4Ihw5+XS8ll98w23FEEf+JKCgVrmOu5r9olg0thBANHPBNb9ku7mN/5JOaaRfSzMeWQq
	wizv79poDfhMrykD19ZB9zhCjVj4Wh+6RFTjZVtohxN2dm4oSlvA3IdVfUM2hqsHVtm4LaNFrNg
	MSEFnUAoyVd3LzrebfGV8XOvM65MuudNAb6QSH6gNUnH97ZGI9UFDPBoRp6iR+sOljegX03Sxsp
	dSxu9Exns4Wau/mUadBxNpte2tUr3uunH0lqV94gj+m4QiTBIyi6O5iZabww23MLndi/ZekOsY+
	/aEg1gv7574+K3BqBwBKn/vl5T2LWEHEg1eh7mT6XSIVzPhadjxy0t2HUT4Zgmf7BacH3sOZi/p
	8lYoZAajvm9rwNMBpZbDn/5uQ7BaLgMU75IXsSN8ZcwNluz7S/o0KNyZj7BFQgOSMHhrkY1g0DQ
	XAIahs/wh0r9iCcxlMUpp+jwBrOZGZXonORq+CM/R3MYPTBeYgERF1T8LCs6tR2VejeCh96gkxl
	Ecj5y2P1pD/vfwDSHAc=
X-Received: by 2002:a05:693c:620c:b0:356:b370:a0ee with SMTP id 5a478bee46e88-3674e15fa01mr7570801eec.20.1792659879720;
        Thu, 22 Oct 2026 02:04:39 -0700 (PDT)
Received: from youngkk-vm.localdomain (67.216.200.102.16clouds.com. [67.216.200.102])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-367411b4145sm16789928eec.15.2026.10.22.02.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 02:04:39 -0700 (PDT)
From: Cheng Yongkang <teel4res@gmail.com>
To: Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [BUG] net: bridge: late FDB learning can outlive an MRP port
Date: Thu, 22 Oct 2026 02:04:31 -0700
Message-Id: <20261022090431.3641707-1-teel4res@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Post: <mailto:bridge@lists.linux.dev>
List-Help: <mailto:bridge+help@lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
List-Owner: <mailto:bridge+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi all,

An MRP-aware bridge port can remain in BR_STATE_FORWARDING during
del_nbp().  The terminal br_fdb_delete_by_port() runs before
netdev_rx_handler_unregister(), so a frame received in that window can
learn a new FDB entry whose dst is the port being deleted.  No second
FDB sweep follows.  The port is then RCU-freed, leaving the FDB entry
with a stale net_bridge_port pointer.

Observed on Linux v7.3, commit
08ab31164c55f20c7a2653de3186ae333470e2c1, with KASAN+UBSAN:

  BUG: KASAN: slab-use-after-free in br_forward+0x55/0x3c0
  Read of size 8
    br_forward
    br_handle_frame_finish
    br_handle_frame
  Allocated by:
    new_nbp
    br_add_if
  Freed by:
    kfree
    kobject_put
    rcu_core

The failing sequence is:

  br_stp_disable_port() leaves the MRP-aware port forwarding
  br_mrp_del_impl() restores BR_STATE_FORWARDING
  br_fdb_delete_by_port()
  ... late ingress frame learns fdb->dst == p ...
  netdev_rx_handler_unregister()
  call_rcu(&p->rcu, destroy_nbp_rcu)
  later frame -> br_forward(stale dst)

This reproduced in three independent VM boots.  The target bridge code
was unchanged.  Because the test VM has no driver that accepts
SWITCHDEV_OBJ_ID_MRP, a small diagnostic switchdev endpoint claimed the
MRP object and widened the already-existing post-FDB-flush/pre-unregister
window.  It did not replace bridge logic, modify FDB entries, or alter
net_bridge_port lifetime.

The deletion path should stop new RX processing before the final FDB
sweep, or drain the deferred/FDB state after the RX handler is
unregistered and before queueing the port for RCU free.

I found no matching upstream fix.  Candidate BR-007, BR-040 and BR-058
are consequences of this same root cause.  BR-040 gives the forwarding
window; BR-058 independently describes the stale-FDB lifetime.

The reproducer, module source, and complete serial logs are available
on request.

This was found with AI-assisted source analysis and fuzzing; the kernel
behavior above was reproduced under KASAN.

Thanks,
Cheng Yongkang
