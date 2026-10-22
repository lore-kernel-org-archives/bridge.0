Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792660493;
	b=nBLE8HHfEQMJH+ooewJlVEdzv4eiOYR6nARnDrW1WCVAyQgE8fN7+8qxJsSqYqqwx0ST
	 8IUG38Fq3dnHx+0ynlxZIuvMplJEtn5Evg2mjRlL9q42CS9chnNp3T6v7lI8wn1a3WGCT
	 VORpqWMjdj2IkxOIkEclg2RH/g9zs9b8F180O7+2bMP2hNii9JNy5aBS9eFQv43HR6iFF
	 ZNs3snQJjoNiThEJCrs8LNCZJ1qJzX4ESgjGh8Ljav8d8S96oFTvv18cnVBUxDOIwFyIR
	 82+GedfQG65Fhknar/Mv3oWnU4jmD0dBjCb2bR743dJC8leAG38rxfJhwvXFs9HMkSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792660493;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=fUpHgJn4/5UVMTDClUybGN+1JsPzSxgZqen/j5U67+4=;
	b=qd0rngK5EtioFqWrHiB8m6ClQotc4igK92Cl7AVGq3M0GI+NEXXimWNIJAt0IhUSDEAE
	 qaSnm+Md0i4XggeR2hTcp0DdexvEkTfjtKU+W6JsNfBr8PqB5KxZKJ3tIaV317hUle21X
	 XzHLcbv0Ky9U0K+XyvX3y7CS9tJ1oQpfMckEuvzfS0QsS6HUly96tQxcXKVGdhRFyu51Y
	 uNinpPnJ0OPcy2TEQkQO95lbKv+Q5UjBs2mdJUK4mZJWrt+72AoOAv1De4UkRf2pl24G4
	 YV9m2sQ36sXJcGqGbYE7iBG2mvGimOg1kxYsaQK+zNCrFO80kVjpVYDWGXzL+aAL4Qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=E7DDsXHp;
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EDD606A324
	for <bridge@lists.linux.dev>; Thu, 22 Oct 2026 09:14:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61EDD606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=E7DDsXHp
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-185fd3a4ca3so807212c88.0
        for <bridge@lists.linux.dev>; Thu, 22 Oct 2026 02:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792660492; x=1793265292; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fUpHgJn4/5UVMTDClUybGN+1JsPzSxgZqen/j5U67+4=;
        b=E7DDsXHpRd+rXuh4B0RGgq0BwZUPTPPtRBICCB3g2xkwQdMYkUDWJYKW12W3GHtCuv
         svPEVZRlT1CTurmnm813ts06HlY07rxBNJcilQODFTaltI3IzaEk4UA5RPro/U5sKOZp
         LQOKtRIHB+DUJzFhiAQf31kRzeMOkxeVLaO8BwniLS25l6X9Z4vdLXRG9CsOSE42Bp+h
         TC4lRxm/rsDOF/rmgs1JmMCeqBbKqT3fOHWC4qNAAFUnNFjtYd0a7HHPUcSULMSTSw0I
         HfFHO1M9dNe3RtD+2D09ufvHrG4iHUvBnvsCOegAD9lxnZFQwiMr+7ySKnxrvxet0gVE
         eZ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792660492; x=1793265292;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fUpHgJn4/5UVMTDClUybGN+1JsPzSxgZqen/j5U67+4=;
        b=iTiEG4KX0lPmY0HbbBm5zVAshyfDmyR1C5Zhmw0tnFZv6sx4xMF4TXLKYJdQ+7jAvS
         G0EW8htRCOqrB+/yMkicc9ASxZw2VOOPi1h/6T+3VHh9Tglyak1EFHa884ELbMddxvEz
         hjRMqcjnT1qYHQZU4xczqt/qvhHixcUOGGr3h3YmP/13blnKF/W9iZQmAx8GChO/MFt0
         B1t0vd45kONoV4U5OxVf9wqv6h+jEXeKmmkFoHwc23US0SDSkdHiVUYCeyqOeDfF1bm+
         VIeI8EJOqoyjpDyH84ugKlgUE1FreYZXg6MrN72ouEZZfhQP9WSOaWgtoU0hiObrOeN6
         8KIg==
