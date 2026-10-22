Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792660541;
	b=Dudz4Ub5mG7WlH8k5vdeVbd0aZ0DYkiBrwUZJRWuwuVsh8u9s/9stSTH7xd6Ut1bbox1
	 GxkKqLYPe7HV3WZLBR00w9kAmp3C5bDu9eMLf2Vj/U/zvzK8fDK6yPdI3kzNsYeCiQJbI
	 PWvurZqiqpGJQbMg3VbUnnEfjA2DrmO0PUBBAHbx7gfPcVVJXAi1mdZOxWJ+jmkfj7Lfa
	 CndRDkmEK/nH0Y+vOez6sTRRzIZRJi9SNczRuSwA0UqwQXd6CiUqJT0HaMX7MUVN5sXxR
	 2GSZR5H8iHUzAfQVqCnLBF5lqVwdZ+uT8PzCId1a+0JqpBFcBoHPKetkWig727fy6/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792660541;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=cE1oRv74Uai/JOHCCDXA2NxiKeZ88D+LuOVAazAETn0=;
	b=GhMJ9m7knamCiKAdwm/XwINS/AhM98VQgZlUFU25sh5XzrcmO7hR18tIEDhJlSwF/TbT
	 WmCdYwG/Kn7UaMpYnRdErMMaMJBkkvBRCTAozJCaZeOn3UBaWl4sMEFEOj0tI+q05u1Xs
	 iQTFe9JEy7FzZ+0Yy73OWZeDrceYXLve8wdAQYVpEOkUonoDLT2UtaQgF2rzvK280uv86
	 gYq2NHqK/+uLh0CwUEz6ZFhLZOxqmRWmVBA9ZE4KxvUVN1xr+m+g/5EzlbJlQ2EdiLDsx
	 Ish9H/u1DX5apL4ctENdmWe15AVN90xiH5jBOdsJa3RUSz5herap/UiPAyLfay8Pxgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EhxxW298;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113A0606A33E
	for <bridge@lists.linux.dev>; Thu, 22 Oct 2026 09:15:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 113A0606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EhxxW298
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-15ea896ddc8so2344329c88.0
        for <bridge@lists.linux.dev>; Thu, 22 Oct 2026 02:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792660540; x=1793265340; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cE1oRv74Uai/JOHCCDXA2NxiKeZ88D+LuOVAazAETn0=;
        b=EhxxW2989TdOoqz8O+Y/PaBz7T0MwGBywSdCR8jrd/SezV5JxN0r+AatHQLuvQIq4+
         G8QWBpr0s1mT4vV31ew3Z1Dpsf/2r2mOYRJoQTCa4GFiHOclVyeVG/RKcwG2X1TQbNmf
         vY2r6EmIuYsRtgninKJr/ApUtXW7KSbKiBG1ljC4SgfZXoLPoz3mnm7VL6HEgmF+w6Ny
         1m5Re3ypsmVRWGFYw152mUbS5kRIYH/QffGt3t1zrDbNfTkSIIsAiI6s9a1dqpoLZcSD
         k4rJgyOKw7nVF5KIbzMwwe4F2H9SSpdFOY2EMs5wTvfCcQhIxEfuLt51p+1rz90Ovv5i
         7/hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792660540; x=1793265340;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cE1oRv74Uai/JOHCCDXA2NxiKeZ88D+LuOVAazAETn0=;
        b=Cb5NiLqmP5tlsHGSeQz70ZyRQRJf15O5UFyEXROPOTQtsxm9VtGHppchINs3GQFLxI
         d64Fu8fdKmUI4Y364HOFP0tQ5v358NuHA3lPQA1nQmevimq38B0K7fr54T7alWm0zEyh
         Nj+vHPa24dYW+gpGZ0hEulOhbRpLF+VfxM82m54txdYTQNZ8Jr8jmCs1/1xjtraXelUW
         Ayf/QtTLzbRe8aHIYOf1hVeW1gJkGMfJGumVXlRCoBdHAqMY9j+w2LpPJWndpPWpCKvs
         ODTOUygXZqvbMohLZ6Xgq7SyBlOivKKB7Z/YF0ZQ/U9si5UxzsYYCjycd9n1l+9URjqY
         t8nw==
