Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795375279;
	b=xZb+yr5bAfpTKBin/G/qs0bRMmv+9fyNJbB4zThOISkVzPsDW6cggeavg/tKE4k4OXBE
	 HLKkvC/lneEg7dcgAtjplecXdnwBkKB+cQB1gF/Mo711j9zrrQgwCZp5DotUVhvqCVADy
	 /SyfMIQSIHVAPL9NfQA9eHdgv9hF5zbTQhtEoYC7qN1eF855SufDiP/vX1xJ7ZMWqIbzH
	 Ku1b7r3YP/ZHfA1+HHXz8/xU1WvSJk40KAyH+f+wPVIc31w0SZEAme9OEPcA2qPj8z+ew
	 T4448SZ/AVYMqE3nvkLj1hpCHDbXnE9NP01ZuTIor3yXvfqo3Fnca2xOIhkdBcPm0Yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795375279;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=YvX22Go66K8PzO602+a4bbxhWUwaAgDMlVTyOM3+06w=;
	b=pVpJDFJUpUlFjPj9RLxdeHasYczXrJOcKrioA+9yU/WJGhlU0cdhZf87GYxfaTGkNk2n
	 V/oht0lwV02khcFldEbI+Gk4dhA8NHEgJlj+EPHRtTDI2WI1TZwyRPh+jQpOoRh7qUwn0
	 DIkFbaritFp2g2JDAXnbLbyN+01F169xJjjzTT7O2oGJhH9nwVP3Wj4c4qJm61m8vpyQ/
	 dy3lJH8oTpUA+hHpirsSqxKPc770ZU95ekrMBk3Ldf+I1IkFjl+gBXYvpLcLxOs5abg1T
	 0LA9PriPwJ9IVZ/M91R39RyEXSYMCx8X7Ww4/GBEJ6rLRwMWLDqG+lvPFURtNRiN4hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bairaktaris.de;
	spf=pass smtp.mailfrom=bairaktaris.de;
	dkim=pass header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b="b/6nncNS";
	arc=none smtp.remote-ip=209.85.218.43
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEE6606A33A
	for <bridge@lists.linux.dev>; Sun, 22 Nov 2026 19:21:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1AEE6606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=b/6nncNS
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c5126505cb3so331311166b.0
        for <bridge@lists.linux.dev>; Sun, 22 Nov 2026 11:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1795375277; x=1795980077; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YvX22Go66K8PzO602+a4bbxhWUwaAgDMlVTyOM3+06w=;
        b=b/6nncNSC0HpFm9cW+GKIY3VZvnH6hJuNLphCeoh3H8Hsjkl+gs2JUpZ+d7F9p+FVN
         aJnWQuOeGe9+3L/f7aZI+yGj26IaH6G66PhR8xP6xAuO+YLqCaotZMWw3ueuNJI0QnXG
         tu92ko2zqFYGmDyetsjz8uFcjmeYosOA/Xjg7te303TJgzBEktAl4AX/tMZw6PXZYse1
         va6fOihxMoQGShTmiwMF+LyNOqiZsY8Ab1EmgC3XGaEKkShMaKhf2nW2Q2xF3lg9TKD6
         RdATQxXal9P0O0aQYNasZ8hCmL4sgFrYnKNPpKzV0bcgHJekoZqqqh2JjP3nvyygLvcw
         IlHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795375277; x=1795980077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YvX22Go66K8PzO602+a4bbxhWUwaAgDMlVTyOM3+06w=;
        b=0KZkklaqyALRV31ATaiO1dyjKgcJnkpAIGJqGQIY/cBs+xr8wjOIIRCcBRLO0jj5jv
         +QlSnvZlzvWn8s83Eeooxw//22ARLcbHngugsO+cxfEBFELOVWr7/nSEXOwKGGQSCfjc
         qmdQUCXcMES+n/IYbaaWkp8sdpDFjtZPZsSpJzmbXMAptL++7MqJrvmO5IEdvQONqXcU
         I169M7uUTUZvHm/0ZInase+3QOAO5z3ShJk1oXcA3adF8ec0l7WLAmB00FilQ8rx2Rjm
         X4j0p92SF943pYSO7kKAsqX7n4k/cQVKYIzRIWVm5YOqmkKVgnAWB3DbPFb0Hu5DoUV5
         CY8w==
X-Forwarded-Encrypted: i=1; AL+hErFIzv7V9mdgSC4SCw9kXvuJSbb3RrwiyyvrRnxlaznlqADqfyuzdLPuYnKkSMS3zV6Gv4+7iuw=@lists.linux.dev
X-Gm-Message-State: APuU4Z+vkE3eEENo08tqU8Q381UMmGGSWrjGSfa6DjWJ/MpgvsDjfSH3
	TMdYPT3F7BMldii4OrubGyt+6JiXS5SjGJ/szEy7K11ZxxJGElKGq6RbHHHPf6zfMA==
