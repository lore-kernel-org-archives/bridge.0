Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772497262E
	for <bridge@lists.linux-foundation.org>; Fri, 15 Aug 2025 00:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755219252; cv=none; b=iw6ywCdD/0MXx6k0k3LpEQ8ggcEyC7eegM2rvDgkLdR0wA28aenMkt7MwSmpUX48o3Rde4uROyc6C81J1zTJKcb8YyeGvjtlyNMKCXDFgWpcxEnnIb7icI0LZ2ajf/qiq8ucGxCelnOA16dMIbuLRlWlO2Lbtsm9tOGIMqbRA+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755219252; c=relaxed/simple;
	bh=9xuHR9yEMaYoCQlVCOJnNAhVRweYn88H6OWA3/FpgP0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JtdAF+BEDIHpmpSQr3NE8dvgeuzU3cNuikGxP2Vzsu8JycpnaIUCalj9qUENM8kaFh0ZwIMZGDgAKEQ3wenizupuP1of+tA5qoru93v0zeoSMWtUig3ovBjfJ7LQtqObvp34ks2TQRi5F8AnZuz9bpPOnSlP4lDKm1HHH5onW3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/qz0bzy; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/qz0bzy"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E6FF84071C
	for <bridge@lists.linux-foundation.org>; Fri, 15 Aug 2025 00:54:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -3.893
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t1C9FrxRSD4W for <bridge@lists.linux-foundation.org>;
 Fri, 15 Aug 2025 00:54:10 +0000 (UTC)
X-Greylist: delayed 357 seconds by postgrey-1.37 at util1.osuosl.org; Fri, 15 Aug 2025 00:54:10 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 3A22140644
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3A22140644
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=G/qz0bzy
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3A22140644
	for <bridge@lists.linux-foundation.org>; Fri, 15 Aug 2025 00:54:10 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id DD7C2A5688C;
	Fri, 15 Aug 2025 00:48:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DED4C4CEED;
	Fri, 15 Aug 2025 00:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755218891;
	bh=9xuHR9yEMaYoCQlVCOJnNAhVRweYn88H6OWA3/FpgP0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=G/qz0bzyl3rsonm371fiWgCPonG3C1aE4o908UPChQ7YVIJP5KzLoEkoKo7maMMDC
	 y3MA4grVB7sN2CUk9xxS5z7LQXHo/tE2rYuZQNER99LGMdbLr5sCBzEyKXpF5iIIf/
	 uDF40q42cHBDbqhpasMaKL0PClE02CzLouLs4g+LMKMIJ3vXnh6uUvEMDnT/kybkat
	 2Ig3fEHQvHWFgC69yaIuiWQvJ/cJxLqiq1CXcTT2ItuhGH/Tfz2cHheOXelEbELi7K
	 fQvMLYW55x/kWT4CTa2fFppmRjYsPMu279hl+Tv1FN6xfPMRn1IJvTlxRfsJpwkBN7
	 VapN4t3VVOV9Q==
Date: Thu, 14 Aug 2025 17:48:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org,
 davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 razor@blackwall.org, petrm@nvidia.com, horms@kernel.org
Subject: Re: [PATCH net-next 1/2] bridge: Redirect to backup port when port
 is administratively down
Message-ID: <20250814174810.4a5b2c9a@kernel.org>
In-Reply-To: <aJ2eSgyoj4JuxXrG@shredder>
References: <20250812080213.325298-1-idosch@nvidia.com>
	<20250812080213.325298-2-idosch@nvidia.com>
	<20250813172017.767ad396@kernel.org>
	<aJ2eSgyoj4JuxXrG@shredder>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Aug 2025 11:28:58 +0300 Ido Schimmel wrote:
> On Wed, Aug 13, 2025 at 05:20:17PM -0700, Jakub Kicinski wrote:
> > On Tue, 12 Aug 2025 11:02:12 +0300 Ido Schimmel wrote:  
> > >  	/* redirect to backup link if the destination port is down */
> > > -	if (rcu_access_pointer(to->backup_port) && !netif_carrier_ok(to->dev)) {
> > > +	if (rcu_access_pointer(to->backup_port) &&
> > > +	    (!netif_carrier_ok(to->dev) || !netif_running(to->dev))) {  
> > 
> > Not really blocking this patch, but I always wondered why we allow
> > devices with carrier on in admin down state. Is his just something we
> > have because updating 200 drivers which don't manage carrier today
> > would be a PITA? Or there's a stronger reason to allow this?
> > Hopefully I'm not misreading the patch..  
> 
> Probably the first reason.

Thanks, let me add clearing carrier to our list of potential cleanup
projects.
