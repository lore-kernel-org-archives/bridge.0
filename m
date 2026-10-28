Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793206055;
	b=w0/FdtVruWwA8bnQl6GUeURkL6N9778iLP/B3z/yZzc4RhI/mS/rhqVpCMJ4h98IY7yH
	 wDDzmGoNDviToeCiEFxA88Khy/3WMo318wn7Njo7NuZTBqNFJO88S0feapsjrlR63aLhz
	 PNmVxOVuoLURYd/T0eyONz0iwMcDs/X/kV/OmptIcxNNJqI491BfX3F6rX0Cjqp8LBA40
	 BPW2LIjDBhdDC5sUX/gqTVIaz4I56ClEMhvGpUFihyca80KckJKo02DdJhm17NfUahEIQ
	 tL2clYhaFFWh/UtoaJlVCtj6JnkXLD2EZRAQtECY8reurB/0YBNrfaNheyR9xFILBZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793206055;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=hXQ5AtLbtETfyYAi8CVU1bdEjN/xUiyW0YYpN9HOqkc=;
	b=gdep7RMVs2dghqIzu+Rnddr3TfBaF9GpYxdoWDMiVR2Tms+6Vs+AaqdVlD8utLzB96Aw
	 YgULrn1uLyaH1Ht3W5KXFcKKkNDTpJ3uapWm3xI802GVujb9M+bCSAsOIXGU2cKdgY4Xq
	 EvUA9mEtN6fZ1XDeVYCGJbWWMAscZ2cDcNERTXPATKyaVRjm1vDM68KVHgVJwh8r4Jo0V
	 QoyOxXCdMoBBtzepj8SS+QiB7DHSQaQTWVjHsMJgf+BjkNbpmtCuSYEpUVgKJV5jyuDvz
	 0J/VO7bWJkujoq+BghOgBFK8QzcSSdy4amLiaRQ3a/3uVFM2iiKZ8srbPY9SFIgkcWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zZTZv+OJ;
	arc=none smtp.remote-ip=209.85.215.179
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C21606A31E
	for <bridge@lists.linux.dev>; Wed, 28 Oct 2026 16:47:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15C21606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zZTZv+OJ
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cc4c02ddd62so888994a12.0
        for <bridge@lists.linux.dev>; Wed, 28 Oct 2026 09:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793206054; x=1793810854; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hXQ5AtLbtETfyYAi8CVU1bdEjN/xUiyW0YYpN9HOqkc=;
        b=zZTZv+OJwSIDgAFrc/P9dvDV+/aoXbojC81rR8cbbCo65Rxh9IjvL7y9quzq0LxVJL
         LHQdk0Nq+8jQ+fAgW0g93XbWRM/RSHn/9sRC0JWAI9F3eMwBCxLXzYYFzapsOStvLCP8
         jdi18Y81iccwl2rzG3xwPFg3EClxbPS+yXJErCtY5XrXFlPAFVErSVAWpgbR9YzKqpTr
         VDQUkCdUqwCiPbKVn9U/+iFTW1KMbEVfFChTloemkzW2ErNKkOnWF5dSboH8m1s38fgh
         aTj1qOB41YS35YIaHvihDvFIXDJumYEq6uGymBj7Cj3cFZPi1n8w4cgDN60ga3Xw9VPE
         AxvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793206054; x=1793810854;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hXQ5AtLbtETfyYAi8CVU1bdEjN/xUiyW0YYpN9HOqkc=;
        b=wjd5vCB4piPDCZQfZi/Vqgka3oXfxPUW1Ro3sdWLa40JxM9FHsSRXmVrDTGde4Zxk5
         CxiubP6WPf9XD0fpvh1Ip2JEbkkLUKXh1gD95AJHVGvdgI7AT+mafpV34AL2oCuehzI7
         fOONLpMoVtDkkB9kSOc4ocnL3PjEdEOSGfVRJ8Wz1KHoi5ZLQ3rg5TyKqVi2hV8hsCAM
         zad97ednPsYcekt3nzMPBB16mCG4KEZF3ts2ywaur/uXNMU9iVTBg5nBqHm5kl2kkfeF
         CZYl1wyIY6hqKWdqDlsd1U5heOLp1c9fX1TOuPoYgByEq0SZ/SeGruog0uhsUt4ZyOvv
         L6nA==
