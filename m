Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E796242A82
	for <bridge@lists.linux.dev>; Tue,  9 Jun 2026 06:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780987932; cv=pass; b=fx1g1PQfZSixk6axNAYTBHuBDLSYlpJFKjLesyXVc5jl5TN1oZK9Bcb2qbu/HKVrAfLNK1EPo5ohzamiaqvAU+PQjwCffC42g2K1GAhp1poAOWI+ef57B/0jr4dh+Fvr8g1bmVcuk7UTsY3NZtNrnE3PgYQGDFdsTecwCBDucYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780987932; c=relaxed/simple;
	bh=X/iRlO1TvvmGyp0MM+znIVEUZN5pzHHcxW4d3e8AgKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EuG5k9RSjog7S71AqT+FxXPA7G2Q31NvqRcp1Oyxq+hA73bFx/pgOlABsQg4KmJ+tzOUgHeGxKxm9uxdBXHytbkTg0tY7VNx5SshXY1aImkXBCtcp32MkPcSDrBjuPbyHmERGMWFXNAXN5/P3rwhFsPtFVd6I9OU5h43nvYAShQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=E6/xn6nL; arc=pass smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="E6/xn6nL"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-84232e83ca9so2176725b3a.2
        for <bridge@lists.linux.dev>; Mon, 08 Jun 2026 23:52:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780987930; cv=none;
        d=google.com; s=arc-20240605;
        b=SoET8BbokCqvPhgHhzvl4ZnsT1a1Qs2rwN9zv8+6BBe+CMHoIJPQlVUh6zOchNF/+r
         XGMfuQr1yqujkIEdc4xAsIjGtyrYzx1OHBxFJNtT1dUHSIZT5UdnUebCahUxFjBJF3YY
         6peMDpu3TJWj9W/gk67pAAqPHhG9loqgaa7fHM0cZ8j+InYuArT7fHVJbdJD+ZMkqefd
         FCtxziwNI9gY6rxmMwRO3JEuID4xx3J5iKryJq6pCpE9m+0qFqKG/zY59A9uP742xPnc
         UEqz6mf1GrUcvzreqcWWcHo1A3xBl6ieV6spsmbDD5yUY1q61xeoY4PMvA7i4gKO+QSB
         VRfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7P++uzpx+K3WEIGO/No/y6eG2e3IylOIU8Nw5uNReaw=;
        fh=Zk1exemWBitx71yUeMmzxAJeRoKPs+dvd8DRX/61Sn0=;
        b=M8wO4rI1xD8wrvtBkVy/m3yqkhS1/Z7llTdfhY7F7TptZ0GxspnKZUdNblNIlrpGFL
         b8zXklbyveMNtZBqyf5RiVYPMFJHSc0RsIcAWRDRSJJe8VhZ/qZxU4CaGkNst7tGEQbH
         7Jq6hEk2H8JVeqYfp5HQUvU37Ga3MLvz35hsqGQY8I/sKPZYZQ6WWKot5YHQypv36JgY
         Ja0PYfc0T5TCG5ByI2IV3aZrjUMonKqJDUgrMt3IjgjJp1Fskvpao1VGPZbJlW7FD5tx
         rWVfrJipMCpnOxCxoNA/SmMhY8Aeb/it65fxdgPGYJz8uJ11jcZwgZlJQFto/Ta1/M1E
         w4Uw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1780987930; x=1781592730; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7P++uzpx+K3WEIGO/No/y6eG2e3IylOIU8Nw5uNReaw=;
        b=E6/xn6nLvW4j0TqWNfqYnv1NYJEia5++zFb4G9ta4TbHgx03uhyK7YSD4BoarC2Vq9
         KKY3L0YvuxB2wYiRAqYyX0CBBQGYb7v/mycoS5XLLBgVSRo6h8jX1137VMHDaGa+nlNw
         +MkByXlq/x8aMUX3BkvnUf2AyFcQ1+uzIHxNrXIi+UrdP6n4Xbb+XyfpZVDBzjT3e15t
         xzFITlrFCVJ47BHDjnkpK+9iRGcE0aFESso+UxEBLPnlS9SpMiU9gZ5Qw9cQUyh+ga4n
         taq3h21DAo13hAWCTgN3H3Xt3XmrPMHdw77+S0CnAdVnrvBH58g+H60p2KF40txAhh5D
         AUMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780987930; x=1781592730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7P++uzpx+K3WEIGO/No/y6eG2e3IylOIU8Nw5uNReaw=;
        b=rmUddFoXMCegkhuVdLBkpGSBBfyMOTzY3vMY0BC/pfVvidPFIhj2dtVHAveJKvehYB
         RcrP7oKPodnFSF4AzTljPe0pxn8qJy2ok9UJF/mFQrU/pCD78Kz4WBsEvaS4/ieHT+e6
         wT1jfgo9lgQd2fv4DNLqyLox1qBzeakboj62iJy6QpkUTQBPWEDgE8PNE3dDSNchlB3w
         +1E8uFywEvLyIjwYZhGM4516695t4DjjkjgRRBLHHKUh7KdNlILAmsQZORnLBib87Iun
         yTLpGQxvH7XYkokzdgBqD30/llK4MyHWrJAj+zkDtr9DwVLn72w++uoCW26J7dOnTWzz
         UE7A==
