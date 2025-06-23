Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DAE231A32
	for <bridge@lists.linux-foundation.org>; Mon, 23 Jun 2025 09:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750669625; cv=none; b=ndbzGhnQqP7kQY/LctxU82bP/7hER4KZX7ZC1idY5APwWmsW9WFFDETLCywwdX6gALOvi1VsVICBKAGx3M8uRMYWUsIugJRUNRl7D/C7Isiz7G8z7P1r3tAQ+3RHIhOuWjsXjGC2u4wBelk1PYtDeuysHnFOWGD+IxLtObGT4xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750669625; c=relaxed/simple;
	bh=EflMIV+kkp7UhsZ9tUS4w48sTU3134OYm+F+GPclhF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MztBL4DduGYuV0DzLCjM4Vf75UMGyozxk3213IG3vz3HmKvpkDVoHobxbVJQzXXC3vKNkI4SvViSDqFCxzLBfVZg9+XYwDkHSYlpkIXCCzvKXTmU6Jucxb8RgAudHgytUCQxEyt5mnBREsGKsG/LJt4kfCoA+rOJ9C/3X/PiRrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=ezdo3iC4; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="ezdo3iC4"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 52FB240209
	for <bridge@lists.linux-foundation.org>; Mon, 23 Jun 2025 09:07:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MXnHWaVWX7nA for <bridge@lists.linux-foundation.org>;
 Mon, 23 Jun 2025 09:07:03 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::52d; helo=mail-ed1-x52d.google.com; envelope-from=razor@blackwall.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 612E840180
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none) header.from=blackwall.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 612E840180
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=ezdo3iC4
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 612E840180
	for <bridge@lists.linux-foundation.org>; Mon, 23 Jun 2025 09:07:03 +0000 (UTC)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-60789b450ceso7588511a12.2
        for <bridge@lists.linux-foundation.org>; Mon, 23 Jun 2025 02:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1750669621; x=1751274421; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mwpLh1YokKB/zuRQcdVqUx5WgOSKBlw+lHCDlHkU3ak=;
        b=ezdo3iC4Ily9lpsDk7Eh7Wsy+Ph9i15Sz7Mj4bAz9tdu4BjLx9xz20XZnP0WGbDk5z
         HDOSmsdbxCNlLlWC9kXY+gudUcQag3zcpezHMRJ7H/EYxtS69tJjeQ0Fl+m/keM5lXsD
         j8kwTXuYr7duB9lHekZeOMWjlqCNrTXfL92XhPFivw9sia0HJlIu+cRRZjMeenk6As5P
         VkYSLvDrp4lzSE25f6mvICFsGGNgGQX/thqh7GRQl5utRnsth8U0Vep1Fs0sK5nK5MJc
         ywIg31NgjY6IL9PmjiHnv3CyFu+aYNz+ZVIXmqcNEGDeylksFObXjXBMpVrHQGalDVbu
         aQWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750669621; x=1751274421;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mwpLh1YokKB/zuRQcdVqUx5WgOSKBlw+lHCDlHkU3ak=;
        b=UerzQWMo4ADA8aCazx/ePdEjG0sz9LoY/obbMCoIo8JOhXc74R5lmN1T/bN2IcINwG
         xzs6bT0sshRkel/uKjL0qS1HcfMAZV4jKcF+ljxoebT2wXYBPTDsf4xbzjey7YTjA2X5
         FJkpigOW5EbonsYmN406/M2uJKQz+4K5Ww9TBIMuPtyoa0Wba76Y6w6Ne0qcEBFToCPr
         omfmgXYCpBT0DeJAi6brFIrA8QZwGzcS8ims2PBf0KZqWwZ2EPTMj4pLQSMyRTImZ6Um
         xVsjGXBUSN0ik0aibgdkYsta+O4mgNxVxokFv0d3xrxwHyNhNk28ytvLsX8i5Xfuoeks
         DgZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqAOynsPW2MhXdBW4N1ZmgQOnxDv0z7HYCxVxQVuVUrO74X3b4JjHNR927eMdSrQ7Qm+cvqKg=@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yw+P9/OFJr7O8pg+HdrwrDA73PPcziJkPlG/GFwcD/XBSIss0hW
	aW6nQQgVEBQahjVu3UbNlNT5o37Bj5TkQg1vcZAO34u8gV0Asyobbnq0830Vb+VE0Os=
