Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AD91B0433
	for <bridge@lists.linux.dev>; Tue, 10 Dec 2024 15:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733844554; cv=none; b=a3o66xEbWS3YgSWmkawZV3nUOdBxQgHUkySdvP4CYvUaMSMI5B8uswsvInMfrZwfMkERh/aSrk8vYnRiovKVgopWH2e+aDbApIl3oymgYEp7pZrAMbGoDbHkx0quGwlnoo8C6XEG7nz9OWXw4JE5vuGuIkp1cTzrd9nTyL656XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733844554; c=relaxed/simple;
	bh=cWs/c4TFgM8ytblaB0OKLNZx4QlCxkLj//Xce3vvX44=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B2ITZ0ZQORFD2b4rcE39hygI67/X/ZfWpOMsCNMeZSI5FJgSGioKJgkcX/NNwjmhMuMMkJxwgVseFh9+NGtD7XGW1N/UIv4CiRWKtPxRwncMCzd9SJeCYBSWPIHrp5i7ll3eh7+xe8muvXoBgybUzD5+t+Q0bzWHY5UkciRBCcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bisdn.de; spf=none smtp.mailfrom=bisdn.de; dkim=pass (2048-bit key) header.d=bisdn-de.20230601.gappssmtp.com header.i=@bisdn-de.20230601.gappssmtp.com header.b=DeC2WY2G; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bisdn.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bisdn.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bisdn-de.20230601.gappssmtp.com header.i=@bisdn-de.20230601.gappssmtp.com header.b="DeC2WY2G"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-46764d20b91so1464881cf.1
        for <bridge@lists.linux.dev>; Tue, 10 Dec 2024 07:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bisdn-de.20230601.gappssmtp.com; s=20230601; t=1733844551; x=1734449351; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cWs/c4TFgM8ytblaB0OKLNZx4QlCxkLj//Xce3vvX44=;
        b=DeC2WY2GVCnNqXDGHRTgrUPOQV6Ws3+vXl4HaY0TQJDSXUFGqdW1q3jycQETAkQYs4
         UPXfRksTPKm2UEm3IvMJPWVEgGLfroil1Lg6sc5X47PNo0O3g4XjhqDCqM3CfRU/I+w1
         cGcSXmFhf/qdMbpjk2m/mwEuC4dfu1hlMrDtV+NU1rXObJ4WcIsBBpA+RJEUjgWFSnmf
         7BecJgafCNAVzu+AW+HqybFg9pIOXvCN369jk/LywfejrU0r55MyvSOkuAStthzgKRqe
         BZ1JA9AGCkb73nSNceQSNnQ3ap4qG90a7zp4wEOileNTNguYXasp1jW3ZKQZYtaJHBFW
         5gPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733844551; x=1734449351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cWs/c4TFgM8ytblaB0OKLNZx4QlCxkLj//Xce3vvX44=;
        b=l4Ul1WTfizLojP9D9XufVAUUHuuIFLWX5sXsIYXuUssYTWKrDub6yDd9VCNxkuPal3
         AqcF1fhyVvzsQS9Q8Si4Z24W7kEgE4nZmrFre3unRzwIE6HjVf8jreehCkY8jU3wrAlF
         yKhDHwLQCccqPpmfuuDZFvuD/FWFWh2GX+8jRyHbAKdkVceMmshRH7Tjh4SBstE0oRE8
         R4sFY3CMRjzMuL4blIWf+Ve8RmHeaCovz9e5OEupqf9H/YB+dsZK3CueBKkfVNdCK7ul
         4BGupsnt9/6F2DU+pQph0SHXO3s6HGDHZV3RywMHis1LgWz77DRPiVZDA4EsIsNMEjkF
         MayQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8y1K3XSzwshlKlyDtgwpTnVmRFrEP6OcX+eAvHchYsSQJ8STmchtfgMhRe74vAXVcRsDS46A=@lists.linux.dev
