Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792660621;
	b=o6TV9c4g77XMF9w2rYzBW2ZAbroP7zZk2FAJVKEZZIByuPeSGtdMumL7VxtXyDWw26p8
	 d6Zksi6NvniWk0Ls5tBawL3Z7t3xGz++HYAeLYoPNkhzoYmZ/BidEwYUYnLXP38zvs5sF
	 ZIwxer4FhJOra4cdPfCai5Y4oiu6T6jaXfS5t4AM/RL8OA4jSkuKlgFiuziFaYQ4hbYby
	 RWvDObAgUkDn8D6zFHtx02YXM8DmtSZ7fJ6vuIOUZqEU5hn2G2YjHbBdwLsV8uGb6x5kx
	 eE/o2q/NZ8ehEQ81IJB27iDGURuY4EiK2mh+g8yPHptQzEJYGFKOjqCpdfR6NN3Ei4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792660621;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=74Vw0j5rE4cQu4U2NNcGbj29GdZNeea1qUhNAa2u8VA=;
	b=K+ZzEpHYR80mEKZUjvA55MUVcvTx3p6trJIeTOaHSYMTzn52peytSStSmXGZA9lDgwHf
	 4fJwcCeQecKuQBDXezNH0gzHvTY6aWSkV2kxy0Bfz7pZoWq8RaGYRVc9u2Op7RFk3noKa
	 LosyV5aXwXkEIEuYI95EAl8wRty7KIxpVUHvQq/MZ063SgnRJabs6tTWPxwzgC2guvmYc
	 JlsYZGa0wzYMP5Zn8QhsEer3aUGPL6uWXEN2QpLXN51uPUrsj/5FcHIojbQRX0/NIplv2
	 TH1s1SoedqP7ZtiUBsf33lnjesA5BlmgFxIyY94lYTC70F5l0JGhHjQ2DNVJsMkoEkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rJ33Eqnw;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9EA606A31D
	for <bridge@lists.linux.dev>; Thu, 22 Oct 2026 09:17:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD9EA606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rJ33Eqnw
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-368581df789so856051eec.1
        for <bridge@lists.linux.dev>; Thu, 22 Oct 2026 02:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792660620; x=1793265420; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=74Vw0j5rE4cQu4U2NNcGbj29GdZNeea1qUhNAa2u8VA=;
        b=rJ33EqnwJNqsmuD5cSx2I+Uz0hr0WBtVmqoW2t5E1QpGDJjbJj/El0kCk1JrM+fBBV
         8ofRi+XddKwptIdvjZuXnqcy8dHD7uh0/SyU+G9m4pofA9cLNS8UMQlYNjSbDyQNn56I
         S0QGaDddiVEQ2NvvponthVE0kgYunO0S7nGWN6Fo45BdOBa0u+/x8NBFqtsck9F9RUe0
         WtMnAu88saEAEAw3zmdNE0MeJyCa6Yv46NW73+N19uMmUPfEfF+HZOduC98pIR6L/6ES
         Zro14ZNSoUYvuTc7ZZj0QyM1BqjVAKtwlSNp4GnxvyysOCjwn+A5fR7VRlZkTTt2L0Rd
         UpXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792660620; x=1793265420;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=74Vw0j5rE4cQu4U2NNcGbj29GdZNeea1qUhNAa2u8VA=;
        b=Jrx5/kon69JyV5OI+uH9c8LP0ODbdhsTUhGvWUje5BKAU69AL8K1qZd3hGMRBi6M9R
         cFeQMce4VZ+Lid5QyITwhJ3DYqB8tCrbYmbnilQfd7m8UTvo8GFkyV3NAbPoFtdW9KN4
         TPeLtcDAW+iZ5l2ZpMOHx32qOVVhkLPoUL9eRiy//Mevq34ng0grgOoHvimnJwEIudru
         UUG8yFnsOBqXkx79XbsHN9Z92HFkO4ThSbinLUlAcqB2VhO39K5S+y63xnqqmQSY+4uD
         ytZZ3jz5W4EHd+x7hGjQAmWFN0fhv5rN2hwOldTCVj2DiXSRzIuHfzGROS9JzrENpA+V
         tFqA==
