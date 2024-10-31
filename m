Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A434689
	for <bridge@lists.linux-foundation.org>; Thu, 31 Oct 2024 00:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730335525; cv=none; b=RiIlyrCyovdI/+zgNu4gKXWfX4RuwBIJCa5N2TTW8v5IA+BVYvd/ngPsxxWeLyo5Y/rv19aEPfAhLbtvkrUCbeNQ0m3jD2IkqxlgQBatyMMK3dYqs9c5jjuckFN+KPmfPTfzj4s0ku43Xb7Dc4VZXPNB+qyHfNPLdk5iD5DUAPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730335525; c=relaxed/simple;
	bh=DlNwPIxvoDePtUKHBG/Dt1fSWAKy9cm1/TEoVetVqZc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cbfdnMGCeITCVIZIHeKEJWj2RNDiIGCrzu6hNb7Pdk8WmB/nxSdyG7xWMFwjqT5FTtC2x/wv/89iu6SI/1qPaabMXIOiqrs8Tl6DciDgWGYt2dHd+9z9WT+SfsjlPqXKiYs1dF04AVJ9rnJCXLVDdF4e1n8Lx318Dyh2ezU1798=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=WQrEB8qm; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="WQrEB8qm"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BC9ED608E8
	for <bridge@lists.linux-foundation.org>; Thu, 31 Oct 2024 00:45:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VQxpnx4AREDl for <bridge@lists.linux-foundation.org>;
 Thu, 31 Oct 2024 00:45:21 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com; envelope-from=stephen@networkplumber.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 7C452608E7
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7C452608E7
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=WQrEB8qm
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7C452608E7
	for <bridge@lists.linux-foundation.org>; Thu, 31 Oct 2024 00:45:21 +0000 (UTC)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-2e2bd0e2c4fso345670a91.3
        for <bridge@lists.linux-foundation.org>; Wed, 30 Oct 2024 17:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1730335521; x=1730940321; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sUD0KPvqMk9qfe6LI5x/QFIzi9ou2XERMnVYjUAAYzs=;
        b=WQrEB8qmPkzuCXL5aMP7hp+HbFFIXMJeyDgAa5JdlIF0c4hCvnoWDDOYRiZIFjtESj
         zZlZd3e8ap51saO8rGVQF+XZGPJ9h9VC5r92mLB/plRcS+TJI2vSaC5JToIh8oCPejmJ
         S4ud8t3s0/7ogkMdsx06NXnXkoKoE6hQ6bMQiGunK5rra+rNendKLUhlSYpRLxtZ7J49
         mi1tZ2WBp3x/Luj2aHnxCMlGygtUOp1ggI2OTYvlkry1BvcO2G84/BLp8n7RAp/6VsIc
         Rtm0aAy9DDdJ+Jng0i21jK+2nOJF10+GJ7kiDCRN8bYE11gRGB2OdaFW0glnLmg1V7pr
         kJlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730335521; x=1730940321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sUD0KPvqMk9qfe6LI5x/QFIzi9ou2XERMnVYjUAAYzs=;
        b=eDGO8HK5c2izLEjUOxNnevGWFuiuR5ZoqE6toIloxsH0j7tcCePMkjUP9V/jjtQQvO
         KsakxWbJeM6D6If9GzqFM7rTfFxjkfm+8fMp2ZcLrWshd/quZAP/clKGzGctS+jqdYkX
         p2eI789T3+Ukb5yLpPi9lUFa2Yyp5n18irgtTxB/GSydpQBbRFgQUFc8S/r6PLiAd8Xz
         uNQfxwCWjX3nBSA35JFyURy1lwMg/xhWRkrdu/yarGs4o5+IQjXx1TvCnafhfSjENBZA
         et7kdM+tK8j9L0pxB6S9AcoejF0CDlGVh0QrXk6rtvG3oXX/yE1v80N830U4hhUIQtMH
         Ut0A==
X-Forwarded-Encrypted: i=1; AJvYcCUxld88NAWlMXcTJ3V0YV2xSo5QeLiFcjoFk6YXA63PypJG39T4mm4knyWbGwUaywNcLfb11Ys=@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yy4oIALg1iHvZolWirg5kgshWKTY81k3BDLCeR3uIlGeLRKnAm9
	BGuZD3IgSieS7li+trcwLamsgVzJrr2J/4NgOPUKD2n5+W2IS8H61wVOYoY2mAE=
X-Google-Smtp-Source: AGHT+IGVdwehaCX4ipap+FU6VthaUmmb1Nw+SpydfSQKG1Qps6M11BqXxxDqZrDRF4J8WonCbKYnbw==
X-Received: by 2002:a17:90a:e7ca:b0:2e1:a81f:5520 with SMTP id 98e67ed59e1d1-2e93c158c64mr1960415a91.1.1730335520616;
        Wed, 30 Oct 2024 17:45:20 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e93db4296bsm286596a91.48.2024.10.30.17.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 17:45:20 -0700 (PDT)
Date: Wed, 30 Oct 2024 17:41:40 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Fabian Pfitzner <f.pfitzner@pengutronix.de>
Cc: netdev@vger.kernel.org, entwicklung@pengutronix.de, dsahern@gmail.com,
 roopa@nvidia.com, razor@blackwall.org, bridge@lists.linux-foundation.org
Subject: Re: [PATCH v2 iproute] bridge: dump mcast querier state
Message-ID: <20241030174140.4ef77885@hermes.local>
In-Reply-To: <20241030222136.3395120-1-f.pfitzner@pengutronix.de>
References: <20241030222136.3395120-1-f.pfitzner@pengutronix.de>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Oct 2024 23:21:36 +0100
Fabian Pfitzner <f.pfitzner@pengutronix.de> wrote:

> Kernel support for dumping the multicast querier state was added in this
> commit [1]. As some people might be interested to get this information
> from userspace, this commit implements the necessary changes to show it
> via
> 
> ip -d link show [dev]
> 
> The querier state shows the following information for IPv4 and IPv6
> respectively:
> 
> 1) The ip address of the current querier in the network. This could be
>    ourselves or an external querier.
> 2) The port on which the querier was seen
> 3) Querier timeout in seconds
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c7fa1d9b1fb179375e889ff076a1566ecc997bfc
> 
> Signed-off-by: Fabian Pfitzner <f.pfitzner@pengutronix.de>

Use print_color_string for printing addresses; to be consistent with other code
