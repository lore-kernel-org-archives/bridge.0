Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C73E35E926
	for <bridge@lists.linux.dev>; Sun, 17 May 2026 17:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779039479; cv=pass; b=CigYhKiSa0IaN3ZcvdFjOl1/M3M0FgRbtjtkE0/dUw/cAQWP2OQi1Z04HajSBh+9lD3mTZHUl3w2HlITkyOcBgsd/E9j3SWtdZA1ooJgBGCwI1ak123noVy0bqn18FbWq+LCfmGzjIgtwrgi00qKMLJshrudFE8DWv3EYVr518w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779039479; c=relaxed/simple;
	bh=YZ5Ke/sEGFabuzBfVldOLJOcizsrW/Nl7bivRjdo/zU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uf5+6fklcY8SBnyl6GzfEB8ddcPKtuqGRdpPrVSciyDB4cCCyzsVUCsPfNB5EmXnG3QYR34HpPjUS5XXX8slXAZN54iN/lAD4V8lsvxRePXcJs52bofbC/o1bqfJ7D4IDtl9Mug82ENGL9UFvjFwV+/uCwh3j3I5k5TNSJXyiB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ltwW55Ph; arc=pass smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ltwW55Ph"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-43496e6a964so1081116fac.2
        for <bridge@lists.linux.dev>; Sun, 17 May 2026 10:37:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779039477; cv=none;
        d=google.com; s=arc-20240605;
        b=Z2XiIb5yYGahWdB1dSdyjhaWmpx33GkD94SoZQQCh3HdXiElcPX+DWU19fPMQ7tzpH
         J7+sECPfwibxUYyCB9chC7KMPHoylEbf6bGhb2esVy4e3Zu5LmIzha6wTTfqlQiRiuWn
         rWis9FR65XFeexnEQJKZo13PQoEPJ9YpzEppO0eh4ihKeNRyvvdBueHIL4Akunb1Dyal
         2M3BUc9yIyvyQvdlEu6Ka6g7OWAX9hL9DdsiHAUGAche0BkxJmka6ADZN26agpl0+QNx
         uzIMWJfeLV/P7nYF1F1jKn4Q54LmAJI3VkT9VG5Pu0il7namJl+wIDl/r3YmTt3Q/tYZ
         EOYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tlVlaFBAIkcv0HbZfkTnOaqrfVsvTeI+ScRy+0SZE24=;
        fh=0rxEEFuK0+s8wi9kx9zzWs8UuVLcVwHA2ftBRaxZI60=;
        b=RcY2vN8oHJl2y+URLOQdkrnkwzOMBpIVXCG7V19jxOVp5JKtjHqrfOE8/QXDEPd5pk
         bz4CPEF9UIwnam9tlA3qqty6s2P2iEgCI1RADom9J56A4ld8YMe9vIa/y4Y1FDU5ZnYv
         Irn/Fjra2cPCZPfBjAZT1XFdXsFVIrxZthTknMrKjDPDeCRP/2uKL26AkFYLvLUO9sO9
         mW7MrPisbu/jwmGXsoyfQGyZewuAe86/6jGssBtJVskUHV9hPQl1CfzfMEjzKi12zNaq
         XgduGCAPC6FacBY7r8JiiwR8F00Z5uKue8Ykp+TpmzB8VUd4ifvJykwiCWZZj2v8hC20
         iHYQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779039477; x=1779644277; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tlVlaFBAIkcv0HbZfkTnOaqrfVsvTeI+ScRy+0SZE24=;
        b=ltwW55Ph60HQBja0eYiNX0GPqNSSgVPrGw/aKDZaOmFDIGYyA0vI859hVS/wi/SPCR
         EOVw8ykg1emaVUQot9dxWiSTotdW8aq0ARdrSwgjkbB21e0hVnXGCdL/3g6+k3E/Gp1c
         +gjdxUth+tSDcG7nxSAk5AlG7/go1v+Ze9rDP+d8Cl2Rui/XaUSz5iTHBt8QwvqA4YuB
         mDV7Vpj3qtr9vs2IwpUGuNBe+WK0hYswtidgxqH+IIs13YttT1JXzBghNokTCXZ7Jcid
         G/rMGhv7vdEwD8rySWqF+hBT9zF5zkBIxl9//7BI39mf5fWF3QIkw0DX4p01FE3jjVX7
         T+Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779039477; x=1779644277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tlVlaFBAIkcv0HbZfkTnOaqrfVsvTeI+ScRy+0SZE24=;
        b=acOeqivqn3Oi/Gp1ob7amZsmsAEM4wgv8xlt7RjOq7bdxdW+EdtNTR7S50p5DykIiV
         fiVR90SJt4bniuJL4gKTmHf4iazwxMXwAS0ijGC1wtXRb+o6Cq3ul9EjojWuK2uQi9uu
         2RR1fmswsDWsaw2+HLkGxzkTjzxwyNbyWK9zRpglgZ5vINa6JdNGf3A3dMlxz6CZcEZu
         Se/tLrjFIjujyQsSET7Y1HM2YTWlIFNgfRBKvXJDTONmhO0y1t47XIicr+qmCBQRwWXI
         O91D9ln+rIfnVwCmia2Dour7bkS/Yn8v3MV/eV+aESXCJW+M3o4m418ymOWUYq4BDNby
         LNHg==
