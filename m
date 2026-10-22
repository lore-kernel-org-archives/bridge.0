Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792660574;
	b=ObaWiHuLGHqXUCTJYEAlhC294e/Zk9IAiaiwKjk8ZsjIQGxqfTYNWRHXtr0rDPVPWU5l
	 Z8LjmenfOhgWvILLV+IDx+GOpAMJqGLoJUcapTGiVDuxYql2TVPFMfzW+y/o8hlRu0tLw
	 eqRNLWZuCJWhZmit2ltynSAzApQtQx8WQyGVYZ+3Y3I0RBuReZfN7pwD64SHDyhcHDemB
	 DsxWA/tRxagdWMCv1mXd8kp+MtoED5FJxTeIJpTzXAmDgKIDUZff4PO2CqWkX5nz8/oOG
	 QQGhO1EyYBXxV4MRSy+gVCOU8vGwKSn1sVrmFoS7I9Ct4aBRuwqU3XQ8jq1dzZoqTCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792660574;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=y4SBB/zAR7G8uWNCyu3PQ07icMwXcC5cIWOIKYHE0eo=;
	b=eWZzrRyWVBhm4HsHc3VHpOleu6NsYhhLfS4xBq+U9pFU2XkFt4xkeOtCjtXLr/yJw5Rj
	 fzWpLxO1gGzyalxgQBzmBjk03G0vMnK2UXgRnafpD5FY1z5torb9FON/11pPa6x+K4K1m
	 lRZRU6KQ8ku8VQNLnQIXmsXvTV67yvuIRqszvUZ1KWWZxSxrZtOpaZovebSi3bmCrU3S1
	 kSJlpLt+8jqdE5SvWN2aeoX5Ikvpr0Nkb1MDUUolw8OCVy5mRsg5trLMq3/VKXIbsFVaP
	 /Wc3AGt8OQ8qd+SnicWnRrVbCc8/4YAKsFCbUhtbihdjC5eJHKJ5KWweRAKNjzPy3yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=H2d1eUlQ;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE173606A31B
	for <bridge@lists.linux.dev>; Thu, 22 Oct 2026 09:16:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE173606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=H2d1eUlQ
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-353804b591eso2971640eec.0
        for <bridge@lists.linux.dev>; Thu, 22 Oct 2026 02:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792660573; x=1793265373; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y4SBB/zAR7G8uWNCyu3PQ07icMwXcC5cIWOIKYHE0eo=;
        b=H2d1eUlQnEt5hUP6KJ4qCce1MoUvdjlC2nxHUt/K/2icmxGJEa2/6hQYDZbnN5b8bq
         XdNfZhDa1h0VlHQtUz9JcogVAgbIc8w8RYGGhc/z4bYXHOyrAguSrg51MPvjOIXhjq+y
         nG+6mJRGVWRlqCPC4u0uphoqW/MMH6lPqb8vBSNRuESLQYzvr4Z5KzK/S12LJYXzCro+
         pqTx09vFDcS9ziLelOQBiv3TFd+e3eZIBR5sUVffMeogc3rywxzDEwY7xAfma6Br9toL
         6ZeBCp6OohjgvfLuQtwC1NsesJLuj+2A1VaxELp5ab5ns+zwk4GCTSFTm8bsGOxTzpfc
         frAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792660573; x=1793265373;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=y4SBB/zAR7G8uWNCyu3PQ07icMwXcC5cIWOIKYHE0eo=;
        b=HqkeQnLBUspbBVZW/UMcaPXTZY/gmUwlMkDylnif3c3nDbvYLhsge2U9tLe/uI4d06
         0iTzK8pHrjowHHBIjrYELloV1nWUFP0hxMzuX2sQtZ3eJeN4r078wvmgYN/Nrh7KV+uu
         A160nb3tMmYwKk4KGx8mj8f4uRM10r6fXrgUCGp81HFYMRL0lJrM/wx+fWnuSBFp+LOK
         Edd9dm4VGTwL+z4bGAIw6R0bh8e9lG8pSc5xXn/qSQUw54BNEOHY4ACs4Opbjufug9hy
         hVe4L3vGF8tq0gP3VNWzP9sRmjpGLNyNUkG1s997JEWx4x1vYKYBMVoHtfyv5MyhP6Tm
         4UFw==
