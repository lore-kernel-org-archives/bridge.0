Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E171272D4
	for <bridge@lists.linux-foundation.org>; Wed, 31 Jan 2024 15:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706716055; cv=none; b=tQLz9D9k4DQL8evpIfg6Ki05obq5cv7WqxH42KEMRi+XCCYTHDgCudobhS01p7HzJHd2tUgF4e+gs/uMrE88uwgQLpYJN2N5VQRC9A1mdoDd74S75ZylzZ3lFZ418Rl6vaYsAMqaJh9aCdWFqLYotWQ/vgTCnrp4LzikoHZO52s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706716055; c=relaxed/simple;
	bh=EXcXyeANmJmgvfw8azKOBTTXAU2Cs2bPyOWuEk85O1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SwZJXr/lFzLH7NhcZQqT+Q86GY4501HOU9AkSAJqEWXl7U3a2Q9tFyadFPuDGRD6AsAQ6D27c+mACmZmwvzuG5lWXCbiXr3Q90N39pnJHB+36pjigai/tNMHz848V3tI5ZWJibyiyODq+IRyBx0I+eNXfXMXZw5o+Dw8SYMJGsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gFhRxtdU; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gFhRxtdU"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 037FC60F47
	for <bridge@lists.linux-foundation.org>; Wed, 31 Jan 2024 15:47:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 037FC60F47
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=gFhRxtdU
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9W3pGvlE7RZ8 for <bridge@lists.linux-foundation.org>;
	Wed, 31 Jan 2024 15:47:33 +0000 (UTC)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 07E0860F41
	for <bridge@lists.linux-foundation.org>; Wed, 31 Jan 2024 15:47:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 07E0860F41
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-33aed096cb3so2643128f8f.1
        for <bridge@lists.linux-foundation.org>; Wed, 31 Jan 2024 07:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706716051; x=1707320851; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7R6bRnIXwTFaf6OBoNqtFX0s+pTAlpakYMHMrYTjwpQ=;
        b=gFhRxtdU6CaMT+mij6HOqnFfGapxZXEdm9uv6kys6oiYmyn+ixWqdZs6QA5Vv97F6d
         CWQBodhsTBy2qsevJlvisl1v8iinZ4HmBs4rgyVsdKFJ7oevHFOjTaVvLpXK/cs924wg
         3Om+7m2L12gwcHLyHZF/4JiYsUjaJEF6mP+csUb2I8U+pb2gAIBX/TlE8/CCUAp3UbEU
         Lfi79cvASZ2z2ENIFUcbbWXVhyUPmAoZLWf9C3dc3KmGdiL+Rhu10beImurEhcJ3fXtD
         uCFnFnxPVatdX+alTh4yop17cT28+V+ValeUsvE9HBBbbCG/Drt5sNQzq1vnWF2lwZ4u
         Eqyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706716051; x=1707320851;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7R6bRnIXwTFaf6OBoNqtFX0s+pTAlpakYMHMrYTjwpQ=;
        b=kxiOor1W97xbGj8SN2loDgiYXDOTQbvbKY9vTtBxZfVCzOQhmpvOzCE1VRagsOdOfx
         qWW8Dr3GZhbSR61Xw48pS04N3Pv6VvpywSn/zgSprVQa6H5Qa4kdKH2n0lzKDmC4PWt0
         mVIEpb0Gi18xB9A/6/GL6kwkUXv8J261sPbtnyMz/ZDlU18HzyzwspaaEvt8CSI00Deh
         nZiUYY5yS0ey0tvo7LB111lpJzC0RzA3X2lWnT58Ox/YFtVbnoRDhDfWAQvKImdTouO+
         V5rNztuC386wGElegfMzskHlDHguwKSJ+DPN17n3ogcQb/wGoTuWp+MaRkPa8+jrSFvz
         O8FA==
X-Gm-Message-State: AOJu0Yz4k7DJp4S6jctowN4vyh9doFECSvQChb4jMa29IGAVLsCeTI4R
	sY5s4p2fz3zOSktwuoTjo3oHvbzerjRKQoCkUpx03KOp7fTw6DPF
