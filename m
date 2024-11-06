Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133D21D6191
	for <bridge@lists.linux-foundation.org>; Wed,  6 Nov 2024 10:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730889885; cv=none; b=NHLqLAN+EiK8ghUr1W9Ik0hcBc84TCeykxkrRybvZKYXsr0cAZ4fP7Yamf/PuAN9uyx2sWqa9VBghZaXMFRbWEUJnJ0ngNRTwDI1q4Kd5hBIiRZ94RM6Yh3JAWQrYx4lggZPLs/6qQ1Uxg0nb3eiiX/aF3CcCuhGiKiKbz35t+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730889885; c=relaxed/simple;
	bh=wY+Ghtl8OHCmvO4RRUCKxlLE8oGioKjRaRQoDwHsEdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qE3LH/nrmDZZvnB1NkwTUbwRJvI2VhI2kXLkcevvc7oZ7XFa5GD3in6UOVbX9NUhfmJxEbQfcL0bv9uzZyl/5aHbCzw18saZ+fyTmUl/WuU4HCjuEaO8eAUETZe29LfVQXmag4kDdx+zALGrO2+Q4QfO6pBakKURAbUTsisNCFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=Lp+gyCrz; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="Lp+gyCrz"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8E62A608BA
	for <bridge@lists.linux-foundation.org>; Wed,  6 Nov 2024 10:44:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RP8nV_l9SdTS for <bridge@lists.linux-foundation.org>;
 Wed,  6 Nov 2024 10:44:40 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::12e; helo=mail-lf1-x12e.google.com; envelope-from=razor@blackwall.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 23E89608AD
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none) header.from=blackwall.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 23E89608AD
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=Lp+gyCrz
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 23E89608AD
	for <bridge@lists.linux-foundation.org>; Wed,  6 Nov 2024 10:44:39 +0000 (UTC)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-53a0c160b94so7344868e87.2
        for <bridge@lists.linux-foundation.org>; Wed, 06 Nov 2024 02:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1730889877; x=1731494677; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=62qh646GpvjlP+xmX9TNCRorlHO26GssuL6MxAV6gSc=;
        b=Lp+gyCrzXT5VxSpXIYWzsgpZNNkbnUJRPDJIh/iLOajvZUsEyJeZ42IrrlnbeJ9ZFX
         D/0WIfdQEDpHaVUa05cgeXygvdIITSQMjNSWU4s1jFOLGRP2Iwd3JI3n9EUPFkqF/Lcr
         MsxgkFQ0vMdfFSBz+LBIw2LMQk2i6xYRA0rcUK1RnVqunNYJUEJWlhllBFmiejlJpnMo
         hEjB1q53diOZZpUfbboEivr22RFBmr1MyOs7OZzvPOdu3Ztgkjj4rpB8IouvAXuR6R6I
         52I3e3G5cZrPfj5ct7y5TYSuVMy+p5UaQF1eVGDYkXSN3GEJ8kKq1XgOWorcRmxaJlmw
         1XgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730889877; x=1731494677;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=62qh646GpvjlP+xmX9TNCRorlHO26GssuL6MxAV6gSc=;
        b=cOnyVaJw86tGIKwVpZXSO5Pn6Ug79jzNakJADzIDogXZnYJ+btui1y4IZBdWeWZnNf
         ZzlsJWwpbboez2kmn+R6xCK11lF4L0P5gs6K5BmHuFIN6Kniqs2Gozx+KGM0MPUFdPB5
         u85QzPnnkmaklP5Ngn3cPzXfPGxshjPSpKVp0WLi0xAoXLYkVYwomKzz4JnfwqUhXNMs
         yoRtMEIwgdxKHdaGUSKcf1c/kDVVy0s2uSw1bOtcEu35LHF2OhYeExiELAz4QqNUDxbr
         K4p9HHUde+WzWdHd6d17vI4OJdzer/gMk3rxXN0du8jGnFwn7tyRcLN49HqngGO6ywYM
         Uhyw==
X-Forwarded-Encrypted: i=1; AJvYcCV/E+ruvVrQhqA0R9av0NuGwoh8e6KGFabOlKumrmBYnhFPmLmy3SaqdoLVXu+ztI5nktYPfz0=@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwZDF/ukH7lOJInnXECNfBFrdtY0JeYSM5fVy4esbX0oNI4FibK
	/zufc/MQxOst6Cv+dsM0lsjlAKiTr/X19iF1e3mf/WWlw1VLC4LikzxVFwpA7PU=
