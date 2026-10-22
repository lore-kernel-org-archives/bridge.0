Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792660508;
	b=1vcYYXv0Up1tFIEu9MuZW5QOHIGBIKiLbGRL2AB6Y6H1k6k+sizMRwISoCkLNx7isMlJ
	 2MuO7A9BRVAu8yLx5rAQIp5mrRn3Tq6D30gerrqpeLJ5kQnPx0RBfUx+LaRWT+hB6m5YG
	 14+u3GFwz+rDszgDe4ipNLO9bNkeedEJY8S8vXK+ZFaAZrW/de+IssQQsgIhxvF8bRUSZ
	 nixK4P5+saRxLwDJYbrvkISiPXOvU2yIu4bbn+E/I59L79n0+riJwH+x14IM36P0pT0Cc
	 u3rrh2GagMXx/mTnltIOeBmB0GWmsopdnKweexg+OKK6/HRMnJ2JpwqdbL5s11jpdug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792660508;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=e7NVZjs7NMYnhNT7+IbNDUXDeXgt96yTHJb2bsDwWM4=;
	b=LB8AvIxQ8Cw6xHL0bztX+zlK+n5+/8MU940qVf4Pp7l5bdCjc4bT/BdxwAhd4QDjgQeX
	 F38eBJ0wAPhGrUfhnblPJ9t5DUYKUMZFbCPQ2grWD2OAS4jXWc4Ht+3Urw8f+drol0heE
	 q1hDHuIP0l6XfQ13Ku7z0Swyrp30gx4uzXMqewKOi/CTPRie2vF1NZtY/lEyhuCMscyAm
	 FFzu+7TnzRvZ1w8ZquyMyB8waV3LPTAhQuKyBkT6jq1mQG0/XLMS+sIipDCK9Gt9S7ZIL
	 1yBxrhApxsEzGqFxv0IrTQg8j1Ciefrsljt6girQkToehKQD2Gn2i06Bhs9jWuHlB4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=K7+0VHIC;
	arc=none smtp.remote-ip=74.125.229.9
Received: from mail-dy2-f9.google.com (mail-dy2-f9.google.com [74.125.229.9])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CAC606A31B
	for <bridge@lists.linux.dev>; Thu, 22 Oct 2026 09:15:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49CAC606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=K7+0VHIC
Received: by mail-dy2-f9.google.com with SMTP id 5a478bee46e88-34cbc588a31so748450eec.1
        for <bridge@lists.linux.dev>; Thu, 22 Oct 2026 02:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792660507; x=1793265307; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e7NVZjs7NMYnhNT7+IbNDUXDeXgt96yTHJb2bsDwWM4=;
        b=K7+0VHICCWhZcgpOTmSOiYqqCvNM1phN/LAJ+sy7vaUJvjmTSThYYM/R5E/2hKJJlN
         mlIcRiSrpyefOleZN+mP9VQK6CgAonvdJ+dT3S+kI2GBaBryC99imqx6WUsEvYnWXLAE
         QcsYxuwb2GIUJbe7rviTD+ZbPw7opXuXf6Y4/M5acD7DtMcPwgjl0HH/J3omvqbbvF2g
         k7+NKId6kIBo+kjHM2BQ2XdN7TdT7rsIbDCDzEXresqufst37at/2L7VxnWXvaN/P8u7
         QCn4yye0r8c8majzYYRLhrDN0SKHO8qplU4KUj1ifFdi0WjpZ7EAtP7krqgt7NdUm03s
         D2tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792660507; x=1793265307;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=e7NVZjs7NMYnhNT7+IbNDUXDeXgt96yTHJb2bsDwWM4=;
        b=RpvA0vy5uexcydLL90W4YopYnF7T/mHhgwK+hvLXZlPWIf37RTl/S3orfEnphVTddH
         s7CK/+XWWQyLXgf/4WIeEVZayOvdOuowwtngARdilqpQGm6+2HvtMmmubc5Lvfho0t4Z
         kR7zGK8XK17Cea3oG3FhzS/I/zRDuw7RWaKDKTJwrkm+SPosXJT210x+bCk+8iWiPCX9
         xbqY8rXZo9WhhryADyZMPpQm1zCWU1mYwzln2UzaFlFzACuMDJdYtkKVLQKIKVzO4vFO
         2mUzW99AYUYGXR+3I11ubVmhX2N8MGvpQL0i4JLH2qYUlM8sM7fQ9dm0XAFiIsQvQvCG
         qzSg==