X-Forwarded-Encrypted: i=1; AFNElJ8Z5jWGTmxPtDBSFJOMfwNwrTlwBclAlGixUO6fEbZ/r3Cj7X/e7dRqQvZiniY4b6KylRNoaDQ=@lists.linux.dev
X-Gm-Message-State: AOJu0YxSSQBw6/yFYEdkl7jYIl0w1TN4t8G3WVAf+9KPMLfavuxYdfHM
	Lui3bCQxrdOAQlAxxb8CETeCd0yfkrDxbAwqvknZ32v4BLSDWI8TxjwuC0LdZKfcXyR8OH1zaYP
	pboIlUb2TiclceyvxzEW+sD8MhFPkBS4yjmAkiH4S
X-Gm-Gg: Acq92OEx/XJxrE4OzwvasAu68IG11yzmj7xAq6SHjQpr/lTj053wSlD5rID0RzSltDK
	Y7P+QSt5sTTpsXm6FXQ7h5HkFfJpqPTHEwseCniCYnrdcfbQwSPs56yJyzRnT8HJtK3/YfHbkWv
	TuI1WHLJmqLGZE/f2xuRlfqEk68lp87E9gBi0DbibZ/HtNsVIywmWHejC7yjxHXqNfDxCvgtD90
	vFagX5eyksXwdrpxJRvyQDKYI6vRNUsecqXtchyY0GOpMpn53oT//CluyTHcvO/ndNHwdG/RG8w
	wXikzQJ8YUVulNpywA==
X-Received: by 2002:a05:6a00:acd:b0:82f:776f:a78d with SMTP id
 d2e1a72fcca58-842b0f9987amr17980453b3a.19.1780987930373; Mon, 08 Jun 2026
 23:52:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260606215848.1951633-1-xmei5@asu.edu> <20260609064613.GA652158@shredder>
In-Reply-To: <20260609064613.GA652158@shredder>
From: Xiang Mei <xmei5@asu.edu>
Date: Mon, 8 Jun 2026 23:51:59 -0700
X-Gm-Features: AVVi8CcNtq0vP6OjZjLU7YHKFAxa-n9jLGai9XO-aEAr0BaDLTn9EOhL3ZDIi3I
Message-ID: <CAPpSM+QGAARoC2Jq2EfMkXCgBQXy7k64W6rBFdJ8mhpfrR0zXA@mail.gmail.com>
Subject: Re: [PATCH net v3] bridge: cfm: reject invalid CCM interval at
 configuration time
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, horms@kernel.org, bridge@lists.linux.dev, 
	razor@blackwall.org, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, bestswngs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for your review and the tip. V4 was sent.

Xiang

On Mon, Jun 8, 2026 at 11:46=E2=80=AFPM Ido Schimmel <idosch@nvidia.com> wr=
ote:
>
> On Sat, Jun 06, 2026 at 02:58:48PM -0700, Xiang Mei wrote:
> > ccm_tx_work_expired() re-arms itself via queue_delayed_work() using
> > the configured exp_interval converted by interval_to_us(). When
> > exp_interval is BR_CFM_CCM_INTERVAL_NONE or out of range,
> > interval_to_us() returns 0, causing the worker to fire immediately in
> > a tight loop that allocates skbs until OOM.
> >
> > Fix this by validating exp_interval at configuration time:
> >
> >  - Constrain IFLA_BRIDGE_CFM_CC_CONFIG_EXP_INTERVAL to the valid range
> >    [BR_CFM_CCM_INTERVAL_3_3_MS, BR_CFM_CCM_INTERVAL_10_MIN] in the
> >    netlink policy so userspace cannot set an invalid value.
> >
> >  - Reject starting CCM TX in br_cfm_cc_ccm_tx() when exp_interval has
> >    not yet been configured (defaults to 0 from kzalloc).
> >
> > Fixes: 2be665c3940d ("bridge: cfm: Netlink SET configuration Interface.=
")
> > Reported-by: Weiming Shi <bestswngs@gmail.com>
> > Suggested-by: Ido Schimmel <idosch@nvidia.com>
> > Signed-off-by: Xiang Mei <xmei5@asu.edu>
>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
>
> Nit: I don't think that the Suggested-by is appropriate here since I
> merely had minor comments on the previous version.
