Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AA43C0624
	for <bridge@lists.linux.dev>; Tue,  9 Jun 2026 07:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780989771; cv=pass; b=ZhvypGdHihYNMwdTIUd6Skc0aZLED5PH0BxmBMlxqh7t3yhOvjyOpWkRlz5p96u+nS6mnVA1Atu7hOaWTIkUCjmzk0S5Fbly1ZuySGkv3EE7odiZ4vccDtld707AFKzgMgPDLj1+UV2lFtV6eOjgC67Uj1KAb+Kn8vY0Fc396Ag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780989771; c=relaxed/simple;
	bh=L2fJeoj9ZckODw6I+JHP0ss2IJ6JLk/k6cCU+U5PeT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mswSgYJ+nd9c1lBwQdVwNMDQtAavTTNP8DeR4DaRYXypKkTQ7LmbwjKw5zmnhUUVx8Up+1MVaxOOjC3WCGhOiv2z0l1gmdqaBrxzYLR1/lyzAdmITUjT6fOW8USzNYyVAe85E0wNhVULP50Jqqgd6pJv2HjZhC1ijZSQ8V9QbEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=KeBk6800; arc=pass smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="KeBk6800"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-84226d0f1d2so3462848b3a.1
        for <bridge@lists.linux.dev>; Tue, 09 Jun 2026 00:22:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780989770; cv=none;
        d=google.com; s=arc-20240605;
        b=fpvnBWX4Fte7fGmU1oOKNcvy5YmN7Bkbyp6g5oPdDdJSlArumvmQVRcCLrB5TWmM+/
         WBN48CysfGWZT7K0gc7R/FhaPapeEnVNogspF3zkTZai5CqusiumBlB5GDZQN7Oo9oEo
         tcbBEbVlo+7zNVzmqy++eZ2ZgF583aBItwd9mHt7DXjXRwVj57C/Y4m+czl+wHpNzMMx
         aISvVo4h0YrvxbYZcudkvbAfsmUAUalgjxbGgo9r18TzjZu+ojaMY87zTWZbxKFa+UcN
         3PmYqORlUG2a62BDiiIY8lYwyubg60Taa+pVC+3XX5MlTbMBCU/QAG52urA/Oz54CQyF
         XoPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XhzBDyqhqWawgeb7Rpt+eyD0SfA21gLZx0HZ3QvwY44=;
        fh=xp68UIfY9q+ogy0S5WFa73NyympWZSWNTddlwOgUNzk=;
        b=HupAlQIpGoOZUH/3R44SvqIN1zLDI07Y5HdzsY58fsm04W3C1kakRs3Xx6ylLRzRkV
         vmAH7ftgDH3RuQLDFWZ0Hy3q3rMK2sL2jqKJXso1Xdkr3F5XLkBhqbI/BmiriSs1Mj7/
         F3gvLAzMYrVlqVIZvMnXWn97d5UWu7zjn4yNONJO+KssANWVzNP5HQo/eVgwJ3dASDXo
         0Sdv0PPV5cMVIkf+3VKuTCRv4FztMr33QxFBKUeOAhZCdzmr6gvPbP52dG8qRDIjI0YH
         OJxqYr4AUobdl47oGeIR8N1Zm6mLw4OWIZzZuxaRVn0W6VhzXrulaPC7fbq9yQgvp2Mn
         0Ucg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1780989770; x=1781594570; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XhzBDyqhqWawgeb7Rpt+eyD0SfA21gLZx0HZ3QvwY44=;
        b=KeBk6800NMG+02sRoEI+Use2zWSgqlWcITMA93/oI0vUMlUG56uMOTlSjyI7tkucEs
         JNoe6PM+E7OQBF4uDb1bzEmkEg8uwPROl+mwqe8nce7rf7rMUBOTk97Rhe6fC58RiGW/
         G4cBi8XZzRdTpUZt8POBWMLOg9Xed0sPHZAPfxiDIpPn6b4K3GPutSLv/fA9sNnkp9Mt
         CIXMFB1c3qJOPGjLRfGfUGdwXSgRRR2lrCEXSJezjktvvJ8LnIyerU2lCLoC5S/cxWn6
         MJR3/wK1tae4xS28WMrz/YT/Y2nLwEe6htXB70Om+A5dvTnZTyuOiHGBB2d8a++bIp1s
         IE/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780989770; x=1781594570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XhzBDyqhqWawgeb7Rpt+eyD0SfA21gLZx0HZ3QvwY44=;
        b=bAch/lrALN6okUOBqmrSrCCHWxyAgS2PWzjfAR+VvSOqBrNrHnsk6lg1/o8rLeWIOb
         5a44ZkM6GpQknaAy5vSTuHmfJAj75TB5jRJlq8MvAPrdsg5omwcgwDH+ZOA4iELryBHy
         yyK4p8qopAZvsuqRBNrg6ikYGMiM97hbn8dvYEur7GokhJerKqUSSwDpgo1+qADAcQzV
         0HRDpiSHD3RMUFAeNZX+Fo8P3OjqIv5gP0ytp1NWoSJq6bZaXm5DTJlvHxkSTYBO/iCO
         lcqCJcbA+9CBGjcbpbc1cqO45jvkOMoVFz5xwS1RgJIP/SIzGqAiwBKH6+V0hq9wDV7e
         5W4Q==
