Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169B737B003
	for <bridge@lists.linux.dev>; Fri,  5 Jun 2026 08:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780647385; cv=pass; b=TpG7t8kWeS8xOu8ROiP/JAARM6BkWRgWrzofll+DstS/pXoagTVvzpI8fC9lM05Fo7cl93G6x7Ply/o0EX3cOJgDeQBL8+6OweEoCkVsEi+NodoA5P0fGyXmbTKNbkm2zccpnmqOTw2sAa0asA2orxAaU0L7JUr3K6mszi/bSGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780647385; c=relaxed/simple;
	bh=XnAelB6AxuXfk272RlEQBTCRyboXtSXruWGQB5iba8U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pV3wvRuJ/HAhnt7Ktf9/AtFybxpsSd3oohFKKB4D1dZLP2qiQqvrxJYBXJX3KD6Vg3zqTH/mg3tBx8a+zQEj6mKTY66N8prUg2RDqpS4Y04N22xncu9lbXfRzmCT8blnP+RiFGj6fvQPjvLFwhFXrlAsEhGvApsTzBMGUNY1e3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LnywUiA4; arc=pass smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LnywUiA4"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3965adfd75fso16378771fa.1
        for <bridge@lists.linux.dev>; Fri, 05 Jun 2026 01:16:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780647382; cv=none;
        d=google.com; s=arc-20240605;
        b=T+U1f8WyaulwNpD944y7vOS+QTUcmJsCx74zLn1X0R55rcDhXDPqnTpo6nwkII4M7T
         CHphVxiqqOuLJ7nPOQ2BaFj73GG4jDrmcRrhJ9KKW9NSVLSDHORhrGbgxxzplrDFlfdt
         nFgAy3iajmNDor0YJ0EShErppSDBGJ1+VBs9z9A61rSh01cWVg1GfEL/bJ1iYQtnEmbq
         m/L2LNrCx4sKauJd6sSysw3UHQZrry3Zg0cgrdTU4rQVN7LCLjbZAnW7IX+FpKB/ZXxt
         EX9Hf1z4+g00iJ5r7A7iLiF0yp1aE8orals4cDNUWXlXqgC0NaHlni7+D0bGTleQZJZs
         7fbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=chP+DoD6o+jNnBy+ko9NHVAvB6qXMkilsQ0fEfCieus=;
        fh=b7rnQsLcZ2XRggjM3I7pwFmNTj29Sfzg4WlcEO90w34=;
        b=D44wGr7WCmZUXe5s8VEhC/LoZ9rN/iwaPRJywe6u6BzgZupbDp3DY6YEwxFMLQc3/z
         zQpZSQbMSEsnOfV1pf94y/7bXtrZoExEln3MwCHo1O0xqLNrfl6i0r0YX61qYsk62xZT
         P8e1shyOdp465rp9iZjv4650nDlp46gAgniDB4y3OE0NAenRfL5gxH6yqH7jOcn6km1k
         9maH9/VN4Ab6VuQ/q3zOK1IkIyKbngn83GVRY2NNKNFKckIAnegw23OGIz+8m/5w8ubt
         H0YwJ7/pt1wlWT4LEZRMXI1vCASY9WxDMutoTW1C7KfKPBXinVAX0Dt5jUih0YvNOVsS
         mVBw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1780647382; x=1781252182; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=chP+DoD6o+jNnBy+ko9NHVAvB6qXMkilsQ0fEfCieus=;
        b=LnywUiA4fsAzc7gTQLWwPX4EFQygZynEZnsBvhC1HczIUx7DH22MliQDqJgtVJDDO9
         vPfAKGA/r9u9i5Ew6YPpTtXjC8+nPEaZ/MgiKoC8nYdjMaDzZJR5/rlm2SpJ+AetsboY
         qwQbYZlzTCV/vsRY7XFMVRCUDOrl//m0Cx6pPuC66Gbcs7FI3VfyMFkRO5G01Q5FKYZw
         N46nO3nKt4iXk//zeJlou2D3g1tZzuytQUAKGaXZDyAFIpKiC70aYQsuhRvh9iUvXjfx
         s8l0/ya9Q8fiPbDgcvJfJNVW/QV/NcEPlgfTkSpWsN8ZS3/pzSvOrupJ5brB/lsbKG7m
         eiZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780647382; x=1781252182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=chP+DoD6o+jNnBy+ko9NHVAvB6qXMkilsQ0fEfCieus=;
        b=cwmlqPyYcLiANRySNsv0quHPAFl/NCaWqsTMQiCOJIJXQnIGylmk+gM0O+AS4T1Qdf
         tQ17rfUV6ga9KeqO5Bt8lHpnlxSiGrJXyVx30EAHNvm+n73dx/bH0k65YPGVJUTHSkux
         LqNSbYhbrFhljLocP8sGGsz4jL26bhSYZ0Nx61md9YPZS1JR+TZFzFzNLvrGuQRn+Nn8
         1Pp6PgIrTWRT0RKwjGHlNHWphKfi6Fl7DZ88iIhc8DC2Ftc2Iu8v8xntPGipKaDr3y5R
         R51tb3719obiSl93PPT42RcnW6S6zww6Ry6Zv2lQtBm8YpIAv/Incb8GhSLmNzSUS9hr
         1+Uw==