X-Forwarded-Encrypted: i=1; AFNElJ+2VYizYHnoPx+FyZUqspv0opcunYTDjL2XLxe1px4x77xFTny60uLkPMrDkC6VFIp22Qf6iHE=@lists.linux.dev
X-Gm-Message-State: AOJu0YxL1PDdyiAEk/L/L4XaVV/4TSq2s0he75QHkT90keSPm03jGRLY
	2bKhNGXfvmGuQimezxyFR9NdBXDR2f1U7/VpsoFpmtpCQgi65I8iZlBA6h7sJSlXGMgzDLh4gXR
	RoohJ6f8QRkfG5RfcKWWsejI8BfTYi/4=
X-Gm-Gg: Acq92OElNG/htZVm3a9ZE3SbqMRSpD6lhMRaHZ8i+DB6S5hO8CBhUHzwPRG63Hb9EfZ
	pRN68/WIInbvBt4tkdxJAwVo6KN4wLVY/yp4Y56nYMyrOa3X0dQbtTSofeIc7b5KZWvJCoHtEVv
	BUBffqnOaCDi8wvATFe3Pgz4/Ed0cmDbB5RQBHvtsR1S2e7AlhMIsbctTp3Il8ts9H7EvtnsDMg
	IZ6DnpIOlOxnKtoMh47bqj1HgQGDnauwqfYqUfBDDfShen2Wdbvk6bUQYsjnINeaqu4hEN/H9by
	mkGudE8IrUwMsv1iFsyshA1ytcTeS4bnq3Y3OA==
X-Received: by 2002:a05:6870:6b86:b0:435:51a3:7139 with SMTP id
 586e51a60fabf-43a2da2c0e5mr7428036fac.13.1779039477364; Sun, 17 May 2026
 10:37:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260517041306.24841-1-devnexen@gmail.com> <agnF8KScbKxtUite@penguin>
In-Reply-To: <agnF8KScbKxtUite@penguin>
From: David CARLIER <devnexen@gmail.com>
Date: Sun, 17 May 2026 18:37:46 +0100
X-Gm-Features: AVHnY4KT-anqkYPAowTH1z-aktUBhVHv9a9ooTXMQP-FAwDVJGuu25829Ys9ZHM
Message-ID: <CA+XhMqzrQfN2qmyfCyO1J+u0865cUDfkGrexW+h4dXS39CokeQ@mail.gmail.com>
Subject: Re: [PATCH net-next v1] net: tpmr: add Two-Port MAC Relay driver
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux.dev, andrew@lunn.ch, 
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi !

> Please give people more time to review the proposed RFCs before
  > sending v1. Also you specifically asked bridge maintainers to comment
  > and did not wait for us to do so.

  Fair point. I jumped to v1 too quickly. I CC'd the bridge list and you
  specifically, then turned around v1 inside a day on the strength of one
  review. I should have waited; sorry for the noise.

  > First, I'd like to ask: could you please elaborate why bridge's
  > group_fwd_mask isn't working out for you?

  Honest answer: I should have tested that configuration before posting,
  and I didn't. Let me actually run a 2-port bridge with group_fwd_mask
  set, no_learning, stp_state 0, vlan_filtering 0, and see where it
  falls short of a TPMR =E2=80=94 if it falls short at all. The places I'd =
expect
  to differ are PAUSE handling, multicast outside the 01:80:c2:00:00:0x
  range, and carrier semantics, but I haven't proven any of that with
  real traffic.

  If the bridge configuration covers everything materially, dropping
  this driver is the right call =E2=80=94 400 LOC duplicating existing
  functionality isn't worth it. If there's a concrete gap, I'd rather
  close it inside the bridge than maintain a parallel driver.

  > Second, what else did you try and how exactly did you try it?

  Same admission. tc mirred, cls_bpf, nftables, XDP_REDIRECT are all on
  the table and I haven't evaluated any of them seriously against the
  use case. Let me come back with measurements instead of arguing in
  the abstract.

  Please consider v1 parked until then. Thanks for the pushback.

  David
