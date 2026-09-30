Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com [74.125.225.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5510843785D
	for <bridge@lists.linux.dev>; Wed, 30 Sep 2026 19:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790797860; cv=none; b=CV0cnn74gT2GyfxjzDQcXwaA4DJYLhLBVYmPhMtsy+q2D8/yuwxE14ID7zmLWsE9MXR4ZrMWISlJbROQswyxSJ4tpWG0+ITwTip3yS+lWGh1Z2kFhit2TAeynX7NQvS/Xoh+Acvzm/UGSpwYZ8zML37WTZUiaXPOodlC1vHhim8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790797860; c=relaxed/simple;
	bh=g8kSnvXNg0KFakuMMNxgd5z8HZ/cGn27nYQqTIEFHGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HPduD7NwkEf2tQ6ouSx3+jnlw5lqwslQMi0A/tZnX3kt7np9JTYUGKdXp9CdaD4IhMSfz586zAfiuUnOipA/EgYSmS/4HeES4wkfBTxDwkXBaXLJhJnNWCKOFLQRs/RR9x52CgNyoVFMrvDvUsZKXOEZz7oa6UxeI1WTK2r6GD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JBoXp7IS; arc=none smtp.client-ip=74.125.225.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JBoXp7IS"
Received: by mail-wr2-f34.google.com with SMTP id ffacd0b85a97d-48afd5b1678so731476f8f.2
        for <bridge@lists.linux.dev>; Wed, 30 Sep 2026 12:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790797854; x=1791402654; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zG43L4MPOSqtW553TU6Kwtxr/jOwyLkxMDRoqbA2Niw=;
        b=JBoXp7ISkR81h5Gc20BgtnzDGW1IwwKZPY2jwiCWFPbobajD2eqE1WYYrsny0DkG9g
         Oe5n/qwI9jBI1gnSdR36ILWi4nT1c4NLyCBas1PBhoHFWHPcTl9EDUuJviStLOJSgeY+
         EIpZEziYcooiJuDP6WzJoEEEGpyiU5MAxMe0P1jHzJUNHWNs8u89eMTac8da6QRM0o6T
         K1b5Bg+8n7SZdGRJ1+o8Gf31YXjEQkqWLQ00XFZG238QO8xB0vn4SrF2/Z/9t1QN+XmI
         G/NWBLwKgGfaipX6aRAu84Kn9FYi3iohNT5SoGaJhtXq2d5RH8YbnWtduDxlW1yieF4v
         +FqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790797854; x=1791402654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zG43L4MPOSqtW553TU6Kwtxr/jOwyLkxMDRoqbA2Niw=;
        b=TcqOigJzgxXGlf9/qh394VHywSed/pPNmaYpJ9GGUnG1//s+LEqz5GuakiGbrtl/a7
         SPFey+D+asYeXNZ91BHYe3+wVqn4yv/WuWMlBDpZ7xVEzxV+m2xMN4wlbzlfkRcd62z8
         9q/W0vTZoZ2/b7zxeSpXxq3uIXrjITOwiH8luqUdCeSNWgdCQiKJfYrQkEktO65cJpj4
         NVSQGvNhtQsUuV98yP/qIEFMeCdD7nnjSHt3TR4eoRTLfQsZKTaqIuiDyASSmk3KKqvO
         adksTUBcvdMu1+ZuxtqZoPDxe7/DhrTHu1nvvNFwvQo0Ihxan1JMc6/bIce050BFmcl0
         N8Dg==
X-Forwarded-Encrypted: i=1; AKwUvBzgGZb+BuggzqmjIHBNTk44qnKWm1HeKmCexZZdx6jnFRudK5ecHaxolYlTJ4scQwG5fdwSe7E=@lists.linux.dev
X-Gm-Message-State: AFq9FYIm2NqIlrsuyaE2ymb04+Zi5m6r7YiCeoMPStF71O7TK2hz7jlJ
	GVjg/qKYRcZYgAOvViohznXB+wKbViHeZUD0lwxmtfKkawViLJgRyzrcWAyJwyml
X-Gm-Gg: AYBFou22ir0WTJXjgh3tcP2YsTD11mogC7W61uRdSMoQ/igyxLTf6KodjPhjALWtjKs
	TWjIYCglZbJtIi8BfYMOmI65EAcY3Diq9xGEYWrQ0xFLiajUmdSdxTsl5KtZ8CDvwwFJlNMsmo1
	a7DxkgRBGC1+LKutUMISZHUuNrMU2+mC3x07bFjDAVEm6nDVDVs+68sxESw1chGEQi8sxe2e2SG
	ko/324DqsoCKxiAicsO9AWRXj+EV5+8/BOm5GvgqwlzYcocjwIkAUvcbnxyptGxvdZReoqjDRSo
	ftYW4TTFV9n2mKoXBlS6yF3ai+yzl7I2QL7lCy/cN5fLYAQJwE9+Za3tdA2iX2xdJr/ThGes9ul
	3FTHqx+gkTO0evsRUvsUt/uv2yalNlibid0ulM/UXAONgJEfQ0tfTtuSO4+HYKIhtSBl4G0FrV1
	Z6f1emFjfYgFo/Qbnr2DmEmC/B77/Kz1yPoIM3O9pNx3jprfhKHn8CMVKbPzXRdrqCup6Ga/wlL
	+jB2NaQCby6LT3MP5S5NL+Q6gFmuvc5j9TS/XxlKsN1
X-Received: by 2002:a05:6000:98d:b0:488:83f7:6352 with SMTP id ffacd0b85a97d-48b0243dbe8mr4875486f8f.4.1790797853873;
        Wed, 30 Sep 2026 12:50:53 -0700 (PDT)
Received: from andreayoga.wind3.hub ([31.189.116.68])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b0692b5c8sm1101574f8f.29.2026.09.30.12.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 12:50:53 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	netfilter-devel@vger.kernel.org
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Phil Sutter <phil@nwl.cc>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	coreteam@netfilter.org,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH nf] netfilter: br_netfilter: restore VLAN tag on refragmented IPv6 packets
Date: Wed, 30 Sep 2026 21:50:36 +0200
Message-ID: <20260930195038.64098-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <179061238760.31693.2318453255259270234@kernel.org>
References: <20260928161830.351199-1-parri.andrea@gmail.com> <179061238760.31693.2318453255259270234@kernel.org>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Resending with the full Cc list, which I dropped by mistake in my
  previous reply. ]

On Mon, Sep 28, 2026 at 04:19:47PM +0000, netdev-bot+sinfo@kernel.org wrote:
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.

The issue was triggered, not only found by code inspection. I
reproduced it under virt-ng with a local test on a VLAN-aware bridge
with br_netfilter and IPv6 conntrack defrag enabled. The test sends a
fragmented IPv4 packet on one VLAN, then a fragmented IPv6 packet on
another VLAN that the bridge floods to several ports. The test is
available on request.

Symptoms: with the patch not applied, the refragmented IPv6 packets
leave the bridge with the wrong VLAN tag. This is the tag of the earlier
IPv4 flow when both refragmentations run on the same CPU. Otherwise the
packets go out untagged. There is no crash or warning; the only effect
is the wrong or missing tag on the wire. With the patch applied, all the
IPv6 fragments keep the correct VLAN tag.

Thanks,
  Andrea
