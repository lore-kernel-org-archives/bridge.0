Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792660596;
	b=3He8WyXUh9g3A09dSYi6sebl6+BLPRQOe9+bieNgBOzm2HaxzBVQq1FRHxR0+xUc750b
	 dX9+KbL3qdxsMUatP+hdukrfrhnfDUzKpBbAvqZClFaE44HdDSMmuoUUDC9ZOBoxsbnnW
	 CL6DCkoB93fTzWKOvyBx+UcK1iTyVRxItTJOT8dCEyw+/qJqThALVpdyi1qvX4G9UVvIf
	 N9W8DFUto8PEdDDoqTwq9JOAvxYBEqAd0ocAPH6zNztjy68av9qpETn1WHsXipO/DzOF8
	 qKboFTJdcGErn1Ss3lHKlLCEq0dnnQgaCfzWJfd4NZ872rVq34zVPXTpJGBrKb+Oniw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792660596;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=+AMxaezLFZtkF1EvuUK/tXZzKytmFsqIBjzoA/zZ63o=;
	b=1uPONLRBrZwMNxG3BKJP2BEWd+6kBYONPUL0ab4bVlkR1FCkm9FP2lCVP/jG2w3BUzAy
	 AEnNguvizSyW2IO7CRB+kIJpxYvWpnyzXvyfBfLCAuxY+qn2gBPfT117QmBaWleL4/QK6
	 57xislejs/45co8rjpxPf1QEi8mzz0AutwMj+Jk8DYHjlbT0cExUV5lptob5JbcA2RBDh
	 +SdP/7PcwHJ89XCU7lLb6sM6LtQVcRwSE/cQb5OqsE62uBGMuqUolW03d4E7ODOtIvNKD
	 iLqeuprBJQ0WJk9lX9chZ9LRYlQ0+xZL597/g9gIo1pbK0piP9AGUEwjS1H4VeEMceg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=T2ZJBQ8I;
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372F5606A324
	for <bridge@lists.linux.dev>; Thu, 22 Oct 2026 09:16:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 372F5606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=T2ZJBQ8I
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-185fd3a4ca3so808882c88.0
        for <bridge@lists.linux.dev>; Thu, 22 Oct 2026 02:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792660595; x=1793265395; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+AMxaezLFZtkF1EvuUK/tXZzKytmFsqIBjzoA/zZ63o=;
        b=T2ZJBQ8IStRZSNfARahpHbEWbKPxVwnCCOQlJRKeKo0nWJRaxZ0JWM+OU8qDkQYnpP
         POn64/dXZsw8pP1SJlMHGA9N7YLCWBLUk+uS2rSDx9NO/e39Ex2GBd/zHZmvI03OOUwh
         CLHj2TUzX4dyj9heLGHm2L10swn6ugiNYTFVzf8gf1mKz5FMubtfjScg1P7FdYhbLAED
         vByZSP5GMuANFqE4UMKNimoKsgwwlblBtviT31kd7OCatbdThq745As1JM0zqs7RijK5
         kyD6tyDKk8cyfCjxfYp0xgydEifYDQk6Xe9ZLimhinQHerXk9Wt8jOAf6IFYlx91b37A
         139Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792660595; x=1793265395;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+AMxaezLFZtkF1EvuUK/tXZzKytmFsqIBjzoA/zZ63o=;
        b=sy/rJSTHEltklq9mUonZFwXSGB2hSxTdCqla2A7kYJepU1vZ1ztrdcnAGVGNQc9Gsj
         zayuSBQoSD0K9qf+Jx8bPjjd0bqMdNemgjeHWu7UMt2PuGivRMkYdZ6AGDRQWZBV26z1
         vpE8r1B2dzmQoYo8YcmxDlbi7lt0fMCsOI0C+EZ/uxAUmqkidRe2v3oYv3+2aFnOX8KF
         ePWgqtiB08aOzrwtha5z5FTxDOjjZfMXh+gaNd5hyFUtT7grS1DctH69vbZczHOIdWdS
         aoWUoSAYBUrMHsU1+tlySkvK//llVbxTnNRb1ii5Doto7MtMTpQf613iPlb03HFDPDEh
         lMYg==