X-Forwarded-Encrypted: i=1; AKwUvBw595xZS+X72CxccIKhN1ETU8ug4mXuJOD14Ipi7gfflOB1Sl6Vl6PwKh8itXOrSHaD2M9USqw=@lists.linux.dev
X-Gm-Message-State: AFq9FYLb+VkBebhwfyPlVClH2167UgoRvyqXWLAvn3Zd9hdoRtqK61W8
	rwrTvitI9S0HXZUldAG5iQ1qTUEzXUB5dJ+ov8mtlF7vzjkdlIdgFwkw
X-Gm-Gg: AYBFou23RiajBwCND/l4R+E7THwyC/LPCZ8tUb9b6jO/sbG4Cw3Xf49Qli/gUiAjZPl
	CimJJsBLB+NvZXxJVwVbWksmhq/iAynsN/n7npZWGjSl0e/jYuovYzEw/7hdd0m+idoxRlP+8Hy
	udi0fbvxHM9cE+43fku5RydpcAoXTHv9w3/bSdsqMQ9bqXluG8rNXWYehQGpUVRLA5sazmJJRSh
	UyXuEM4Sui/tzaOM/wUprdRYZ2xhfN7o9MB0+JCh+CLCWLeMFi1rbRN/8fqMO5E2s2g8bHj67u5
	GcEqC0Lhmov6Wrue4oYaeLDOrMDRWi+jxKtvtKSrbPwXe5u5fJSMzNY7N1PFtJ+wqhoecPJShQ0
	ZF4qe9aXBLMbS6EELfxQl7l4vpAhP9YGGeCZxOj35JZTCxoSsMUIt2sNVFU5dzBgheoDVgvaTGd
	z3fpWYD7jk6bN9rdurOkFm7ImDltjkeUNylj9tQ0HRDP7yYRdbwp+qbF8mccdQ0aqTfPVeDsTc9
	CYPZsb+6fK+IvmVhXLCI3ArxjaRztl7BWX+MCJ/Xxu4PqIavmV0aAyFpwHVA4Y5EF0DsCzEuIi3
	HUcCBjjGblnNaAceEYip2lo4Qk5FQQCCwrr7vdZM
X-Received: by 2002:a05:693c:4199:10b0:35e:1807:cedf with SMTP id 5a478bee46e88-3674a405bbamr7360868eec.1.1792660507440;
        Thu, 22 Oct 2026 02:15:07 -0700 (PDT)
Received: from youngkk-vm.localdomain (67.216.200.102.16clouds.com. [67.216.200.102])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36740cca3d8sm14612471eec.14.2026.10.22.02.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 02:15:06 -0700 (PDT)
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
Subject: [BUG] net: bridge: MST bypasses blocking when VLAN filtering is off
Date: Thu, 22 Oct 2026 02:15:01 -0700
Message-Id: <20261022091501.3650765-1-teel4res@gmail.com>
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

MST can be enabled while VLAN filtering is disabled and no port VLAN
entries exist.  nbp_vlan_init() still installs a port VLAN group, so
br_mst_is_enabled() returns true even though BROPT_VLAN_ENABLED is off.

With that configuration:

  ingress skips the normal p->state check and forces forwarding
  br_allowed_ingress() accepts the unfiltered frame
  br_allowed_egress() accepts the unfiltered frame

A port in BR_STATE_BLOCKING therefore still forwards data in both
directions.  STP/MRP loop protection is defeated.

Observed on Linux v7.3, commit
08ab31164c55f20c7a2653de3186ae333470e2c1, with
vlan_filtering=0, default_pvid=0, mst_enabled=1, and a port whose
IFLA_BRPORT_STATE read back as BR_STATE_BLOCKING:

  MST on:     egress=3 ingress=3
  MST off:    egress=0 ingress=0
  MST on:     egress=3 ingress=3

Each direction sent three matching broadcast frames.  This is a
deterministic configuration/state mismatch, not a race.

The MST fast path should require both MST and VLAN filtering, while
retaining the existing non-NULL port VLAN-group lifetime check.  The
MST configuration itself should also be rejected if it is unusable with
VLAN filtering disabled.

CVE-2025-40297 used the same broad predicate for a port-deletion UAF,
but its fix only added the vlgrp lifetime check.  The normal data-plane
forwarding bypass remains in current source; I found no separate fix or
CVE.

The test used a diagnostic switchdev endpoint only to establish the MRP
ring state.  It did not replace bridge, VLAN, MST or packet-forwarding
code.

The PoC and full program/console logs are available on request.

This was found with a multi-agent workflow; the
forwarding differential was reproduced in QEMU.

Thanks,
Cheng Yongkang