X-Forwarded-Encrypted: i=1; AKwUvByOZUzI0pXiBrtQFKapNCUdBWCsHiOtOxBl5FCE1mu7VJnV28voBbSaliVOcM0lP0TUR6o08xI=@lists.linux.dev
X-Gm-Message-State: AFq9FYKqEAJK3RvB2CuoFbh2FI97F6MQvG+i0hxyyGlD0VGg6d5C2lWS
	z09KD+Yz7f17AoXV9qpbq1WBnZsdsi4ypNpS33SCk27GKLfIO1eI0IHw
X-Gm-Gg: AYBFou2XjLbNk6vnMXBG2udxSknJ5ELXS4c7O9oEqqI/tDGJ9e7QSKGJ6gBUSsmpv2E
	M13AyVH/G5UP1E1qTOOte55YXpYj9RWv0xBW9jJ/AGXhnTteFfVS7Yh2fUk0ekicyaHA6Pfc2lU
	KNrcgSyKuU7z01JZzKUsQJI+aQiBZj6subTCHOdVAKrxFVejQXQ8uzHpliE8eq/v3QLo2gC4S2u
	haZAYTIAUvKfz3uQ7A65BG3iBmVyYggMHgiDfyrZLEt6aysr9YGh2sJO8yN+F4Mzu8iARngMqHK
	yojsw5qeJwrAcPuZHyY7Zpo/GUHgPrnJJV5DC73K9BKGCHKvZRn+g/9/4A6Jf6gT+zuR6AW9Bgf
	1TLbu1T20uFDA5Z7li5aHIdR86cMa3SeWEYpIXCvQnNk0RGSjS+DgLn63qNjgeCTHQ0Wq+7w0Va
	SWL/DK4QGrrXmH6duVVTFax4RuRLJhWnvjYUhq04sKV1A1tNHVUKKh68iO7EXCBSwdx81NLrguW
	eAhbGeOUtRAPqCSHk3WADgQU0biORj1ZQPB1AHzzdupeEI+8y58ZQCz276bbn2Eyfol02e80iv2
	IEUXtmBHEowWHfG1aLs=
X-Received: by 2002:a05:7301:7e17:b0:366:6c79:212b with SMTP id 5a478bee46e88-368b122ff22mr2280564eec.25.1792660619861;
        Thu, 22 Oct 2026 02:16:59 -0700 (PDT)
Received: from youngkk-vm.localdomain (67.216.200.102.16clouds.com. [67.216.200.102])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36740cc8439sm15295791eec.11.2026.10.22.02.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 02:16:59 -0700 (PDT)
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
Subject: [BUG] net: bridge: CFM CCM transmission state races with delayed work
Date: Thu, 22 Oct 2026 02:16:53 -0700
Message-Id: <20261022091653.3652341-1-teel4res@gmail.com>
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

br_cfm_cc_ccm_tx() and ccm_tx_work_expired() mutate
mep->ccm_tx_end and mep->cc_ccm_tx_info.period without a common lock.
The start path also queues ccm_tx_dwork before saving the new
cc_ccm_tx_info.

One reachable interleaving is:

  writer: store ccm_tx_end
  writer: queue ccm_tx_dwork
  worker: observe an expired end, store period = 0, do not requeue
  writer: store the requested nonzero period

The final state reports an active nonzero CCM period, but no delayed
work remains and no CCM frames are sent.  The keep-alive branch has the
mirror interleaving: it can update ccm_tx_end and return success while
the worker subsequently clears period and stops transmitting.

Observed on Linux v7.3, commit
08ab31164c55f20c7a2653de3186ae333470e2c1.  A self-checking userspace
program exercised the start-path ordering and found six phantom states
in 384 attempts:

  start_period=67108864
  probe_period=12738873
  two readbacks remained 12738873
  keepalive returned success
  final period remained 12738873 with no pending work

Four independent snapshot-VM boots produced 98 explicit confirmations
in total.  KASAN and UBSAN were clean, as expected for a control-plane
liveness defect.  The target lacked KCSAN, so the report does not rely
on a KCSAN warning: the queue-before-save ordering is directly visible
in source and the inconsistent externally visible state was observed.

The worker and configuration path need serialization, and the new CCM
state should be stored before the delayed work can execute.

This is distinct from candidate BR-038, which reports the 32-bit period
conversion overflow in the same state fields; that arithmetic bug needs
a separate fix.

I found no matching upstream fix or CVE.

The self-contained reproducer and complete logs are available on
request.

This was found with a multi-agent workflow; the state
mismatch was reproduced in QEMU.

Thanks,
Cheng Yongkang
