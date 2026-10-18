Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784F11096F
	for <bridge@lists.linux.dev>; Sun, 18 Oct 2026 00:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792281879; cv=none; b=q90vkCmMGrEv/TzS1u1dutxMuVdOAVRKlkclNFCxivL9nAnfvg5J3jgr7R8R3fZ2mB4ritrYr9tDQnmwdi9kkI63y0Uxk+siFSy1S4WwMBlvOCm2e1LLAxJR8E3j7ayKpHC4U8RzBfitSiagMR2SSHZlm8ynnOhQeeXx2ZZA3fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792281879; c=relaxed/simple;
	bh=CRQqrOceBO7jj8qsVMNU69Rgv5g+O9xd6prK5pGo2OU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dgtRi0APDT0ooXDw6xsgiV9s+vO67Vb4wtYS48eNN9p2Z4/WUHgik4gydiodAiFx5tAw6gc5bJhuLWWi/Xqv/UxeKo9luzxwU+Qa211GVMv4mTxSOBs+zAIlgc8b87BwkRpsYEFmyFK+Cq4QwYltPBgCU4T/Y9Vk4jWLTh3K9tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de; spf=pass smtp.mailfrom=bairaktaris.de; dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b=CIAM+73M; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b="CIAM+73M"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6b2232d8ef5so1388623a12.3
        for <bridge@lists.linux.dev>; Sat, 17 Oct 2026 17:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1792281877; x=1792886677; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CRQqrOceBO7jj8qsVMNU69Rgv5g+O9xd6prK5pGo2OU=;
        b=CIAM+73MqknRFTVdFWR6AJT5yYe3IfmR04i/Y3uhLKSGVVhuguF5Lcckpds/wl45l0
         HFIK3VrzUp4Zog0enFzn+EjutwA51b9D6AE4VAnjlVRf6SiJSnLBY6BdXo8yTF2HiJd+
         jAtfESAcuH0+Ht2FMoaSXLQllKxAf/CtKr2S0hnoih2PHinBYIUq++udxPqshr7u+HcG
         EMOwR3+AURhIsZ5Yf+gFdP3Fjba3FwTBKPot3T2ne3rNr38TYg5vuRO0grMi9Zpt6Reh
         iV5pQVDIGJ/6zYNjFGXHcothGLECjlwEPJBjYFDulRfRQyg/3dHrQT1gWLgohpevrGvT
         jepw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792281877; x=1792886677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CRQqrOceBO7jj8qsVMNU69Rgv5g+O9xd6prK5pGo2OU=;
        b=FPTJ9Om5pmAwAvcCs8eA/qc66HZGy0ZEBDxw1nkg+lbxPMxfpiUrN92RDW6bjWH0cZ
         SKT2XEPVKw7PJOtjgN/xA7SEVWw+HP5/SEtiaqWon9PHDyfCwFhAFesan4xspHRG/Nb2
         nSIDC7LOBy6XTZARrRkJY3BF5XXqy8wgm4OklMn1yPRESjibXD8O9pLOSoShH4fVPa6y
         qfI2Nl+z0zGrX0ORF3CHjy21aqDtqw94oG1HIsekYQ+ahhPVzvbkgKi3/5ZHyUlwN0Xt
         HPlOXIxu28hcBUlykf+n0Nvc+3uWXgb92BjUS3hufEfsgdQaKwqUp/UybLOZHqIocmYU
         xEGw==
X-Forwarded-Encrypted: i=1; AKwUvBz1fg/dgwM+wJK8Ib/vv/aoFfxSUBRuRKWXCZOn/QmTaoJFiAr6Z4wMXLuEzMOAFwt99Ey2WmQ=@lists.linux.dev
X-Gm-Message-State: AFq9FYI0J64313xhTKNRFlOlaR3a5JNkKX6QxeZE+eJY9Uk008wErX95
	2GdmYPQcGLJK7wMOGBiaZczw0bRd06oCA2z8F6Wdu0stLDNRMd3naiiJ/XlJAra6hQ==
