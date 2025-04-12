Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E141898F8
	for <bridge@lists.linux.dev>; Sat, 12 Apr 2025 12:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744460676; cv=none; b=AaUqIioI3tUASHsLiCWDfkjWE0ITyuq55wSKt9X9ezfrBDxoJnooBl59qCbyu++5T6/YhgUBODQpAI+mYqtQ9FEA8K98n1l1Dvf/X8GPTrVt0N1LHqoy3Ob1fm8CTWFZ8mi8jxm53/RduIBVyx9YybzvjNn6DI3cN2907nWyECQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744460676; c=relaxed/simple;
	bh=J80O7lx+S9pEIU6bV6NeFN2f6XCVqGZw2Hw8t5NoRHE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ScjHWKJ4A9b9FDtY2lGhxlmYfu88lTjPDWHfMIMXnja+phjksikNVVKApXOSZ1b1Xq8b3+8DodhwL/u2s1xorIggGxk1bpXFmgpnr/YaJwTeDY/RCEcgxx8SP8YBDcTTGeWspcj7rkaeSMfT8Mzl3tB615SzM8bMpvuIsiHFilA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UWP5ED5q; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UWP5ED5q"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-abbb12bea54so561348466b.0
        for <bridge@lists.linux.dev>; Sat, 12 Apr 2025 05:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744460673; x=1745065473; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bVuqSu3NOK87RkcbSVOR8gLBwOzmPgPAFU9FS4oYFp4=;
        b=UWP5ED5q45vQjdipv4fGGIYXKT2GzuhtJjsdNXML/UU0bEkKO1bG94Hwop5ekqHhRB
         673UFgKuEJDwYkuAJYxLmgWoCBwkIZUiivo/RGTgNfGy310KZxpp+hgT6S32s4J9rYTO
         6DAEOynoUAoqrEm71uBAdKml2ugwNQGJZ5Tye94KpNzBbOi5aKaGEj9TRmSGEYqDL0Ty
         KYklAdqosTNbp0NJ6NRDs4OEvwGT6NQzbte1zG9TDV1AJdq5b5ATKz4OFpjA2fU8cz+x
         iPoh8p2M1geGyPXe1xG8LLrGv/URM9P+QnvPMvu8o9xr9DN4gkcE3hxJmZGp0gOPNqVy
         Jdig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744460673; x=1745065473;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bVuqSu3NOK87RkcbSVOR8gLBwOzmPgPAFU9FS4oYFp4=;
        b=AvQecnuoHn/JumzKZwnDgR0W+6sY2OCe5yhpO+LMv/6soZpAe6YE4esXWLne53ks1/
         N4SEhp4FtNNWTgtby67f0/JaFJQubIul+vOllM8WDI9cwbtrvZijzbm3V1jlm+iGNUMR
         nn2xE820lfBiTcIUiShh9PI+/Qlz3ujDEgeibAnImxAt51oRPGivEf2KwC+murkiKtbh
         tc0EVyLgh0sXUy06BibIqYzlBufKC25WSy7B7qhvxbkHajHtMt5rbSFGBsC+bg0q2zwv
         XwayW/z2DCjhQw7Y2h9RkdHJpdvoQkvvUd/WVJFwBYl5ct2M+18Uq/tj9P2YMUMEnn6a
         e47w==
X-Forwarded-Encrypted: i=1; AJvYcCVthjMROJrx+i/kXnttLGmZC/Ce2UTyhbs6cWh4AX2eeMCOIc0TFHuD6fI60slM5Qb/gHCPh+E=@lists.linux.dev
X-Gm-Message-State: AOJu0Yw0o43Oi7dFdclkrQ6rrwP7qgnUM69103VXraly5kK8QsrU1Blv
	7ga8Uc3zCaA1vgB8MpvlLZdeKYxZTAa8yiQyauZwITlHGH0iQqZs
