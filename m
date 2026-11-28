Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795872908;
	b=uLNvAwncEBPUw74G8NDlh7KuogNmzKyB+CeKPFgp1JbfPiktax3hb0h8WG2QNs7OQz3c
	 aPnoail8Pv+srI96PC7yR736mcEM5Kpdp2Xog5BfkRe1lgweb/43LTLelhHZw2cnBCa/s
	 RchQDzPmvaHigultQcJ+DdUoz1C2d4B3SN00UoOzkxhiHDHLqnAf0oXKos5rG/PB+0c+H
	 drWwC5ZIbqQoozKzMUxBmWViKMb+ETIMcAvjp0Kxb/B3wc6shuwhvjV2Mzh6P2UTBe93b
	 LWg9zwFGiKwTpn5Jjtj2QgnPbYpGYY/qPRYp254b0vqn8fY1lEmd0udFKYLoK45r31g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795872908;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=1nx0IzBlV3p41W0idmpXgDKraGpG2B/QDdKxYpSRZy4=;
	b=dttGN5BRRMeRevCKexX1T/sNI8/BmgYyXsp7Ex8GuJsl/t0RRxlIyKn70eGEQ7xhEm5g
	 z/q9nD4lyHA7ltLHQlpaagZRiucURR/x5hYflIGJZ/2CnD5WDtWL123bht232RpBUdKKK
	 04CR16LlSEEv6YWilf1rBJJ1YtqS2qbYl5sVlfbaPD+Gc03EdQ1dhRHsnTKO6w9Ui/btg
	 w0yDw/TerQZpdxaLi0JUpTgq3cjWMuBRb4DgwmLvX0tR2c+Elee7eoLVCJgT9DW5oHlx+
	 qmcOD4zm6JE+9BCo1DmZxyvi+TnPbKQWvyuOCWYgWW8ugREGobqdfB+95HBV33lBPZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bairaktaris.de;
	spf=pass smtp.mailfrom=bairaktaris.de;
	dkim=pass header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=pT5qBdAF;
	arc=none smtp.remote-ip=209.85.208.48
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0177606A323
	for <bridge@lists.linux.dev>; Sat, 28 Nov 2026 13:35:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0177606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=pT5qBdAF
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6ae305e3bd9so3908275a12.0
        for <bridge@lists.linux.dev>; Sat, 28 Nov 2026 05:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1795872906; x=1796477706; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1nx0IzBlV3p41W0idmpXgDKraGpG2B/QDdKxYpSRZy4=;
        b=pT5qBdAFpMf+9jPjL7LNaXezgrQU3CJ9RMD1ZeDBung1w9/3n0ObqulWtkL6uWplFC
         I/o0V1FMdUnwHHFyjlp8iK0UdtOVNh12shUkv4SSuitYv3k7RenS1fTLyfFD0i+IkdNG
         WAazwB7FyAEpA1/MXF/rXsrCHIxZSqgj6uucbGmCDtcQz4ro/x2MKoltbAXm8eWgkvi/
         Ogik4kPD4zuYJGzak+yk13YFKAsXNLxBCBfwKGAQjkUPJclz6wqFr7imR8RaruRqBFFh
         uh/zc+qcyCWIq5Fl4i4Fpjq5e/N8+M1iBYxi9cdaEiekjXeap36xhKtlYCsa7X5E3RuD
         vYiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795872906; x=1796477706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1nx0IzBlV3p41W0idmpXgDKraGpG2B/QDdKxYpSRZy4=;
        b=lXHZFLHF8lCjOYCxGxRD6l18GJFllfcJXoma8rxovZauyMkJwyjXOQ+YuuoyAQjNEa
         bbo8TCOXmCAZE3pv/LbNz+IIwmZY2ephNEY0s1qRMxJC0yXBAxLwX6J2MdZvYpiTLzX1
         05qIVsnbuFXpjFMrhBCql6hHsKdIJ7iva1pgON5Ee6I+e8k9sVWtTE4xDieaqACRuKf2
         S3DBzAi9FDvByX/BvyUdM1edGx1o/kfpC8XdlfAL1srwYns5TwyVhzUWP2N/MwPp+8A/
         ZAbRuXf91eqTc7rf+SeDql9F5gB35b0oA3vg+UqV5aS2L0w1fM2eb0sy0bDPEagUBlA7
         9Law==
