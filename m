Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792660053;
	b=4H60iIxPngXubsaK65nfTqKR/Oj4PKIHL1AAiTwJOwT+QqzIoim0eNKMMbOTHLv9aOO3
	 cAs9e9ofu2eiJ1TASn2FuR70wIaEj5RyG3w7h/nzm4DpXsp47+RvPj4E9Cdh049tjyfJj
	 AQ3Zw1YamR5KwGgmKs+KdET1C2kRogaeMRr7ae/DXAzE4MSVVNBH9FiitcZtWn2rjQK88
	 ZZ7cZTfSRn/eNDYx1PtQ26ayGzo/p++x+kIjg/nI2rf3A1kgdzOciuu79tLTEYq207stv
	 1iQx3hDW0OH3qZhZCjVqNRL/ePzj02qXIXcMClXjJVh1SGpp++locvCq4oySoisH5ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792660053;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=9URtOwr/J7TkzlGgRbYmOknzNQNn+Yi2oYcy4B3bLaI=;
	b=nu9EMQYCwYh5lz9/Kc3bRIrHKv/oBvqTRrQjQWrxZHrNsMLvQ5zFk8xrTge4tIvnh4yp
	 hxrhmQNSQVZwoZ1IVEocUkV3UaWN9zF/yNJC4HMIZeeE5Hb44Ytupl4lp4n2imXKZyGRj
	 r1cx7QBQNWdCxg7rwjV67V8PzSI+jB0EenKCxqOnsFCcsHVLVMHwX6VF5QNx5i6nE1amg
	 GeIUyPiR5ibhrJBNyi5ZJh7d2TYYGiaXGKxpphSZRBYeQTitOIAfp1NaW4Je0kOMjUBuq
	 93UOQ7kTCv5LhxhgVdILgltvt7lP4442mc2V6HDavDJK80xZWvSoN1FXI8Neh7erMyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nMH8fLnl;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D13F606A31F
	for <bridge@lists.linux.dev>; Thu, 22 Oct 2026 09:07:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D13F606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nMH8fLnl
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1438d9363fbso575265c88.0
        for <bridge@lists.linux.dev>; Thu, 22 Oct 2026 02:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792660052; x=1793264852; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9URtOwr/J7TkzlGgRbYmOknzNQNn+Yi2oYcy4B3bLaI=;
        b=nMH8fLnlrvwOrpWsms+D06wVZipKxwmkCDVTzqTzEAYBDmktuLRDKGKR6rjBPcWoFy
         TymLWuceCZp+wuLMP86B9R8hGFb9652oFvBiRVNfx9LX2tRdBaf5ORwdS7ZIjHOIY0iU
         VU7wwumGVEo0URsm0WKAq8tJvfwiSyJqgONqjvHzvj/mSyG04RTuoQyXhltT7zIa3Yuh
         Eh9Y+Nfs62CkDKi7P6toyTDTusCUdO4EH3eVvLdzflJtzWfjJxysuiwlG1JQg41RXwHG
         mPmDX2lhnUSp9Iol2R4R35Dmb7e9lL4IhMxDh0utA83BvgqH0pgS8TomY1Mz73eZTzUX
         p4iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792660052; x=1793264852;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9URtOwr/J7TkzlGgRbYmOknzNQNn+Yi2oYcy4B3bLaI=;
        b=eQpZGemimDJ2BviwRi9AXBQEjoBXiePGh1lsPgGgj2FC+RUrWK/3ysbR0zm6xJi2Tb
         iK0DgIHIplMUGxIGzZUc08h+zSaipBhhj2nfkGlqRGnLnmAka4kIg80zJcv6akiegi80
         aDzji1YPLfYW9lFWMdxpJN753hF4XdgZQLKwBJA/d9xeydDnQd42cw7RNjQl/X3dXF1w
         g4VqvFmWjREDo3khWYFmjUTFjeIp5fJED4Nk2yUhKmuYeoUaLeqi1w2+k1pQ2XfUyu3O
         +Wt6za5C2JUZ5gGr3eWLonyGrxnYQw6Q5Mt2SiqqpYRUEtwODvjfw90UzGU3BjdTZpVF
         RgnA==
X-Forwarded-Encrypted: i=1; AKwUvBwrfEi89pnWnwfqORx4N/sDnINnyjCO3KCZFcnHuOsXRXjBcRududG2k/44TqUSIXhxdkJ2fmE=@lists.linux.dev
X-Gm-Message-State: AFq9FYJ3CtvH/3TpjkjlGwM48i5hebAZ/QAagZw/hwIIGb+KbvDUhFXy
	4FGCsAKg5z0VM0xEFjCJpPNrNPLWmNMhCdnp57qW5ibRDrPHtXrkCsJM
