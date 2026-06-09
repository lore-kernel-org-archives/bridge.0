Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF763ED3A3
	for <bridge@lists.linux.dev>; Tue,  9 Jun 2026 08:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780992846; cv=pass; b=igW8WR0P35V+eoTkkwDgPkcl2yOM7O3grN7iOjNvDhr3cYo+ZBOeQXiF/lYXATJJek2m7A6UY0piBVfoUAvN8Ky+QBm3w2IxqZvB99DpL6z52QWvywqrzvfwNs0wlXdKBue2UKKR+6gYb2pXpJ+8czs4gQQbbu2IWSQIVH00GUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780992846; c=relaxed/simple;
	bh=jpBMVbXcusrEMvBmUF/dRJ+gQ1j6wnRpj0ePwoXw71Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L+TXwu78KysYI9Ep5PRILrv/IjKrI8217CKD1Ki17j0TJmYTzp3XQp7A4dZWj6yVPQAOVNVXlDbJkEfSWF7xFUyKp0NONQwtbqscdzuPsSUaQ7fLQt3EqP8EXfkAc52DGIEuRKGRZvZlj6o5U1MXKvDZOWMQ1O9YLX7kYSV49L0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=V+054JUl; arc=pass smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="V+054JUl"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-36b7b7b7a80so3330345a91.1
        for <bridge@lists.linux.dev>; Tue, 09 Jun 2026 01:14:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780992844; cv=none;
        d=google.com; s=arc-20240605;
        b=IGmhMW5vN7Gk81t6g+lN76ketAeKHXsoqXAi/44Sc2/TdhLLb2Nrg8osiPBZnzBANo
         lzckrl56F1ALYDk+2NdkecvWrWJS5isa31VmVXEBCur+F+eFxs5nAddR4A5tGAri+yAi
         mz0MrjmckfxZSuVwuvi5KpW+oIv9i1txEwsjVxLaT4kOAkJnwDBOWucN7CxMyJWlTxxy
         TKj0kMjbj/KqVF+ZsB/3kPzTPIGUy2HVZlyFdMOUaGUFtDtx9tndYYaUhp66qAokhbWa
         OGdqMdMoSSAvckY0NOudb2+QJ3bhph6RL55lWltovnlPmTxX4AB+kj7QvH8Cb/beh4Gi
         YMeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=v9VryaH60xfoLk76bMOCCDJWPkr3dAUhALxUukgVR/U=;
        fh=L3jlN8el3Sa7hwLuuOlH+026rSByqDvHZ4NLDkV1fB4=;
        b=VIMjUDxzodGHNUlg3TPhMu+NLPXQqejTO3HFqfZYx3gZUdEcexW27yAElSLhN4vExG
         CpeFSdI/WGQMtC1wKasvxtvCsXvI/87B1D3sP9RLDkLOPeCWQp89yacGyoddhLk/oY1M
         mUfEkvBimC1+FiNDVjRYNvy9MmioFTeHFAdnoJRVSYPjL7fBzdhXFU+DUSFrPTF18NF0
         LPwnwl0XPi3sNZhpOeF5yeWfV6DWMlJc1gSbiUiDbTl8l7oK4YB8RyZLYY3FkDRuF0J8
         cgMYSZXBRlNudjWs4C5pDR7umNLUhYd54lSt+Ps12OwlXorApGNsr5T/7YBaOCGDQHVm
         76bQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1780992844; x=1781597644; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v9VryaH60xfoLk76bMOCCDJWPkr3dAUhALxUukgVR/U=;
        b=V+054JUlF7uvoGORDEsifTf8ZXH5D0VH4ELF/f78ZAKWRwahcNrIoFoc/G3c/TOISN
         xNzmtCZiBoSI9hNqsxa2cP9b7jCCciFSPy3mNPmyWn4POm2TaNHzY7Gw9kVh7soUoyIb
         dCXjIxz+zzfXNhfKaRi0lPIw0wL4Q8ADfiY5jcxMIHp0R9bBkKSC6EJpDbaLboJE8b02
         9RkdSCffe26Ozlpm5z/58SDsmbFwZqEGf6iIiYuoPiX5suKX5RiDJ86UNq2wqNAFuGHv
         BtHFP+A1ktpqDUTIkRdxRv9OmADn6N5bvyNKM8kHBzrs/h4mUwxwnEtbG/hH4X5l/Zh7
         diHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780992844; x=1781597644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v9VryaH60xfoLk76bMOCCDJWPkr3dAUhALxUukgVR/U=;
        b=iTxIO9SuDY8rq/v5IsEzv+Wd0HReQcnXhN/nqeE+mZ6gnYuss+3Wb8xh+4zB2Yrtke
         wxfIfbRoUPwsglzieMyQJLbMtO1XkEsqeX1PyxAp+Sg/IdXy9Br7KNrk3Luvhner+4b9
         Jzng/Oi7FPrMYrbscCZzTNvpf1tcmwqaB4SKVf8I1O99LEIVus32K7L5Xy6ZqHRWMHUn
         L6Ux02KXWHYuRMYuUM/xJsB6t9h4M0chBgHh0rZe9FtBE2BdWkK4S/tkxpqmp6g8zQ1f
         xUTYD2fshdVckSibkstI4/9qAow9R6NpM0A0wml8Kn8ZjMQusG9fmgnE2FdLCokKBKZV
         oSwQ==