X-Gm-Gg: AYBFou0UuMCRU4vCiCRLPtG8JAPXUgadD8b7H1/6hIxkBLjdK1fvIN4TdrYorx+AhYJ
	9xmRS/rbFY7t3OU7JaD65AvD9OtL8cmPdI+wm3xXakZxL9OrAQv/4OEwyhejkaaBHV5gv1K9g3C
	z2Vye0QlFtwyvsihDPHNmb7tWArAvcpvX0A2XQFcTQfHAztQKTaTdZtz9q9Hvvljl7QHZS/97Rz
	fwx3/a2eazYBSQUH7v0lP0JbLh0O6Wx+7/KJSJxDE3n1yhT/dsYbbMI3yQhLYPml2xOUGzgEOLt
	fVNRoNJHTI/nH+GaTDa2tAZe0iYCl/3fXNpXHiq5inT0ISlbi7Raf2HDw0tvK/bkBH2Dfgv7as3
	KwAbS+S5i1v2JgVCoijIqFFb0M5PBcjxdGUtn2aoIlsvE8Oxsy+EQpcXMRIKt+ljyKH+wSFmjKo
	1nw54CVTjIHAf7GWOQP8kBQ7Ip1SssK/exY92Z4U2UsIfh86bhWMdcV3mesl+46Ige5JmIVmL+F
	OrMe+6WydfuDb1YgPoaKTK45MFViGk2Y+Hs+mYj9oYmdul1piJSrwphM4cAxdmeKiZsC3cQL6T/
	buzjRJFQefT08awjWWMbjQ7lhfjDAYy0corE/UmDZAMBYZRa2FdK2/4YIiJjvOOtHqB1AOIEiA/
	eI0PumKoC6UMDAxVHEOu5aw7ZvMPgYosSihyIxnawSvi9he0fmdxocct5SgEhmRw6rhc0qaZmvm
	yv9hV8OFkezLlFhIsEccOXBYkVKIWA4GsPuWZgzdKUztEh5MKu7dxAQU+0CsiMjNAC5uBsF+uuc
	OyfHxcr
X-Received: by 2002:a17:907:9713:b0:c2c:d06f:cf89 with SMTP id a640c23a62f3a-c419a942f35mr242613066b.2.1792281876811;
        Sat, 17 Oct 2026 17:04:36 -0700 (PDT)
Received: from Desktop.fritz.box (p200300f247412f10cc8c3f7d773dd5eb.dip0.t-ipconnect.de. [2003:f2:4741:2f10:cc8c:3f7d:773d:d5eb])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c40912ce05csm213267866b.33.2026.10.17.17.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 17:04:35 -0700 (PDT)
From: Julius Bairaktaris <julius@bairaktaris.de>
To: pablo@netfilter.org
Cc: netfilter-devel@vger.kernel.org,
	fw@strlen.de,
	kadlec@netfilter.org,
	phil@nwl.cc,
	horms@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	razor@blackwall.org,
	idosch@nvidia.com,
	ericwouds@gmail.com,
	dqfext@gmail.com,
	netdev@vger.kernel.org,
	coreteam@netfilter.org,
	linux-kselftest@vger.kernel.org,
	bridge@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH nf-next v7 1/2] netfilter: flowtable: tear down direct xmit flows when the fdb entry moves
Date: Sun, 18 Oct 2026 02:04:33 +0200
Message-ID: <20261018000433.1466958-1-julius@bairaktaris.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <atCsGx2IRecQNK3r@chamomile>
References: <atCsGx2IRecQNK3r@chamomile>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

(Resent as plain text, the first copy was HTML and did not reach the list.)

Hi Pablo,

On Thu, Oct 15, 2026 at 12:34:06PM +0200, Pablo Neira Ayuso wrote:
> > Assisted-by: Claude:claude-opus-5-5
>
> I did not use this LLM assistance for my patch and I show as
> co-developer here ;-)

The tag covers my changes on top of yours, v8 says so below ---.

> This comment is not needed? LLM likes to bloat code with unnecessary comments.

Removed.

> Why LLM decided to rename this function? :-)

No reason, back to fdb_valid_dst().

> I think bridge_ifidx is not needed here and I am not sure we can cache
> this value?

Dropped. The gc now walks from out.ifidx to the bridge port through
the vlan devices in the encap. A 2-bit port_vlans says how many there
are.

> Why do we need bridge_vid? See below to explain an alternative.

[...]

> A new flag might be need, but there is room for new flags to annotate
> this VLAN header came from bridge filter filtering, I understand
> info->encap is not enough.

Dropped too, there is a bridge_vlan flag now. For an untagged port on
a vlan_filtering bridge the vid is not in the encap, so the helper
uses the port pvid.

> Why LLM moved this away from nf_flow_dst_check()?

Moved back, nf_flow_dst_valid() calls both.

v8: https://lore.kernel.org/netfilter-devel/20261017235849.1066624-1-julius@bairaktaris.de/

Thanks,
Julius
