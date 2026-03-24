Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1AA24634F
	for <bridge@lists.linux.dev>; Tue, 24 Mar 2026 04:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774326485; cv=pass; b=bxyeze1TFVsewiPRhVsoKKRUMsZaUToRKE640lPUPUCq0s05Nx3INq9iY9V3wkXvs58LkjCc8Z/ZczY0tHNZZmbiRsqCuE70qItqpD+eYgja2dG4TlQDGWyTLu6CvOvD8cFP+cnDdOZU/W0L9UGP2n9/RsHiPaGzVEOhAZRoOsw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774326485; c=relaxed/simple;
	bh=svClQVwTYvLN+679sWWYhBctw/RFEPMWANDN/6NPjuU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jfzJhGJKbs5hoCtO002QKgwCdeEkLiymmlvQqA+m0T6fbXWa03glUR86KRvK7+fkXhCPAbgkjJCpd4U/anDR4YsJYlBUw/j8usEnh+MRuR4+FchpIweXynN9+3oXy9Nf/OjgHE1ptCARiYxmShzb7yJ8Ctt0BI/btCenmpqTXoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YqbeDoI7; arc=pass smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YqbeDoI7"
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-6694d00e01bso1587013a12.3
        for <bridge@lists.linux.dev>; Mon, 23 Mar 2026 21:28:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774326482; cv=none;
        d=google.com; s=arc-20240605;
        b=ORmivUUyuW9ncgLr3mIFu3k0MTR8eroRoX1WKXe8rb3+veBZjvkrDTZkidyll/p0gd
         TQUqoprwM4CyLuF85uogrNJ3GtxYh1v6XGLU2nk4uxi4hAr9FrAo1eHobpKHZbR8JJHA
         9ttxOtVUEpdn6tDGY4q4nqN//FdQhKXVqAklRXxxegLWwnFWVoz/VfvKByVWiv0bO/hy
         d/NdBf4CppOU/7wQdL/QKHxsAgTm/HOimsoCfS0mNJZ3WeUb+cWnx31djkV9q0kMrQei
         nYqeuFMYboBfvDWzN7RWDmCDjIpS1ffy8rOsFIxeM1yCLeTqD+m1iSA+6RwCeb7pSZ7s
         qNXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=svClQVwTYvLN+679sWWYhBctw/RFEPMWANDN/6NPjuU=;
        fh=MWjEdgy7LgU7KQEur2Ph8l4XCVpuRYYBH9WxHoaPaLM=;
        b=EX3adShRm+Y7wD2fXdMNf+NA9vQfoiTyO+6DREHpVG68JF6CRBeFUlSsXwrLkX6AIw
         D1VSCQ2A5NYyNa/MwOA/c/6RTMMOjuBqWo2DBpAWogb+08Tmi7uwl7ijWuLH0OcnGtqB
         svTkbXv0/8uQnbxLK4PRwiZCr6krIohKnUstsMCYyindaSkvfahUKaZQT2fxVkWGR99Z
         o5D32aI/RJgH2s3FwhIGq3YAbGMhpzH5EqPN04Qoqux2irbsmBIqY2KBpRlX+Ng9C6h3
         n1y1S3kWIzIkt5fZ1wqv8ps7xB+KQzE1sIQORqFMRG1aCalhAFqZOkMeMYkiRemhmxlM
         vzIw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774326482; x=1774931282; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=svClQVwTYvLN+679sWWYhBctw/RFEPMWANDN/6NPjuU=;
        b=YqbeDoI7DQFiTUw3/1Lua5Bbo7A00Q0cz2bpkNTlOp/K2fOqG2NdFPUG0CRGeoziIj
         TxBw6llJI/EBEi66krOlxJPxxoPke+iiQjy2I91iLeCWNRZDcPhMb4hw7Kbb2SjZSEAy
         cDFLkqfIMzPZ77X6hWbbK1a2QdzxFTk6evO2rjlanC6+ShL3cLzaKU0l/WYPlkXVo3fh
         9b8LLR4tEIpHMW6xR56LU1SiGHbFcuhDj16ngfL3xOhlfikJBT5Uf1IZjaUJt0etbtt2
         ZQBulPrOFKQr1JKTkfjNIGTm0Ri2to+qnPWkK5ywRYC8jFCCPRgEPvtJ1wqD7GmrtIGP
         7hUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774326482; x=1774931282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=svClQVwTYvLN+679sWWYhBctw/RFEPMWANDN/6NPjuU=;
        b=C56Pi5jsbOMxJpujFV/QRmp1VXYZU5joy4DN3ntR8TwlLwSfCpNkuuxfQA27HGbcf6
         L7894ouQu0SGHZxyIzewRcUkGtBjpkfxBv/nCFYJ7EZ3AnVcZaPY8wZSmt89kdsSaCVH
         4pIQlVb65Vr/EIV6JvbSmVxrHp1tySFAdNr3XHc/mFHFvrPpsIl9U9g8VmoSZw8QI8r1
         eu/jDDiTslpOrQJt9HL6gPCea6HNkYyun0L1tj7CIgPE/fF/5Rvjyr5Z1UvsiV3n97ah
         B6KtnaqPyWl2ldk0FNZ0u1PWWvAO6pc/kpFHbEiv1mTNEt3znXPu+cNXW2qhCjJPWf4W
         1sgA==
