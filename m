Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDE2210F8
	for <bridge@lists.linux-foundation.org>; Fri, 22 Mar 2024 09:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711100459; cv=none; b=gepE6GRjzLo142NJTST0yZ7M5gV5+0Xihiw5ahC0JN9yYZI22zK7rC3yYvBS0dDTwzK9+M++Sh7AOHsSnG0wUwhuiT7AUi5bFKrcwS3g6epOu7Sldvo5QvWH4pho+C3LnuOJkaiktsgWUu4djCNji9QsJU3FcrvRuXZK+6/OKHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711100459; c=relaxed/simple;
	bh=wHl8vui89YbwiD1z9uvsu5ZySjOCx+53uqMcWz3icBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sZLuBX++7SGyvgfKgw2cOs7fwwATgXn69o7xsG9AHrZaeMxtfkANF6UyriKTCZcoQcNmaeJv/eMU4cDF+9Gliwt5Op8teYcD7zGqgszOiYrnF8xRvuTJdHrQQ0KtmAh6QaOCejYhiuZ7q6gSv9lHvoXsLY9cNZEHNc0VQIE3JIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=RSTPG8lp; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="RSTPG8lp"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1FFCB60EB6
	for <bridge@lists.linux-foundation.org>; Fri, 22 Mar 2024 09:40:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aEv_-y8bBLws for <bridge@lists.linux-foundation.org>;
	Fri, 22 Mar 2024 09:40:55 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com; envelope-from=jiri@resnulli.us; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org B39ED606CC
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none) header.from=resnulli.us
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B39ED606CC
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=RSTPG8lp
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B39ED606CC
	for <bridge@lists.linux-foundation.org>; Fri, 22 Mar 2024 09:40:52 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-41468f6d584so14064945e9.0
        for <bridge@lists.linux-foundation.org>; Fri, 22 Mar 2024 02:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1711100451; x=1711705251; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kyKiO2Vj+ML9FOel7cGcYwp21WMR0LrM/tgUEPI6Y4E=;
        b=RSTPG8lpFBlwfv8/dLM1M33M1xBy9ggUL4qQuOMBKUSaT1TzrX/oik9tb7uvxxxLXp
         by4H+4s7Et0jL9MR4dt72IAp8hy1lVaqLXCiM4BxSda5t7s8GALJABcTPCSuFcwA+t47
         eQXiPkC8dXXU6Dtmg4mNcXp2BmTTVCSgqGGT0OFvjfKGL1NwWagoQWZ4G0WiwfjB2kse
         fH8836RVeSUVYX0USkD67X972mMmfPifPrESrjjA84uyzlogr5KyLp1SCTjzHwQMP26l
         6NNXWFGddzMZYhfQMyWK3/yJGyMAxdXqwlX4QDDAZ93g6G37k0mAhI+eN1u0neIiO01q
         s40w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711100451; x=1711705251;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kyKiO2Vj+ML9FOel7cGcYwp21WMR0LrM/tgUEPI6Y4E=;
        b=WDWHoksoDBkZpHC9QKas3gYr1eON2+iZ1HdXF355+R3G9oS9JgQkAw3ipnialILdbl
         IYdMcOFNqT0bIgX6LYWw+Oi+3y/SfnJWRMOEz/kHDwRvv/E8GgvjFL4PPN5jxVGlihYJ
         RkOf0oigMP/OFQ2wvu7rf3Vqg8TFFvvzPQ1Hdy5tS2aonpG1SVef4aS3dQuPqEqIsvlv
         2+mNd38JLkn9htl8dt34ufXwejqHGQWNYLevJWiGOoK+MP8WdvR/x917eRbDS0ltpzUi
         SQqIDXBewqnxz8kd72AEMZCPG078g6vksAD3Z11TRsQ+k6CgC0wern0Htlzv8kOO0h1e
         r9gw==
X-Forwarded-Encrypted: i=1; AJvYcCWgQQd8QAjH3y6f5TzBW6TFvdrFnm0Dv+RcgWyBXTeUkg1V1c4fRXhBvf4vj4C1IhYo2iG5ILH75TH0vfwkhtKWWQXVOL6jtOE6ES4Zq/C+N7k=
X-Gm-Message-State: AOJu0Yw2DqEUcgucp6mZxF2X/VlVnb4hRjVCtpudJM9hz3+HJ4+5ErGD
	5ACoPW6ojta6T1iXKjKd8HB6AQGxF8rkiF+CO361CkeNFVOohC832x37AT3DAjE=
