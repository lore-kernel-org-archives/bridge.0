Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794138457;
	b=aldyqaBUqwVFdtL4x2WK3gAQaK5LDcbOS+61Skq4W+CD2IXumk8VfeVIJ5bMk0DyFTmK
	 5G9ELuOEEAWiI/cchuyw8Wy3UBnVUhTrXIxJeMOsPfZCHZqQd5P6L17p6SoIpLE4NpB58
	 kvlUSXExtLlbCULcGDpTmrljAzbLHGLIgwz8nU/L0/um/OJK552phf2qsJ5ygxnSF7vf3
	 O2R45nBxVUK8spMP32IsfgWwv7P8O5w25JUylr1W5RajtxlrYW1vxUsg1Gt+C20VHXh7+
	 VwwnDg/oWEbSbQ+O0EXUqneU9U5NISpk5tYVxlp9bxhdmK8PlE/XWt58Dj+ze26nV9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794138457;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=lSSFytxtbJbtyMN9RV4GYLmhr+794g+CxDzHCGkwhLc=;
	b=ijVv6i2W0hZLwDFr/xsEhczB9q5ottyKR/hNMMFy/XjhntuVqFmiJG4lJr4Gl13PVDh/
	 CtBnAN9nfE5bH3cTCAS+wBHEnfD8mK+lRni/Smaa1YdNeE7bgNKmx977iOR94XMx3mtzY
	 PF0s1D1pTIkzyIWwl9tvbbnjSoX7NJj9vDjAHvAPpt5H/Fu7FpB3Vi7IdLj0IPY8AfLYC
	 jKW4M2G58JDPJSxWllvU77tKVpGWxUwYQVbfNWimZogYDTnf8GNbZXY5wHOIgzTJdCmzN
	 TCQ3uSdcgDHnviue8CwxQQKUTYNDoYM7pHemhGVVaOYF+5p40yiybIxQoAyDkOy8S6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bairaktaris.de;
	spf=pass smtp.mailfrom=bairaktaris.de;
	dkim=pass header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=LnZHLuJn;
	arc=none smtp.remote-ip=209.85.208.45
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B50606A335
	for <bridge@lists.linux.dev>; Sun,  8 Nov 2026 11:47:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0B50606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=LnZHLuJn
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6b547d6c07bso52591a12.1
        for <bridge@lists.linux.dev>; Sun, 08 Nov 2026 03:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1794138455; x=1794743255; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lSSFytxtbJbtyMN9RV4GYLmhr+794g+CxDzHCGkwhLc=;
        b=LnZHLuJn8mgrbTPFaz+OBZNyZRV9jS6QpJuKYn/1YshI2oGgAsSL1K4kfdLZ73IH8O
         229QcXWDdNa8aBCpl7rfdQBeIPPexxmVhoExE4adUZsXF+lCfqKoD9vaLkOm5Ocn0AfK
         LgL3AfQUEZdS/pGEB9/5IoE0O7d6yDLOev/o7/l/Oz3hDDxkYd7NHNN0ZoiuceNzCUJl
         CRenlcDfg7CqCTKPag1D2thP64DcmF4Hh/75QIZPjsNB/l5HkvjRYqdzbM90e9z3EZ9a
         onri4ptuaK+2pu49qW3LUxJ4PPBDUzAcZChF0y+nUFlh6ZoIBfdltECSaN83qhOa7M/9
         Nh4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794138455; x=1794743255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lSSFytxtbJbtyMN9RV4GYLmhr+794g+CxDzHCGkwhLc=;
        b=QjUMVaYw2pJ9/lFR6LMuI/Th8q6vrIK3Pkcpob/3ftGtWYQlG+qpFaErh17b3mpnMO
         EymCCKWNShcYOprahT/WMfjzxFa0XS2LddMhY3Go5pD8tP7rcKpOXqqEw39+aWcVv/iP
         dgom63dAOmFsdUkAAx2P4qwj4k0Yd0vjLabcP1+NCcSQnv0b9R0bxXrXx34p7zkAIeWh
         V1cp2I15MdWpCiULkDkIVWESIyGgOsSvgIQ6YBduwgfFlpi3BgBAuhbCyL9DlazInNR9
         wyBza6wPjp+/Y1hjarvEgEGA0ZXTRESO3QgiP0zRmUIrzww4uogTem7BOjZzH0QawYdR
         CQww==
