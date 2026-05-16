Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A73E26159E
	for <bridge@lists.linux.dev>; Sat, 16 May 2026 05:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778908145; cv=none; b=YF5L21ohMJyq4+T9LydO8cw6nFQGTZlal4lWR4QP1t9Rq2SFVqqt/1NJ6r/W45v1cUS03NX7Ni04SyGUaf2oN0iJxWbBJSqUs34ljFTK8tv6Q4LIT1QZdCgyTLQS5FrtWV9i2evRIl+PWG8Q+3Qvybe2T8unKtyMuFDixGB3mRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778908145; c=relaxed/simple;
	bh=ISuYdhRgBF/I88vajJ/AvTvMbUJp4nxRUWM9QUUwl60=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GC2dT4ccCqDkH/V52xPgyTZzgg6YVzBU4trOAkmpsvQHQeUuKNqyYX169GZ9tOovABLNsPV0LOlXLbtC4bCfDB6eKssvHb2hRMULwD9R+93S8zQeUdi5lj0tlsbkzzk3Th2m7YRJ7KfppXH2+krS+wIwFNPJB70SgDNqkG5qDLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L2AfTgUn; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L2AfTgUn"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48e82c23840so2835965e9.3
        for <bridge@lists.linux.dev>; Fri, 15 May 2026 22:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778908142; x=1779512942; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fiPdzVDkhoOohsVNfeXeRSo393UPIi49IoHtz+Ot6WE=;
        b=L2AfTgUn9U9wVyZVlkojp7Zl6wHerH0aUsa9bvYP0HTdZGf/g/RGKQVpfMUwsR0xLr
         SzVldOnY5Mo7jum6hydJ0oSuMu9l+rTGG7d6AC9y+v8tJgqqw0DwR7xZRInfbkGIomdY
         AKwpzrl9ZdmgiZw1Z6TOm7GC251XpAsRc/n16Hk2juBGdTeDDcZNHP5BWgO7d8BUr3O8
         PHnuobvogQunS34qpV92qXOGiEIuPui9si51wSrhMu1+V0DV0GAKbe/oYad56bLjGvJN
         40KmelesvD8BHOSArKMmPwu6ZklH8++XurNzTK5t1ThpADe5plvOfGjg04RO/vfoDg3T
         HGCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778908142; x=1779512942;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fiPdzVDkhoOohsVNfeXeRSo393UPIi49IoHtz+Ot6WE=;
        b=qUr6Mxlzv2paIetYppYxxEgOXKu32+IMGCXo1m/Fm6H+PdV3Ii5omI3gi7HFl4PALw
         pJR+M8n4Uhme83bCl0l7t2GGEzCheyY2UxyWIy3w/rEBG7prgoff27BOBpFT6cpiJb6Z
         VzR4/SUTIzuA2zOTamhYXoRvKEgUzRewWq4WJgsC3uG1FrVI8sL9g8IegzNL0GQ2cBAH
         sduQy4Y8r3q11TST8/cE74mi9MIvE6XwTk5oERii7KHgTXAEop3XNFBOECedUyX/vgVb
         MMoJy33KphduARLfDetWOftEOA6CVIoPsTaiZrWYvvFZeT/sG1P4pklhdTUJ2NyTEaKM
         FE7Q==
X-Gm-Message-State: AOJu0Yx8Po7AEG7WR2Fl9G7q+j5sum4F1qKTWnGLp79mDdrQkP1BHWnu
	59H3jjbM+m2/fljN1IDFc1DiztPI4lw5QXXZPYLlOQkl8YLUkt0QTt5w
X-Gm-Gg: Acq92OFAx9wYeTJBwhaBwAEN03GF4ju1tdMXM/9NoMof/P7Xxzylcdc/m1jBr5FklSW
	R3XeQrm3tO4cQ0KYZ8QUfjNI4mVGW/0bbqRdA84nw7NqzTdqD4PV04gfcUUzt/ERK/0QLZoAKED
	ycpuUnckzehpglmhyUe8kJ4cd7LZ/SfZXFFXScRpBVmRE2ZenNhUMghhYiUqE66PJZ24AyTHCDD
	Xr9Jzd7meloVese/lrmM3CF6EPehNYUI5D8ak90AAY8Cv3NZsZphtHhsWjgKINKKImO8Z79VSPn
	TUxsjymWFi0ZJKMr400Ga9sicSe6jPwc17H5BDBtxxlMW+CwLWCYJKK/2MlNGxdKRkh4FU/FEzF
	504wwofaKmMlfZZ283+f3HIOEgQh5vqyGTqWyehaf/1A0jQ6KhFeCXc28pTBrmDpL1PHAmTWz91
	sBlGtsFhKc9S5iQtLmL+YjzGDgo6fCKZCe1BYDOdq8bgtPf4UqcJRv4o/TDNdSlVwYP6E/xMi8K
	G0+y33pSGN95JGQRS0J6A==