X-Google-Smtp-Source: AGHT+IGqHip+JS2pa8/GSES8Ac7KwcNaaejk7Lf9W9r3Xv2znkC9L66RhStPkDXM5V/GQOd6VE/YSw==
X-Received: by 2002:a05:600c:458c:b0:414:7431:6983 with SMTP id r12-20020a05600c458c00b0041474316983mr1072784wmo.25.1711100450943;
        Fri, 22 Mar 2024 02:40:50 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id fl21-20020a05600c0b9500b00414674a1a40sm2522768wmb.45.2024.03.22.02.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 02:40:50 -0700 (PDT)
Date: Fri, 22 Mar 2024 10:40:47 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Date Huang <tjjh89017@hotmail.com>
Cc: roopa@nvidia.com, razor@blackwall.org, netdev@vger.kernel.org,
	bridge@lists.linux-foundation.org
Subject: Re: [PATCH] bridge: vlan: fix compressvlans manpage and usage
Message-ID: <Zf1SH2ZVfBG6O2EE@nanopsycho>
References: <MAZP287MB0503CBCF2FB4C165F0460D70E4312@MAZP287MB0503.INDP287.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MAZP287MB0503CBCF2FB4C165F0460D70E4312@MAZP287MB0503.INDP287.PROD.OUTLOOK.COM>

Fri, Mar 22, 2024 at 09:56:29AM CET, tjjh89017@hotmail.com wrote:
>Add the missing 'compressvlans' to man page.
>Fix the incorrect short opt for compressvlans and color
>in usage.

Split to 2 patches please.

Please fix your prefix to be in format "[patch iproute2-next] xxx"
to properly indicate the target project and tree.


>
>Signed-off-by: Date Huang <tjjh89017@hotmail.com>
>---
> bridge/bridge.c   | 2 +-
> man/man8/bridge.8 | 5 +++++
> 2 files changed, 6 insertions(+), 1 deletion(-)
>
>diff --git a/bridge/bridge.c b/bridge/bridge.c
>index f4805092..345f5b5f 100644
>--- a/bridge/bridge.c
>+++ b/bridge/bridge.c
>@@ -39,7 +39,7 @@ static void usage(void)
> "where  OBJECT := { link | fdb | mdb | vlan | vni | monitor }\n"
> "       OPTIONS := { -V[ersion] | -s[tatistics] | -d[etails] |\n"
> "                    -o[neline] | -t[imestamp] | -n[etns] name |\n"
>-"                    -c[ompressvlans] -color -p[retty] -j[son] }\n");
>+"                    -compressvlans -c[olor] -p[retty] -j[son] }\n");

From how I read the code, shouldn't this be rather:
  "                    -com[pressvlans] -c[olor] -p[retty] -j[son] }\n");
?

> 	exit(-1);
> }
> 
>diff --git a/man/man8/bridge.8 b/man/man8/bridge.8
>index eeea4073..9a023227 100644
>--- a/man/man8/bridge.8
>+++ b/man/man8/bridge.8
>@@ -22,6 +22,7 @@ bridge \- show / manipulate bridge addresses and devices
> \fB\-s\fR[\fItatistics\fR] |
> \fB\-n\fR[\fIetns\fR] name |
> \fB\-b\fR[\fIatch\fR] filename |
>+\fB\-compressvlans |
> \fB\-c\fR[\fIolor\fR] |
> \fB\-p\fR[\fIretty\fR] |
> \fB\-j\fR[\fIson\fR] |
>@@ -345,6 +346,10 @@ Don't terminate bridge command on errors in batch mode.
> If there were any errors during execution of the commands, the application
> return code will be non zero.
> 
>+.TP
>+.BR \-compressvlans
>+Show compressed vlan list
>+
> .TP
> .BR \-c [ color ][ = { always | auto | never }
> Configure color output. If parameter is omitted or
>-- 
>2.34.1
>
>