X-Forwarded-Encrypted: i=1; AKwUvBzSwAaXnN2IpDWUehc7l2vxvBqVoL+VOS/0+G3rPpRyj7pZaa/9bLPThq8hmATMbHdFxxflycc=@lists.linux.dev
X-Gm-Message-State: AFq9FYLhmw2zDWfAOKQWyQPgDppDI3oRFwPQPrgGZE62HI/ZUHu6I8dH
	FBHA26STqjfDMcA2mzTchs70lYvl/X787IxLQPBRgg93vhYEDr10K8rB
X-Gm-Gg: AYBFou3aRledOgBZVfeEsrgFXxqjRP/2WUGnvRq4UNp98UBzs7kvamWnBsJbRL6PRlo
	0+OT23MzVxrcLj88RnQ9lcmnwWnsAiHRy55xlWpk6ubE9111iH+kN3OSJEAG+xpMATGseyWiXLF
	+8LGTzWgNLib8FVhtdfBBnnTwmapQ1jXOaAyheMxo9mu0ROeRzMZml5Gh2WNd9z94xttenhsK11
	Ait6ckGeGjh1Le43+BjPnGe0Tz6sEafBh2whxFQBvJeCRWlQmkkwPUufz864twu/nCoMruO0pCN
	L3ey2JWeBR92bqwaQ2boyj5fh4cPWU90J7ruVZZvZaZ7OHz1Fs7Yaae+4rXssXdnj4a5nLNEqzc
	q0pakZ6MtVI2Z6etCiI4R4prsys2C+M0QPT4nkCaOQR7ENZhxr8FDGHNbEewUDAkERTc4HcFB8X
	cS3jZfKyg8etbC36+OeIl5h4fq8hRynRwudYTJOe+6pTQPuIzvCNR1im6kJk+kouUUG4G/S2sTW
	nJh2xCn6+YqUxLmXmxkhWbklQcSKA9TyuHSt3eRb78/LOJaXedNriPHjMuntUlpRGr8J56jHWyF
	WVYglJtHR/W3z6pGKf8=
X-Received: by 2002:a05:7023:c018:b0:144:fa57:c617 with SMTP id a92af1059eb24-190a756bfcdmr5268242c88.34.1792660539942;
        Thu, 22 Oct 2026 02:15:39 -0700 (PDT)
Received: from youngkk-vm.localdomain (67.216.200.102.16clouds.com. [67.216.200.102])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903bf5d0a1sm13415991c88.14.2026.10.22.02.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 02:15:39 -0700 (PDT)
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
Subject: [BUG] net: bridge: received STP timer fields need range validation
Date: Thu, 22 Oct 2026 02:15:33 -0700
Message-Id: <20261022091533.3651250-1-teel4res@gmail.com>
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

br_stp_rcv() copies peer-controlled max_age, hello_time and
forward_delay after checking only message_age <= max_age.  It does not
apply the ranges enforced by br_set_max_age(), br_set_hello_time() and
br_set_forward_delay().

Zero and oversized values have several externally visible consequences:

  max_age=0: br_transmit_config() cannot emit configuration BPDUs while
             non-root, while a zero-delay message-age timer forces rapid
             root/designated-port recomputation

  forward_delay=0: a later BLOCKING-port transition uses the zero
                   shortcut and skips LISTENING/LEARNING

  hello_time=0: once the non-root retained value becomes active, the
                hello timer repeatedly re-arms at the rounded minimum
                interval

Observed on Linux v7.3, commit
08ab31164c55f20c7a2653de3186ae333470e2c1.  A superior-BPDU flood with
max_age=0 and message_age=0 produced:

  max_age=0 in 904/1000 sampled intervals
  attacker root_id in 897/1000 intervals
  68 non-root-to-root restorations
  122 message-age timer expiries

The bridge returned to its configured 600 jiffy max_age and own root ID
after the flood; the impact is rapid flapping and transient suppression
of valid configuration BPDUs, not a permanent takeover.

Received timer fields should be range-checked before they become bridge
or port state.  Candidate BR-035 is canonical; BR-036, BR-037 and
BR-041 are different consequences of the same missing validation.

I found no matching upstream validation patch or CVE.

The BPDU reproducer, verifier, and complete serial log are available on
request.

This was found with a multi-agent workflow; the full
state transition pattern was reproduced in QEMU.

Thanks,
Cheng Yongkang
