Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B3235F619
	for <bridge@lists.linux.dev>; Wed,  7 Oct 2026 23:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791416209; cv=pass; b=NrZYhXgAtfyqqWI7AlhXPGGbLQzi7krCdMd4DVGVlXKPlB8QWwRGaGlduUQKGIUKTuFSNFf5K7JqTDs7iH1J148y/SOVdgueC0qh5BBG3B7gcBaLZ2lm/F2djXmZwCbdYPn/LlTJ+8lcrWU9jE+QMDcAa9Nrj1oBk/pKy2+wvGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791416209; c=relaxed/simple;
	bh=YW7ppVeoRLVQCLnGvfkZ3DPxaXrIg4n4TYyY9tNYUuU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gRrxfFrSlizar7jHSVSsvS+rjBI1AxEcL7iumSUkkueKHpeb7leTeylMmIR2OouscaHGMxLUNTa1mIES6kWRPFhZInV2WMhU4YBFAzAxm1Yy+6d9WVZMsb1bqz5xd7G+QDY0fpjJKRcPpHp3rjJ+ehpUOJVFPzr7a/++5T/5X1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eRdy1oUq; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eRdy1oUq"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-66c7e3a2332so3424159d50.2
        for <bridge@lists.linux.dev>; Wed, 07 Oct 2026 16:36:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791416206; cv=none;
        d=google.com; s=arc-20260327;
        b=CkDKMpoPBOMToWNDRx9hdSyGdSDZfZKJcwd8bFdAajVJexAvWQ4CSFYf0epb/XSISA
         BRCCQG2pLHPzNCKK0Zw0yZXpFwB+CpJKXoDT/IaI8UjpDpv8/DfvswzXEb8PoaczTkKu
         cGJYJgPxMFwRtbwlCMhDU2Lqf//nW3hh2qfIvFcx4waxK2VlDnHnu3RHLGSGwyBEAETn
         bTQGcc729pozsvhc56Y7xV0vYi2lq2iJwk9ilZdk9/imXNn7sqSgjKvBD/+zrzuvYxvW
         JX3eEsH9EQC5H4Cfiq8rzC+phAfd/CZOk3denUonGSCSu9nOM4EeNE1NYqZwoURHqhrj
         0Ssw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YW7ppVeoRLVQCLnGvfkZ3DPxaXrIg4n4TYyY9tNYUuU=;
        fh=is3S7pgZnqibXiDhputRbcpzxo1Xzumk+xRdlC1SSPM=;
        b=MG67+OP4zwHeEcWt25gX14oWfU3ROPE8GXjk8BH4+Mhl9HIk/mkszkevE0xYqLeaAE
         MFrp9R8ZLfoD8fj6mKbSHGtNt++akSr09w3AN8scsu9fpBxbbCMvU/ePd2LuhasBpaZn
         5cIji+mSGiH58H0cg8DDQZkEWH4wLxFSoGfe6TGzU7Z8d3scfpazaoLvLJYlX3QmtxUV
         UX2npS5s7UABGMeUPXOmQT+vqf0JhsHXBtaH9zDT2936p5z1mLWo4NQ4DCQo0fJpu5vb
         Icihj9ZCyLsBwivRB0i4riJwYgTqGQXVnnzX8BOgTbzAZUBZfhrYO8rT5X0I/sLnIzok
         utdA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791416206; x=1792021006; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YW7ppVeoRLVQCLnGvfkZ3DPxaXrIg4n4TYyY9tNYUuU=;
        b=eRdy1oUqoPGeA+mMc/MGIBNS5zO4SmEESCzw3DWEQKwJ1D0RnlkkkIqTHo1Ey01n6J
         gf5xg0+vbtjp1eBARjBi8Hx8TElQKSqY+1biu9zMypLUkzCOROlVq/cYYtkOKgDi+UJ/
         SHRXImfz90J8iyYEMBMrV8n5Dsnn9XuDpucDAbVKFbqi04uqhiFHM8IoV3VRzYBUF0Mr
         uyQgb9eKVBFai+w/Qfsp+KuKMsb43s5rnBSI+yDgk/rPFnmoi+gMxAXSLSvlVNQ1eWOC
         JJ7FTA0nUgKs7TU5D3bDuP/5WZM7EoBZMtnnECdtek8HBhoYOGWl7kOX+N9IzdGL/Z/Q
         yXdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791416206; x=1792021006;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YW7ppVeoRLVQCLnGvfkZ3DPxaXrIg4n4TYyY9tNYUuU=;
        b=xeDacVPt/2cByhxkPDqoMcaPintJQ6NkXwNI+XxOuIDEQCIP1VpUZVoud97Mai0gr9
         qX62cqyyuF9jTeNqurFoM9pxyP1htvxmCbufvagOUcUgy2zoYCt6Pp8oN3Zylv7Ic0XH
         /eMwpMS3aGcn9+imKgN8BXKlDCYqPp7r0pXUWGuL5JQSkXyRVYeBl02bteyFKy8gwoss
         JD6S3XYaCWDepsEjrxX+jVsi7M3UHXI+u3h0abDOX+PWqUn7lE7O3DlIgbkkqVSbv6Fn
         R951ruxXwUxYVozfliPkBDOTV6zK8VqJh3xJSv/9SIGquLYxO89ZwliRLT895DXCwTyG
         Rozg==