X-Forwarded-Encrypted: i=1; AL+hErGtWlE7EBNukMFoZkWXx2hNLpfhamZWoZ2B4AyfwJN0G+Nbb8OLY5M6neR8lGq99V8ad1xCJNU=@lists.linux.dev
X-Gm-Message-State: APuU4Z8gBXSB0q2O2OWbZPPB6vN21XzFUdS5BLcGqovTDrtnSKgYeMfM
	hfdlf/hEXnag9oF57lWdO+v2s5xomzmxhZ4HjW82xCKaOAPR0JLpaJ8CBmG8Ly3Y79L+bYiA/JU
	/UlC34w==
X-Gm-Gg: AZFdTZed1lWyt6FZXYgh5MzU0C2WOaoiz245yfDZS1bCNF5WA52J5jEGCqKSBML8Dtm
	plDRPtxtSZ9yrbMT5Xw1yzFPsO3tZ+qlbrTqA3LGqaQBpE1VWvsa2yezE0hOt2mIwSKrY+fOUxF
	LHAs9WdOF19o4T6kNniOWKNqv+eg4ToMisKytBgrwHr50HBbBQ5mqt7Gzo2NGzh1MgzT5sO0Yir
	UlMod3bgnx/SRyEK0oqWiK0hPwSgelOjjzViB2gYpD7FV+dzRDcMDnb3bmzZRxREEPlTy3IN01o
	a/D5AjMKmfbLu81ZQwvrPaRUuMSZEjNlQBufCw9vqC/wFcpMm6LsZ8jsC+2QEPgKELbfoloC2fu
	/42STqkeATi+N1/JwarAN1Qca/MnG3sit3cYdOw3uTOulfK52mxJu+jJhH5eA/f9jivP+FiFCSm
	XctIwAoTRr0Ux9xMZhlepvPjNMQ5RJPsL9DvzEczoh3vWnyzc38jv4jhPBHKOazhaR9iEBo3wMU
	jLGNFFzYTVjCCx4EX6u4mOD/15MHcnJIgi84Ruag7Kcmr6U0Sems0ubG/kJ2mtej/+A/nHfgkLa
	vZUdb3L7N7GUaiQ/MHqdewimLbindoJ3u9J93LqyWgvEgZytOZX0dJz20E4k7C5Nsi8WGjcWtwq
	R7tMyCsHg2XYPP8CY4XIipMeft3TANxuAn0dB7IjUDMRcEgvfpEpxFlxPP06DSWkRl24lmgkBJu
	y06uk6ap66ZOrPPeB8ixR+OVhC5GxZq8CoHsRJ8zyGvxFXiXKkFCY0ybWILH9BwchZPq/6IuERa
	IQ3jUEZcyePZ1WQQ3IJUVCZ1wUWlV+5J3G4gSm90Ne2MiOtd4h3VGx/vlo84ZSTw59qMy1W9Wbo
	vmz6YhgQtwRbeTIaExstKdakDRjbIBS0eCOSi+73V7kwenLcW2Derg==
X-Received: by 2002:aa7:d353:0:b0:6ba:22f7:189e with SMTP id 4fb4d7f45d1cf-6ba37d63cdbmr13811986a12.7.1795872905760;
        Sat, 28 Nov 2026 05:35:05 -0800 (PST)
Received: from Desktop.tail070c67.ts.net (p200300f247080f000000000000000a27.dip0.t-ipconnect.de. [2003:f2:4708:f00::a27])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6bb1d49d992sm5282111a12.26.2026.11.28.05.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 05:35:05 -0800 (PST)
From: Julius Bairaktaris <julius@bairaktaris.de>
To: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org,
	bridge@lists.linux.dev,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	=?UTF-8?q?Alvin=20=C5=A0ipraga?= <alvin.sipraga@analog.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Tobias Waldekranz <tobias@waldekranz.com>,
	Linus Walleij <linusw@kernel.org>,
	Pawel Dembicki <paweldembicki@gmail.com>