X-Forwarded-Encrypted: i=1; AFNElJ/BpigBTmDw89UFv/d3JH6HWeTFS569xnreP+KDpJWO2alNT561eGFCnZs3767xu6IYp2BZQqg=@lists.linux.dev
X-Gm-Message-State: AOJu0Yxvt3fRMtIOUAm20tlfMWlzvEaKklV9Fy1ntqlceGyll/RpeqR9
	wWfft7zLlQxlpFwsw97/qtbIol1GNASOM9Ks39nkjrCyBRskNBP0LLB+9C8YLEVhSgHNDvTEASb
	yUPD+ULmtQ70lo7bW8fbegaLRfl6cTJmET/RBSxK+ipvo6QKnQ6vdj/1bLsc=
X-Gm-Gg: Acq92OF8PGJBtqgzehjiZFMhWHrs2GqlmDr2H7NIyuqVHNWQNCee8GCpdrYgbP+w01m
	Th41dTIsU27MLIYl0RK93LjGvjL4GQnwX8R+P9ymTIDuatL7Opz1Iqhki/mCuJsKrtOIBv13rcr
	64ef3O9jOulCQgM7taTC+NXG2gU7GkWJGAbQObhkO7S5bQjvCv/6dGn/GX5NRVbGzZJy/xFlVdl
	nFlfP5BypCpGpgA6hDZ+3MS9AOLm0jAUN5OfBXhgMDOEWGeT87Kx1YvqUzReCJ5i9O1+bARoskZ
	naRPFYgrOKeaalwWxw==
X-Received: by 2002:a17:90b:3903:b0:36b:4d63:4a93 with SMTP id
 98e67ed59e1d1-371328ae3c0mr16093603a91.13.1780992844361; Tue, 09 Jun 2026
 01:14:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260609065116.2818837-1-xmei5@asu.edu> <20260609074606.GC663407@shredder>
In-Reply-To: <20260609074606.GC663407@shredder>
From: Xiang Mei <xmei5@asu.edu>
Date: Tue, 9 Jun 2026 01:13:53 -0700
X-Gm-Features: AVVi8CddlugweTVHZnFbsUW4hGvFX4X5keZXlIefSk9fZFfXDwmQ5mvxObZY2E0
Message-ID: <CAPpSM+QUrK6mMSsngGpU0=ym2cMqffWKq6to8NUTUeCO=M5OrQ@mail.gmail.com>
Subject: Re: [PATCH net v4] bridge: cfm: reject invalid CCM interval at
 configuration time
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, horms@kernel.org, bridge@lists.linux.dev, 
	razor@blackwall.org, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, bestswngs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 9, 2026 at 12:46=E2=80=AFAM Ido Schimmel <idosch@nvidia.com> wr=
ote:
>
> On Mon, Jun 08, 2026 at 11:51:16PM -0700, Xiang Mei wrote:
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
> > Signed-off-by: Xiang Mei <xmei5@asu.edu>
>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
>
> > ---
> > v4: remove the Suggested-by tag
>
> Should have kept my R-b tag...
Thanks, Ido, for the tip.