X-Forwarded-Encrypted: i=1; AKwUvBxTMkPfd+yOOV9FanCL35JipDX53RFfF9NjqheheNg64MoSyYz2nOQUO6FmAC2eu4CB58qKMto=@lists.linux.dev
X-Gm-Message-State: AFq9FYJDFO1VFwuNKCJtKRi4OeU1iVKAWATufNvLN/wnMmHS/sodaRJA
	MkU+BAg84VsFgEvc6KiMrWiRZl5Gk2lJ/qmakrp9V9ILJiAOmyfLL3JdqGOPH+AHBYkKR3ZMvQa
	8OP/HcHMHhKpCk5mTs2T7ljvtocHJdgU=
X-Gm-Gg: AYBFou32WLhec2son4El5EEo3Q1i0WwDgipF/6Sfj9nga/DtxcxQ5M5okiaNmkoclei
	CXLhnZR1eefBD1R7kjGT/g7vjiGq42XkfKUmP1abDzn/ZW+JasSMgK+bMQpGuYsiZCug0nhxBlq
	3X1zx8rMYztWceDBz06Dosfb/ViakZ6lcc2cJm/eJ9NDTYJoYeebzhgHDYo0yZv1QrT0FMmjj2h
	EyItyPLJJA6R0M2wGOOQPRlio5rd4Kyp7ZzVp/mZpNReBVG9LAz8WcKWjnW+Mm+AshvcjefrtLr
	u3X4G1QDPIyJU+ZtizTyQRdh+ZhOZCki6ZNOa4fVEPuDT5WbjkrFXgGxAMxHPij30RY/2jY5xFV
	AJju/mYq3iQlP3VU50hOqh6zar+TkaFuehkOOZFV9zdtkJ55HHrFWNiDZ+X14GZK9LSET3pDRGU
	8=
X-Received: by 2002:a05:690e:4853:b0:677:c24d:ebfa with SMTP id
 956f58d0204a3-6790a3eaa26mr994855d50.58.1791416206358; Wed, 07 Oct 2026
 16:36:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <0a012b4923e189c4c593ef4f471e5ff0edbe9030.1791412497.git.mst@redhat.com>
In-Reply-To: <0a012b4923e189c4c593ef4f471e5ff0edbe9030.1791412497.git.mst@redhat.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Wed, 7 Oct 2026 19:36:09 -0400
X-Gm-Features: AclHuK9jyyf5sYugVmTQQFcLaa4pyEtdizNnLZGPpZtB9PsCE0-Mfu-D4Td6hn0
Message-ID: <CAF=yD-L_sv90qxUxEh6HRrz3mHMRP=WK3smkMMYScLAnJbgTpA@mail.gmail.com>
Subject: Re: [PATCH net] ipv4: validate checksum_start before completing checksum
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, David Ahern <dsahern@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>, 
	Phil Sutter <phil@nwl.cc>, Nikolay Aleksandrov <razor@blackwall.org>, 
	Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	coreteam@netfilter.org, bridge@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 7, 2026 at 6:42=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> If a packet with bad checksum metadata gets into the ipv4 stack,
> skb_checksum_help can corrupt the network header and cause a bunch of
> mischief.
>
> This was discovered and reported by Paulos, and has been reporoduced

(minor) typo: reproduced

> by others independently since.
>
> We really shouldn't allow such packets in, but as a defence
> in depth measure, let's also check before we complete the checksum.
>
> A more complete validation at input is forthcoming, but needs more work.
>
> Assisted-by: LLM
> Fixes: f43798c27684 ("tun: Allow GSO using virtio_net_hdr")
> Fixes: bfd5f4a3d605 ("packet: Add GSO/csum offload support.")
> Reported-by: Paulos Yibelo <habte.yibelo@gmail.com>
> Closes: https://lore.kernel.org/netdev/20260922030310.8684-2-habte.yibelo=
@gmail.com/
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Cc: stable@vger.kernel.org

Reviewed-by: Willem de Bruijn <willemb@google.com>

One point about sending as a single patch touching five separate
modules: nf_br_ip_fragment was only introduced in Linux 5.3.
Such a block is probably easily dropped from a stable backport.
A single patch is likely still preferable over splitting into two
(core + optional) or even five (one per module) patches.

> ---
>
> Lightly tested.

Tested by me as well and found to block the known bad input.

Touching five modules is not ideal, but could not find any other
approach that would be preferable: low risk of unintended
consequences, out of the hot path, and relatively concise.