X-Gm-Gg: AYBFou0dQCC7n5sjdL7uE/hjPllAbZXNS8395VUxaCooVNWBmrpo/2TFZsDLeVCUQZE
	+z2Y3AsswLxcWeMJctDXQvGehOr2x4WQnXDcAAgTUuDHQl24sozcHQ3kbyLIhoGJMv5euie3m8Q
	Iv8nscahi8avpENog3l2BMsXEeCcZNf+gOaQuP9llv0q467fjQvYGyrBc13/3+09l4c7u13GYwH
	dUq+L6cj3GwUv1SFCXtnGrENvS83VF0jpM8SnTbiu4/ZbR5YzjTRGHg6kErK3YE7XoMQOxUvhXU
	Ocp2/q3o5cdYv9VwpO3MnAPXWsJD3pYi0w8bvRNIocBNoZ1OZl0gsfMt+uY1BUx1ben4auLtHHR
	+wOtd/gzA+O0ScCtpOoLnFhhr/xioKEvxDn6aKJlcnTmcO4YSpLqs4q2omY9qe9Onj3skbZQykW
	HW7LoJqkf2V9VrAGQgp7ovGQnaXmmOawb2DuX1+XHYK2HBc74O6pgzazLSgrCEw24y3HySYtJPm
	D0lXYkQSrFRT9lJ+Q59EbSW9a2yIsMeTQhMqwk7jBvaowh1Js24jJ6rTJ0+P9NYO/ETZzCfA/V7
	eRwgV75BW/+KfoO8HAU=
X-Received: by 2002:a05:701b:280a:b0:14e:61bb:ec3d with SMTP id a92af1059eb24-192f03cb940mr2225519c88.16.1792660052045;
        Thu, 22 Oct 2026 02:07:32 -0700 (PDT)
Received: from youngkk-vm.localdomain (67.216.200.102.16clouds.com. [67.216.200.102])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-190e29381d9sm11175412c88.18.2026.10.22.02.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 02:07:31 -0700 (PDT)
From: Cheng Yongkang <teel4res@gmail.com>
To: Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [BUG] net: bridge: failed offload leaks busy hwdoms and TX refs
Date: Thu, 22 Oct 2026 02:07:23 -0700
Message-Id: <20261022090723.3644079-1-teel4res@gmail.com>
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

br_add_if() can fail after a switchdev bridge port has partially
offloaded.  For a bond over DSA user ports whose LAG members report
different switch IDs, the first member successfully reserves a
busy_hwdoms bit and increments the tx-forward-offload static key.  The
second member returns -EBUSY, which aborts the upper-device link and
eventually frees the new net_bridge_port.

The br_add_if() error unwind does not call nbp_switchdev_del() for this
partially offloaded port.  The reserved domain and TX static-key
reference remain with no bridge port owner.  Repeated failures consume
BR_HWDOM_MAX domains globally for that bridge.

Observed on Linux v7.3, commit
08ab31164c55f20c7a2653de3186ae333470e2c1:

  before attach:        busy_hwdoms=0x0, key count=0
  after one failure:    busy_hwdoms=0x2, key count=1
  after three failures: busy_hwdoms=0xe, key count=3

After every failed RTM_SETLINK, bond0 had no bridge port and
/sys/class/net/bond0/brport did not exist.  The bridge port list had no
owner for the reserved bits.

The target bridge and DSA code were unchanged.  Because the VM has no
physical DSA driver, an in-tree dsa_loop build was exposed as an
external test module and a second switch ID was supplied through the
normal DSA identity objects.  The reproduced path was:

  br_add_if -> NETDEV_CHANGEUPPER
    -> dsa_user_lag_changeupper
    -> dsa_port_lag_join
    -> dsa_port_bridge_join
    -> switchdev_bridge_port_offload

The failed br_add_if() unwind must fully undo partial bridge switchdev
offload before the port is destroyed.

Candidate BR-030 is a distinct packet-suppression bug caused by a
self-match and hwdom 0; it is not this resource leak.

The module sources, harness, and full logs are available on request.

This was found with AI-assisted source analysis and fuzzing; the exact
resource progression was reproduced in QEMU.

Thanks,
Cheng Yongkang
