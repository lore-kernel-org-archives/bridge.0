Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792660558;
	b=NOes2q8j9YRjnrFe7mJbG+fm4SRpNcWcxpU4xf9b4zQ8vpxMCQ/iCfzBJ6bhOvrjqAaU
	 tDdU5dzEcU3w68XsnPi3UtKxK6ZJkmQgzyx83QIArGwBPoawFFEwvHUFh8o6g89V4ZMLd
	 B4oS7w+xAmg1ioXTWl7f2hRfaow7ew82xySMPHv/RFzzpRt1Hp4rEbyQrigh6amVx0bY5
	 WbvK7lJZv61whIRhIv+u9FWhIsFJ2uOXNU8//fJZipQG39B5gz3jFw5GAIcgw81sdsmcI
	 qx+utQi8YO5/iHQ7IBH5a+9kldzf8qWwVJelP5FZNs1V535K7HbtDIJHy1uEWIBd8OQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792660558;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=0DnBewpAT9Tp8HPHEGwu8TFrPEm2oKGIa0lEEldW23A=;
	b=uwTQjg8kVqQN3C6mV43bfccIFKy77jX//mz3cRzKXqtN/3Xulnz09GvVorGL2TEtTaxz
	 IjtFjiD6FfrKwsp0j2/QuWgp0gstd7iqin3tG/MlbMG9c3APnhltXkghAHHzklRVd8gtc
	 hRLIhZShykGEANf5rdWmvIiaHFBEufrCQWUvTIe125akE4OxrMcxVMUJ5bJyVQpWroc2D
	 el9dPo/L/6RFe/+7X+dpjLhsAp3CkFgOOt/rRUANfgZEu4PuBI6wKbNuSEJZQy+g+Yd3H
	 WAgbbkD+ARuRFVYYdF/cAapZCZ53g56P0iSB1nqDd04uZ3hn3tRuG+YOzuYZtJMT3sA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="mSqHp/Ux";
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F15606A32E
	for <bridge@lists.linux.dev>; Thu, 22 Oct 2026 09:15:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7F15606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mSqHp/Ux
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-354ba08cfd1so2801558eec.1
        for <bridge@lists.linux.dev>; Thu, 22 Oct 2026 02:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792660557; x=1793265357; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0DnBewpAT9Tp8HPHEGwu8TFrPEm2oKGIa0lEEldW23A=;
        b=mSqHp/UxUz7GkN5sOPyHDLlwDDY2wiVcMyLaojFf8Wt++E7Xd5rQ+8BGZ7ZSJTZ/xK
         mg3PrKESOfzB2uYUC2fQ0lQPSeTta04UuCZF1dF+PJS1xENjaqARcttIpHkOe0FtnLrk
         Sb5jcD5QopbH88Sg/Eck23sFnuBjXcB1f/8AwCLKhTkDQxJsKxiMeGL/FRT2BKguax4I
         SftmkT5wDRtnxQcuWQWn61b72QPb8sM5crcfC8LKrIb9AZtALH5Fpyo1ariuFlzoB4hJ
         835oM+IgO9yIlfl5Pj82vAPW80/j/QZGSBWxYqbvJGceKTnFKFk1CDXKrExxZsoWOKz3
         I2bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792660557; x=1793265357;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0DnBewpAT9Tp8HPHEGwu8TFrPEm2oKGIa0lEEldW23A=;
        b=qUHVDFCfDSsw2Vtnl0IFbKpu27I3lhFJQA/9aW7seek9MmFIszzaXI6LFcchSuJvgF
         Vz7ao1sOQ+RxbLFjp1m8YDwUXAemwK38g/w0LdKD8SBDRqCI1DIuLahFgviMlivk+kFK
         RwR5grLDiMNSKrbuuqTgS9F0QuNYr+9u4h6/mTPoV+773khlzEsLzVC6rUaSKts7dQah
         WsL5jqE2ETE1HhqnAWPGUGdyNQwtvZsGZVucHSXEYFNEGdDdn3l+2jyGVx1ahyomdHdi
         5LTfTYdmbV73xdgjZwqoo3ObWcyYX8SR91IEFgq14PzxERSRo7P8e9b/JQjL1huDQigo
         d4fg==