X-Forwarded-Encrypted: i=1; AJvYcCUD4XJfV7YP7F70WNAkhtzkXzN2K011UWr+xcL/CBQDLBg1dQ09Qx5nJkw+gfqg4TFufnwWH5I=@lists.linux.dev
X-Gm-Message-State: AOJu0YyaiErkIL+uUlOjOM+hq8X+hx9/X0YDOykKioOWSMPwSXTLjoGR
	aVd5T5B2scutv/G0YbwnrW54e3sA23KMOBGXsM4Uo5cK+X3BzqHBIYfHU1f+SWirMynOQWnovT7
	jpdO1wllgLg8YzRPxPjiObqyzrp+wSMk=
X-Gm-Gg: ATEYQzxhMqYk/z4ZHY3F5+oUo2JxrvwFQvX6aT0Lzl6F3VRWP4gLRjrl58jjhhyhvmO
	uQ/ZcFinR5DHu3ZLxs1NYYGnWXKK5/iao1fnlZM4DG2O0QTv+1z1HiPigCe70WACrlloz2TXuLk
	0l4Y05JUVfiO53mweYUMzxBF4v0CaC/Pe0OIKWb24byHtU12Euc3Y6sPTXKvnQjeUfFj+fXdxXQ
	vqVu5D1GsNsRq1iRSjWpnll5yYFwpi48Qn5Lme9pGYWRGDYmNfLxeZDglhtC57Uppbi1OGgddfl
	NTZCUySDCTtod3Y9zCseQtHGAff2AvGy1/x/UeM=
X-Received: by 2002:a05:6402:270a:b0:66a:3419:248a with SMTP id
 4fb4d7f45d1cf-66a34192961mr1158702a12.13.1774326482054; Mon, 23 Mar 2026
 21:28:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260225010853.15916-1-ericterminal@gmail.com>
 <20260225033840.33000-1-ericterminal@gmail.com> <aaRbWCeu-wNdWGzB@horms.kernel.org>
 <CAKNPVZA2sFv7k=wyf5iBGyOUQcHkAdpVLVNjuqr+7XBXDKxNbg@mail.gmail.com>
In-Reply-To: <CAKNPVZA2sFv7k=wyf5iBGyOUQcHkAdpVLVNjuqr+7XBXDKxNbg@mail.gmail.com>
From: Eric_Terminal <ericterminal@gmail.com>
Date: Tue, 24 Mar 2026 12:27:50 +0800
X-Gm-Features: AQROBzBgTmKHaA7x9bBR6YuiaU8Gh2HBa_zkliE59q0Q7S-SffyKp90n7TFmYBI
Message-ID: <CAKNPVZAtH59NRqDscaBPgFYhxOB=KzTY=Y+FA9WBkDo_um33tQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] net: replace deprecated simple_strto* parsers with kstrto*
To: Simon Horman <horms@kernel.org>
Cc: Dominique Martinet <asmadeus@codewreck.org>, Eric Van Hensbergen <ericvh@kernel.org>, 
	Latchesar Ionkov <lucho@ionkov.net>, "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	v9fs@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux.dev, 
	Anna Schumaker <anna@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Simon and maintainers,

Just a gentle ping on this patch series.

Following up on my previous email regarding the testing methodology
(using virtme-ng, verifying the Oops fix in Patch 1, and confirming
the strictness of strsep + kstrtouint).

Does the provided testing information address the concerns? Please let
me know if there's anything else I should clarify, or if a v3 is
needed to move this forward.

Thanks,
Yufan

On Wed, Mar 4, 2026 at 11:28=E2=80=AFPM Eric_Terminal <ericterminal@gmail.c=
om> wrote:
>
> On Sun, Mar 1, 2026 at 11:29=E2=80=AFPM Simon Horman <horms@kernel.org> w=
rote:
> > Hi,
> >
> > Thanks for your patches.
> >
> > I would like to understand what testing has been performed on these pat=
ches.
> >
> > With the possible exception of patch 3/4, I feel that unless they
> > are motivated as bug fixes, these changes are too complex to accept
> > without testing. Although the opinions of the relevant maintainers
> > may differ.
> >
> > And as for 3/4, I lean towards falling into the policy regarding
> > clean-ups not being generally accepted unless it is part of other work.
>
> Hi,
>
> Thanks for the feedback. I've verified the series using virtme-ng and
> a userspace mock harness (for the 9p tokenizing logic).
>
> Regarding Patch 1: This is primarily a stability fix. I've tested the
> error paths by forcing init failures on a non-Xen system; dmesg
> confirms the new sentinel-based cleanup (NULL-ing intf/data and
> checking INVALID_GRANT_REF) correctly prevents double-frees and Oops
> during teardown.
>
> Regarding the "complexity" in Patch 2: The strsep + kstrtouint
> approach was chosen for strictness. I've verified it handles cases
> like "1,,2" (empty tokens) and "1abc" (malformed input) correctly. The
> latter is now rejected with -EINVAL, whereas simple_strto* would have
> silently accepted partial values.
>
> The same applies to Patches 3 and 4. The migration to kstrto* ensures
> that sysfs/procfs interfaces now properly validate the entire input
> string.
>
> P.S. I used a translation tool for the message above, so please excuse
> any awkward wording.
>
> Thanks,