X-Received: by 2002:a05:600c:4fc9:b0:485:3abe:ab86 with SMTP id 5b1f17b1804b1-48fe60e3b17mr86047875e9.4.1778908141750;
        Fri, 15 May 2026 22:09:01 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9e768bcesm20648123f8f.4.2026.05.15.22.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 22:09:01 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: netdev@vger.kernel.org
Cc: bridge@lists.linux.dev,
	razor@blackwall.org,
	andrew@lunn.ch,
	David Carlier <devnexen@gmail.com>
Subject: [RFC net-next 0/1] net: add Two-Port MAC Relay (TPMR) driver
Date: Sat, 16 May 2026 06:08:57 +0100
Message-ID: <20260516050858.23858-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

This is an RFC for a small netdevice driver implementing the
Two-Port MAC Relay from IEEE 802.1Q-2014 §6.7.1. A TPMR is a
deliberately stripped-down L2 relay: exactly two ports, no FDB, no
MAC learning, no STP, and -- by spec -- it forwards most of the
01:80:C2:00:00:0X reserved group that a regular bridge consumes
(LACPDUs, LLDP, EAPOL, and so on).

The reason I started looking at this is that there is no clean way
to put a Linux box in the middle of a link without breaking the
control plane on either side. The obvious answer -- "use a bridge
with learning and STP disabled" -- doesn't actually work, because
br_input.c filters BPDUs / PAE / LACP before group_fwd_mask gets a
chance to forward them, so anything on the wire that relies on
those frames reaching the far end (link aggregation, MACsec setups,
802.1X) silently breaks. tc mirred only mirrors; macvlan passthru
is single-master; an XDP redirect between two ifaces works but
isn't a netdevice, so neither ip link nor any of the network
managers can drive it. None of these are what the IEEE standard
already describes.

OpenBSD's tpmr(4) [1] has filled this niche since 2019. The driver
proposed here is inspired by that one but mapped onto rx_handler /
rtnl_link_ops, which lets us drop a lot of the BSD bookkeeping
since the Linux framework already provides it. Details are in the
patch's commit message.

It's sent as an RFC because there are a handful of design choices
I'd rather get pushback on now than after I've written the
selftests:

1. New driver vs. a tpmr mode of the bridge. The fundamental
   question. A separate driver keeps the bridge code untouched and
   sidesteps br_input.c's filtering entirely; a bridge mode would
   reuse the slave management you already have. I lean toward the
   separate driver -- the semantics are different from what a
   bridge guarantees and switchdev offload would be cleaner -- but
   I'd genuinely rather hear from the bridge maintainers before
   going further.

2. MTU policy. Strict (reject mismatched slaves, refuse desyncing
   changes, bridge-like) or pass-through (bond-like). The current
   patch enforces strict at enslave time (a second slave whose MTU
   differs is rejected); runtime MTU policing via a notifier is
   left for v1 so the shape of that callback can be discussed
   first.

3. VLAN-tagged frames. The OpenBSD driver bails out on them. Here
   they are forwarded with the tag preserved -- in the MACsec /
   LAG cases that's almost certainly what users want -- but worth
   confirming.

4. Reserved-multicast forwarding table. The IEEE spec lists exactly
   which 01:80:C2:00:00:0X addresses a TPMR relays vs. terminates.
   Only 01:80:C2:00:00:01 (PAUSE) is terminated, as it must be by
   the MAC layer; the rest are relayed. The table is hardcoded.
   Making it per-instance configurable feels like premature
   flexibility, but I can be talked out of it.

5. Statistics. ndo_get_stats64 on the master via dev_get_tstats64
   over pcpu_sw_netstats is what's implemented. Per-slave
   forwarded/dropped counters would be nice but add ABI surface;
   master-only for v1 unless someone has a stronger view.

6. Netlink shape. IFLA_INFO_KIND="tpmr" with an (initially empty)
   IFLA_INFO_DATA nest, leaving room for a policy flag if #4 ends
   up configurable. Flagging it so the shape can be argued before
   it's frozen.

Not in this RFC, planned for v1: selftest under
tools/testing/selftests/net/ (bidirectional forwarding, link-state
aggregation, MTU sync, third-slave rejection, rx_handler conflict
rejection, reserved-multicast pass-through), Documentation/
networking/tpmr.rst, MAINTAINERS entry, and iproute2 support as a
separate series once the kernel ABI is settled. switchdev/DSA
offload and richer ethtool_ops are deliberately follow-ups -- only
worth doing once the base lands and if there's demand.

Thanks for taking a look,
David

[1] https://man.openbsd.org/tpmr.4

David Carlier (1):
  net: tpmr: add Two-Port MAC Relay driver

 drivers/net/Kconfig          |  14 ++
 drivers/net/Makefile         |   1 +
 drivers/net/tpmr.c           | 409 +++++++++++++++++++++++++++++++++++
 include/uapi/linux/if_link.h |   8 +
 4 files changed, 432 insertions(+)
 create mode 100644 drivers/net/tpmr.c

-- 
2.53.0

