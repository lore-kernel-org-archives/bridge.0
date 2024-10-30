Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5899213120
	for <bridge@lists.linux-foundation.org>; Wed, 30 Oct 2024 15:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730301795; cv=none; b=otB122AQLj/nmC/lf97cv3zmMUp4BPwNVCDy0Ncp0clUIR6B7H5kYkGOdvXwbSmqKEjxZxFMdVzSOZs5DmRtdjpKIs5ZqAuZj8O2/G52CYpcg5n8spbcuwnQEi3joOnLsl6fdPLMPa982zUCZNvbGUoZLUgk7LAA+7qaH5BNo58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730301795; c=relaxed/simple;
	bh=iu+F0QpBpIymx9Mb8vWJMs1rMDhvYv026jUBdr892qs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cPSg5gFYujvfGge5LGQR2ljsmuMBrwy7hHDRv2GV7ccq0iaTiqy6HgrCxmYs9zUXxJ22tBB52oMjesLQnx0Hnjbdp1oMBPklo81ZDTSQg5uTMS7miWSlCBRUE+S5gef+S3V2qlW+SjGS1C4T+QThA2eYd0ZUWXZr/RgmEu/DvjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=IFn6VTHf; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="IFn6VTHf"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 529CF608C9
	for <bridge@lists.linux-foundation.org>; Wed, 30 Oct 2024 15:23:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id enmt8HGJuxwA for <bridge@lists.linux-foundation.org>;
 Wed, 30 Oct 2024 15:23:12 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::102f; helo=mail-pj1-x102f.google.com; envelope-from=stephen@networkplumber.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 363B0608C4
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 363B0608C4
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=IFn6VTHf
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 363B0608C4
	for <bridge@lists.linux-foundation.org>; Wed, 30 Oct 2024 15:23:11 +0000 (UTC)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-2e59746062fso5498510a91.2
        for <bridge@lists.linux-foundation.org>; Wed, 30 Oct 2024 08:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1730301791; x=1730906591; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OP44vKkaZ8TCjJgk08P04GYCIsessEUnYhYzif9jznA=;
        b=IFn6VTHfliEufr6z/qaYYA6TBEsUtFu4UNK/f+4Ed/M/4VO7/KTtRKcJGGBm23b1pT
         nzigUHZQxdW7b8uPfSQIInD6xqKDNImKYrHEAVR4SOHZhhu5KugZNRopeRdgg3srVv0+
         w2vuWGzP0CAGsy+DYrTv66eKOQeLmhcnnSkFnTt5xVmb5I2JGSyV8vLQunimpthyBBWn
         1cZ7Zf0PIAGT0WLOoZdGUwqtP0C8ZLuLf7K0W19bNUug2W5THW1aY9ys8LuaW7S3oe8u
         YOSWfjf5KjxGiZ7accjlWw/71iDdTvSo6YZvV++TQ4g+Nk3szUlq+GUOko22iCrp2dFe
         7/hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730301791; x=1730906591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OP44vKkaZ8TCjJgk08P04GYCIsessEUnYhYzif9jznA=;
        b=SeTYwmRWFcUXWHtR67hCxbY+04dvFB7fQ3HIj977zr0Jbuld/Iia2WLA0975MbPyXg
         TQGNS0pId7poqCQUmjiXH9eNf0m3rb9s6H9PsrG6qPdK2hSTjwmmpq0yxUvHZjayMBCD
         S7NiAXEtw+DJuLi7CvJThH7Z7I0X15UJbJM+7DQW53ibF7lCRbQrrAtgL+p1bKXH8GZn
         iJKKVLFOSlD3kmVOpxX4gt44Sgi7cyYTlHHUIiHbqwc82o5RdQxgkWG8v8vNRdiaRAj5
         BvPie/iEoBQY4PZ6+PW2WQ6qvV0s3UcNGrUKzniiyeEPfrv3TPp1D8bGWmpPefrmwWTr
         s6yA==
X-Forwarded-Encrypted: i=1; AJvYcCXJTvpVgzno/fEVRjj08xFaImzXUJskQM+aMZ9JVbvjv4F69i43dLIaEJXIPQ4ZDaxKoUJ8NO8=@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YybvUN/lTez8K33IGLXJieXT9SuH410z9DcV6ggAhLnhep2wfsM
	BxkePP5j/xEmQoZF6LAsGM/N5oRPjBDTBTeMeTH55jOYX8Cp/PemqiAYB4QCQbA=
X-Google-Smtp-Source: AGHT+IEiSInTP/WgvB8Iwxew4lGfgEKdPRUEJ92Pl9krgZVcbbPzoI8dAQK1wjwjKybWxRsz8OJ7zQ==
X-Received: by 2002:a17:90b:360a:b0:2e2:b64e:f501 with SMTP id 98e67ed59e1d1-2e8f10a6d2cmr19546145a91.30.1730301791303;
        Wed, 30 Oct 2024 08:23:11 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bbf6d327sm81955795ad.67.2024.10.30.08.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 08:23:11 -0700 (PDT)
Date: Wed, 30 Oct 2024 08:23:09 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Fabian Pfitzner <f.pfitzner@pengutronix.de>
Cc: netdev@vger.kernel.org, entwicklung@pengutronix.de,
 bridge@lists.linux-foundation.org
Subject: Re: [PATCH v2 iproute] bridge: dump mcast querier state
Message-ID: <20241030082309.44fe54d1@hermes.local>
In-Reply-To: <20241030084622.4141001-1-f.pfitzner@pengutronix.de>
References: <20241030084622.4141001-1-f.pfitzner@pengutronix.de>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Oct 2024 09:46:23 +0100
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
> ---
> 
> v1->v2: refactor code
> 
>  ip/iplink_bridge.c | 47 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
> 
> diff --git a/ip/iplink_bridge.c b/ip/iplink_bridge.c
> index f01ffe15..f74436d3 100644
> --- a/ip/iplink_bridge.c
> +++ b/ip/iplink_bridge.c
> @@ -661,6 +661,53 @@ static void bridge_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
>  			   "mcast_querier %u ",
>  			   rta_getattr_u8(tb[IFLA_BR_MCAST_QUERIER]));
>  
> +	if (tb[IFLA_BR_MCAST_QUERIER_STATE]) {
> +		struct rtattr *bqtb[BRIDGE_QUERIER_MAX + 1];
> +		SPRINT_BUF(other_time);
> +
> +		parse_rtattr_nested(bqtb, BRIDGE_QUERIER_MAX, tb[IFLA_BR_MCAST_QUERIER_STATE]);
> +		memset(other_time, 0, sizeof(other_time));
> +
> +		open_json_object("mcast_querier_state_ipv4");
> +		if (bqtb[BRIDGE_QUERIER_IP_ADDRESS])
> +			print_string(PRINT_ANY,
> +				"mcast_querier_ipv4_addr",
> +				"mcast_querier_ipv4_addr %s ",
> +				format_host_rta(AF_INET, bqtb[BRIDGE_QUERIER_IP_ADDRESS]))

Would be good to use print_color_string here. 