X-Forwarded-Encrypted: i=1; AKwUvBwvbz9IChcLtCXuTOq3W6GtoXjdOY6LxqIYjK9pm8foCOlVQmr/vL0/h5eBc6Oe+FclZ8zRSOQ=@lists.linux.dev
X-Gm-Message-State: AFq9FYKeE5f0vI1Tzi3in3gjDPL9QPcmfJiA+EgNCYCifOvEXRmWa8cL
	YFfN0fsivlK6lr5FLDht3TxJhPNdlLKSB1iJ/ZRCYynzi6L6/gkI20/C
X-Gm-Gg: AYBFou3p1kAP5s8D7B/4OanU3Il19tdTEvRknryOtKVWfa4t/71qD8S1QgRpS8wUL2p
	bBsgWWfvxFAkYgY6kvcomzF/4pCi2lvpuZsmGFqZ8tD3HJ1aszwmiqXPuuWBVYolNcRw/cORuO+
	IfRbX66ZE9I5ZZzF1udynXKRlmWzBp1luFEgHFqoPFnATS4M07b5JFtKt5IzGPZ6pWWx02+ogq5
	sGdRGG0I9GyLQy7zaipFmy+MAbOU62t9tBQohTsFZzgKL8CV6u2QlkirhB8MaP5vDP+8PRi6d/+
	xYB8jap5hiMip+ICC01yTvUIdBHYVgTXrW68ABqQ4EvctmiFFR4NYLsGJuGG28slCJHXUY6njuT
	AY7Qlp+VB7zYROCpacPKGEcqn+jpiyHn0OsxRk/29VJLuyfiBFrYNmp5lyn1/K+eK8jq/Y4kQoa
	Xy6FykeX7T9WuAdfOBqb3pO0MW5nyqJnca/NZxpv3y3BHX4ID5LAoimfSLlnKFZQQaXmOBvsBaS
	kY9bfbppVvJxLZREzqAMMdj8fvgtFiVPqGUSFJLsHCBhziZgCYc1H78PfI/b6OFi7zHGWbFwqv5
	gm/NzYhKnlkAAiIAQSvUInDTvrjNQtdA5dLIcllS
X-Received: by 2002:a05:7022:407:b0:14d:c7ae:85dd with SMTP id a92af1059eb24-190a52e2836mr8053196c88.7.1792660595263;
        Thu, 22 Oct 2026 02:16:35 -0700 (PDT)
Received: from youngkk-vm.localdomain (67.216.200.102.16clouds.com. [67.216.200.102])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903b3d0530sm13702627c88.11.2026.10.22.02.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 02:16:34 -0700 (PDT)
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
Subject: [BUG] net: bridge: VLAN range notification merges unequal state
Date: Thu, 22 Oct 2026 02:16:29 -0700
Message-Id: <20261022091629.3652038-1-teel4res@gmail.com>
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

br_vlan_fill_vids() encodes per-VLAN state, tunnel ID, neighbour flags
and multicast context from one v_opts, so every option must be equal
across a range.  The dump/options paths enforce that through
br_vlan_can_enter_range(), but the old-style br_process_vlan_info()
range loop only checks whether the request changed PVID/UNTAGGED on
each VID.

The old path can therefore merge adjacent VIDs whose state or tunnel
id differs and emit one range carrying the start VID's options.  The
notification then describes a VLAN map that the kernel does not have.

Observed on Linux v7.3, commit
08ab31164c55f20c7a2653de3186ae333470e2c1.  VID 10 was FORWARDING and
VID 11 was BLOCKING.  An old-style RTM_SETLINK range request changed
UNTAGGED on both VIDs:

  one RTM_NEWVLAN: vid=10 range=11 state=FORWARDING
  dump:            vid=10 state=FORWARDING
  dump:            vid=11 state=BLOCKING

The notification tells listeners that VID 11 is FORWARDING even though
the kernel database keeps it BLOCKING.

The old range path must run the same option-equality check per VID or
emit separate notifications.  The February 2026 expansion of
br_vlan_opts_eq_range() for neighbour/multicast fields did not add this
missing call; I found no matching fix or CVE.

The PoC and program/console logs are available on request.

This was found with a multi-agent workflow; the
notification/dump divergence was reproduced in QEMU/KVM.

Thanks,
Cheng Yongkang