X-Forwarded-Encrypted: i=1; AFNElJ/jgQVwcnIV1tLo69lfxoNwoarCYOqMx/VQMex3GVr/bpocplF/0CKWmrXau9bPS6dryScbzzM=@lists.linux.dev
X-Gm-Message-State: AOJu0Yx/PQMrt8YVR9jItlmuSS758eAaccSOznownp1NXjhroLjWOln3
	9zURQcKBIQAQjDHlPlvu++7vcrx1iq9y6TaXujnecenOsciAft1mC4/sRvT5XOXL2pwSWv7nUmP
	qesQPJrsSBJSNj/e54wilSOfA1k3P80747ubkHS+a
X-Gm-Gg: Acq92OGlNpXkFNFCxvI/ECYPNFt9KWAfoVpJjlrK0uZENQdW/EWpzEEAc7pBdo8dJT2
	2JQSoXUnhywdZUMgg9TWamSgesttsxfXO5emQIqnkNslbMCBlgF64br8Kw0Ad+0uEFrAJX28Xu7
	BRlABSdELsy68/VtA1XBzt4vb2nt+duKEvKc6oK1l6xifvPOYejMqDVqfPm7Mz4Rge3BENNIwoP
	YW1M1FECw14HceCDh81OzmfARJuBRksK8ZOvEN6er/xNt3CC+2GhkXhrfqYNBGazEGkdccZPRCY
	jXuHgQLz3eN27XQaRg==
X-Received: by 2002:a05:6a00:2e18:b0:82c:6aee:b21a with SMTP id
 d2e1a72fcca58-842b0ec6826mr19358557b3a.45.1780989769886; Tue, 09 Jun 2026
 00:22:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260606215848.1951633-1-xmei5@asu.edu> <20260609064613.GA652158@shredder>
 <CAPpSM+QGAARoC2Jq2EfMkXCgBQXy7k64W6rBFdJ8mhpfrR0zXA@mail.gmail.com> <099ba3ba-49af-4ed2-8b58-31f8132f0d32@blackwall.org>
In-Reply-To: <099ba3ba-49af-4ed2-8b58-31f8132f0d32@blackwall.org>
From: Xiang Mei <xmei5@asu.edu>
Date: Tue, 9 Jun 2026 00:22:38 -0700
X-Gm-Features: AVVi8Cf1pKtYuSzwyuVqnoD65scraW516qZkZNa3AxiW1AO5tTzX7XOZgeq8pmc
Message-ID: <CAPpSM+R1nbAwJ5oxd4csVhwPHTVLo51DCEcM2Chm+s6oh-G0+A@mail.gmail.com>
Subject: Re: [PATCH net v3] bridge: cfm: reject invalid CCM interval at
 configuration time
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, horms@kernel.org, 
	bridge@lists.linux.dev, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, bestswngs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 9, 2026 at 12:19=E2=80=AFAM Nikolay Aleksandrov <razor@blackwal=
l.org> wrote:
>
> On 09/06/2026 09:51, Xiang Mei wrote:
> > Thanks for your review and the tip. V4 was sent.
> >
> > Xiang
> >
>
> Please don't top post on netdev@.
>
Thanks for the tip!

Xiang
> Cheers,
>   Nik
>
> > On Mon, Jun 8, 2026 at 11:46=E2=80=AFPM Ido Schimmel <idosch@nvidia.com=
> wrote:
> >>
> >> On Sat, Jun 06, 2026 at 02:58:48PM -0700, Xiang Mei wrote:
> >>> ccm_tx_work_expired() re-arms itself via queue_delayed_work() using
> >>> the configured exp_interval converted by interval_to_us(). When
> >>> exp_interval is BR_CFM_CCM_INTERVAL_NONE or out of range,
> >>> interval_to_us() returns 0, causing the worker to fire immediately in
> >>> a tight loop that allocates skbs until OOM.
> >>>
> >>> Fix this by validating exp_interval at configuration time:
> >>>
> >>>   - Constrain IFLA_BRIDGE_CFM_CC_CONFIG_EXP_INTERVAL to the valid ran=
ge
> >>>     [BR_CFM_CCM_INTERVAL_3_3_MS, BR_CFM_CCM_INTERVAL_10_MIN] in the
> >>>     netlink policy so userspace cannot set an invalid value.
> >>>
> >>>   - Reject starting CCM TX in br_cfm_cc_ccm_tx() when exp_interval ha=
s
> >>>     not yet been configured (defaults to 0 from kzalloc).
> >>>
> >>> Fixes: 2be665c3940d ("bridge: cfm: Netlink SET configuration Interfac=
e.")
> >>> Reported-by: Weiming Shi <bestswngs@gmail.com>
> >>> Suggested-by: Ido Schimmel <idosch@nvidia.com>
> >>> Signed-off-by: Xiang Mei <xmei5@asu.edu>
> >>
> >> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> >>
> >> Nit: I don't think that the Suggested-by is appropriate here since I
> >> merely had minor comments on the previous version.
>
