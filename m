Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FCD423765
	for <bridge@lists.linux.dev>; Thu,  9 Jul 2026 12:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783600979; cv=pass; b=s3Ikv1gx4Re7hiCqpOrxx/svbWdQ7MG7StIeu7XqdfQy8OBFo3O28rFZcsYfnvdbFTe0R5CVb4Fk3IX5YK8PmAYoLzJSA/WX6DDzHD1uMZ71PeREjTEjcrO1aV48Wd3hVuk8emBAI2S5vYsNJUaO43UJD03UxPUAa/SJFuqKq5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783600979; c=relaxed/simple;
	bh=lGxuTmJonByeoKZLNGDqsTWGMGeNSB8gf+bZY9/34MI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KlNtumz/V5FPIvW7b8nQMsgVD/Hu4ylIzH3WriX7T+9231M0s1ioV1Q3Iz9h0izalaiJiVupeDornszi7bvltb/dKVBAi9e/cs2LpXeJhIO3qP0K7hMWAXCVgkkHy/HBLQKC+XeJg4pmiyvL+cnuIH2DcQ/kc3Lhhteb7bIcVn8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oGfYGkMB; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oGfYGkMB"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c15ec1da77aso56600466b.2
        for <bridge@lists.linux.dev>; Thu, 09 Jul 2026 05:42:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783600974; cv=none;
        d=google.com; s=arc-20260327;
        b=YWbA+SyxpNTKnHg6VFoTOsOW3HQ65/Xb+zW7dURbC1723FbXUPIe9aw1q0+7qskngZ
         BxVGuZhroxQh9dIDQ+c2lu3Isi+sZTM9BWYzCkqUDne6SCKT8Fy1XS3KNKKIw8QZGHSx
         hrbIB2jQrdQQJXv2XNjuezgUWBnAi/tKSye4bE5Qu/b6KH1xEy2rMpmxuD0NZpnyFQEI
         eP/YanZxCUmLr2ruplkrw7uFEvk0uU5fyYz6WrJftavcdqo2q1DM9VCmspylQJzpP6+/
         0jkgzhk/22zwcnel0sWIAGGt49V7YbbVstnk5mxq1R6RQLBaB3LFWGBo/HkE7X5AmglD
         ypTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lGxuTmJonByeoKZLNGDqsTWGMGeNSB8gf+bZY9/34MI=;
        fh=bG+5OxA3m4PGRZw77nUFa/nqwYLPFvOjR7mWZzU7FTs=;
        b=a3JS/SVgVjnaZvNYnE6chXq7W1LCdmBFXVyMwQubczk4ZPBatLy3hHOD0+uwQ0eQVc
         u+fVlvTuBZcb9hKs+kEs2j1QZqMFVRIn3sPZ8TK3e7PXAYbHpRygkYo8baZIyU+nT1Bp
         Ls2D2g54pQrxknlxBr+cnlA7nvWkP7GVXLMq1h/vciH0/bkW6/9gj/Qk/NL3IyHGiaXN
         W65L2W12VestwLmi65iEhOdLxL9U/paTUlofI0xNoqSc27VJmNdOt0zoAuGk8METz4FP
         nfq4e5NEjQDYF8H9Vn/UCigbLcA5jQYA90JWjxRSczGFy7jmbPGeSM6bb1WVA2KV2DfS
         NV3g==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783600974; x=1784205774; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lGxuTmJonByeoKZLNGDqsTWGMGeNSB8gf+bZY9/34MI=;
        b=oGfYGkMBbDThCNx7j79NC9QOLGt+6E8ytV63RCLBTfzt96KcgXoo9qkNGK+FqJj76F
         nLbPraH/Qct5gyu1+DWtJQsphhL4FrKo5/gO2agCVMiXiwaUQIlSFyt64Jjy8Zj1hsKb
         scmBLZgrqAIDPWVKJWx5yRW9efdrkls1iH1CcVMY796TZxTysI+sQbZhTpIMdURZ23XH
         D5gtNr/ZK4tXgZ9I9zVMhFMLDxdbn33lKtjDlQr1ccPdQQa0GM4Od3fPlK3J3FVq6cVu
         rgUk+a/i8S5Ssj5J5qb+QMDF/baEtxsrkSlQJ4+snUgfpjoUkYwlSA0CWSivbOZiWEN6
         RJuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783600974; x=1784205774;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lGxuTmJonByeoKZLNGDqsTWGMGeNSB8gf+bZY9/34MI=;
        b=dVEVaOfuhS0zbrjViShynPC8HiVUwT55dr9epD6HwlPVghwF20nXcDPxT+gEghMocn
         DPLaqKCNLhexwPqdSGbwCjzBHImkY0SPMOcsbbWkyysE7c8+0Xsl/YxEMaJDJ6BOXo4A
         YLiU93eRgX/aFbAwPLmk32r6tuvVStUCl/l04ud933Q8V+m2UiS5+acClDucMq/3FNh9
         9PSsCJDEewniIHAtVHdb89HVDpmf2tvGoI2PeYPE5S6JiwEDWbVWShwasVJVlQF84mYk
         H55E7iWXKK2QmgQ0OJsqDf5Zm3jL1TqZdkK53iKnn2lB0Q/pL6r4Z3HdU7Nz8v/aAWVh
         e7Pg==