X-Gm-Message-State: AOJu0YyuoHG7RIRazzgd37YQLuq/9lQQ+D2nde4T8pcruvSTq4xGpxuX
	UcaHfC0C7yZqWTy8cqJ8MFdV8pALYd8DJMGZJ8BFHjNtLN4HxG1lQnsnAeAHhzz5BlAKFNspqTL
	X/K4S/atzfKMGT6Pp/tK3Obs1kyt/QcsfcoVximaZ0Rz/ZuI7tFcZz7P12gCJEVnpes4oOaDblF
	0BCN2ZnqKOIT7Q4U3A+SmJVw==
X-Gm-Gg: ASbGncumfc4hbK7IpUw5xPOf1LiorhFTyg2UA3CEAp+CJaKA8QpY7Uz/lLJ1MT7Atvn
	3HvgrjSpkX5RSJWjrfcPV2x0wyVghAjSOdg==
X-Google-Smtp-Source: AGHT+IFYp2J8sA1dyCVQ1vOCeeXRqBIzaSBN+hS+fa8YG0sEE7LCygde5whGIR2rD8IsQqAE7colLdcVHHr8uxRzDYs=
X-Received: by 2002:a05:622a:307:b0:461:1fc9:61a3 with SMTP id
 d75a77b69052e-46734ce0dccmr104642071cf.9.1733844551264; Tue, 10 Dec 2024
 07:29:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241210140654.108998-1-jonas.gorski@bisdn.de>
 <20241210143438.sw4bytcsk46cwqlf@skbuf> <CAJpXRYTGbrM1rK8WVkLERf5B_zdt20Zf+MB67O5M0BT0iJ+piw@mail.gmail.com>
 <20241210145524.nnj43m23qe5sbski@skbuf>
In-Reply-To: <20241210145524.nnj43m23qe5sbski@skbuf>
From: Jonas Gorski <jonas.gorski@bisdn.de>
Date: Tue, 10 Dec 2024 16:28:54 +0100
Message-ID: <CAJpXRYS3Wbug0CADi_fnaLXdZng1LSicXRTxci3mwQjZmejsdQ@mail.gmail.com>
Subject: Re: [PATCH RFC] net: bridge: handle ports in locked mode for ll learning
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>, Hans Schultz <schultz.hans@gmail.com>, 
	"Hans J. Schultz" <netdev@kapio-technology.com>, bridge@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Am Di., 10. Dez. 2024 um 15:55 Uhr schrieb Vladimir Oltean
<vladimir.oltean@nxp.com>:
>
> On Tue, Dec 10, 2024 at 03:47:11PM +0100, Jonas Gorski wrote:
> > Huh, indeed. Unexpected decision, didn't think that this was
> > intentional. I wonder what the use case for that is.
> >
> > Ah well, then disregard my patch.
>
> The discussion was here, I don't remember the details:
> https://lore.kernel.org/all/20220630111634.610320-1-hans@kapio-technology=
.com/

Thanks for the pointer. Reading the discussion, it seems this was
before the explicit BR_PORT_MAB option and locked learning support, so
there was some ambiguity around whether learning on locked ports is
desired or not, and this was needed(?) for the out-of-tree(?) MAB
implementation.

But now that we do have an explicit flag for MAB, maybe this should be
revisited? Especially since with BR_PORT_MAB enabled, entries are
supposed to be learned as locked. But link local learned entries are
still learned unlocked. So no_linklocal_learn still needs to be
enabled for +locked, +learning, +mab.

AFACT at least Hans thought that this should be done when there an
explicit MAB opt in in
https://lore.kernel.org/all/CAKUejP6wCaOKiafvbxYqQs0-RibC0FMKtvkiG=3DR2Ts0X=
fa3-tg@mail.gmail.com/
and https://lore.kernel.org/all/CAKUejP6xR81p1QeSCnDP_3uh9owafdYr1pifeCzekz=
UvU3_dPw@mail.gmail.com/.

Best Regards,
Jonas

--=20
BISDN GmbH
K=C3=B6rnerstra=C3=9Fe 7-10
10785 Berlin
Germany


Phone:=20
+49-30-6108-1-6100


Managing Directors:=C2=A0
Dr.-Ing. Hagen Woesner, Andreas=20
K=C3=B6psel


Commercial register:=C2=A0
Amtsgericht Berlin-Charlottenburg HRB 141569=20
B
VAT ID No:=C2=A0DE283257294

