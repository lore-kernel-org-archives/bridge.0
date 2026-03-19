Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F148E3CF670
	for <bridge@lists.linux.dev>; Thu, 19 Mar 2026 13:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773927449; cv=none; b=bmoHRnx4R2y7LK1jmTTPp0smgLZ86zwRSBNN6nHFcZu+0e5LJ1k1wTt6jJm20/nt8a+q3ceOnxAxoh8Hbb9Yf/4O4K0k8kEhIbffdu+eYhT1pcY6sxt86BUmcU1WLTYhT2gWcqm/3vMZ38pamQ0JoD8QxeRxaxn0MX6ZM3GQ2p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773927449; c=relaxed/simple;
	bh=cPdIohDR0Q7zRJ6m55ii7YN9S5ciaGmg0kfLHizWxtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GSrk7yWVGNbYGidVkPs0uO6TeI7+VIeXTdswcAfTue/vKcxRxDc7It/rCX1I+ubKKt4CcaOeT1CAp5jFlK2CC8xfumjA2sIp15+P+4cXP7xUA1KpaxEDz3uTt9/sKta4TY1Ne1JnIrwWs1WVdf3F8bthd0XDOEht51bfWG/bz6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dtmCqrS1; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dtmCqrS1"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-824c9da9928so739090b3a.3
        for <bridge@lists.linux.dev>; Thu, 19 Mar 2026 06:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773927447; x=1774532247; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mj7czIw3HDieWJuIXocUwtMNw0GcfpyRJfd1mQTzkxo=;
        b=dtmCqrS1HYT9vTRF7y06G9JtAIaj6TJH9cVG2ZN3k20mUT0D5BryHgWgHmjRQwtn0W
         QJz8mOmdTFrOP3Idyd5ZS5R1eOhaIyQ43we0xl/pTGEVYsFmDA68l94wEwkiPuJ+mY+i
         hWnqrmh6bd+6MC6mw0Cfx4vUrLB0tGPvsPNyk14iQFQpzVKMU2HV2UBkA1p1RikPNoB1
         R35Cz1xYYmTKk3c3zG+HdlbiWop2LHh1OFOUeJqMcKvuBsSlBkr4pgn+x7VhEAc0qjYv
         v8laOmBw8rpfwQd4kFSmdPyT5dnMi/21pPk4v4SVmcU7KxXeNZXPJs1tpv5DEg8vfmOe
         JpTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773927447; x=1774532247;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mj7czIw3HDieWJuIXocUwtMNw0GcfpyRJfd1mQTzkxo=;
        b=IeZaXVDs9GgODlLLhdtrE4h0WswF8ZWYALulZkxF2ZQAH1G+vp/ZjuOx2puCWbW6Ci
         ir7WATwTEXzx5faaMt+WMznWGxvAoTzNjIZqmiR171KBLWD9xYxhyx9MS0UohUpeGt32
         bWZZ8MYJM+hLGp1cWWldOeQYIi1+qu0+ndxklRAZnDFYgvqT3uFKkRMw3cXgTGaHXTq0
         jR0j+EGMCy7zzehOqhUS1YkRzPidglI/3zmNYmw1tcdTk8zjqYUoGjW5YLBpUzJlQp5J
         ZYcSO1SJGIQpf5XRGhNiQsSIoCxS9LUOs2WUWBhQbzYM9HzajU3TcDN+uUG593TY+sy4
         3EGA==
X-Forwarded-Encrypted: i=1; AJvYcCUq1F0lsz/7/EvzdZ2RLz8Fl3ebMHL1M3ZSgjZNQTpy2kA39J6Oq3UJ5NLxeDl9ZZQ74pU+lC4=@lists.linux.dev
X-Gm-Message-State: AOJu0Yx/kEJbsecm3LcISeixst+a0BAzcwMGxZuCtowG3xZeO+y7G4/v
	0hMiyh6h7MirofQsAI91PTg0XRNCOWGA4rvlhEMyMUuOmlm+3lxvlHi3
X-Gm-Gg: ATEYQzwRdC8NBLZ4DvHbiRV1KOUQEb7+sDfLlmCeipTiEDMOnVFGxAFrJwFsXgNRoqU
	p8vi8bPoP917dcDYSofD0/EDvJiHes+/scs6fuytJz+5dKkbR1xTd9GPAEfS0njENsnTebcU19o
	D2m3gAT/Q0Q3x733gbr2BgwA8xUoBdiaxpSPgPVJCXio/Srw1ndveYs/SSsDs3KSEj/NB0yV+k3
	Xazlo+34maqHWBwAFEzwEpOrgW0Qta5Dz++LixAS02Caf8oZB/OgBG09PCAXSh0frgN5+lYHVVb
	hQPydzHh5gXGz726mvhdzid69hK7nmyPKs8dDG+bAIhloNoxlxDn0vZQ0RxQZzpdNnrIkEMoBQQ
	gJoAAGCP1RZK7BzUkzpitfBuBU9+mne0n9o16Hm0HJk7meZCtpXun5n4QnrhdvIX6dLDJfyH8bT
	5gtzaX9K+Uxa0LEC6cDO9xSM9C59w=
X-Received: by 2002:a05:6a00:4fce:b0:7fb:f87d:a0aa with SMTP id d2e1a72fcca58-82a6ae4b089mr7143017b3a.52.1773927447104;
        Thu, 19 Mar 2026 06:37:27 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a6bbe1af0sm6590376b3a.41.2026.03.19.06.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 06:37:26 -0700 (PDT)
Date: Thu, 19 Mar 2026 13:37:17 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>, Simon Horman <horms@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	bridge@lists.linux.dev
Subject: Re: [PATCH net-next v3 0/5] net: centralize master device offload
 feature computation
Message-ID: <abv8DXkR0RtnZJ8P@fedora>
References: <20260316-offload_compute-v3-0-a5d4a07d86d3@gmail.com>
 <337a938c-8a03-43f8-8402-745020185b37@redhat.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <337a938c-8a03-43f8-8402-745020185b37@redhat.com>

On Thu, Mar 19, 2026 at 10:52:34AM +0100, Paolo Abeni wrote:
> I'm sorry for the late feedback, but I think the driver cleanup and
> simplification is not worthy the core complexity and the new NDO added.
> 
> The AI reported issue would probably need very non trivial changes to
> both team and bond driver to be addressed.
> 
> Most of the cleanups belong to netdev_compute_master_upper_features()
> introduction in the failover driver. Factoring out that single change
> would be IMHO a better option, if possible.
> 
> The new ndo looks controversial. We already have 2 different ndo at
> __netdev_update_features() time, with slightly different semantic.
> Adding another one feels like a design issue.

Thanks, I will check if we can call netdev_compute_master_upper_features()
in failover driver directly.

Hangbin