X-Google-Smtp-Source: AGHT+IHUI491lPMA6eaODzik0Gih2zVI4wOgoLFn4I/Ko6V5bjkYg2ZGvY99YHvrpc0RtNmUiLIKbQ==
X-Received: by 2002:a05:6000:1006:b0:33a:eedd:c892 with SMTP id a6-20020a056000100600b0033aeeddc892mr1386447wrx.66.1706716050842;
        Wed, 31 Jan 2024 07:47:30 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXGulGP+rCmZq4e8Ik5k4f4HqC9/tJk7P0cV3z7xY08fvjBZRkr+dFiJDMWAjNDT/vO0XQm6HEkZ1dkSOEhkYnERqYrHGUs5gFuTHJmFdkh/uhkrV6PcFJg4DDPsFbX5HfTBDwbCstoEK6LFXdWC8J9u3rEHT4whfjF9VsZLb7RQgwExI3paSF609LzvOUEbGUWwqm18Po85OCsTe1ec7uYjYD1w+ByvGfdpCZK2UIGH8sjG+XC7rcuzlH4Y2dYkLExH3GPQS9ZgdWxmujQOC/PROtZU8hbih0Zgdp9Ysh70C9tfCwB3BGzPu+3SwDL/wa6N1l8BHo9oFuapgSylj5xfK7MxqBtd/Tc2Hk0qybR7YPrbYkftNCrCFx+WSZjKx5j78s3Ki0Tnybl
Received: from skbuf ([188.25.173.195])
        by smtp.gmail.com with ESMTPSA id bt3-20020a056000080300b0033ae6fa7f20sm10906120wrb.65.2024.01.31.07.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 07:47:30 -0800 (PST)
Date: Wed, 31 Jan 2024 17:47:28 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	Danielle Ratson <danieller@nvidia.com>, mlxsw@nvidia.com,
	Jiri Pirko <jiri@resnulli.us>, Ivan Vecera <ivecera@redhat.com>,
	Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	bridge@lists.linux-foundation.org
Subject: Re: [PATCH net-next 02/17] net: switchdev: Add a helper to replay
 objects on a bridge port
Message-ID: <20240131154728.fnw6pnib6l7x3vzq@skbuf>
References: <cover.1689763088.git.petrm@nvidia.com>
 <3145c726aa2290b82841a51590554e97f3c099b6.1689763088.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3145c726aa2290b82841a51590554e97f3c099b6.1689763088.git.petrm@nvidia.com>

Hi Petr,

On Wed, Jul 19, 2023 at 01:01:17PM +0200, Petr Machata wrote:
> When a front panel joins a bridge via another netdevice (typically a LAG),
> the driver needs to learn about the objects configured on the bridge port.
> When the bridge port is offloaded by the driver for the first time, this
> can be achieved by passing a notifier to switchdev_bridge_port_offload().
> The notifier is then invoked for the individual objects (such as VLANs)
> configured on the bridge, and can look for the interesting ones.
> 
> Calling switchdev_bridge_port_offload() when the second port joins the
> bridge lower is unnecessary, but the replay is still needed. To that end,
> add a new function, switchdev_bridge_port_replay(), which does only the
> replay part of the _offload() function in exactly the same way as that
> function.
> 
> Cc: Jiri Pirko <jiri@resnulli.us>
> Cc: Ivan Vecera <ivecera@redhat.com>
> Cc: Roopa Prabhu <roopa@nvidia.com>
> Cc: Nikolay Aleksandrov <razor@blackwall.org>
> Cc: bridge@lists.linux-foundation.org
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> Reviewed-by: Danielle Ratson <danieller@nvidia.com>
> ---

I just noticed this commit in the kernel, and the commit message did not
really convince me.

As unnecessary as the second switchdev_bridge_port_offload() call may be,
it does not hurt either, because it just bumps p->offload_count in the bridge.
And with just this justification, adding a new function to the switchdev API
is equally unnecessary.

Even worse, switchdev_bridge_port_replay() is a partial misnomer, and
will become a complete misnomer soon. Out of 3 object classes (FDB, MDB
and VLAN), FDB and VLAN are not actually replayed just for the given
bridge port given as argument, but for all ports of the bridge. And Tobias
wants to change things so that the same will happen for MDB too.
https://lore.kernel.org/netdev/87bk927bxl.fsf@waldekranz.com/

Can mlxsw not use the same replay code path as DSA, through the _offload()
and _unoffload() entry points?