X-Forwarded-Encrypted: i=1; AKwUvBwvc5aoYQBmF5r4Q5d12SFQGHvbI482kxWMl/BPvppbdvU7T9wSCS6SMhrkeR/Af/X/4boeOuc=@lists.linux.dev
X-Gm-Message-State: AFq9FYKwLW60ekZsj4mVEh0s03czUpZm8zHzk1qhVAf8p4J1gpSQsIuz
	IjqgZunWUVJM9UOg4VO65A1E+hUWQRWMqCn9isBVJzJr1RNBY3xE5guJDjAZTn2p
X-Gm-Gg: AYBFou0cSba1STzj/Q5NrUCxDkWBYX8U8jwv/VC0sBqXDCACb67bb7F4S2BZDW6kSM/
	eujlqvBFLLqHbJngQtQ+XiOCfalO9EZERQVhO6liCCwUL6jvauKNcofE3DyFh91M6F0pfGhQTb0
	UukpJa88kn0EuglVwxc8URQnvPkF4zERDmrtM4Z25bM6O3oKcJf/1n2PCX7lY5QeIdl+yAzRqat
	qe3Y1YmtzGgTNgtOijB4yAO4woURj8nSgTmscEe3ml30kg1/IA7QnxcWfpex5svSQ0UDmsvy79Z
	om20SBV+5ygBBCZuBAE3+tfHx1kiVZBZ6o9feXJsC9IS+LNSWrOR1YGvncL/QkXHmbIipSdPT49
	xPQ/fmwORwAIlJ0792w6bJDaNYz632q3f6ePLz5vJBslgSBvBkzSyqvLEWa842f9/aRUQwmN1YM
	kAPK0XnR/p/tfowdpjNczVqBgqG38CKJuiOH27laKD0N5BksKIuFQBDvMwyMB6wLzFxxlSr1Pc2
	ZVZ866ymnNXrTpHlB9gW6OvITDpSmvntaPPYD2HkTcky3J4odL/gvqYPQcbCGWcuMVJPyKcVwR7
	JOXGMfz32M4iIOFQ6sc=
X-Received: by 2002:a05:7301:dd90:b0:35d:2633:ff79 with SMTP id 5a478bee46e88-3674e64b5b0mr6323161eec.40.1792660556817;
        Thu, 22 Oct 2026 02:15:56 -0700 (PDT)
Received: from youngkk-vm.localdomain (67.216.200.102.16clouds.com. [67.216.200.102])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-367411bd2a6sm22187442eec.18.2026.10.22.02.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 02:15:56 -0700 (PDT)
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
Subject: [BUG] net: bridge: CFM period conversion overflows 32 bits
Date: Thu, 22 Oct 2026 02:15:50 -0700
Message-Id: <20261022091550.3651455-1-teel4res@gmail.com>
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

The unrestricted IFLA_BRIDGE_CFM_CC_CCM_TX_PERIOD u32 is multiplied by
1000000 in 32-bit arithmetic before conversion to jiffies.  The same
expression is used for start, update and keep-alive.

On a HZ=100 build this produces:

  requested 4295 s      -> about 40 ms
  requested 2^26 s      -> zero
  requested 54369991 s  -> effectively non-expiring saturation

The netlink request succeeds, and RTM_GETLINK reports the requested
period rather than the encoded duration.  CCM transmission can therefore
stop after one frame, stop before emitting any frame, or continue far
longer than requested.

Observed on Linux v7.3, commit
08ab31164c55f20c7a2653de3186ae333470e2c1, CONFIG_HZ=100:

  period 10:       3 frames, active for the control interval
  period 4295:     1 frame, cleared after 1115 ms
  period 2^26:     0 frames, cleared after 1 ms
  period 54369991: 4 frames, still active after 3507 ms

All four requests returned success.

The conversion needs a 64-bit intermediate or an explicit bounded
duration check before storing the CCM end time.

An October 2026 iproute2 CFM discussion notes that the CCM-TX period
overflows above 4294 seconds, but I found no corresponding kernel patch
or CVE.  Candidate BR-009 is a separate queue/save synchronization race
in the same state fields.

The reproducer and full logs are available on request.

This was found with a multi-agent workflow; the
overflow signatures were reproduced in QEMU.

Thanks,
Cheng Yongkang
