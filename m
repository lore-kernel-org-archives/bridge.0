Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793283243;
	b=fTUOjblScnlz0kBgZ39Px7PxXdc7f0Ho4Aox6FWkPgazwVkBcKqGmNBT+C9I4nJxFvZk
	 DrxHeh4JBN1MLhxmkhWVqGoQEe1Is53KWLQOhGJsqhIbI+xIqoscDo8poBN2piJVUQhZJ
	 /TEc7s4bECUSUxDLjVxsTCAIc6MUOkH4VxhKKyLdZdt5hIqNRCGv10k7ol94nnmdmGiy7
	 dt/wM8f9vsXKL1Q5AlbndQb0FxeTVaLjeAfSp9zC/zxUeWuyr3xkISrAsm+GdiyZ2/khu
	 8ClDZGxcV7a3uCQ8WHkfYzGUB2ZvHR7KcLf3OcfZBFwBpeRUPRYOvOr8/t7iVkrknIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793283243;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=JbSTxllG6qq/Srrtm566fJNVCNWR5pySfmfZ5YTXfSE=;
	b=be+/DaQIz5bsyXznXZ2DsqglW3KgywajA0Nn2znBswd3Nzz3nVlpZjg6rWTmwH3JoaEF
	 GDde3K1jXMm6uSdRs0C518dAPX/M/v26aAFypW0Y77II9MckTrPA2Q2oWgVRfShAg9AEe
	 lxQ3jRCS/skSJJnAz1f8dSWXUypT7s+ao2Nn8WthNMOb7v7tbXjCJ+YWlRRyNZe1AVJ26
	 1JU0X1Jiy1Wf0slQZIr+dDAD3dzVNoJdqji49MkYXaCl5cQ1TxGP6+xgQ23fjfYbzvzGo
	 1qQg5t9fHwMdRnDOb8Sm4p7M0OLzLmnX7zvtdTEVIsobFfpiJ63SIxsPl0E1V8aMQMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="ukiNCD3/";
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60C4606A32A
	for <bridge@lists.linux.dev>; Thu, 29 Oct 2026 14:14:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E60C4606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ukiNCD3/
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-35829219da8so989025eec.0
        for <bridge@lists.linux.dev>; Thu, 29 Oct 2026 07:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793283242; x=1793888042; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JbSTxllG6qq/Srrtm566fJNVCNWR5pySfmfZ5YTXfSE=;
        b=ukiNCD3/3d+kAVodnZ7MFjnuI9I1Wv+sOW4OkCQ8wDld4c6eCZzc0CvgNc+K9/IukW
         8dHEvO7CB69Rfkb+w8gb3p1K2OYFqYy1ztW2uJkVTWKRM3g4PEIDGGRdsUWdHnV5K9Uo
         rWD3a9J5sb941UOK2fNFvQFooT4SAFsmOcvlBslC1ckXj+3PYUTK1ORs51f0Z5iqWWy7
         tPsgsq+iFHdPgrXFY0UtyTztrIa2ZV9gezkydtFbCUoGKteYfctztmG4SJycy1pKdZdb
         FtF/Ditfj31XC7mjlFm8V0H36le73I/E8V5aS7qdosUgyRSgF1r6sIShA6SvRkM3pn4O
         vxvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793283242; x=1793888042;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JbSTxllG6qq/Srrtm566fJNVCNWR5pySfmfZ5YTXfSE=;
        b=mWfDqHAcvHZ84G3mJe3oZf1nagUX0CRjTbL9X3lNbws7/M0IRHIgPr83YCwld3ryHM
         KflFcd+SmHYmSM84C8l0ysncxI2DoIrb1B2T18IQYANBgFV5ZNrju920QbWgnawJ36ba
         c8i1IQ3g4x9Od8jfI7IyGog9GyPZM+hEHULy7dcpaHk97q+GgCUx5oXkOMWYf7HKrQd6
         784tDuPObmS1oxcPlon3cRsbEei+9qHFTloaSU5MgINKQeWtqazOlQEWjmgXN/CzsZsx
         gjXS2h/jTvGLUS8CCyHrGpAyM9SrypbD0LNSs0dShzIL+UVvXNUjOvfE14sOhtcyhRCu
         TWZQ==
X-Forwarded-Encrypted: i=1; AKwUvBzyea/07lWouHZe76YXp1ze64guE7WikB/cTGnnQJPK6A+Xy4deGc6s8qhz8f+NJjJv3+TyL4M=@lists.linux.dev
X-Gm-Message-State: AFq9FYKt+Fvr6GjlVesR0BQOirUoJIc7EPvlXECc9WxjgPzEfiU4JOos
	9luesHDEQRsdKm+rHa9uucb2EhGHa/IFNH+6E8dgzhdfJT07sSbHHe33