X-Forwarded-Encrypted: i=1; AHgh+RqawDJRnnTUo4YAar0/x9SGnlVmvwwe4tFGPfWGHBKTdkGcBDCSR4zqd4pbA32Fg7MEACf/YCI=@lists.linux.dev
X-Gm-Message-State: AOJu0Ywxvx6GdCqtBboCI/+5c9F5T7SBIdaj/MeueCAMB8znwzkFJhDE
	It3Xfpq2onE9iBXcfpuas6Cp9wD9SRTvh276qrFz6JEARDK7fAWKwj5MF0cFOZVbRnsHSyega1B
	A1kZ3EGHObN71yUwiTcknESYbiTSLW+0=
X-Gm-Gg: AfdE7clNEHBR2fpRz71REp3uZMPHhHQXWwXRJkezzLYf+uzFcEGzF6A2Lf/XchRdU/y
	AF4Dq8EXVlXvTZD072Qh9mOWg27v3rRAYmBE+XTE1jG54QgOq+3dnkiEAFcinoEWH+QTbdM4Zq5
	nZYuAzUx180yk0U0J0k5cPgefoWDFr6W7ybU0DaKmUhgxQPtBk693S76R84q12Vj5FRERA34Zkm
	4AXJIcJCjlt88GjU5D/8iQrpav7MUmjLyTc59xU+6Rh/36zRil3ZJ3jw64XtYoUQLOHT/shCtpJ
	Rds2eQ==
X-Received: by 2002:a17:907:782:b0:c15:b368:28ba with SMTP id
 a640c23a62f3a-c15ce1dc0f9mr300135666b.56.1783600973674; Thu, 09 Jul 2026
 05:42:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260709101327.9508-1-royujjal@gmail.com> <2026070925-delay-gauntlet-bc7c@gregkh>
In-Reply-To: <2026070925-delay-gauntlet-bc7c@gregkh>
From: Ujjal Roy <royujjal@gmail.com>
Date: Thu, 9 Jul 2026 18:12:40 +0530
X-Gm-Features: AVVi8Cf_qxhMx1ZeQ3oKQ5Ke958RTxWs-_NyJm9hkmAWt83JY7oFCTeQuoLyaug
Message-ID: <CAE2MWk=mm8_bkd54Gv1mdox6rfvx85Dd3AjOCxPz0fPAfyuWYA@mail.gmail.com>
Subject: Re: Please backport bridge multicast exponential field encoding fix
 series to 6.1.y/6.6.y/6.12.y/6.18.y/7.0.y
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linux Stable <stable@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, 
	David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>, Andy Roulin <aroulin@nvidia.com>, 
	Yong Wang <yongwang@nvidia.com>, Petr Machata <petrm@nvidia.com>, Ujjal Roy <ujjal@alumnux.com>, 
	bridge@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 9, 2026 at 4:34=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
> On Thu, Jul 09, 2026 at 10:13:27AM +0000, Ujjal Roy wrote:
> > Hi Greg,
> >
> > Please consider backporting the following bridge multicast fix series t=
o 6.1.y, 6.6.y, 6.12.y, 6.18.y and 7.0.y.
> >
> > 726fa7da2d8c ("ipv4: igmp: get rid of IGMPV3_{QQIC,MRC} and simplify ca=
lculation")
> > 12cfb4ecc471 ("ipv6: mld: rename mldv2_mrc() and add mldv2_qqi()")
> > 95bfd196f0dc ("ipv4: igmp: encode multicast exponential fields")
> > e51560f4220a ("ipv6: mld: encode multicast exponential fields")
> > 529dbe762de0 ("selftests: net: bridge: add MRC and QQIC field encoding =
tests")
>
> Why is any of this needed in older kernels?
>
> And 7.0.y is long end-of-life.
>
> And why, if this does fix issues, was it not tagged for stable to start
> with?
>
> thanks,
>
> greg k-h

I already explained this in the email thread, "Please backport bridge
multicast exponential field encoding fix series to stable kernels".
