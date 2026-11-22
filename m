Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795375280;
	b=j6e0O9DkTsRIMZveaIw5JxNqLUtn6TL2RggIL00Dz1/M2YGr90W1AdA43bU8o77vaLpj
	 k9HGOfJYBYgemUe4zvQr6fF3ROMUTWHIag3ndcKpCZNJ6kiS71bzTnWpuWNv/3VuNR6iX
	 iqgRStCSygyuVS7lAAyJhcZ0meoVtNmO/CRF25KPk9d0qYsMpUbHPrmL5VnoT1LvePb6N
	 vwubORySkxPiywlk3k2LcI+w1kPU353P4JKPnHNlSHrZrLcfIioGyM699zmcAY1iBfnB2
	 UwvLS/eYKBSnIfeTMotmEejpFfFjsWVTNI5W8IxXf+IlwapYN0yO6s9dE6tgnqJGMYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795375280;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=w10pGPahh84PPcSjgYpFSJZpEhTwZ5QElxtP1NCGCv4=;
	b=lPSAVfslJeCXJUsusTJexVB5ykITr3FVk5m1B14Rz3zgSJvWqRsqIF9qoML9qOAslm4t
	 ESW2s5U02WQkaROgDFLXqBNJSjr0TC0dr2hsgu/zOXQHe2+XFxE22ZC4Lud0aysVVJwUp
	 1cxdau5BsVppaFgxUPIrjrvkftJCcDxld0Mp7Nrjg8uHpe6uO2Fwr7WU+ow+VUCjKTGhZ
	 xayroYA6x4Gmk+CWqlJWL1HrZfU0Rumpaj5j2VTVu5SegzUXcmXNwbu1cYIXbP4/SsFuX
	 y+b7eRK87Ky5iAaN32rC9UxKbe9EKsjyCzbeCYChHo0y4n/eN3EC5w17jjVnqolRPyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bairaktaris.de;
	spf=pass smtp.mailfrom=bairaktaris.de;
	dkim=pass header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=aaIYfVuM;
	arc=none smtp.remote-ip=209.85.218.46
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84121606A327
	for <bridge@lists.linux.dev>; Sun, 22 Nov 2026 19:21:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84121606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=aaIYfVuM
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c50933bdf4bso583321666b.1
        for <bridge@lists.linux.dev>; Sun, 22 Nov 2026 11:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1795375279; x=1795980079; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w10pGPahh84PPcSjgYpFSJZpEhTwZ5QElxtP1NCGCv4=;
        b=aaIYfVuMhGZeT3xS8YRT4lvQX/cFSC2GqcUy3aDD9MJidKNf6vrWTWqLLT5dzyOPEF
         7ijA5Astzy8RA/rGvnxRdVqwxlnN9cBFblDq1WJArWpBhQONmiEx5aIz8iAhZ5oiyYwF
         KzgTqdAiUI6LA7Uw7ugwwaHk/vKKBT6HkH5omB3DPYqYV+olFZGv6U8zlgqNTvnoqugY
         ER6ZOeFAY6bB9liK+QOEN0nV/MorFMRGLO2oCOksjvGBBR7hC2DzGKUfVlmHlQA1BI3K
         se5zAkDzUqkY9ikzLyfn1B5G4c4QwYQEXfI3V7MF2zRm5Jz5FT+dR9215DOzU+oxcF0t
         sG0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795375279; x=1795980079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=w10pGPahh84PPcSjgYpFSJZpEhTwZ5QElxtP1NCGCv4=;
        b=tosYWphLuDlNVrdsgqghJ96Y2K3VMUOt0OQ/I4W3Y7OSxXtAwLqTzgQEllsFhEoKqp
         pFpeSbqPBDVXAjLemprsa+7uxZsQ76go5W/G2PSSreA3UipHaQ2b6P7qWlkVfdrwE1Z9
         Qh+91tOU447Gj64Z3Vb5v1gQwIPRVzXCMJNIWNwM2ysNXRSUQBQkq1v+TqnHuY66aS4u
         NzhefFI5UcqpZNE01mGNZAmBIhCKee6/4r5ccZC5nWAXtK7w1Nl9R/GJwDdxIH72KrsL
         vq9mNPbHEXaB4dobO3reGsbMv10bZgrZluFQJIcfk1uTwKCYVKGnNB4dimxjNvK7l2mw
         LhMw==
X-Forwarded-Encrypted: i=1; AL+hErFH1wLEG5z1hNMIhOF5m0sIRXoPfoS37a1k6PQDR+JDq5qL+mnZhnEK0MlNOBDJG0Wc8f8Wfcs=@lists.linux.dev
X-Gm-Message-State: APuU4Z9PU9EWyfbHZTuvyolj+Ri46ieYuZci/2cafUoMDFAcU9emRLBG
	am6dqS52EcpsZzNDVlL3uCRrEvXsbaf+RC6P4S9K+oLvyyqcCwgwpi3Y5B2sHbRCwQ==