X-Gm-Gg: AZFdTZczEXsUk+sQD7khyNng6TiuMXDt8s8eM5SWmI8fkgPSPKbROD5WRxkpFPMcym3
	LEMSCqE9ykvK7lMglQLVEpso4GE/sW557e7zTPWxNu1DKuXn1quGLZyV/cnPVhw4aBY+5MaLDNp
	VnRb9mWXsfArXX8gv1GnSa8GhHpWHG2f78ua/hbU46yftDET281/kOcgKPxvfxjDpuIJ5uMyJVP
	o1y11EmtDqyHcbagiAKxWbEhb4FvPfLGYY2zPago2UfC5OPqrF8is83geX40UtkQ0hdgZ5rmtSP
	0zxKCqxvSYGyKEmjcVQoN1y3aHddKZDgxJpXIL2QDzToXGVDby3HZZS6qtJ2oHTe5mWTXWMh5kD
	ocYMDoX/2Wfx0//kl21RWfqOlCX7RSGdn59LSGQFRHbn+8JpNzFN5ESmUQQSP6yKAAoX4XTiy7j
	X57AkmGHKBHOF6ahZGmt3DZFph75za0hlAMOKzf/mRqw/adI5AHi8nyp05vTnuTpZXa1uUZmewY
	P08OxAzkn4ICMxrXlCaVaFz/SOEflPQ29shx9D3dN6D/tP/3P29MY2WN9Rhf/5qhUTf5hUFJlt5
	MZRkcZIR6FcCl5JoYsFAJzKErXsN855FUI1FXukz4EsQV6ASL52DxrSdOwUbM8caCLy/xR7Yr71
	a8GabIJXETRRuU+w2Om8n+0hmLXYTRb1ysKiJtLI0bg7Ehf1a/ndJRwwSzo+Db74QbzYlsloJBZ
	EBTVLqUjLTP9toEU3tQO/3xeK9h7xpafNEBOWR2+XOlBW4JRSh78GKCiHt+b1HHENOTemZwA+H3
	k8eZnIN9w8LE97czgjpyrsWVKbul4uz9naFX6E3pn9t9t4TuFhRz+i2yxA6TjN2WJFQ46EJTZZT
	Po64E3uUfeO7ozJchGOswlc62IVEoPrVG8F3Cp3NFsoc06ZKE419efk=
X-Received: by 2002:a17:907:a88e:b0:c42:5363:38dc with SMTP id a640c23a62f3a-c513ab0e03fmr802808666b.25.1795375277441;
        Sun, 22 Nov 2026 11:21:17 -0800 (PST)
Received: from Desktop.tail070c67.ts.net (p200300f24713a7000000000000000a27.dip0.t-ipconnect.de. [2003:f2:4713:a700::a27])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afeca8dsm338808566b.75.2026.11.22.11.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 11:21:17 -0800 (PST)
From: Julius Bairaktaris <julius@bairaktaris.de>
To: Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org,
	bridge@lists.linux.dev,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Vladimir Oltean <olteanv@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Jesse Brandeburg <jbrandeb@kernel.org>
Subject: [PATCH net-next v2 1/2] net: bridge: withdraw the switchdev entry of an fdb entry made dynamic
Date: Sun, 22 Nov 2026 20:21:17 +0100
Message-ID: <20261122192118.1204290-2-julius@bairaktaris.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261122192118.1204290-1-julius@bairaktaris.de>
References: <20261122192118.1204290-1-julius@bairaktaris.de>
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

