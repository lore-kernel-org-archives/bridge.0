Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA7BBA45
	for <bridge@lists.linux.dev>; Sun,  5 Apr 2026 00:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775347511; cv=pass; b=gWFRujN7meUJgzxSHTlwG/uSUxDCHcc6ehIePS793xzxjNhV+skugLJLfZ8V0GsF20iLe0Y47bNcLYqLzRrVpvBzm3R4/KJ0AFexGHTD8Yg/4jAHIVavykCi98Dvu+h2CxEjgZfxgO6RpQJWLnbGNlRzCFPDJT5YQ7BKTDBd+vY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775347511; c=relaxed/simple;
	bh=R23rsYH+zgP21jS79cqvnw2fqeQu7QiruRCG+NqhnIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nDF8ln34qY3DYHVMiWMlAzAxVTZ705XMJNbszMTnuuGjmz8N33fgOB/O1nTr9gE0LIh6+uno8mPt4zgVpevziqV73a1xG1YHxSb5JIe9NRhSly1fl6snRWi9WyJbBifJ598BKwlgZ5vavXIlnsnK5R3sDQ1lvewnR7zO639iZSU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=VJ7Bf78/; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="VJ7Bf78/"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2aaf43014d0so20660585ad.2
        for <bridge@lists.linux.dev>; Sat, 04 Apr 2026 17:05:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775347510; cv=none;
        d=google.com; s=arc-20240605;
        b=a1hkesrluyGF7JWbGilMEaF8tJBM+JEz3UXDTdQ2fnXTxNCz/NZNkPN9KUG+nC2lhh
         4WVVL+wrnzAryOajjleHos/oQ7+YLKmGWq+bOwUTalSwaqeCdN3Xl7twxa9zJKYYj+kp
         yBIEfEaoE+wN3YNOUwr4jEytl4xz0Rif6cyVolpPlgmqSGfwpqMGy6k34QCvrmC6m128
         ZORmqy1Aw2OgpPgGWVH87pQOO4SBcB15DUkhbIZkcUopvLars0pLDHkonbMwq2rEj+mX
         MeYYcaM29UOXjs1ps54BPTM5WSCNmBbj0ypI9W9H4aOyYIMEDtB7L2VwxWHSLQauBfxM
         J6Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uBdFnIwU/qogTBcIt+veH+3ao5W7MrcqdsJxPS4CqGw=;
        fh=HQk0Wm8JWDRYI1a1Sni14MxVnFr89OGaLkeo2FbJXGs=;
        b=hSMGOf0o9W8e2ANMuxn9OOyIgXt+qgPZq8Ifak0SsijSbl6Yw3DDLD8m5edSQcRTQz
         h4zPXIaa3hnJIifWlHJZWQvpWbTadty/3IerFe8U4EFzZyd/gbg+je77EESBR98ONG0G
         HRxIfi8kHF5ZQwO8/CFjGb/0DVHZXOhRKICKEIuo0eb+otc94ibRRwRk5RztoI5AiCrd
         r8u154t6PwyHdrK4y0sXuvzRASBpFpCOsq8Y16vcFZ5ZncRPI0sZEiVCGhr8Dq9UAvWi
         oqsoaDmpi1tJG9css98wBD9I3JBMfqLi/i1reDKcV2El03nzWqHV4d65aMkYA1dHKqPj
         Ut2A==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1775347510; x=1775952310; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uBdFnIwU/qogTBcIt+veH+3ao5W7MrcqdsJxPS4CqGw=;
        b=VJ7Bf78/MpRx8zMFFkEOeTFS9+YDlBxwMqYEpM7McxXfstKB/PqyOvCx64laq95VA3
         hhNW6cTt8wF/Y/HVuTVjAsVEr+fWBVELDZHGPrkxKaHiMpfJGANIRXbmrTUur5o7DuED
         RFrHMea5x9o31pjH+nK2ayl8xZYHsE/56/DIw2gxD5WCYl0wSThJvjSrRE0kGc5lss1m
         WwFn5oi6i/UZojltBYsxLBQclIXrFcQWVLt2dDARnHsgzLR57ZBFtmengcW2SJDiIvAC
         eyIQ9359A3a3d4m9Q4IKsA/V/ZX+v7Ev4+WfEcaCW3T3m1L/Zm5MwZzcViYoCb7Ac4RF
         ftfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775347510; x=1775952310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uBdFnIwU/qogTBcIt+veH+3ao5W7MrcqdsJxPS4CqGw=;
        b=Q6I40R0LpI+VxI5Pt+tffaNWW8Rh2A1xMmBB75D/a6LpACwY4szNLOrGp9gxRj2UM9
         0G9ryXX2qgVvLYMWbmLvB6x2Bmcjuc1jHWR4i0kd3XqRBHy8qiT1D0Cys6TsoU3c38za
         w/x4I+e5tctkAzUc35pEM9gFl4KOuTS0hC3NVggQmaHX1uFQ16d9TFPmqGHdA36F2OGB
         qwsAozN0Zs7vQQ9sP6qGnznIfV44xyIzJHEMn6kzH73ymES3yIhWgTkFb0bLFwJL9pD0
         /NWOT76xYrUp+0Bkjuw0DCj7jYXw7Bqt38QdHmSxOHwKoW3kZJDxY5ymXPRiW3skElKF
         ZuIQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/GZoQxdbteTDZBKz9Ylxkk1RUlJV06MeWNk/4jdzA4p++fulhlD1dFczRsbIjqr7paSi8FrA=@lists.linux.dev