X-Forwarded-Encrypted: i=1; AKwUvBx+6EtGKIo/NnMF6z8sXlThfBcOLi/dtJaKH9jHU97cPboidMtwnrDKwgbvjuIJ/VUssjFkmMg=@lists.linux.dev
X-Gm-Message-State: AFq9FYIRJvHsHvnMRMrjkIRPCeVc2fL4MYWDGlrkP0p4GDZz1F4RTWkh
	OYTlHoiNvvrYHpwGOINb8p7a3XWMhgk8IqZymaaS0GPp6ACyt1yV6mnH
X-Gm-Gg: AYBFou0YVCjKy0uNfemcABVlh/2SUr5efDrU8SvGN1gEey6XSgL64ZwM/TIWQ/nvKWa
	EKE9tJ13QB8xQeigOnxrp25neVYJkkAsXvOrSIe9lEK7K8vyg3WvKdl+Yzrtjcr96S9GgczLvtd
	ERxPxBhuZgFrza1rwfFX3oLVlEFfkdJ1e6SYQ/5vJ3AT89dcT9P19Gyve+GmDXI33xCVN+1O7Cq
	E2JleoFBQPmUmZhd0/6lF0lhl1yd865T7m2AVDKBCmKFmzB547Lom0aFfJPtOcd3im5wxZmWN/G
	uUOyFMXyCzyA+ixxVTvZlpL+JwY7w2b0kUsO3atjACjCeBB9khkUG6mpfpEMFQS52RmXU0iwdR6
	Czd7dvmrEr6ZhDbl37qa57K6XE0ndqrWoNVwXRM0pYcwYPDxzMqFKBHnAOpxeqZZeW32ciOJg28
	OhCI2alr5JdGM6Ulbtwk4/s/RHQpW5a9iT6eGIwc6T3QvY+FcPO63ruP5ShZ1/d2FRUvcuptskk
	/bnQS757zkYbD5fgQLC+itRfZKMUJ+TFaF2IiypKu4sV6u83eywmVC35TG3nXhf8F2kUjSjqSoY
	4G4RNdipY56FgF0IPL+yp9fQnCiuYrxn2kRduWaVIvP7mFmIOcFghPBq2qbvm9fQyVou
X-Received: by 2002:a17:90b:4d05:b0:3a7:f4d:b23d with SMTP id 98e67ed59e1d1-3ae5821f346mr2159561a91.52.1793206054280;
        Wed, 28 Oct 2026 09:47:34 -0700 (PDT)
Received: from asahi.tail4da9e3.ts.net ([218.48.198.193])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae579c5b77sm2173048a91.3.2026.10.28.09.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:47:33 -0700 (PDT)
From: "Baek Kyu, Kim" <pocj8ur4in@gmail.com>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Ido Schimmel <idosch@nvidia.com>,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Baek Kyu, Kim" <pocj8ur4in@gmail.com>
Subject: [PATCH net v2 0/2] bridge: cfm: correct CC receive monitoring transitions
Date: Thu, 29 Oct 2026 01:47:28 +0900
Message-ID: <20261028164730.253238-1-pocj8ur4in@gmail.com>
X-Mailer: git-send-email 2.55.0
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

Two CC transition bugs affect CFM receive monitoring. When CC is
re-enabled with a new interval, the first RX check uses the previous
interval. After CC is disabled, a received CCM can still change peer
status even when its RX work cannot be queued.

Patch 1 stores the new CC configuration before enabling peer RX work.
Patch 2 keeps RX work disabled while CC is off and skips CCM status
processing during that time.

The v1 submission covered the RX work restart. This revision also
addresses the two review findings. The interval fix is a separate
patch because it has a distinct failure condition.

The combined series passed 8 CC interval/transition checks and 3 CCM
status checks under ARM64 QEMU/KVM with bridge/veth. The CCM status
test failed 2 of its 3 checks on the v1 image as expected.

Baek Kyu, Kim (2):
  bridge: cfm: Store the new CC configuration before enabling peers
  bridge: cfm: ignore CCM while CC is disabled

 net/bridge/br_cfm.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

---
v1: https://lkml.iu.edu/2610.3/01364.html
v2:
  - Add the CC enable interval fix as patch 1/2.
  - Skip CCM status updates while CC is disabled in patch 2/2.
  - Retain the RX work disable/enable fix from v1 in patch 2/2.

-- 
2.55.0