X-Gm-Gg: ASbGncsJe/+HgKBgPf7AHv/B2L1pvY2zaBc6TKLZqSVpID1f04zunY/n2DtBWcI3edD
	qQm7qt0WPEofZlk46rLo9aGFqWgoqkWhJuQxfUQh+sKPTRDWZJcpIU88rZz6RSTb+bPmOK/7duj
	hZvFExWUkwtEbcBjzWmZmqHSigkwJf5RvE4AertQcocbq0fLC7pmfQ6uUuCuX355AdntOpMUyTE
	ALRSRlMqdQaXmj3Duy5LrtpWeyuCIwjI4h630/UywNkc3Z7gm7UNtdHVR7UsZhJfU6uYOluJEpq
	sC/zTfeuJl8hR9NZeuEZBGe0rGqHf3sERH9967JTcsZljxZR+FRZge7qznATRPLWOn1qd6RH5ia
	BPmrSVp1Y9i/NkmU4oA==
X-Google-Smtp-Source: AGHT+IFoNeREHCLZ5lXZKiX4iyr7z14GOgxcoVyAK+9phPgUtXE2KzB2nCOBwExmYB7dNfFG0ZnKiA==
X-Received: by 2002:a17:907:7fa7:b0:ad9:db54:ba47 with SMTP id a640c23a62f3a-ae057f65a32mr1036698966b.43.1750669620951;
        Mon, 23 Jun 2025 02:07:00 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae053e7d1basm671019666b.25.2025.06.23.02.06.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jun 2025 02:07:00 -0700 (PDT)
Message-ID: <fe7f1941-77c5-41a7-b892-ec4f42d45e9f@blackwall.org>
Date: Mon, 23 Jun 2025 12:06:58 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next v4 2/3] bridge: dump mcast querier per vlan
To: Fabian Pfitzner <f.pfitzner@pengutronix.de>, netdev@vger.kernel.org
Cc: dsahern@gmail.com, idosch@nvidia.com, bridge@lists.linux-foundation.org,
 entwicklung@pengutronix.de
References: <20250623084518.1101527-1-f.pfitzner@pengutronix.de>
 <20250623084518.1101527-3-f.pfitzner@pengutronix.de>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250623084518.1101527-3-f.pfitzner@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/23/25 11:45, Fabian Pfitzner wrote:
> Dump the multicast querier state per vlan.
> This commit is almost identical to [1].
> 
> The querier state can be seen with:
> 
> bridge -d vlan global
> 
> The options for vlan filtering and vlan mcast snooping have to be enabled
> in order to see the output:
> 
> ip link set [dev] type bridge mcast_vlan_snooping 1 vlan_filtering 1
> 
> The querier state shows the following information for IPv4 and IPv6
> respectively:
> 
> 1) The ip address of the current querier in the network. This could be
>    ourselves or an external querier.
> 2) The port on which the querier was seen
> 3) Querier timeout in seconds
> 
> [1] https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=16aa4494d7fc6543e5e92beb2ce01648b79f8fa2
> 
> Signed-off-by: Fabian Pfitzner <f.pfitzner@pengutronix.de>
> ---
>  bridge/vlan.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/bridge/vlan.c b/bridge/vlan.c
> index 14b8475d..d2770eff 100644
> --- a/bridge/vlan.c
> +++ b/bridge/vlan.c
> @@ -852,6 +852,10 @@ static void print_vlan_global_opts(struct rtattr *a, int ifindex)
>  		print_uint(PRINT_ANY, "mcast_querier", "mcast_querier %u ",
>  			   rta_getattr_u8(vattr));
>  	}
> +	if (vtb[BRIDGE_VLANDB_GOPTS_MCAST_QUERIER_STATE]) {
> +		struct rtattr *attr = vtb[BRIDGE_VLANDB_GOPTS_MCAST_QUERIER_STATE];
> +		bridge_print_mcast_querier_state(attr);
> +	}
>  	if (vtb[BRIDGE_VLANDB_GOPTS_MCAST_IGMP_VERSION]) {
>  		vattr = vtb[BRIDGE_VLANDB_GOPTS_MCAST_IGMP_VERSION];
>  		print_uint(PRINT_ANY, "mcast_igmp_version",
> --
> 2.39.5
> 

Same warning here,

WARNING: Missing a blank line after declarations
#112: FILE: bridge/vlan.c:857:
+		struct rtattr *attr = vtb[BRIDGE_VLANDB_GOPTS_MCAST_QUERIER_STATE];
+		bridge_print_mcast_querier_state(attr);

