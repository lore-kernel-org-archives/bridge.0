Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D320B1FBF61
	for <bridge@lists.linux.dev>; Tue, 12 Nov 2024 13:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731419813; cv=none; b=fFzKMjve5ykY+njk4DA21Oe3XnkpJAih8HR9bBb0IIh/aNLFY4l0kod6bXy0Q/bhONGFLwVV8nUojJnK6h1Cq/8TsOCMIZIb8SJj2KXpSANmHshJbQtCgnb37GCJmLhptOjTRrO6f2m812vd5UFWrhed82yA6RF/pSfcUJbMUoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731419813; c=relaxed/simple;
	bh=pkDv1qZhZ720WQ+N9YNVRNgTFRC3x08IFpZ57D13sY4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VbRERMRVZRvcE4wuLwCMAkqcKqttA9j8mMnHWNTd4i0KMp3WkDOehBAyVMvpyaFChK2tfz//AvVH3rlQPcN0+cSDzhSz+Jq/2IbU3zfQ/PWBCVXDCB5eLJLrz4979M7llaNHVLKUi/xl+NOeP4MwEi0N7eV2goXYrO8qpdrKVo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=ASYv/Rhf; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="ASYv/Rhf"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53a0c160b94so6846824e87.2
        for <bridge@lists.linux.dev>; Tue, 12 Nov 2024 05:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1731419810; x=1732024610; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z6GJIfsl8L+Awni2vauytFSpkySMXcNGaJ2BvaXXMQw=;
        b=ASYv/Rhf3+GYyoVcFVOucaAXyR29ho2P2KoA8ShxvRbaeZ1GSkM8l6ncbrH1+ZlVJ5
         cSDp9KuWMyrfqrPFwsjrhSqsM0VHofJZB1Ja7btlh3JI3+5j6vK+TouE9nj03rCT8h74
         PjKIsERoKHmJ6CvjfRAPIT0VLlAbREUdfGblt25dNWWKKr8eyopnZ8aDAkQw3JiNUdxe
         /k9ifpNlwYtsojKSC5sy2giY2ICd5I+hLps0DqCEkxDifpRf8uDVgCxpPxaZZOhiCJ5P
         +xbPNonureLF23P/C0O3Y7kckMB2zLMgCkbP7x9Xo+E2GUMr/F0Vng5lc1UxB7oZ4JCe
         as+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731419810; x=1732024610;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z6GJIfsl8L+Awni2vauytFSpkySMXcNGaJ2BvaXXMQw=;
        b=iNq0FCGjrdIkVJFHx5S3KrzRGEvDuJZuGfRD6dmzBDL8eFozcdaXo/fWPWaP3Z3NcY
         yf7DGsAT35WoZVVwJbUW0DafkdW0LSnmmwrojEtTVIrvc0TTfaOcZXrTy/2VXCbuy6s3
         OPabcC8QTBABshYT8qYogiHQ64n7oANnon888elWLES9t4rB5PyERKU2OSxLsvPGOroD
         uFFW3yh+IQPge5dzYhoKJ28sUOp4fzdbWUfFtiLC26Y015JM0e2wA93gs3NzJB9Kbncs
         PPY9XgJ4W+i+/SVFI+Y3WDmjEQldIkYbZfAqTRYWvrI/tks6Yxl821yNy+YMC5QsikG9
         K//g==
X-Forwarded-Encrypted: i=1; AJvYcCVb6FEN6ftw70vVwnVhBXMcjRMDEfxRv4PPxjtZkaTviD2XJok7ojZMBq6+Vnd4qUArt6HGBSo=@lists.linux.dev
X-Gm-Message-State: AOJu0YxBvArROZX/0L4vKzZA50YwczaHgKmG5nHSjwMIvo1VSSAyrVIm
	EjdFI1xBZOhMD55KMQxnqNz7MUWEeUS8Zz4ZRLZmKIc9kfP0dnd9j3ezuNtyEOQ=
X-Google-Smtp-Source: AGHT+IHOF4VYkC1Kg9QmW1uZS8lsVgKoN0pd0sATWDdzVSP/M3Xfx+BY8yEfFd2p1qhzXQFX+yWURg==
X-Received: by 2002:a05:6512:3dac:b0:535:645b:fb33 with SMTP id 2adb3069b0e04-53d862b358cmr8000838e87.2.1731419809953;
        Tue, 12 Nov 2024 05:56:49 -0800 (PST)
Received: from [192.168.1.128] ([62.205.150.185])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53d82678ec6sm1884152e87.50.2024.11.12.05.56.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 05:56:49 -0800 (PST)
Message-ID: <c0bcb7fb-6e52-45af-a115-7d10375047bf@blackwall.org>
Date: Tue, 12 Nov 2024 15:56:47 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/7] ndo_fdb_del: Add a parameter to report
 whether notification was sent
To: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 Amit Cohen <amcohen@nvidia.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Andy Roulin <aroulin@nvidia.com>, mlxsw@nvidia.com,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 intel-wired-lan@lists.osuosl.org, UNGLinuxDriver@microchip.com,
 Manish Chopra <manishc@marvell.com>, GR-Linux-NIC-Dev@marvell.com,
 Kuniyuki Iwashima <kuniyu@amazon.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 bridge@lists.linux.dev
References: <cover.1731342342.git.petrm@nvidia.com>
 <8153c15a3a5d341642e8c176cfb0d32e4be3efeb.1731342342.git.petrm@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <8153c15a3a5d341642e8c176cfb0d32e4be3efeb.1731342342.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/11/24 19:08, Petr Machata wrote:
> In a similar fashion to ndo_fdb_add, which was covered in the previous
> patch, add the bool *notified argument to ndo_fdb_del. Callees that send a
> notification on their own set the flag to true.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> Reviewed-by: Amit Cohen <amcohen@nvidia.com>
> ---
> 
> Notes:
> CC: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> CC: intel-wired-lan@lists.osuosl.org
> CC: UNGLinuxDriver@microchip.com
> CC: Manish Chopra <manishc@marvell.com>
> CC: GR-Linux-NIC-Dev@marvell.com
> CC: Kuniyuki Iwashima <kuniyu@amazon.com>
> CC: Andrew Lunn <andrew+netdev@lunn.ch>
> CC: Nikolay Aleksandrov <razor@blackwall.org>
> CC: bridge@lists.linux.dev
> 
>  drivers/net/ethernet/intel/ice/ice_main.c        |  4 +++-
>  drivers/net/ethernet/mscc/ocelot_net.c           |  2 +-
>  drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c |  2 +-
>  drivers/net/macvlan.c                            |  2 +-
>  drivers/net/vxlan/vxlan_core.c                   |  5 ++++-
>  include/linux/netdevice.h                        |  9 +++++++--
>  net/bridge/br_fdb.c                              | 15 ++++++++-------
>  net/bridge/br_private.h                          |  2 +-
>  net/core/rtnetlink.c                             | 11 ++++++++---
>  9 files changed, 34 insertions(+), 18 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