X-Forwarded-Encrypted: i=1; AKwUvBzaBkU8YQ2b/snBj7qq67yslBxc12Lw1bJZHOD0S6IkwywkW6gqE/kIfeNLcA5WGlCp7L6oCCs=@lists.linux.dev
X-Gm-Message-State: AFq9FYKVxbCpXi5kUffDoviJJZm9H5/5Gzq7/HcJzj3dEwHnIJjMSxat
	cjVESKux6JbQZztLyrIg9RKr+voVhgGJ4IcWqP/F6tNxjL362ZiIyJYJ
X-Gm-Gg: AYBFou1FL7AXj7NOBJ8Xg9Mtq+NUgZi/ebYXEsc4YaRz+ZJpgJNqjP20VCFNwyuExNT
	i0t5s5LYovu/ovWAHnoeaTTgPH/xcq0U7tTvcLncR0xmp2vfWuhtageOKOPcqN3RuVHC0YDwHnb
	+e81tcGInfZcvQsqzMX9p58B+2oXBh5eIIOLx22+QxXTyZqzAGjEp2ME40F/cYu5M6qjvV5Zlth
	o76OMEeUIRpJNFQo4CV/KPSmN7vEgoFwreH2OIf8TpBDYdMBCuhHBX5vARU3IEBG9BcQeyEOPTb
	t4dOswYWCoooEIlyzsdtWzhUpbQVoz3cKDIV295jyzARdJByb4T9jB7WJGeBx8BMT4oMTFYbQxM
	jM+vRoy/ugkCr5cx+BV6KPEcu8pfnB7jdp32wvK36u6YSkbPdJ76jAOY4CEel1ZAfmEKTKakA/z
	FvHolF/7zTE4xEtcIgB+WLQoVOfLhCpgX4ZhDwetqP0gabzrUM8FTh0GbsEhNhP3tTK4cMvQcEN
	QiWepsSYYhQ3kPpLZaieQFIaFREWX9b5AVUc1o1WsX1WRsL7XzPKD6AqSlwpDvXrYEBpD7Rvpfx
	w9A3HFvpH5u/2A1VeVc=
X-Received: by 2002:a05:7022:1608:b0:166:37d2:3b72 with SMTP id a92af1059eb24-190a6add68bmr5187470c88.27.1792660492388;
        Thu, 22 Oct 2026 02:14:52 -0700 (PDT)
Received: from youngkk-vm.localdomain (67.216.200.102.16clouds.com. [67.216.200.102])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903c71421asm13121003c88.16.2026.10.22.02.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 02:14:51 -0700 (PDT)
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
Subject: [BUG] net: bridge: failed attach leaks slave promiscuity
Date: Thu, 22 Oct 2026 02:14:45 -0700
Message-Id: <20261022091445.3650534-1-teel4res@gmail.com>
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

br_add_if() can acquire a promiscuity reference for the new slave before
a later error sends it to the err6 unwind.  nbp_vlan_init() allocation
failure is one reachable point.

The successful prefix does:

  list_add_rcu(&p->list, &br->port_list)
  nbp_update_port_count()
  br_manage_promisc()
  br_port_set_promisc()
  dev_set_promiscuity(dev, +1)

The err6 path then removes the port from port_list before the remaining
nbp_update_port_count() call, so the removal path cannot see or clear
the port's promiscuous state.  The later dev_set_allmulti(dev, -1)
balances only the separate allmulti reference.

Observed on Linux v7.3, commit
08ab31164c55f20c7a2653de3186ae333470e2c1.  Failslab forced an
allocation failure in the first nbp_vlan_init() allocation.  The failed
attach returned an error and left no master, but the slave's
IFLA_PROMISCUITY grew 0 -> 1 -> 2 -> 3 across repeated failures.

A later successful attach/detach moved the counter 3 -> 4 -> 3.  Another
successful cycle returned to 3, proving the first attach/detach pair was
balanced and could not remove the references leaked by failed attaches.

The error path must explicitly release the promiscuous reference before
unlinking the port, or reorder teardown so the normal promiscuous update
still includes the failing port.

The PoC, fault-injection runner, and complete program/serial logs are
available on request.

This was found with a multi-agent workflow; the state
leak was reproduced under KASAN+UBSAN (no crash is expected).

Thanks,
Cheng Yongkang