X-Gm-Message-State: AOJu0YwPaC4rc0tZ8Kd/4hPyUGH3wd3+EgXAYNl5H3s1OGlhydC4YiO6
	XpSD9QIjorUizURdJvoBI45ImrkhUxCnS+lDDxLGo5py9kMyw2DDNQuRiCEOkZDmOKg6UzJFCPZ
	vWdfjOgA1z8B8ZimDtnfpjKcMR0n7KmAO20LfXCHX
X-Gm-Gg: AeBDieu2b4y6V8AqoNUDkhuTvO7DgDCHdBLSTJbUqQk6TwVNqhqTtIBH//h7gtIiLKJ
	S1IL7Q/fl8zdD/PeMnFo3RwVs/xCZ4rbsYYp6FREgweoqwqvZ9+4KTpyLWhkLNifyY2PEtK5rNE
	wvqF2zPtE89KRqkGzqy9leqa8rdTKWbDRyRnNDyKzYqH+QjhH59djRc48HVpkOHvf94I5p22MX2
	7fCwkdsBErXyr7h/LLzkhDsFZWMKQqaxNF6O8bQyXF5aX4bHdog7wOCI3du9/HAV6BPvutPjR4w
	S1kJ6rI9
X-Received: by 2002:a17:902:f54d:b0:2b2:4e1a:aff9 with SMTP id
 d9443c01a7336-2b281997e1fmr78997865ad.44.1775347509777; Sat, 04 Apr 2026
 17:05:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260326031957.3299500-1-xmei5@asu.edu> <20260327112056.GC567789@horms.kernel.org>
In-Reply-To: <20260327112056.GC567789@horms.kernel.org>
From: Xiang Mei <xmei5@asu.edu>
Date: Sat, 4 Apr 2026 17:04:59 -0700
X-Gm-Features: AQROBzDVrru311INQMcAH2NeVIDVm62F2BspdoCZ1Sm8hSx6TOuC6jLJ0FBtOPA
Message-ID: <CAPpSM+TV89o-aj7SVsAWPcVVSSte5SENe8f4tGe+Y23CHza+iA@mail.gmail.com>
Subject: Re: [PATCH net] bridge: cfm: do not reschedule TX work when interval
 is zero
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux.dev, razor@blackwall.org, 
	idosch@nvidia.com, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, bestswngs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 27, 2026 at 4:21=E2=80=AFAM Simon Horman <horms@kernel.org> wro=
te:
>
> On Wed, Mar 25, 2026 at 08:19:57PM -0700, Xiang Mei wrote:
> > ccm_tx_work_expired() uses interval_to_us() to convert the configured
> > exp_interval enum into a microsecond delay, then passes it to
> > queue_delayed_work() to schedule the next iteration. The ccm_tx_dwork
> > callback re-arms the same delayed_work struct at the end of each
> > invocation, forming a repeating timer.
> >
> > interval_to_us() returns 0 for BR_CFM_CCM_INTERVAL_NONE and any
> > out-of-range enum value. When this 0 is passed to queue_delayed_work()
> > as the delay, the work item fires immediately and re-arms itself with
> > zero delay again, creating an infinite tight loop. Each iteration
> > allocates an skb via ccm_frame_build() and queues it for transmission.
> > The skbs pile up faster than the network stack can free them because th=
e
> > worker never yields the CPU, rapidly exhausting all kernel memory until
> > OOM deadlock panic.
> >
> > Since CC config and CCM TX are independent netlink commands that can be
> > issued in any order, there is no single configuration entry point where
> > rejecting interval=3D0 would cover all cases.
> >
> > Fix this by checking the interval at the start of ccm_tx_work_expired()
> > and stopping transmission immediately if it is zero. Set period to 0 so
> > that br_cfm_cc_ccm_tx() correctly sees transmission as stopped and can
> > restart it later if a valid interval is configured. This also avoids
> > transmitting a CCM frame with an invalid interval value.
>
> Hi,
>
> I think that the principle should be that code that doesn't need
> to be in the datapath shouldn't be in the datapath.
>
> So, with that in mind, I think it would be better to set a lower bound on
> exp_interval when the mep is:
>
> a) Created. It looks like that happens in br_cfm_mep_create
> b) Configured. It looks like that can be done by setting a policy on the
>    minimum value of IFLA_BRIDGE_CFM_CC_CONFIG_EXP_INTERVAL
>
Thanks for the suggestion. You are right, it's better to move the
check out of the datapath. V2 has been sent, which blocks the invalid
interval in creation/configuration.
> >
> > Fixes: a806ad8ee2aa ("bridge: cfm: Kernel space implementation of CFM. =
CCM frame TX added.")
> > Reported-by: Weiming Shi <bestswngs@gmail.com>
> > Signed-off-by: Xiang Mei <xmei5@asu.edu>
>
> ...