X-Google-Smtp-Source: AGHT+IHKOvVmGpDv0Rb+QaFKzxFEmBF5i3SaGTPXbYLhre4LICxHFGg6QqXrN7uVueWwrpLpqhT2qg==
X-Received: by 2002:a05:6512:398d:b0:530:aa82:a50a with SMTP id 2adb3069b0e04-53d65e1abc1mr9195064e87.45.1730889877511;
        Wed, 06 Nov 2024 02:44:37 -0800 (PST)
Received: from localhost ([62.205.150.185])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53c7bcce69esm2428924e87.157.2024.11.06.02.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 02:44:36 -0800 (PST)
Date: Wed, 6 Nov 2024 12:44:34 +0200
From: Nikolay Aleksandrov <razor@blackwall.org>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org,
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, roopa@nvidia.com, horms@kernel.org,
	petrm@nvidia.com, aroulin@nvidia.com
Subject: Re: [PATCH net-next] bridge: Allow deleting FDB entries with
 non-existent VLAN
Message-ID: <ZytIkgDsKaallC7F@penguin>
References: <20241105133954.350479-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105133954.350479-1-idosch@nvidia.com>

On Tue, Nov 05, 2024 at 03:39:54PM +0200, Ido Schimmel wrote:
> It is currently impossible to delete individual FDB entries (as opposed
> to flushing) that were added with a VLAN that no longer exists:
> 
>  # ip link add name dummy1 up type dummy
>  # ip link add name br1 up type bridge vlan_filtering 1
>  # ip link set dev dummy1 master br1
>  # bridge fdb add 00:11:22:33:44:55 dev dummy1 master static vlan 1
>  # bridge vlan del vid 1 dev dummy1
>  # bridge fdb get 00:11:22:33:44:55 br br1 vlan 1
>  00:11:22:33:44:55 dev dummy1 vlan 1 master br1 static
>  # bridge fdb del 00:11:22:33:44:55 dev dummy1 master vlan 1
>  RTNETLINK answers: Invalid argument
>  # bridge fdb get 00:11:22:33:44:55 br br1 vlan 1
>  00:11:22:33:44:55 dev dummy1 vlan 1 master br1 static
> 
> This is in contrast to MDB entries that can be deleted after the VLAN
> was deleted:
> 
>  # bridge vlan add vid 10 dev dummy1
>  # bridge mdb add dev br1 port dummy1 grp 239.1.1.1 permanent vid 10
>  # bridge vlan del vid 10 dev dummy1
>  # bridge mdb get dev br1 grp 239.1.1.1 vid 10
>  dev br1 port dummy1 grp 239.1.1.1 permanent vid 10
>  # bridge mdb del dev br1 port dummy1 grp 239.1.1.1 permanent vid 10
>  # bridge mdb get dev br1 grp 239.1.1.1 vid 10
>  Error: bridge: MDB entry not found.
> 
> Align the two interfaces and allow user space to delete FDB entries that
> were added with a VLAN that no longer exists:
> 
>  # ip link add name dummy1 up type dummy
>  # ip link add name br1 up type bridge vlan_filtering 1
>  # ip link set dev dummy1 master br1
>  # bridge fdb add 00:11:22:33:44:55 dev dummy1 master static vlan 1
>  # bridge vlan del vid 1 dev dummy1
>  # bridge fdb get 00:11:22:33:44:55 br br1 vlan 1
>  00:11:22:33:44:55 dev dummy1 vlan 1 master br1 static
>  # bridge fdb del 00:11:22:33:44:55 dev dummy1 master vlan 1
>  # bridge fdb get 00:11:22:33:44:55 br br1 vlan 1
>  Error: Fdb entry not found.
> 
> Add a selftest to make sure this behavior does not regress:
> 
>  # ./rtnetlink.sh -t kci_test_fdb_del
>  PASS: bridge fdb del
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Reviewed-by: Andy Roulin <aroulin@nvidia.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> ---
>  net/bridge/br_fdb.c                      |  9 ++----
>  tools/testing/selftests/net/rtnetlink.sh | 40 ++++++++++++++++++++++++
>  2 files changed, 42 insertions(+), 7 deletions(-)
> 
 
Nice catch, I'd even queue it for -net. :)
Of course we should be able to delete anything.

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

