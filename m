Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B122C6A3
	for <bridge@lists.linux-foundation.org>; Wed, 30 Oct 2024 15:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730302207; cv=none; b=VOqvkQtVfrCP09hkKhGmkVPxWIjYOcgCTix5Zrev1LEmytJXLNAQfTXLDJoQ9xS3YtqoE4p4KE5hSuiXwFwuXxTbXydCsCmlELjMBmpriFQVxrWOUGEZH+wE2Q7MRTCEMzBSly6vY/ABCKSvKQQQlCDQzMPpq+IT7ox6zRz+DEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730302207; c=relaxed/simple;
	bh=5CYlU13wxN3pMieiMaGbP1AuRi6+Brw0TcF0hZyJdpU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jbdvpzwk1A7uDNoNCPQULfY0sBhVkRjNB1Fa0o9afUVaNDOT7iTuSQrRMWO9Trn8Za0rdtlPdEvZgeMzGgJiBCXG5eQxDNQTJ2TkbqdbgbzmpskOFr+v8DfT0JjWsWBMNqMWTA+mkUbVac58F87oZv2f5HjOITgtmp5FyE/xPlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=KHmFc2BA; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="KHmFc2BA"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D2591400FC
	for <bridge@lists.linux-foundation.org>; Wed, 30 Oct 2024 15:30:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r3ookygfme4Z for <bridge@lists.linux-foundation.org>;
 Wed, 30 Oct 2024 15:30:03 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::12d; helo=mail-lf1-x12d.google.com; envelope-from=razor@blackwall.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 54AA0400CD
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none) header.from=blackwall.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 54AA0400CD
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=KHmFc2BA
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 54AA0400CD
	for <bridge@lists.linux-foundation.org>; Wed, 30 Oct 2024 15:30:03 +0000 (UTC)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-539e59dadebso8080354e87.0
        for <bridge@lists.linux-foundation.org>; Wed, 30 Oct 2024 08:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1730302201; x=1730907001; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KT1Rl3kTS58mylbtqpSpuZe6eBpuGZzkCTqOtOlKpe0=;
        b=KHmFc2BARWCdHb8+3m4AYPZaovSdtkAbNux0pi+nmKwIgqim+qPm+UP46WryF1qhfR
         XnbZ4hyybMZg+3eL9E4Lv7oJcYPdwVqA5ITSi/4fSPsarW2RADLpPo9dmOLN1i083Q18
         oiPsymHRPeGLgWGZNhbGoFtmMaItZ94LVQ9GCWbpT9HzfvzLVH/vExZm1KBjH34ivpWR
         uq3EXZEtvnkpE8b4q0ppz5dt6LYe9uPFDLgFRPm17mvBrRPvuLSIaaSYkzDzpeykjwns
         l2zqjD9b6ZvUwATHpXnO8+5YQB+2npSj7GNiuPBIOdSCivnfvMGOIO5ejWC/091qiGBB
         141A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730302201; x=1730907001;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KT1Rl3kTS58mylbtqpSpuZe6eBpuGZzkCTqOtOlKpe0=;
        b=K05ORp5Fo4+Q7XgsEIc0HNug1l4G7YN/xpV1fekSVSD+p3jWeTJV6O//4xpmOeLjcL
         0sQ1wd3NmxLZ9ogPGCpZQ50AtvSnaA1EgnGyzwfrzHxFOTRBcrkBxC+DAy/J2I8xIWUk
         LbbfHjlJjcAx6WVS+rWRgfTVwBL6wTjmzLXOf3mGV8smgB5RTkbBy4n2byWfBUXkzdFv
         V6Pmx3hKjwPt759LOw1MWqGRbd2ACFdvFIZd3r7xa3q06IDmYuNYXC2kMC4Guis1yrnf
         LdOSzwibuX2pdaQWdYFl1g5OAGPI7Pc29OQ5Hzcdk9CNBMHMy2NmDpWuAKctV0ISAko2
         SoXw==
X-Forwarded-Encrypted: i=1; AJvYcCU6VUQDnNeALiDwqLIpQ9rJ0xz2EHOVmEPwY4nLC26fNFGA8NJCDk3pZjNaZeeUC4hoZnIQNOQ=@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxJARbNthwfdhXJRPQVk8u6PCpS48X0W5UtwfCMlDoVerh9ng9G
	UhUHOHVFPPtQrBn5oc7dE4icnh5EESHtI9HxIvLr6vR9njsCRJa5x6dsy/T3QlY=
X-Google-Smtp-Source: AGHT+IF06FD68FGsb9Am/OuTmp644K/y7BVoCARZwD3jKU00IF7Zto5FTyTr2w98MzrHnInXUu2BBw==
X-Received: by 2002:a05:6512:6801:b0:53c:7652:6c9e with SMTP id 2adb3069b0e04-53c76526f55mr872653e87.53.1730302200793;
        Wed, 30 Oct 2024 08:30:00 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd98e7aesm24889075e9.35.2024.10.30.08.29.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 08:30:00 -0700 (PDT)
Message-ID: <f4efc424-6505-4e20-a9f2-14e973281921@blackwall.org>
Date: Wed, 30 Oct 2024 17:29:59 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 iproute] bridge: dump mcast querier state
To: Fabian Pfitzner <f.pfitzner@pengutronix.de>, netdev@vger.kernel.org
Cc: entwicklung@pengutronix.de, bridge@lists.linux-foundation.org
References: <20241030084622.4141001-1-f.pfitzner@pengutronix.de>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20241030084622.4141001-1-f.pfitzner@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/10/2024 10:46, Fabian Pfitzner wrote:
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
> ---
> 
> v1->v2: refactor code
> 
>  ip/iplink_bridge.c | 47 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
> 

For the second time(!), please CC maintainers because it's very easy to
miss a patch. In addition to maintainers, please CC reviewers of previous
versions as well.

Thank you,
 Nik

