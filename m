Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792611326;
	b=NxyGDlymSx8MjCJG+MgHzaagw1tLYVKSVk6C4VTLMK4XNSxPCtw9e2EUVxaNnQKzYEDH
	 cuJanj3KQOwAeXReOEhE9u9JhrFI2V2VFytc9ObCVXBZe7u/o1917Ofo7pkPQ9Rwgt/De
	 Johpnn4AFJdx2TpvlugsGD9f4s0PycpcfJr88e6/ZG6hPuuFv/F/EjkHBI4kXFcCN5fkR
	 rmYixoNfNDmdR/Kyx5tinvVdPz9Fk8LpDLQQ7czhzI1Zb96pihnXG7bf5u2Dc0GywlfgD
	 /Fa8MJFB2SsDlS/i4020mgd6ZCYK16lhU2whGNDOgZaK7Mertl/y5Tg91TY1DzJLDMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792611326;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=vIq4J9MzmzYl9oQxr9an2njN9RrUmQCNsR3GT631TE0=;
	b=uLMEMp2c2iyN2rM9ZY35JrOK19WOdtr2KMmpSY2Qlz0ZIF73yUVpo/6a+5SaIscVqGSO
	 x7il0pnYGmqCxZe04c/v8YVwV2e4nq2+mzwFKsj/9Y3LwKNpbqTGZSPni24eFd3Fqs5Up
	 xhWJHB0QeLTj6owwHSQf9qSYD+cd/HUIy3CvttUamFaRfcGJE273zsxs9YJVHELv5u1Tc
	 uBkPcppV767LAV83i+IMAUkE1u+JA6G4hSH+jKm83HPilj7kwH2sE5DsSBR8uxfCs3VI+
	 NEDDh7t6WuFXRK5tcwokLLysaDuTeWSQslf1Uc1Vp76dPKWDWt8M/dk9cbT/LvocMRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--aojea.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=tUJCA+xO;
	arc=none smtp.remote-ip=209.85.218.69
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0756606A326
	for <bridge@lists.linux.dev>; Wed, 21 Oct 2026 19:35:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0756606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aojea.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=tUJCA+xO
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c4048584447so95522866b.1
        for <bridge@lists.linux.dev>; Wed, 21 Oct 2026 12:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792611324; x=1793216124; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vIq4J9MzmzYl9oQxr9an2njN9RrUmQCNsR3GT631TE0=;
        b=tUJCA+xOKv0KW3phvzrZSi5cvkIWpGicVYqFhrfW+19hOKiuhpRaPidxx9ti5b2nWv
         aFgFAA8t/3svGwGO40nosHGWHuFS+J6mNngT0q8JDwePVALmw2tEOEDdXZmG0lLPAtxb
         77QkEkUUykoeD+OVu/RlpTHNBODLr8aX6E2e8bLBHGMxw00KE3+JcrLGcOfHLbMJ0cXM
         ZR9hR6fMHn9PyzjZiJ4RDUCsX0f8i3utjjHLVgli0aI/4Kaan4qrT9idWr9QbPUz29mb
         k2jTodPC5c3+7q9Dyn5ceZqCLHKbBIlaYo4HCC0Qqx0aguhzJOelXU3GL8RNludTai3y
         Sl/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792611324; x=1793216124;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vIq4J9MzmzYl9oQxr9an2njN9RrUmQCNsR3GT631TE0=;
        b=CEtbK2NLJGdiQHHk0czgnZMRGBClvuEkgimv5IMU1YO2UFV4TIRptnCeZN5+siIGXL
         MdaMGTodCofhIjdNy2AcuPrZdxLSQV+Q5CTh9NIqrzbt5AmlbDXubhiXjGX9qjrIH4nr
         2npagWIOseD6/gVqovULVpgBI3chnYA7/G0bQIxvqwj5pJ+qy3s4OmDnlTX6Qt9a6QSG
         FhCMntL+0Herxr6qWSpQj7jn3FfV9Sl2+Ij4iNmwdh3eidCCC+Gz+n5ZuSi2Gf1d0pQT
         gwZriwCFnsBidIM2MXBQjcTjR97V10IQp0DN9gKDJ+15mVqPnH0hz2UUtt0u0FQKfrR8
         vfaQ==
X-Forwarded-Encrypted: i=1; AKwUvBwiaZkKTcJbK48CfgaPvGCM7J3K5FYO4WEFoKx3pkGFSJOb5ZA1ij0x5dzvHgx0hvU2gsM3GlQ=@lists.linux.dev
X-Gm-Message-State: AFq9FYLUNWJ5ml3Ml8VgxpufFtP+/v5J/7DVUVFCqDEq1jleTx0YHb4j
	LCij2tZZGgh085eLQq00yIi2mzWmpSJENrnCT9tlB8kT65qGMZMMkXdYEMeenqBD+7yisoJa5uH
	V3A==