X-Gm-Gg: AZFdTZcQM5jXaZl5NtOTYhPB5kALadZqFC2mRfpJDK1xWPOV0ph2evYlXfpqpP69MKj
	NahLbOhfA9Hdg3m6V6NT4twECqao2/ObtHhk33k/jerzFAlJwrh+eA65ghkuX6wSTroz91ceCFu
	Zc4sWC2jFq25wgy6qrVolfVtNRHv2Vze4P+XK4JOKWvL5jE6APsWKuzmlFU6rTIrFhsCopthXeU
	zm6a2KIOiBTbzGs17d9lA9YHwwMvxpG6/GOlzWf8OMUrlP2RgIcc7Ss+lqT3TDDxHXWZErNnIuq
	VRsEbEf71gEX8baGG3J9tHb2gZVNB9Lz0y127J1BpseBhzoj74xHOXxKiIlKL2kz7vYxFAnAN1A
	Uo/Lwnf6Wv80eJ7jd/z+muD3lRUZS0Qd9xB7SLaq5XGk4/WWoT1UpwWWmicSaJnrjXseBSnDdQ2
	2fws4kNFQNenTdJkDXKhvswZhIWd/4j0rW+noUkfpdiDRtCSwsURy9z00IlEFgnsAjVEjDbnQqo
	IKO8SuRjt52GCYzAAz6okXWd0ZnS3CwOuClUbzxP0NB3UYTSMNLRSMF5zGlZki/RrfHDjMmCzeO
	b9Or6mo3g9YsSKUMFu5PYBAj9AmUmFUme+yXec5jsl8WwF+nqXw6FCZIYTlAznme8J6MKKYHFz6
	AhGUad3wxItBVyW8DClXjrd7gbyHbEWkQLKuqxVVSYTcj58kS1X2rO2YU6P9uVYZrkT0LG0fkvV
	MDVruLb/EXoaRVwvX++gLVlp0LLUt5kkBO8YAgXEatK+woIYjFhNJee+QBdqN5NIXxTT/miVQqN
	4/1TSqdU9Gz/I35MyZd16lQ+lEd0aQIi4gkPw5Uxl1ttl6/vNHyYP53aA0j9pldXuIYv8TgHs52
	AVloGHmJHAa9Y4kKOWl+xpltGZmatQOfq/iIGNyl7D42EYBmGCyvUAA=
X-Received: by 2002:a17:906:730a:b0:c2e:1b6b:8b19 with SMTP id a640c23a62f3a-c51319443e5mr956292466b.23.1795375278882;
        Sun, 22 Nov 2026 11:21:18 -0800 (PST)
Received: from Desktop.tail070c67.ts.net (p200300f24713a7000000000000000a27.dip0.t-ipconnect.de. [2003:f2:4713:a700::a27])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afeca8dsm338808566b.75.2026.11.22.11.21.17
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
Subject: [PATCH net-next v2 2/2] net: bridge: clear the offloaded flag of an fdb entry that roams
Date: Sun, 22 Nov 2026 20:21:18 +0100
Message-ID: <20261122192118.1204290-3-julius@bairaktaris.de>
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

When __fdb_update() moves an entry to another port, it tells switchdev
to delete the entry from the old port and keeps BR_FDB_OFFLOADED. The
entry is then reported for the new port, where a learned entry is often
not offloaded: DSA does not install an address learned on one of its own
user ports, a port without switchdev has no driver, and drivers that
program only entries added by the user ignore it. Most drivers that
report the flag report only additions, so the entry is still shown as
offloaded, and matched as such by "bridge fdb flush ... offloaded",
while nothing holds it.

Clear the flag with the deletion, as fdb_add_entry() and the NTF_USE
branch of __fdb_update() do when they withdraw an entry that the bridge
keeps. The deletion that is reported still carries the old flag, and a
driver that offloads the entry on the new port reports it after the
clear, since the entry is only reported for that port at the end of
__fdb_update(). clear_bit() is atomic and no lock is taken. A roam that
races a driver reporting the address as learned on another port can
still leave the flag wrong, as the learning path does not order the two
against each other.

Found by an LLM review of __fdb_update() while patch 1 was
reworked after the review of its v1.

In QEMU with KASAN, with dsa_loop given FDB operations and assisted
learning on the CPU port, and a tc mirred redirect that delivers frames
to a dsa_loop user port (test-only setup), an address learned on a veth
port of the bridge is a host address on the CPU port and is offloaded.
When the address is then learned on the user port, DSA deletes it from
the CPU port and does not install it on the user port. Without this
change the entry is still shown as offloaded, in 3 of 3 boots; with it,
it is not, in 3 of 3 boots.

Signed-off-by: Julius Bairaktaris <julius@bairaktaris.de>
---
v2: new patch.

 net/bridge/br_fdb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index 4af091c19244..8bb40645bd6b 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -1031,6 +1031,7 @@ static void __fdb_update(struct net_bridge *br,
 		      !test_bit(BR_FDB_STICKY, &fdb->flags)))) {
 		if (source != old_port) {
 			br_switchdev_fdb_notify(br, fdb, RTM_DELNEIGH);
+			clear_bit(BR_FDB_OFFLOADED, &fdb->flags);
 			br_fdb_dst_write(fdb, dst);
 			fdb_modified = true;
 			roamed = true;
-- 
2.53.0

