Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CF32874E6
	for <bridge@lists.linux.dev>; Sun,  4 Oct 2026 21:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791150190; cv=none; b=Uh235cLbq3yixYlHRC9Dz0OKilncHFe3n6Y9lh4tuQQ7lZXWOzN8vwfevo9/5TOhbgjyhyM6OAWWuN4fD4nFLU4GYe7PMwv/6QPyGRlo+CrM94224+qH3ovc+Pct63esYnt95+NBaWrUAnEhXAw8b5KXXQiVpNN3xJQ0Bjq2BbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791150190; c=relaxed/simple;
	bh=ONQ3/fm+VvJcbR2hGlWWmoJvTQ4LkcEql3G60OArTd8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SLQVOVgDTpbKY6Ab4OO3DD5V+CDTIslQXVSODveMOBiYGh1TpIJPpgPV0tUVKcK4D8XsPddQcbDvH/wIhs0QqiyUF783d9AqZcv9AGvJBTCvlJzsO/eo6SLpY9FoAx4cWh+IAeMgjUw7Nnfh+Ezw2oZba6aGZRFKiV3SWty3P7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CgNzEXpP; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CgNzEXpP"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48b03f23305so1027468f8f.1
        for <bridge@lists.linux.dev>; Sun, 04 Oct 2026 14:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791150185; x=1791754985; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=44L+w1lo0aEfL1hM5su/VJjhXTZhdo5HD8XfCtpMzH4=;
        b=CgNzEXpPv/VGrrF9klDtYccJ3xhc+MX4+RjWiHXiK1P030A4rvaCfHsC1+w2KGlP9v
         WSRZtfkcSGVIs72DIVNohwjprWbuq139NnlLbwjp0BiJTtRIrYPWGpfwyBvy4Caa+z6N
         m/eyR030nMV6CqGU0/EMMxH+6C9iT6qe7a4I/JbDWsnlEWnYZoOE+xZZzcyNToAVEZEg
         /MtFCP2lOZet16alqpXxL85iDSqZSOChw4S0xAQF5JpvAOU4hN4Bok2UxFdL6DPKams4
         mgDbDAoOvl1s0kWdTPc9TWFauaHqiMwFmT3y7LrXUptXPp9FN2ZXfeLymrtchUtE1oot
         uXYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791150185; x=1791754985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=44L+w1lo0aEfL1hM5su/VJjhXTZhdo5HD8XfCtpMzH4=;
        b=w8F/8Qx0FVkTE7MiHxZ4kEuBAXDqQSN91Cn8Red+Z1bHbaYvxBeaTrd8k+CJpqIO+m
         tWOwvOl1bOLNT8vHKDcsNnVAkycNkBZhYyELiOTzSOBEIH+O22eJUB32lqX2ta0JxPvK
         1IFxPM/BN0Ba2NVoa+aQ7JH22taj/atbitTczT/V4kMD9xm/fwM4AutTkDVnlOer2mqN
         lmQTMtpCNnOTjvzVdzxH7n1Lrx2R4ILi85BwtQdfbAduCtdqaRUF0TihPRCxD1Jm0RvX
         4V0I99z3ZdjAC1R1gD1zZeJNWaPL+6slGzQ02o5eTWHnH3g8c6Ic4Au94rNaeKZ40KYN
         3H9Q==
X-Forwarded-Encrypted: i=1; AKwUvByEN2wYkuG/tuocxORUOIv6gJYwdJGl9z+JNOD6e1hyn6NlhTKqlkFUpdYZQV6uiZAK+niDW8I=@lists.linux.dev
X-Gm-Message-State: AFq9FYJUx8Osd0PIrJuLv1IT5lA6v8ALbsJ2nnQIBYt0BokCshXBe8nt
	xU9MRVx9W6gaDV4rttueGt8kBeZoN80bbIYmCcj3AJjVTcuHiUbr0yg/
X-Gm-Gg: AYBFou0wn4YMCX+6EDH6rIn/QTABxqjcrRI2SIZWpANhqfAenUul8Urpo9wp6mMUf4V
	7JysLyUnM8jGW86DqGcvZztHmAqd5ltVabBThvo852EXprTTqkymbmcZfRcG3Yh96t8jQXQvjB/
	B4QnGCScZQb/oQ0OM+kFvGdExju4AHE9z6/SDCUbobidsB6+KA/vBqcpXezP0swjYYEbQiKCqgL
	mo8WY/u0pPUM1EppZ9ZmxomgtfkdTeXPLFhTcPpB6LlUMpeG7XULe9XtO1pj+Hj22vlWvqIqg+y
	SmwmR2gWmPvfdyDgPXyw+2wJ59AZd7mbbd+ocM8xGyf6ihYRfCzFotuPfNsYuY2Cg8pCQgVptWv
	bZTGrV17Dyfipz7RVvSzxOqN9tCXUxvNLLfqtODXxmDdNWqk6i8vGET5/2yodo5y2WBREJRZ8B/
	qKOvj+wxsDfhfMGvtN9CvCeGcjznJBXiNDU0hq4kI8V3n6ElXL0ron2n3pBpZxuQUwUWsD3/RMB
	s/2Md6nQradwZGZU6Th685X2m/EzlLF4dpEPztoJz296/Y+5a117K09dFqt
X-Received: by 2002:a05:6000:491b:b0:487:834:9307 with SMTP id ffacd0b85a97d-48c48023772mr8504789f8f.50.1791150185325;
        Sun, 04 Oct 2026 14:43:05 -0700 (PDT)
Received: from andreayoga.localdomain ([195.122.200.174])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b38104e07sm19331801f8f.31.2026.10.04.14.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 14:43:04 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: netdev-bot+sinfo@kernel.org
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	netfilter-devel@vger.kernel.org,
	Phil Sutter <phil@nwl.cc>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Bernhard Thaler <bernhard.thaler@wvnet.at>,
	coreteam@netfilter.org,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH nf v2 0/2] netfilter: preserve bridge egress VLAN tags
Date: Sun,  4 Oct 2026 23:42:51 +0200
Message-ID: <20261004214253.5432-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <179114935323.1402591.1020652042294576959@kernel.org>
References: <20261004212429.3648-1-parri.andrea@gmail.com> <179114935323.1402591.1020652042294576959@kernel.org>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, Oct 04, 2026 at 09:29:13PM +0000, netdev-bot+sinfo@kernel.org wrote:
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.

The issue fixed by the first patch was found by an LLM-assisted scan of
br_netfilter. The issue fixed by the second patch was reported by the
Sashiko AI review of v1 [1]. I then confirmed both with a reproducer
under virtme-ng; the reproduced symptoms are described in each commit
message.

[1] https://lore.kernel.org/all/179084999520.434549.4764913674478855382@kernel.org/

Thanks,
  Andrea
