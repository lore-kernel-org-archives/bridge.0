Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839F113B297
	for <bridge@lists.linux.dev>; Sat,  9 Nov 2024 13:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731159132; cv=none; b=Lefr1SPjpcUQvyrmjptSXYfjJiaDn+HYADRSJNQwPD8fpg/bF0AK+9kRJ1uC3+FyxRZEV7DskZDw4W8/LWqnuB6Cq89VOoXFNwQ/8WFvCVAWU6BWRdCcxaWngEjIRCCB50jqDxXgg256KdFs0a4hiETHrLBTKwRufKa1uVSXHWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731159132; c=relaxed/simple;
	bh=32gf9hT995PQq1aAYXY53/SFI2peqGmru9vlcv9S7mk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rcnbp+/5iPzThu2cfFUqkkHpCAglLHTwphtpguGou3Obe8Nj8vyCjd1a2zH6735ozvyfaXRIRQDZgsDxTi//xTiicvuFBcY1WMFDtMsEyhVmtB2NYPFleMdrnZebmFJNQdTBCyoBRh0d49ZMAPDi0MSl+S6cqSiydlzFIB9pbGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=cPTCSpRL; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="cPTCSpRL"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-539f0f9ee49so3643317e87.1
        for <bridge@lists.linux.dev>; Sat, 09 Nov 2024 05:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1731159128; x=1731763928; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aPkYK2jE6W+k/K+5sgYeu+6Wgp1BX3wJYLP9Zc4crPI=;
        b=cPTCSpRLRXs/0d+MBqZL+HvNE+Ze/r1UkMF0gBRmcwJ9mpHbj5/RJo5hy1DuphUfRU
         /9hUZunmeBtu8PUwnB06c9lP2rHYdQUONklbZX6xwHPzyZ7zJSqtq+3L2tRbbE8RcTdM
         49YoRRJvNdtwQXDLhe/uNaHoAHSLlhGAM9wkmV5M+YbPlKG2oHOQA9C/zenBQC8T0nZf
         8IRfra67eM/NDKbypkN67q9VUmt83BPXhAaCAzr99m1E5IRGVyqMcCsWE3LRYDmtEPpV
         t/iSKJB1ysYH1bOj6tSwDVbqczp0RnrLMFt/G5XriR95ay8Ck/qfzsavlaeHJLPSvMrO
         5ocQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731159128; x=1731763928;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aPkYK2jE6W+k/K+5sgYeu+6Wgp1BX3wJYLP9Zc4crPI=;
        b=pinOpKJkoqwyegvPxF8uRHx/Yf2X6RAJurze631vrYnsdt/Q3Y4xfD+8TpZZzgbJx+
         EDCvf4nafTedpbJ6AO9XKy57yFEFb2wIPeuoq7RFE3qgVWCpJX5CSVebrTYvVG0rJ3T0
         f/dmsrVHJuie+cudpRRhzk6GBUeOsMGn5hyOjQkcBfguGDfs+EcCeerSFeoxZmhJHVgf
         o1WouGNMVzPVkloDhMh6hOAdFdrWS25xJZOPrR1+i6UDbdAK8KvXFhjXtWxyqUfq8GAc
         VB2GBpFg+4j05iJZjknhB426ERU1oWzxNs4Zst+4VluJcO9KFX4IwSFjKN3bpBs2DMhD
         b5AA==
X-Forwarded-Encrypted: i=1; AJvYcCWdw3k1ugBo4uPtGpCe6pBxII/QIW0vlfu1GI7pWwFDXCIf7gdspopcKeWcK2dpTpqhG1HAa+4=@lists.linux.dev
X-Gm-Message-State: AOJu0YzknT5cnp+s/iz6qmcC5AVDooUeadwK0H56ipTQPQlk+ynlVSJe
	L7SFj4Uw0KJOVeryOhEI5BZ12TMC9QsP8wdBTtdiZaQ4/QMy6VzsdVgGcKG8ZMg=
X-Google-Smtp-Source: AGHT+IGj0D/6yjP10y7ie3xxsGiYheBK1EFju+ttcIftGp5WJQJIP4vfOq3SOeC0NwuE0PHhvjMsvg==
X-Received: by 2002:a05:6512:3f05:b0:539:fd1b:baf5 with SMTP id 2adb3069b0e04-53d862bd445mr2637845e87.16.1731159127417;
        Sat, 09 Nov 2024 05:32:07 -0800 (PST)
Received: from localhost ([62.205.150.185])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53d826a7355sm916769e87.129.2024.11.09.05.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Nov 2024 05:32:06 -0800 (PST)
Date: Sat, 9 Nov 2024 15:32:05 +0200
From: Nikolay Aleksandrov <razor@blackwall.org>
To: Elliot Ayrey <elliot.ayrey@alliedtelesis.co.nz>
Cc: davem@davemloft.net, Roopa Prabhu <roopa@nvidia.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, bridge@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC net-next 1/4] net: bridge: respect sticky flag on external
 learn
Message-ID: <Zy9kVceo3w-YRA8S@penguin>
References: <20241108032422.2011802-1-elliot.ayrey@alliedtelesis.co.nz>
 <20241108032422.2011802-2-elliot.ayrey@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108032422.2011802-2-elliot.ayrey@alliedtelesis.co.nz>

On Fri, Nov 08, 2024 at 04:24:18PM +1300, Elliot Ayrey wrote:
> The fdb sticky flag is used to stop a host from roaming to another
> port. However upon receiving a switchdev notification to update an fdb
> entry the sticky flag is not respected and as long as the new entry is
> not locked the host will be allowed to roam to the new port.
> 
> Fix this by considering the sticky flag before allowing an externally
> learned host to roam.
> 
> Signed-off-by: Elliot Ayrey <elliot.ayrey@alliedtelesis.co.nz>
> ---
>  net/bridge/br_fdb.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

So you have a sticky fdb entry added, but it is still allowed to roam in HW?

> diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
> index 1cd7bade9b3b..d0eeedc03390 100644
> --- a/net/bridge/br_fdb.c
> +++ b/net/bridge/br_fdb.c
> @@ -1457,7 +1457,8 @@ int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_port *p,
>  
>  		fdb->updated = jiffies;
>  
> -		if (READ_ONCE(fdb->dst) != p) {
> +		if (READ_ONCE(fdb->dst) != p &&
> +		    !test_bit(BR_FDB_STICK, &fdb->flags)) {
>  			WRITE_ONCE(fdb->dst, p);
>  			modified = true;
>  		}
