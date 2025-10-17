Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52442882B2
	for <bridge@lists.linux.dev>; Fri, 17 Oct 2025 09:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760695107; cv=none; b=DTeXlyKPCVyYO/ECHCS0JilRKRn1aE/X4pQeaCxLcYJfC/zFwhOzom4V0MyUvPoinPQNOnNWoOd3n8rQMONbUlTGYnC2n3zx2FjWSKpuTb1N9pJq57Aa6XtNHpYMLyLHAh10d/pW1e3znl8594FJT+bV+G2Ib2gthRtBAS2JUzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760695107; c=relaxed/simple;
	bh=uPh/ii+rgmvbCP0wm67KTw3FbLTpuetEo2DXOFYd9RY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vn6UuORLy76pL82slh+WDvKCjgP+p1db8LDXmri6PHQcl+Lv+PvDitMZAA8ibMeUA/QGHl6qXpjKmFZkS3q3E/mYXI9VEXZPqhZZMv5KIO1pOB6DrZVmzhN6s7ZNZpOblj3Sdf3jM3JvSW1G2EN1HlaDCe/WX8lEyGPjBeqmL2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=WOgIKAlq; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="WOgIKAlq"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-427084a641aso224206f8f.1
        for <bridge@lists.linux.dev>; Fri, 17 Oct 2025 02:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1760695104; x=1761299904; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zGr3XDWHjHOJAcUpC5wF1xjA8pPevM01/q+Ros0ANMo=;
        b=WOgIKAlqU3PqRQkvWhVatRGhm99MJOXNeBc+jGfuNRTxDg2NqrOvm3d64Ss6OKxrqs
         9gRh5NOb7XfRGGOmrocdMNI3F/Cz6AmWJM8lP9q1ZmtriaLQrsXlM7oIa3aroMR5RrjY
         lGlfonb+slsdsyh9HM94j+K+H5mHDwtC2//D8/x9mAhEIENwQbHSbQOed2V76KbfstNV
         FKHtQ/YVXeFlwf7XY9rwS/UNpYBTA9JCoQ+g529JxJ07XBlsuMskNVHkcBT62r/PQXb/
         yv2bmewSSNUv1KSqfeU81MGFpDvAHkGiNlutUvcLOlBfRh+C4AKc7jjtdrSPRBGhE7kP
         /Upg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760695104; x=1761299904;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zGr3XDWHjHOJAcUpC5wF1xjA8pPevM01/q+Ros0ANMo=;
        b=eJKbQ5AUb87NIRDQVEHKHCfpF2X+Z7qMFyolRTjWspBMt1Qpbs39IrOhUCg5KETm2z
         dXXZRUKWvIxGlnHorx6IQisjJzZ2rKICPAkuZocyUdbM6x579sxUFUf0dW/kUd9EEZoj
         QxBHH427oGZcG19Ug1JJk33qL44is2usCoOAPenKtUrQxvBcYIDHGjzKS2nFE9/OO4jP
         O5zmMjD9pjQmMW5O0T5z3hTX171g/+EKW3cD2RYbasABbfiXN0RA7ZwpmLbrKqTPKS/t
         VL/X/Ar3LZOPQuQnmzXzAS4zXijZsEdJIo7X0bH5nybPED6iOHoVJTBl3cZ2E8kSE8Qf
         4CZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrE5e0KcwmYdgQ4+bVPCYnhoI0ODwfMthOPx/a4XJe2gG4GhjR+0aOL9jrHw/vBrbK3N8XGKs=@lists.linux.dev
X-Gm-Message-State: AOJu0YwE/0nxBfWshiRN7E2c8ck6eqvVPiJ9fd+Ij9EKGms9QeoKxzMH
	eEuTmvwZ75O4hWsH69vgQkCEoPyHZ+dTC5zCZRTRXG9I2OcGBPes04pFUZm1qGY9tIw=
X-Gm-Gg: ASbGnctQoGtuDGix6uvSJ4dZS8q/1H/uC0iAE/Ub64WgWudvnXqRk/3llUhexgxrdJp
	LTKpPTUeAzQifdyll66qRms+fS4Z1PSqumhYE5S+ziyXfbp0gtso0CfkicoeBg/hFfEnWfJZtJy
	1jJhjrczGFHMml4kA8GM97Nt91n0DbfK9QA0/icYy1eHrneaO1rC554uMps2s7Voav44aiq2znC
	rTyhWCCXqGPZ+axscPgAwgY8S1VhNolNq+CE8iJNKtny9sUOtqNiErgUFp3kq+UpP64NIxPgXDK
	+iY36AuZUb5mpbUH0gFaTlMzKn+l3MkE/bsxueDIWuQhDDGcaDb1872stJqK7WnCsS4Secmdqbt
	9rWDEBbQnYsabFzph9n+mFlKCuB92lRlsKY1KQGivAN/4Axa2H5dtm5XF9E3LJzvfl48I1eSNU9
	MtnZ5ge5zdz78v5mPV7mw9PdHrRAUYeXWnHHG3CA==