X-Gm-Gg: ASbGncsLbaCu7ei1ZyifgZUlgf5mYHC6tsqmL8DxB0vxvXgz7PvWpvd5NmAqqFclCxB
	SuPtLOnYlbuQttqQ6lK9RbRLTw+1Q73ZYiy68wH3zPNqV14fRpU6mKkffApXobYSib2+h+8Ng4n
	L3Xnf8dzmV0COM18xr5CWsTXb42lrVH5I1rCyX7n2Z1jhDECLidTr2hnSXZQgFp9uLkewpS/mxJ
	kZfNkGCrYoitcjC1/fi+Z1uVLOC+ioNhOBrfIbXynGfQUB/EfXboRA3tpuxB1asnFdfgTgdm56C
	KpwXWNer1MNkLWoA646iqZrDtTDrJ++PFx6ZGQAZehqYK+v26dd1+BRu619j69kTTJVMHyCiyt6
	ZH+ntSXbQUbn2bpES1ZNN
X-Google-Smtp-Source: AGHT+IFc5anELwtiJCusv+yFZK/tdXxvnsuy47DJan7xHGiTN/SrWnZQYj+SMt5guZE4sgjUUqlcjg==
X-Received: by 2002:a17:907:3f16:b0:aca:c7e0:6375 with SMTP id a640c23a62f3a-acad3456e7fmr561981366b.2.1744460672462;
        Sat, 12 Apr 2025 05:24:32 -0700 (PDT)
Received: from localhost (dslb-002-205-021-146.002.205.pools.vodafone-ip.de. [2.205.21.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1be91a3sm588742766b.44.2025.04.12.05.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Apr 2025 05:24:31 -0700 (PDT)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC net 0/2] net: dsa: fix handling brentry vlans with flags
Date: Sat, 12 Apr 2025 14:24:26 +0200
Message-ID: <20250412122428.108029-1-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While trying to figure out the hardware behavior of a DSA supported
switch chip and printing various internal vlan state changes, I noticed
that some flows never triggered adding the cpu port to vlans, preventing
it from receiving any of the VLANs traffic.

E.g. the following sequence would cause the cpu port not being member of
the vlan, despite the bridge vlan output looking correct:

$ ip link add swbridge type bridge vlan_filtering 1 vlan_default_pvid 1
$ ip link set lan1 master swbridge
$ bridge vlan add dev lan1 vid 1 pvid untagged
$ bridge vlan add dev swbridge vid 1 pvid untagged self

Adding more printk debugging, I traced it br_vlan_add_existing() setting
changed to true (since the vlan "gained" the pvid untagged flags), and
then the dsa code ignoring the vlan notification, since it is a vlan for
the cpu port that is updated.

Then I noticed that deleting that vlan didn't work either:

$ bridge vlan
port              vlan-id
lan1              1 PVID Egress Untagged
swbridge          1 PVID Egress Untagged
$ bridge vlan del dev swbridge vid 1 self
$ bridge vlan
port              vlan-id
lan1              1 PVID Egress Untagged
swbridge          1 Egress Untagged

which is caused by the same issue, because from the dsa standpoint I am
now trying to delete a non-existing vlan.

After fixing that, both were now correctly working, but the configured
vlan on the cpu port would be stuck with whatever the initial add set.

E.g.:
$ bridge vlan add dev swbridge vid 1 pvid untagged self
$ bridge vlan add dev swbridge vid 1 self

would change the flags in the vlandb, but the hardware configured vlan
would still untag at egress to the cpu port.

Patch two fixes this by allowing changed = true vlan add notifications
for the cpu port, but skip the refcounting. Presumably with the patch
there should never be a vlan add notification for the brentry with
changed set to true anymore.

In case my reasoning is wrong, I added a WARN_ON(), but I didn't get to
trigger it so far.

I did a check of all handlers of switchdev port vlan add notifications,
but DSA seems to be the only one that even looks at the changed flag.

Sent as RFC as I am not too familiar with the dsa/vlan code, so I might
very well have overlooked something.

Jonas Gorski (2):
  net: bridge: switchdev: do not notify new brentries as changed
  net: dsa: propagate brentry flag changes

 net/bridge/br_vlan.c |  4 +++-
 net/dsa/switch.c     | 22 ++++++++++++----------
 2 files changed, 15 insertions(+), 11 deletions(-)

-- 
2.43.0