Subject: [PATCH net v2 2/3] net: dsa: hold the device a queued FDB event is reported to
Date: Sat, 28 Nov 2026 14:35:02 +0100
Message-ID: <20261128133503.3887987-3-julius@bairaktaris.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261128133503.3887987-1-julius@bairaktaris.de>
References: <20261128133503.3887987-1-julius@bairaktaris.de>
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Post: <mailto:bridge@lists.linux.dev>
List-Help: <mailto:bridge+help@lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
List-Owner: <mailto:bridge+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dsa_user_fdb_event() queues an FDB event on the DSA workqueue together
with the device the event was emitted for (orig_dev), and
dsa_user_switchdev_event_work() reports an added entry to that device
with SWITCHDEV_FDB_OFFLOADED once the switch is programmed. No
reference is held on orig_dev. It is a DSA user port only when the
entry is on one: for an entry on another port of the bridge, which DSA
installs as a host address, it is that port. DSA flushes its workqueue
before one of its own ports leaves the bridge, but nothing waits for
the queue when a foreign bridge port is unregistered, and a work that
runs after the device was freed reads it in br_switchdev_event():

  BUG: KASAN: slab-use-after-free in br_switchdev_event+0x41b/0x550
  Read of size 8 at addr ffff888004d00000 by task kworker/u16:0/13
  Workqueue: dsa_ordered dsa_user_switchdev_event_work
  Call Trace:
   br_switchdev_event+0x41b/0x550
   notifier_call_chain+0x9a/0x2a0
   atomic_notifier_call_chain+0x5a/0x110
   dsa_user_switchdev_event_work+0x32c/0x4c0
   process_one_work+0x8e1/0x1640
  Freed by task 139:
   kfree+0x1b7/0x550
   device_release+0xca/0x250

Hold a reference on orig_dev while the event is queued, as mlxsw,
prestera, sparx5 and cpsw do for the device of their deferred FDB
events. Unregistering the device then waits for the work, which does
not take RTNL.

DSA held the device until commit 425d19cedef8 ("net: dsa: stop calling
dev_hold in dsa_slave_fdb_event"), when the report still went to the
DSA user port.

Found by an LLM review (Claude) of a DSA FDB change of mine. In QEMU
with KASAN, with dsa_loop given FDB operations, assisted learning on
the CPU port and a 500 ms delay in its FDB add (test-only changes),
deleting a veth bridge port right after an address was learned on it
gives the report above in 3 of 3 boots, and nothing with this change
in 3 of 3 boots.

Fixes: 93c798230af5 ("net: dsa: call SWITCHDEV_FDB_OFFLOADED for the orig_dev")
Signed-off-by: Julius Bairaktaris <julius@bairaktaris.de>
---
v2:
- Rebased on patch 1, which changes the same exit of
  dsa_user_switchdev_event_work(): its out: label is above the
  netdev_put() added here, so an event it drops still releases the
  device. NIPA could not apply v1 after patch 1.
- The message says how the bug was found.
v1: https://lore.kernel.org/all/20261122173347.791590-1-julius@bairaktaris.de/

 net/dsa/user.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/dsa/user.c b/net/dsa/user.c
index 81f0d3901209..2073129b9f87 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -35,6 +35,7 @@
 struct dsa_switchdev_event_work {
 	struct net_device *dev;
 	struct net_device *orig_dev;
+	netdevice_tracker orig_dev_tracker;
 	struct work_struct work;
 	unsigned long event;
 	/* Specific for SWITCHDEV_FDB_ADD_TO_DEVICE and
@@ -3697,6 +3698,7 @@ static void dsa_user_switchdev_event_work(struct work_struct *work)
 	}
 
 out:
+	netdev_put(switchdev_work->orig_dev, &switchdev_work->orig_dev_tracker);
 	kfree(switchdev_work);
 }
 
@@ -3775,6 +3777,10 @@ static int dsa_user_fdb_event(struct net_device *dev,
 	switchdev_work->event = event;
 	switchdev_work->dev = dev;
 	switchdev_work->orig_dev = orig_dev;
+	/* The work reports to orig_dev, which can be a foreign bridge port
+	 * that is unregistered before the work runs
+	 */
+	netdev_hold(orig_dev, &switchdev_work->orig_dev_tracker, GFP_ATOMIC);
 
 	ether_addr_copy(switchdev_work->addr, fdb_info->addr);
 	switchdev_work->vid = fdb_info->vid;
-- 
2.53.0