X-Forwarded-Encrypted: i=1; AFNElJ9JicZr5rCdwoTaUX6R+GJNoPK+Xq5ghNGH45pit1QYqgt69fVYdG2zCxCK2qNQ0IlOuLahDlA=@lists.linux.dev
X-Gm-Message-State: AOJu0YxXldlhcEpSU4sCFCYszHCk+h8HuVf1+cgYdwqUskDEKebNTLFJ
	zIvDsdsg8WVpnd/etaZ4Tbmwiqdr5UPqzSKXOqjyHNHblyC8flo7coGESrQCIxnOSn0q57d3cNW
	cHsG+MAEUyLzVs9IEOYWRaFm5on2aOe9FgpxoV/eKew==
X-Gm-Gg: Acq92OESNa3ZlDMSvsW7R2SI0i3X3lySrjLIaRwE7BtXf05UO06eyDQs1tY4WCD1Jt8
	h6WFWvfGTXTD0XHkowWO820iIN5o0MSj/3M1zAq2k1YjueTmUIAhOn+g0mnyQsXaFFiJagjgSkm
	wWoWRWw0A9Ln+30rQgN/V/XpijUe9l0d4rqHibSB+m1OA1/AONW+/4bKNl9m+t7V8ll3lwaGGOB
	q6LFazhVFpzgkZt4cM4AIUf1Kw7BRNPRaIatl6MNefFlM6YQJ+k5IPnHIcuoPjrZ79t5FTJQAnL
	ThHKI3W06FlNkHEjt7htNfWKEAIqY0L0F3d/EfrupIKYJYNbBcc=
X-Received: by 2002:a05:6512:804e:b0:5aa:6d0f:d765 with SMTP id
 2adb3069b0e04-5aa87b80e23mr404631e87.20.1780647382332; Fri, 05 Jun 2026
 01:16:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260507134815.295588-1-marco.crivellari@suse.com>
In-Reply-To: <20260507134815.295588-1-marco.crivellari@suse.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Fri, 5 Jun 2026 10:16:09 +0200
X-Gm-Features: AVHnY4Kbl9XFe5VYdITzs-SAi1Xwku4lxaI3mSz8BfUmYzi35gpoXXmtmCC3UxE
Message-ID: <CAAofZF6CcyxoOsYr94KARUFtfi+=H1nF3mBQAtFWxEujdVgXUw@mail.gmail.com>
Subject: Re: [RFC PATCH net-next] net: bridge: Move long delayed work on system_dfl_long_wq
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	bridge@lists.linux.dev
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Simon Horman <horms@verge.net.au>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Ido Schimmel <idosch@nvidia.com>, 
	Nikolay Aleksandrov <razor@blackwall.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, May 7, 2026 at 3:48=E2=80=AFPM Marco Crivellari
<marco.crivellari@suse.com> wrote:
> [...]
>  net/bridge/br_fdb.c    | 2 +-
>  net/bridge/br_stp.c    | 2 +-
>  net/bridge/br_stp_if.c | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

Gentle ping.

Thanks!

--=20

Marco Crivellari

SUSE Labs
