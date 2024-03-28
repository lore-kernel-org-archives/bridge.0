Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256DA13A890
	for <bridge@lists.linux-foundation.org>; Thu, 28 Mar 2024 21:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711660070; cv=none; b=o5NW+g7iO8ESaAofeOmCXwczXmOHd/er6EI4A9TApUKI7CHcs+NSl6tGZCxjLsJPq5JuigsaV4JZxkAtYoWPY/tFu2gwEEsbdPIS233Ijfff+kmaWzn29DdzlXLJzdZDAPDH4A7nFPp7LIghYnzKPlluu+vkKtBAkTGXjR8a02w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711660070; c=relaxed/simple;
	bh=TmkCS9jM7MpgxxtIOAWwrufoB48CaCg9AIUTLLa1ssc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ndEE+X4RB+3/0Pgxd5ncyjFR9C9bsyt0gaIKVe4v8QZDIyMFTivguqeseE5ghn6Svaa9V5vaDhdDzFtNZui7rNsVjQ4ItYzT0oXFsmVEC0ytJXHm8u9ZnMXZYnDbm4J5gF9NXOy4V3da1IMf7KUOvbgH6rW1cYcsqWeThxR0QoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=I9Y4jk2f; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="I9Y4jk2f"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B593F60E7B
	for <bridge@lists.linux-foundation.org>; Thu, 28 Mar 2024 21:07:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PzsorpR51-MN for <bridge@lists.linux-foundation.org>;
 Thu, 28 Mar 2024 21:07:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::635; helo=mail-pl1-x635.google.com; envelope-from=stephen@networkplumber.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org B886C60E5E
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B886C60E5E
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=I9Y4jk2f
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B886C60E5E
	for <bridge@lists.linux-foundation.org>; Thu, 28 Mar 2024 21:07:47 +0000 (UTC)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1e0b213efa3so13176205ad.0
        for <bridge@lists.linux-foundation.org>; Thu, 28 Mar 2024 14:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1711660067; x=1712264867; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aoe08oLfHPamqNE7SkYcG+AKQATabTcrNs03hfc/OQQ=;
        b=I9Y4jk2fV4rAHg0X+HqU9O6TiTmy05GjzVzPwtAH24EydVpz485C3Vvg2Gafnf/32u
         UNvOc9jIgBepgPj77NZROLNvAzfvbNWJId8nLr4tEM9MU5f0OfG435VMz9swaXAjbV4+
         khMfrVWGa0pcOkFSRiWaaGmFFNejQ+IzgW8Jx420J5lY0FOYUOidwlRcII3iS5rud9Kf
         NnRiXpaWJK9duYeFJR+sjbDf8Z0NBqTGGKLih0RHGURu2gMxWoWK+IlRVBC93OyLcOrp
         ivyzQ4CvDFdbkXqEHhrqZbZs7xU2iFvYAF8Y4LLvs77P+YbKF/LvSXoPReBIvUMXUaCY
         AJFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711660067; x=1712264867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aoe08oLfHPamqNE7SkYcG+AKQATabTcrNs03hfc/OQQ=;
        b=tA2DnQu4ZDZgcrtpDiPUtH3AIA5qBuX1UnVwErHeNp2BcoqEmCViLbCLWcojhsOfcX
         64TiuH84aip7Nwg5GGewyafXX9YqMRj8yyUYH5Lz0SX0DRCpN2vXrph1VNRhOuKzI4iq
         Wo2yQVZ+pcoc1YkhkG5VP179OeaVqf9dfA7Wa0e/zbLBTNXJ7+8isEm+L9uoNjDIqPqW
         OWh0dBVy74Kp30d4s1N/3WtE3I9HwVFlrG2xmOtl5lUypu1bX9qyHrZB3Z0IQKHSDp6k
         dch6wTv0fyicuws94rKLxAcYN8YWQLu5eQw7WbgtHbZRvRDFJJs1xRKCLf5Ak0/FF6PS
         qPmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXz4Qa2k+YR/N3HvTy0mYujnvADcC3kF2o2t9gfYZUAqHNRZItD3CHVBsTToFkH2PdNQzMD0xO2JEeyf4hhOAh9mVby3Ty5hHFDqSUtf0VD2Vk=
X-Gm-Message-State: AOJu0YyHI05mWUpWIrY+0if9KWlxUymjsbQtdjtju/owTmzkq6/oAV0r
	O+0+FPv8j5Vb4FViVq1VsUdCikKp8/XgGNqYsJZ6KQswQXhNXgD6LXAYn5v9+Ic=
X-Google-Smtp-Source: AGHT+IE7z0/TK1fMFS0Yvk6NaGjSry7T5aLMZtluecZUF0Xx3MLIsDvGnwum9NiAtMXBaJMCr5R7Xg==
X-Received: by 2002:a17:903:555:b0:1e2:577:f694 with SMTP id jo21-20020a170903055500b001e20577f694mr624724plb.61.1711660066861;
        Thu, 28 Mar 2024 14:07:46 -0700 (PDT)
Received: from hermes.local (204-195-123-203.wavecable.com. [204.195.123.203])
        by smtp.gmail.com with ESMTPSA id lc13-20020a170902fa8d00b001e0c949124fsm2073287plb.309.2024.03.28.14.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 14:07:46 -0700 (PDT)
Date: Thu, 28 Mar 2024 14:07:44 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Date Huang <tjjh89017@hotmail.com>
Cc: roopa@nvidia.com, razor@blackwall.org, netdev@vger.kernel.org,
 bridge@lists.linux-foundation.org
Subject: Re: [PATCH iproute2-next v3 2/2] bridge: vlan: add compressvlans
 manpage
Message-ID: <20240328140744.7c98fa7c@hermes.local>
In-Reply-To: <MAZP287MB0503FE53735FD12BD753C328E4362@MAZP287MB0503.INDP287.PROD.OUTLOOK.COM>
References: <20240325054916.37470-1-tjjh89017@hotmail.com>
	<MAZP287MB0503FE53735FD12BD753C328E4362@MAZP287MB0503.INDP287.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 Mar 2024 13:49:16 +0800
Date Huang <tjjh89017@hotmail.com> wrote:

> Add the missing 'compressvlans' to man page
> 
> Signed-off-by: Date Huang <tjjh89017@hotmail.com>
> ---

Marked this as superseded since your previous man page patch is already merged
in iproute2 (not next). If you want to update that send another patch.