X-Forwarded-Encrypted: i=1; AL+hErEdwSa5e+GCzZ2nsSb2P4/M3SNIjjabNJOZ2xP3QwZoEn0Pl5mR3rtatiNaN6HYv3+vl7Z6nWU=@lists.linux.dev
X-Gm-Message-State: APuU4Z+pxkXdY9oEnPMdzC3/0+2qLDwOvAL29Y18dyKjoJ/Lg/vNXY15
	KfEl2W9RcQBP5Va4YMq0LcrCrg49SKDYIDyOHyHif3NHL/el7aTgdsvIoNq9yQiCaQ==
X-Gm-Gg: AYBFou25/En63Qz8VJK4W7RTF8Xkt1tOALfspAhFAZhcOB21CA4phuhAhct4kr1kOSx
	ZdZNYGJIuTs6RfhQKHhRDqUsAMZX3oi0xZ6B5XKxSSzcsIyqQn+KnKLqWudxAeBvDU6I3SbtkzP
	/prj5IG8WKqCiiWoh7xlsjtvM4kwRKwub0lsIf44bbp0II6ai6zjwiLCsspTTPRolQucxiuszCP
	gZADiRQmQZUtIEHz6S2s6WmaCwlM6+t1WkunacgSOMe6Iz4Z2YXunEI2ZVo34X3AgGv0XUxwirZ
	DOePPMiHYE6Yvx+AdpE8eX+ly2Ttn6R1cr75osGKH86zQ9GGpQvZNorggdz7e6wmShDn7FXA3nW
	VhTZFo63RYKo11SeaotzxS6gP22IxwxejgX1mReg3n/eC7PU9PlgJaEFKkXyhBslQAPxZ9H5Hgl
	iWN6/WHxcxbLuAzuXCs2mBFSJ86cdcPM9UKpVdfKFjbaCWZV9/mJBettlmzHpu6pNGZtQahs6qR
	dK70OaExRv3f/Nk+EwwFLmrDkr2XEiw6IJKEO9PJ6yd37sqTnbsv40QWP/jzkm1dJaAtIiOo7/d
	gFAAtQxXo5qchkK8Mc5FqQlOjEgxRRR7wVUWEtU/T9D1i9MyzhdAk0liZ9gh57LKm1wtPNucxdi
	j58N5BKxU+vemz1nCkBb162aB5enWLd5+49uh/Gr7N8fXJHecN7qGyU0ykCHaR3QssXt1pHd7bF
	P1dyVpXYJPMNsrQzhiUszTKoM+phj9TUMBgHXvu/l1jhJSbUBppPUqCIZFTiVKxK6kaqVXct65L
	SRWWvGYsSwylqBRYgbJBA4Rz4Od1ielG2tvyknrHE3ksBz96EvBTSLP3HJg0UfArQaWvrGqU1u6
	16VhwE7u8UtbieASyg==
X-Received: by 2002:a05:6402:84c:b0:6b1:8316:ba32 with SMTP id 4fb4d7f45d1cf-6b722462bdfmr945767a12.17.1794138455254;
        Sun, 08 Nov 2026 03:47:35 -0800 (PST)
Received: from Desktop (p54afff19.dip0.t-ipconnect.de. [84.175.255.25])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b721ea37e6sm471177a12.12.2026.11.08.03.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 03:47:34 -0800 (PST)
From: Julius Bairaktaris <julius@bairaktaris.de>
To: netdev-bot+sashiko@kernel.org
Cc: razor@blackwall.org,
	netdev@vger.kernel.org,
	bridge@lists.linux.dev,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew@lunn.ch,
	olteanv@gmail.com,
	vladimir.oltean@nxp.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: bridge: fdb: hold hash_lock when an entry roams
Date: Sun,  8 Nov 2026 12:47:34 +0100
Message-ID: <20261108114734.123965-1-julius@bairaktaris.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <179120418105.434549.6770789108608147842@kernel.org>
References: <20261004124254.3525496-1-julius@bairaktaris.de> <179120418105.434549.6770789108608147842@kernel.org>
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

(Resent with the lists on Cc; the first copy went to the To:
address only.)

On Mon, 05 Oct 2026, Sashiko wrote:
> - [High] br_fdb_update() looks up the entry with fdb_find_rcu() and
>   checks it without a lock, then takes br->hash_lock...

Agreed, the lock would also have needed a hlist_unhashed() check. The
patch is dropped: Nikolay rejected the lock in br_fdb_update(), and the
fix moved to DSA. DSA looks the entry up when it handles each event and
so treats a deleted entry as gone:

https://lore.kernel.org/netdev/cover.1794134495.git.julius@bairaktaris.de/

That series also handles the peer-site finding: a "bridge fdb replace"
that moves an entry onto a DSA user port notifies no deletion, and DSA
now releases the host address when it sees the addition there. The
MAB locked-port and BR_FDB_LOCAL findings are pre-existing bridge
issues that it does not touch.

Julius
