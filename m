Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02253B7775
	for <bridge@lists.linux.dev>; Thu, 12 Mar 2026 09:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773308793; cv=none; b=hDnk1eKFJH0nXo+XUa3FYY4VpIehVxPQjMBiEHX8lauFsNmCSKUL1EZvLCzp5SGqM2MpqMIc6g+USUl0lIW34sL+fFav9WP2fR/d54AfVPjfq6kDI9YOCivMtmHfp1UDu+xgobKQ/uvfuVXi1dexNbJKOszK+ZOWySjehO2DjdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773308793; c=relaxed/simple;
	bh=XmgO1TscYmjuACXGsGpTPCpFJQ8z+1vv7PMc1mKHSMM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DEDVEmRL/7GcXE4unJIUCE4X+dlYiA0NOS46Bq9i0m4o+fs8yzToD9ipd5Atmew0RI3jTesuEqE1R+6cHF4Q8ckLz4Cxnt+wrOpLH8j/c9Sdh3PyfqbWaXfDZvRbm8Rsv1vWhasbyheywi7fxIlQhoX1hqcbgH3w4ruujBn+lZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f0WpSmed; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f0WpSmed"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773308790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v3laAzH2RegSSG4RPB9RBAb4LG65Lm6P17O2gbvY3vM=;
	b=f0WpSmed9CDPqlrhQERlgTu17lFHWNN1iKiDp7V82OddnmoswCx/kWRUGnjzbl114b0+Ln
	boOaIevniJnL9yS3KPP0i6AFfWiL5XEdEYYGgbvxm7B4n6J6jVbap0Zg8AvOpzYWMtJbIF
	MIvfvmNp3mjoUawKUfTv6J4JMi97yKM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-5FxU7fBgPbWGPiqnzj1Y5Q-1; Thu, 12 Mar 2026 05:46:29 -0400
X-MC-Unique: 5FxU7fBgPbWGPiqnzj1Y5Q-1
X-Mimecast-MFC-AGG-ID: 5FxU7fBgPbWGPiqnzj1Y5Q_1773308788
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-439c4d71603so1590892f8f.0
        for <bridge@lists.linux.dev>; Thu, 12 Mar 2026 02:46:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773308788; x=1773913588;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v3laAzH2RegSSG4RPB9RBAb4LG65Lm6P17O2gbvY3vM=;
        b=doTPGLibY8q16+QJ3MFthmExQTh5xsZMXE8sacOeEwjX7mP6dp0fDdniOKilScT/p2
         s/Ti42ICw8jj2TdFabEpgvc2ZgIfbgpWmMNSKIl4mTxKbddGsdiwTystQiiFkCDrEGG/
         HRQcy8Z92/TyOy3FD9N9mAxvY3Q9vKCdNUihsqbpTqouXX0tIfZo+sLLWpHeXZBGkX/R
         haJtuSHXJUCILlt3N4rvqgN1T5cvxgDNxZT5Nrj1wyc5cmlc/Dq+2jmMni+jiMsnylE/
         L/rLCzrbx5NBXoVLh8PWPZqq8zTuyQ3KvWfVpmEtkPE56UzH2GuKkTynahc78ks+9jxa
         h4nw==
X-Forwarded-Encrypted: i=1; AJvYcCVYVxahHrmbg3wrNu9pgESOqjbklHkhOSTk47EDLsohCKPmKEY60NsPb26ISZmLqUvyTfX1H0k=@lists.linux.dev
X-Gm-Message-State: AOJu0YxpZi33kiwpDldewYxMx6p/jCWNOCqn6Ga8bnx8rTUhNd6vdikQ
	YfQbvJ7iZCajKHNPh9+ZWGFBWE6FKtFlOHtpHcsMQrOtNz2NUcO892MZ03i7PegmLGRPxGt8Nuo
	GtlekFZzpij2LUcpRiN+cOV2gaxxjMCbfBpUuLOFBz7Z1x+Tf07IyinwlEw==
