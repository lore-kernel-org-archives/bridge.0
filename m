Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B012FF671
	for <bridge@lists.linux-foundation.org>; Thu, 14 Aug 2025 00:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755130822; cv=none; b=VNODfOUEms3z04DfhR4EttMRF+3FEDejDfx595Ja5FfVZRPaUPdG/fj5CpNUqYtchZl3KsQbAEEBj015YEflnSVjEAB1mdpulc8IMXC7dBiAXk2iRVmloM6gyFH2v4wwp3Haf1ZWgYbXIFSrvHVS/vvA11jogHyqpsXfCplLLYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755130822; c=relaxed/simple;
	bh=lQV6PvjD5OLXKSX9pxO3TIO0P9TXKQcWs9Rt8ZRL1Gg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cw8mJ4BlycbdfP0AN3/OgrE914EZhc+9C/kwr2VFNpAEu63KYFD6bUdXpJpjZHut5TVW+QMYnETEFDk3KfY8niRECUZsl2kWN92AHwgk/wAFqX7hOP47+sJVFx5EKsym+fenaeTGio1eAo5t0BwjwowC+QmfyhJ6AQoyGpxE3VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Avusdu/1; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Avusdu/1"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4E46842C06
	for <bridge@lists.linux-foundation.org>; Thu, 14 Aug 2025 00:20:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.101
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LjbuDsO60Zo0 for <bridge@lists.linux-foundation.org>;
 Thu, 14 Aug 2025 00:20:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org C136742B7D
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C136742B7D
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Avusdu/1
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C136742B7D
	for <bridge@lists.linux-foundation.org>; Thu, 14 Aug 2025 00:20:20 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id F159C601D6;
	Thu, 14 Aug 2025 00:20:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67D78C4CEEB;
	Thu, 14 Aug 2025 00:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755130818;
	bh=lQV6PvjD5OLXKSX9pxO3TIO0P9TXKQcWs9Rt8ZRL1Gg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Avusdu/120ohZHhcsz6w+jSIWPd8lPgbbeOH62tVbrycPtDybhrhcx55dBQ+Cz+Yq
	 UpxFk6l3cxp0yOYt7DXSs/LyYRQVBFjmiDiZ36C17Jeqelo/pGVs1Gh5Twb3LhgTWk
	 I5TVzLWx6sdDfpZu+NiEsVM5JUP7Pa+HiBKNTPvLOIIUWWbQObDLD3+nzaEH4Fx457
	 MyG71Cd4DsUIlXMJbm2bTqx8rk+L4GqtExVQGiO/F2vBoNCnz237F4Dbgc4clpI8MK
	 cg6vHggKdYHv+cFaDVlnIuk89qFV06reHXgF42lSipNjeBtgDoSpZDXvVbgVd/FV2y
	 u5VbdNrIy/VZQ==
Date: Wed, 13 Aug 2025 17:20:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ido Schimmel <idosch@nvidia.com>
Cc: <netdev@vger.kernel.org>, <bridge@lists.linux-foundation.org>,
 <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
 <razor@blackwall.org>, <petrm@nvidia.com>, <horms@kernel.org>
Subject: Re: [PATCH net-next 1/2] bridge: Redirect to backup port when port
 is administratively down
Message-ID: <20250813172017.767ad396@kernel.org>
In-Reply-To: <20250812080213.325298-2-idosch@nvidia.com>
References: <20250812080213.325298-1-idosch@nvidia.com>
	<20250812080213.325298-2-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Aug 2025 11:02:12 +0300 Ido Schimmel wrote:
>  	/* redirect to backup link if the destination port is down */
> -	if (rcu_access_pointer(to->backup_port) && !netif_carrier_ok(to->dev)) {
> +	if (rcu_access_pointer(to->backup_port) &&
> +	    (!netif_carrier_ok(to->dev) || !netif_running(to->dev))) {

Not really blocking this patch, but I always wondered why we allow
devices with carrier on in admin down state. Is his just something we
have because updating 200 drivers which don't manage carrier today
would be a PITA? Or there's a stronger reason to allow this?
Hopefully I'm not misreading the patch..