X-Google-Smtp-Source: AGHT+IGGJNKEyEbaEv1ZDoXrARqgE/0dnSH8bQ2YC5QoAeNPQSjV6b1dU/j/crVsbpev8hT0qvinUw==
X-Received: by 2002:a05:6000:2887:b0:427:9a9:4604 with SMTP id ffacd0b85a97d-42709a9465fmr370577f8f.45.1760695104131;
        Fri, 17 Oct 2025 02:58:24 -0700 (PDT)
Received: from jiri-mlt.client.nvidia.com ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5d0006sm39944499f8f.34.2025.10.17.02.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 02:58:23 -0700 (PDT)
Date: Fri, 17 Oct 2025 11:58:22 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Sabrina Dubroca <sdubroca@redhat.com>, 
	Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, Shuah Khan <shuah@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Stanislav Fomichev <stfomichev@gmail.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	bridge@lists.linux.dev
Subject: Re: [PATCHv6 net-next 0/4] net: common feature compute for upper
 interface
Message-ID: <gstrsf76zi5twyohlimenl3zli67k7l52vu27qwt5csrevrqoa@th2fqrhss2zi>
References: <20251017034155.61990-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017034155.61990-1-liuhangbin@gmail.com>

Fri, Oct 17, 2025 at 05:41:51AM +0200, liuhangbin@gmail.com wrote:
>Some high-level virtual drivers need to compute features from their
>lower devices, but each currently has its own implementation and may
>miss some feature computations. This patch set introduces a common function
>to compute features for such devices.
>
>Currently, bonding, team, and bridge have been updated to use the new
>helper.

Looks good to me.

set-
Reviewed-by: Jiri Pirko <jiri@nvidia.com>


>
>v6:
>  * no update, only rename UPPER_DEV_* to MASTER_UPPER_DEV_* (Jiri Pirko)
>
>v5:
>  * rename VIRTUAL_DEV_* to UPPER_DEV_* (Jiri Pirko)
>  * use IS_ENABLED() instead of ifdef (Simon Horman)
>  * init max_headroom/tailroom (Simon Horman)
>  * link: https://lore.kernel.org/netdev/20251016033828.59324-1-liuhangbin@gmail.com
>
>v4:
>  * update needed_{headroom, tailroom} in the common helper (Ido Schimmel)
>  * remove unneeded err in team (Stanislav Fomichev)
>  * remove selftest as `ethtool -k` does not test the dev->*_features. We
>    can add back the selftest when there is a good way to test. (Sabrina Dubroca)
>  * link: https://lore.kernel.org/netdev/20251014080217.47988-1-liuhangbin@gmail.com
>
>v3:
>  a) fix hw_enc_features assign order (Sabrina Dubroca)
>  b) set virtual dev feature definition in netdev_features.h (Jakub Kicinski)
>  c) remove unneeded err in team_del_slave (Stanislav Fomichev)
>  d) remove NETIF_F_HW_ESP test as it needs to be test with GSO pkts (Sabrina Dubroca)
>
>v2:
>  a) remove hard_header_len setting. I will set needed_headroom for bond/team
>     in a separate patch as bridge has it's own ways. (Ido Schimmel)
>  b) Add test file to Makefile, set RET=0 to a proper location. (Ido Schimmel)
>
>Hangbin Liu (4):
>  net: add a common function to compute features for upper devices
>  bonding: use common function to compute the features
>  team: use common function to compute the features
>  net: bridge: use common function to compute the features
>
> drivers/net/bonding/bond_main.c | 99 ++-------------------------------
> drivers/net/team/team_core.c    | 83 ++-------------------------
> include/linux/netdev_features.h | 18 ++++++
> include/linux/netdevice.h       |  1 +
> net/bridge/br_if.c              | 22 +-------
> net/core/dev.c                  | 88 +++++++++++++++++++++++++++++
> 6 files changed, 120 insertions(+), 191 deletions(-)
>
>-- 
>2.50.1
>