X-Gm-Gg: AYBFou2uJrrQjaHBRgU75Z9AZuDnxsUqmmIpp7KfmfFgu8CNPjPs2ca08lijJxYglCT
	TFZdZn8Rlnm/9yRXpK/5dHkC15+koZzX2n7tLJPr5KGQSTOGnZerweZhQoy2EiP2mfKmh5cinN4
	IHDwjWJRUFyMJwn6HpkVPPKIr8Gg7/LpgAp6BZvKhuroC+VRH5OPgdKwx3n9k6suu8ZMkBg4qL5
	QBBdrgFcqHEj2yNjWnSQAwOWLGCAEis4/XOFUM5jVMc65qM6hcnn3MdtinLhoE5Wsq4hV1yEv8W
	M+OD8FvIP8h9rZBfa+C24sOQGnJ0+gTZaAJko23PYAR4ZSeX6UHa9ZJw8meF/4x8A1LY7cvUA5g
	RU2xnKouyNr45C/aGYgmDeL4AHoiOr98aapPVVP8Z6RZHjAnWdWrenL5KAkuqSGzDD0DcZpU6Hu
	wpuQD9xlUSDffjnex4YNz8XTX6N6BCrok/apqsKTRyGoUWhMpwA7n8YAu00A7YVP0FGnUsuuzxl
	mbVjmo+5NVdaQcA6/d+83SEj6PdrOjo5AELlFhhHIaiH2Orgj2Z3noe7doF/TBwCPF6DModM18r
	u+hB7i56VaabRP4XY7+6NgtjAZr4Vz0GQkmQDyBw71mYc3i8TyGQWg==
X-Received: by 2002:a05:7022:5e09:b0:152:dd1b:4fa7 with SMTP id a92af1059eb24-1a944ee37e9mr3337955c88.19.1793283241701;
        Thu, 29 Oct 2026 07:14:01 -0700 (PDT)
Received: from [127.0.1.1] (67.216.200.102.16clouds.com. [67.216.200.102])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1a75d76814bsm15197319c88.10.2026.10.29.07.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 07:14:00 -0700 (PDT)
From: Cheng Yongkang <teel4res@gmail.com>
To:
 Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 bridge@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net] net: bridge: mcast: release the EHT host budget for
 zero-address hosts
Date: Thu, 29 Oct 2026 07:12:20 -0700
Message-ID: <179328314076.648427.17991367257682028617@gmail.com>
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Post: <mailto:bridge@lists.linux.dev>
List-Help: <mailto:bridge+help@lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
List-Owner: <mailto:bridge+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

__eht_del_set_entry() decrements eht_host->num_entries only when the set
entry's host address is non-zero.  A report sent from the unspecified
source address 0.0.0.0 (or in6addr_any for MLDv2) creates an EHT host
with h_addr == 0, while the set entries created for its sources have
non-zero source addresses and are counted against PG_SRC_ENT_LIMIT.
Deleting those sources never releases the host's budget; after 32 counted
sources the host stays at num_entries == 32 and every later counted set
entry is refused.  The same sequence with a non-zero report source
releases the budget normally:

  host 0.0.0.0:  IS_EXC/ALLOW1/BLOCK/ALLOW2 = 32/0/32/32
  host 10.9.9.9: IS_EXC/ALLOW1/BLOCK/ALLOW2 = 32/0/32/0

Only set entries created for a non-zero source address are counted:
br_multicast_create_eht_set_entry() rejects a zero source when
allow_zero_src is false, and __eht_lookup_create_set_entry() increments
num_entries only for those entries.  The auto-created wildcard entry for
a zero host uses allow_zero_src == true and is not counted.  Release the
budget based on eht_set->src_addr instead of h_addr, so counted entries
decrement for zero-address hosts as well.  The uncounted wildcard entry
no longer decrements the counter, which also removes the converse
mismatch for non-zero hosts.

Fixes: baa74d39ca39 ("net: bridge: multicast: add EHT source set handling functions")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Cheng Yongkang <teel4res@gmail.com>
---
 net/bridge/br_multicast_eht.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_multicast_eht.c b/net/bridge/br_multicast_eht.c
index 18eaf9c..548ad78 100644
--- a/net/bridge/br_multicast_eht.c
+++ b/net/bridge/br_multicast_eht.c
@@ -167,7 +167,14 @@ static void __eht_del_set_entry(struct net_bridge_group_eht_set_entry *set_h)
 	RB_CLEAR_NODE(&set_h->rb_node);
 	hlist_del_init(&set_h->host_list);
 	memset(&zero_addr, 0, sizeof(zero_addr));
-	if (memcmp(&set_h->h_addr, &zero_addr, sizeof(zero_addr)))
+	/* Only set entries created for a non-zero source address are counted
+	 * towards the host's budget, the auto-created zero source entry is
+	 * not (see __eht_lookup_create_set_entry()).  Check the set's source
+	 * address and not the host address: the host address can be zero as
+	 * well (IGMPv3/MLDv2 allow an unspecified report source address), but
+	 * its real source entries are still counted.
+	 */
+	if (memcmp(&set_h->eht_set->src_addr, &zero_addr, sizeof(zero_addr)))
 		eht_host->num_entries--;
 	hlist_add_head(&set_h->mcast_gc.gc_node, &set_h->br->mcast_gc_list);
 	queue_work(system_long_wq, &set_h->br->mcast_gc_work);
-- 
2.34.1