X-Forwarded-Encrypted: i=1; AKwUvBwKBQUP4GfzAtpstEIvYjX+8+4pqxAWTWIOi5HLkMuGY17LDm26zLN7WgWfMHhQZNAqwLoGhW0=@lists.linux.dev
X-Gm-Message-State: AFq9FYJrpLpzkD+MfFVjyZjMeeLwETpFHSV1IpW1z3yW+x+O2bX+PLCq
	09OD/jGIm/Rak6XZsQnEnoTr7o2X6JThATvsGaUKqaiNjuF/J+gKT9Y7
X-Gm-Gg: AYBFou083PZD3yfmDgn7OxDx7j1p6G7btQDszDFZ6CW3lUcrtEtnHVG+vOHD60ctNni
	3KywATk6paK/dp00gNTA+aASRSpSWv/6UgJIc4rVQcPSHtr93ukdnU8S9INfhZODzBE5wW98+5f
	DBm5yHhXRC63mK7J7QEgm5nwSNDpZAAKRiRHs6wT/iqYD8pnpESvOwzS4iC+EdSRuWdLV7LzJ2r
	u5kZswMiJOIDdWJ1sxoWS9NOd+neH25RVC/Ufwd+Ixq5NhYTzJ0DZ8wy6dNb/VBsu5/SsrSK44T
	GXJ7OgWylH3jc5qKQJ/nnkAXw/B9nLzylivbYfiisi2UhphyrC4nzwDEQz79lDqho8szTMgGQhI
	gTP4mc7vDV4Ng/bpAjcZ2ePU1TBtsw/eOXA/PUW/JFX452asFcVHHe2JsGeo8WDC+RI+c0tVk3f
	rPiERpefAEjcuEuD7tfmON7syNcSC1m93eGMTAn0v1W7fihNJAfhbiYbcVqXKXue9CrA6q/W1gg
	kz0Xh9nMGoQrt/Fd8yeIyUaGLye0Yv+oRlAuyP/BCR9WSawtoe7PUmvpvd5gbKAEukyr6u5XHQ5
	WGA41zo1mlGI3h4D5Zc=
X-Received: by 2002:a05:693c:20ce:10b0:366:9ac5:34fb with SMTP id 5a478bee46e88-3674c92e0f7mr6089640eec.13.1792660572901;
        Thu, 22 Oct 2026 02:16:12 -0700 (PDT)
Received: from youngkk-vm.localdomain (67.216.200.102.16clouds.com. [67.216.200.102])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-367411bc89fsm18131777eec.16.2026.10.22.02.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 02:16:12 -0700 (PDT)
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
Subject: [BUG] net: bridge: failed VLAN tunnel update suppresses state notification
Date: Thu, 22 Oct 2026 02:16:05 -0700
Message-Id: <20261022091605.3651677-1-teel4res@gmail.com>
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

br_vlan_process_one_opts() commits BRIDGE_VLANDB_ENTRY_STATE before it
attempts BRIDGE_VLANDB_ENTRY_TUNNEL_INFO.  If tunnel insertion fails,
the option loop exits before that VID's changed flag is included in the
notification range.

The new VLAN state remains active, the request returns an error, and no
RTM_NEWVLAN reports the state transition.  This makes netlink listeners
disagree with the kernel VLAN database.

Observed on Linux v7.3, commit
08ab31164c55f20c7a2653de3186ae333470e2c1.  A range request for
VID 10..12 set state BLOCKING and tunnel IDs starting at 100.  VID 11's
tunnel ID 101 collided with an existing mapping:

  request result:          -EEXIST
  VID 11 kernel state:     BLOCKING
  VID 11 tunnel mapping:   absent
  VID 12 kernel state:     FORWARDING
  RTM_NEWVLAN for VID 11:  absent
  RTM_NEWLINK for the port: absent

The listener was opened after setup and pre-existing multicast events
were drained.

Correct behavior is per-VID atomicity: validate/prepare all options
that can fail before committing state, and roll back any earlier
successful option writes on failure.  If partial commits are
intentional, the failing VID must still be notified before returning
the error.

CVE-2026-90114 covers a different defect in the same batched range code
(descending ranges and an uninitialized error value).  I found no
matching fix for this state/notification loss.

The PoC and two independent logs are available on request.

This was found with a multi-agent workflow; the exact
notification/state divergence was reproduced in QEMU/KVM.

Thanks,
Cheng Yongkang