X-Gm-Gg: ATEYQzyOIOHnQS8vmsWLoZFMDsEo+ysS15DvZtsOD1pCm3U6gd4MMURMAU31o9rGDcb
	0UCigzE6QjaaOphmUCAvE8fPV0kV6jZGAWapyqdG9pPTPfZec/lpLhGyKhHwHoJC/g1hh8j6Zrb
	gK6FMlN8jmVNDYI0SE2zkSnPY59Q6zN0N0EBZUzxmyjhvNRN4GBPLU2Gn1/9uILKZ/1KwmgCR2l
	NsZCaOChv0HbAVKuW8/q2ev32KsSKtixQidkesL2Cett35qeNtMoRTQi5Q1rRhhN0WBin5kFV24
	kmNXihgHNtObeF+hu6qO+9osD/twMh4e+lBrMoStRa58ZWXdi98J1bJD5yvVd2GwCshxlcmLM5Q
	57xFTwI9tApKyyLnWjwQB7Xmw230EtVz8VslkgMZtkKg9ESUZC2fX+7o=
X-Received: by 2002:a05:6000:2c07:b0:439:c24b:ec15 with SMTP id ffacd0b85a97d-439fdf8aa4fmr4902913f8f.5.1773308788216;
        Thu, 12 Mar 2026 02:46:28 -0700 (PDT)
X-Received: by 2002:a05:6000:2c07:b0:439:c24b:ec15 with SMTP id ffacd0b85a97d-439fdf8aa4fmr4902885f8f.5.1773308787836;
        Thu, 12 Mar 2026 02:46:27 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe1a76e5sm6445035f8f.12.2026.03.12.02.46.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2026 02:46:27 -0700 (PDT)
Message-ID: <645d7dd2-9dd6-4af6-aae3-4e0b5af612dc@redhat.com>
Date: Thu, 12 Mar 2026 10:46:25 +0100
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/3] net: move
 netdev_compute_master_upper_features to ndo_set_features
To: Hangbin Liu <liuhangbin@gmail.com>, Jay Vosburgh <jv@jvosburgh.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
 Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>,
 Simon Horman <horms@kernel.org>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bridge@lists.linux.dev
References: <20260310-offload_compute-v1-0-3df79c09ea65@gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260310-offload_compute-v1-0-3df79c09ea65@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _BhlyfcAUP4_TJel7a0DQ5FiU6MyBdnML4kIR0H-HXA_1773308788
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/10/26 8:45 AM, Hangbin Liu wrote:
> Currently, master devices (bonding, bridge, team) manually call
> netdev_compute_master_upper_features() scattered throughout their port
> add/remove operations. This approach requires each driver to remember
> to update features at the right times and leads to code duplication.
> 
> The series moves netdev_compute_master_upper_features() to callback
> ndo_set_features so that the offload compute could automatically
> invoked during feature updates when upper/lower device relationships
> change. This centralizes the feature computation flow and removes the
> burden from individual drivers.
> 
> ---
> Hangbin Liu (3):
>       net: use ndo_set_features to set offload features for bonding/bridge/team
>       failover: use ndo_set_features for failover offload compute
>       net: no need to disable LRO specifically
> 
>  drivers/net/bonding/bond_main.c | 14 +++++----
>  drivers/net/net_failover.c      | 67 +++++------------------------------------
>  drivers/net/team/team_core.c    | 15 ++++-----
>  include/net/net_failover.h      |  7 -----
>  net/8021q/vlan.c                |  2 --
>  net/bridge/br_device.c          |  7 +++++
>  net/bridge/br_if.c              |  6 ----
>  net/core/dev.c                  |  8 +++--
>  net/hsr/hsr_slave.c             |  1 -
>  9 files changed, 37 insertions(+), 90 deletions(-)

I'm dropping this series from PW due to the self-tests failures. I guess
it could be restored later if it turns out the real problem is elsewhere.

/P