X-Received: from ejdq8.prod.google.com ([2002:a17:906:3888:b0:c3f:6152:2d8])
 (user=aojea job=prod-delivery.src-stubby-dispatcher) by 2002:a17:906:9f85:b0:c40:bbd2:62f3
 with SMTP id a640c23a62f3a-c4679b9d976mr267535966b.49.1792611323850; Wed, 21
 Oct 2026 12:35:23 -0700 (PDT)
Date: Wed, 21 Oct 2026 19:35:12 +0000
In-Reply-To: <20261021193512.2302587-1-aojea@google.com>
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Post: <mailto:bridge@lists.linux.dev>
List-Help: <mailto:bridge+help@lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
List-Owner: <mailto:bridge+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261021193512.2302587-1-aojea@google.com>
X-Mailer: git-send-email 2.56.0.218.g1ec904b173-goog
Message-ID: <20261021193512.2302587-5-aojea@google.com>
Subject: [PATCH nf-next 4/4] selftests: netfilter: nft_queue.sh: harden test_hook_drop_scope
From: Antonio Ojea <aojea@google.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>
Cc: netfilter-devel@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, 
	Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux.dev, Antonio Ojea <aojea@google.com>, 
	"Sashiko (nipa)" <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

hook_drop_case() ignored two outcomes that make its result meaningless:
when the 20 packets do not all reach the queue before the timeout, the
drop case still passes with an empty queue, and when the nft command
under test fails, nothing is unregistered and the keep case still
passes. Report both as failures.

The keep case deleted an ip6 prerouting chain, which differs from the
ipv4 output packets in both the family and the hook number, so a
nf_hook_cmp() that compared only one of the two would still pass. Add
a keep case for each: an ip6 output chain and an ip prerouting chain.

Reported-by: Sashiko (nipa) <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/netfilter-devel/179237288374.3135.9473018103688224106@kernel.org/
Assisted-by: LLM
Signed-off-by: Antonio Ojea <aojea@google.com>
---
 .../selftests/net/netfilter/nft_queue.sh      | 30 +++++++++++++++----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/netfilter/nft_queue.sh b/tools/testing/selftests/net/netfilter/nft_queue.sh
index 516d9012d2e4..954b7bc4d789 100755
--- a/tools/testing/selftests/net/netfilter/nft_queue.sh
+++ b/tools/testing/selftests/net/netfilter/nft_queue.sh
@@ -912,10 +912,18 @@ table inet nfqscope {
 	}
 	counter delivered {}
 }
+table ip unrelated {
+	chain prerouting {
+		type filter hook prerouting priority 0; policy accept;
+	}
+}
 table ip6 unrelated {
 	chain prerouting {
 		type filter hook prerouting priority 0; policy accept;
 	}
+	chain output {
+		type filter hook output priority 0; policy accept;
+	}
 }
 EOF
 	ip netns exec "$ns1" ./nf_queue -c -q 1 -H -t "$timeout" > "$TMPFILE1" 2>&1 &
@@ -926,13 +934,19 @@ EOF
 	ip netns exec "$ns1" bash -c \
 		"for i in \$(seq $packets); do echo x > /dev/udp/127.0.0.1/12345; done"
 
-	busywait "$BUSYWAIT_TIMEOUT" hook_drop_all_queued "$packets"
-
-	ip netns exec "$ns1" nft "$@"
-	queued=$(hook_drop_queued)
+	if ! busywait "$BUSYWAIT_TIMEOUT" hook_drop_all_queued "$packets"; then
+		echo "FAIL: $desc: $(hook_drop_queued) of $packets packets queued" 1>&2
+		ret=1
+	elif ! ip netns exec "$ns1" nft "$@"; then
+		echo "FAIL: $desc: nft $* failed" 1>&2
+		ret=1
+	else
+		queued=$(hook_drop_queued)
+	fi
 
 	kill -USR1 "$nfqpid"
 	wait "$nfqpid"
+	[ -z "$queued" ] && return
 	delivered=$(hook_drop_delivered)
 
 	if [ "$queued" = "$packets" ] && [ "$delivered" = "$packets" ] &&
@@ -955,9 +969,15 @@ EOF
 
 test_hook_drop_scope()
 {
-	# the hook array of another hook point changes, queued packets stay
+	# the hook array of another hook point changes, queued packets stay.
+	# The packets are ipv4 at output; cover a chain that differs in both
+	# family and hook, in the family only and in the hook only.
 	hook_drop_case keep "base chain removed at another hook point" \
 		delete chain ip6 unrelated prerouting
+	hook_drop_case keep "base chain removed at the same hook of another family" \
+		delete chain ip6 unrelated output
+	hook_drop_case keep "base chain removed at another hook of the same family" \
+		delete chain ip unrelated prerouting
 
 	# the hook array of the queueing hook point changes, the position of
 	# the queued packets in it is stale, they are dropped
-- 
2.56.0.218.g1ec904b173-goog