Since commit 927cdea5d209 ("net: bridge: switchdev: don't notify FDB
entries with "master dynamic""), br_switchdev_fdb_notify() reports
neither the addition nor the deletion of an entry that the user added
without NUD_PERMANENT or NUD_NOARP. The user can turn an entry that
switchdev was told about, a learned one or a static one, into such an
entry: fdb_add_entry() does it for "bridge fdb replace ... master
dynamic", and __fdb_update() for "bridge fdb replace ... master use"
(NTF_USE), which marks a learned entry as added by the user. The
drivers then keep the entry they were given, and since its later
deletion is not reported either, they keep it after the bridge has
dropped it.

Report the deletion of the old entry to switchdev before either path
makes it one that is no longer reported, as br_fdb_update() does before
an entry moves to another port; br_switchdev_fdb_notify() tests the old
flags, so only an entry that was reported is withdrawn. Entries with
the extern_learn flag stay reported and are left alone. The NTF_USE
branch is only reached from netlink: the packet path passes no
BR_FDB_ADDED_BY_USER to br_fdb_update().

Clear the offloaded flag of the entry with the withdrawal. Drivers set
it once they have programmed an entry and do not clear it when they
delete one, so the entry, which stays in the bridge, would otherwise
still be shown as offloaded, and matched as such by "bridge fdb flush",
after the hardware dropped it. br_fdb_offloaded_set() now assigns the
flag instead of testing and toggling it, so a driver report that runs
beside the clear in the NTF_USE path, which does not hold hash_lock,
cannot invert it.

Found by an LLM review of the series "net: dsa: fix host fdb
refcount when an entry roams".

In QEMU with KASAN and dsa_loop given FDB operations and
assisted learning, a static entry on a dsa_loop port and an address
learned on a veth port of the bridge, which is a host address on the
CPU port, are offloaded. Without this change, "bridge fdb replace
<addr> dev lan1 master dynamic" on the first, and "... dev vA master
dynamic" or "... dev vA master use" on the second, delete nothing from
the switch and the entries are still shown as offloaded, in 3 of 3
boots for each command. With it, each command deletes the address from
the switch and the entry is no longer shown as offloaded, in 3 of 3
boots for each.

Signed-off-by: Julius Bairaktaris <julius@bairaktaris.de>
---
v2:
- net-next instead of net, so without the Fixes: tag; the commit that
  introduced the filter is named in the first paragraph (Nikolay).
- Clear the offloaded flag with the withdrawal: a "master static" entry
  the driver had offloaded kept it after "replace ... master dynamic"
  deleted the entry from the hardware (Nikolay). br_fdb_offloaded_set()
  assigns the flag instead of toggling it, so the clear cannot be
  inverted by a concurrent report.
- Call br_switchdev_fdb_notify() directly, no helper (Nikolay).
- Drop the comments in __fdb_update() (Nikolay).

v1: https://lore.kernel.org/netdev/20261121191638.1724620-1-julius@bairaktaris.de/

 net/bridge/br_fdb.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index b601245ad923..4af091c19244 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -1005,6 +1005,7 @@ static void __fdb_update(struct net_bridge *br,
 	struct net_bridge_port *old_port;
 	struct net_bridge_dst old_dst;
 	bool fdb_modified = false;
+	bool roamed = false;
 	unsigned long now;
 
 	/* attempt to update an entry for a local interface */
@@ -1032,6 +1033,7 @@ static void __fdb_update(struct net_bridge *br,
 			br_switchdev_fdb_notify(br, fdb, RTM_DELNEIGH);
 			br_fdb_dst_write(fdb, dst);
 			fdb_modified = true;
+			roamed = true;
 			/* take over HW learned entry */
 			if (unlikely(test_bit(BR_FDB_ADDED_BY_EXT_LEARN,
 					      &fdb->flags)))
@@ -1049,6 +1051,12 @@ static void __fdb_update(struct net_bridge *br,
 	}
 
 	if (unlikely(test_bit(BR_FDB_ADDED_BY_USER, &flags))) {
+		if (!test_bit(BR_FDB_STATIC, &fdb->flags) &&
+		    !test_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags)) {
+			if (!roamed)
+				br_switchdev_fdb_notify(br, fdb, RTM_DELNEIGH);
+			clear_bit(BR_FDB_OFFLOADED, &fdb->flags);
+		}
 		set_bit(BR_FDB_ADDED_BY_USER, &fdb->flags);
 		if (test_and_clear_bit(BR_FDB_DYNAMIC_LEARNED, &fdb->flags))
 			atomic_dec(&br->fdb_n_learned);
@@ -1262,6 +1270,12 @@ static int fdb_add_entry(struct net_bridge *br, struct net_bridge_dst dst,
 		if (flags & NLM_F_EXCL)
 			return -EEXIST;
 
+		if (!(state & (NUD_PERMANENT | NUD_NOARP)) &&
+		    !test_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags)) {
+			br_switchdev_fdb_notify(br, fdb, RTM_DELNEIGH);
+			clear_bit(BR_FDB_OFFLOADED, &fdb->flags);
+		}
+
 		old_dst = br_fdb_dst_read(fdb);
 		modified = fdb_update_dst(fdb, old_dst, dst);
 
@@ -1706,8 +1720,8 @@ void br_fdb_offloaded_set(struct net_bridge *br, struct net_bridge_port *p,
 	spin_lock_bh(&br->hash_lock);
 
 	fdb = br_fdb_find(br, addr, vid);
-	if (fdb && offloaded != test_bit(BR_FDB_OFFLOADED, &fdb->flags))
-		change_bit(BR_FDB_OFFLOADED, &fdb->flags);
+	if (fdb)
+		assign_bit(BR_FDB_OFFLOADED, &fdb->flags, offloaded);
 
 	spin_unlock_bh(&br->hash_lock);
 }
-- 
2.53.0

