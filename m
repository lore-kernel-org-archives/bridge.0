Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67461A29
	for <bridge@lists.linux.dev>; Tue, 14 May 2024 00:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715647351; cv=none; b=LiSyc3xaJw5qbOC3phKwtSrrxZ+LNhjNvMfTbKJRe4NQKGN76DIcT7PBmjkIsVBpn5pCdqQx6eV+/Zpc2mnBCYLC8zQPEp/qMUwumiI1BSUrW9nYHwvNveZUmmhcODhC7iW2TZoOspIqSKXt0gJuedmjzPe21egaTti8JQEmbNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715647351; c=relaxed/simple;
	bh=2MpnvqBD6DvqAhTrqX5oyxnhPl3vca3CQazvTQrvUig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZPjL9O5NlXeYUCVJMBsGT0xXIgDK8FyUYcYhhk0cWQ4wud1d5nr0Zu1lM5AqluWCNrpa2uXSleVPYi4ibWkDsXiSSzV1tN/fADN5t8yPpDQMZVK130ztTZIuxH723t58YvW+00SDqn74B4lRTJNNe/gQiFu9X7VCMTJNdFJh3xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nrKKbjz9; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nrKKbjz9"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1ec486198b6so37318765ad.1
        for <bridge@lists.linux.dev>; Mon, 13 May 2024 17:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715647350; x=1716252150; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TDv6WulsmLQrx5i35Hr3ztFDpTYtAjDplykoKz/q3Co=;
        b=nrKKbjz9NclBdIL65uPXMnIZljb9D1nJXHg4Uu7h0J51XQfmaPB9JwXFmf+kHbFxIv
         xS86+VxiHEZx/4cJYiGRr3tuPtI++cCsxY/3rhQnurMbYE53HU4IKHhdOFuqSJV49IMH
         sUzvd26apPu+MlRugeGuS2ZFauSiXt7I8FrP6vUeF9I26ur2tQsne1XKAQr1XGRM0Ezv
         MIji8o4QxS40QnVWi9DSH3ninxQMyx02AAV91OuFiWZMmFxNgOYg9vpNHPqdQW7Gub95
         ZfqTEnBH8dEu1PVwC8ogdZpD17aCoPUZLkef6yVklo00lyekCu6nmexdO/rqReMw9+qO
         jd0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715647350; x=1716252150;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TDv6WulsmLQrx5i35Hr3ztFDpTYtAjDplykoKz/q3Co=;
        b=NHZrxhCPkCZJnEIV1B7pCl/+YiM80j881fa+UUdEZbCNPZwi7xRv3nuAICiI9q9Djx
         6vOdh9ZDOR3ec1ebWfVg0FgCTaBnvb5mxOznNjg5FQ9Gkosnpm5PMEUsY1Lv5N9Sjh4C
         GGRhA16kS6iKar9tVfadvcY1L/qOEQOdVYHTTlPSixHMonKpGrFf5qaFqNuyc5si3XKM
         AOiHBiXxtwH1LotqaAno67o2XdLbQsqpvnTppyb9AvcYhUNL5PY3lGEOc7x6yWTpySpX
         xA3xr2Y+cw5ql5d0v5+bxkHwM/Ze1NR+5P7japjE0NKTbRan7QWBnm+aIMcZ0YhEJqJ/
         iStg==
X-Forwarded-Encrypted: i=1; AJvYcCVwGeCA6j/JDkDA45+2FRYZvNmnlrRFQnxMHhwLLiXnDpWZXCY+41ko8vmnXuhYSYz1nAOKGGZEisM22jfrJLWNC1OMfG2j
X-Gm-Message-State: AOJu0YweoxuiVNRVp8JXztIbrOyr7IBeI/cHu7KvM5dkXFgmIQSGmSVb
	gudPm2etGA7BlETBiejwyTHqSsfDtzjzfI8BgQXVHsldSaQnLj4R
X-Google-Smtp-Source: AGHT+IG5uMm/dHhBbasES+H6x57LswrMla0Z7VCj9EWBhZ6qfKlLw+MjzvxjiMh4HCjxxKWH9XIEXQ==
X-Received: by 2002:a17:903:110f:b0:1ea:b125:81a2 with SMTP id d9443c01a7336-1ef44161e50mr137549585ad.53.1715647349499;
        Mon, 13 May 2024 17:42:29 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c036952sm84761515ad.214.2024.05.13.17.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 17:42:28 -0700 (PDT)
Date: Tue, 14 May 2024 08:42:24 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, kuba@kernel.org, roopa@nvidia.com,
	bridge@lists.linux.dev, edumazet@google.com, pabeni@redhat.com
Subject: Re: [PATCH net] selftests: net: bridge: increase IGMP/MLD exclude
 timeout membership interval
Message-ID: <ZkKzcJm5owdvdu6B@Laptop-X1>
References: <20240513105257.769303-1-razor@blackwall.org>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513105257.769303-1-razor@blackwall.org>

On Mon, May 13, 2024 at 01:52:57PM +0300, Nikolay Aleksandrov wrote:
>  	$MZ $h1 -c 1 -b $ALL_MAC -B $ALL_GROUP -t ip "proto=2,p=$MZPKT_ALLOW2" -q
> -	sleep 3
> +	sleep 5
>  	bridge -j -d -s mdb show dev br0 \
>  		| jq -e ".[].mdb[] | \
>  			 select(.grp == \"$TEST_GROUP\" and \
> diff --git a/tools/testing/selftests/net/forwarding/bridge_mld.sh b/tools/testing/selftests/net/forwarding/bridge_mld.sh
> index e2b9ff773c6b..f84ab2e65754 100755
> --- a/tools/testing/selftests/net/forwarding/bridge_mld.sh
> +++ b/tools/testing/selftests/net/forwarding/bridge_mld.sh
>  
>  	$MZ $h1 -c 1 $MZPKT_ALLOW2 -q
> -	sleep 3
> +	sleep 5
>  	bridge -j -d -s mdb show dev br0 \
>  		| jq -e ".[].mdb[] | \
>  			 select(.grp == \"$TEST_GROUP\" and \

Maybe use a slow_wait to check the result?

Thanks
Hangbin
