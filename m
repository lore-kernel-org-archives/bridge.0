Received: from mail-lj1-f193.google.com (mail-lj1-f193.google.com [209.85.208.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA1A14EC4E
	for <bridge@lists.linux.dev>; Tue, 22 Oct 2024 08:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729586988; cv=none; b=Ir8ZL/LyAaVtAHGIncGhd3Ixy39ZrtH02KxPPl0NFhDYuV0YBD9SGspn4o6742hnlA1cgk+fql7dKTysY3pxZ4CzWuLKVWb50l/FOtDsNh2tVY3Yu+MVpLjzH5wzVOiBPYmkKpvIVP0Ja8c4tx2TUZCHYKDAQ4SIPSEMnWUr8Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729586988; c=relaxed/simple;
	bh=VmBJLc5YwrovcjmjVJSAnkQ1H6CTGhFHDhc1H9J1qnU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WNse9aV1A0TexPZf/oz3iMiosbon8zuTPy1JWifAE1bGf6g8k/dwYrsHZccZtizKKwcgFAWkd1n2Li9ePgxR/6BdeeWPY9WZ/6xAP95a8tg6bYE2PtfMvcPfRLreMw/6/GG2BqO7fuO4yx9WGsy/g/SS9NsvHi1pRUcfIEJK1nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qkz7Wo4N; arc=none smtp.client-ip=209.85.208.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qkz7Wo4N"
Received: by mail-lj1-f193.google.com with SMTP id 38308e7fff4ca-2fb518014b9so45992191fa.3
        for <bridge@lists.linux.dev>; Tue, 22 Oct 2024 01:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729586985; x=1730191785; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+pOfCiSieyO3TQ+yRCELl0+ufCyFVvkQ7MbO+0NA5No=;
        b=Qkz7Wo4NBeCMeQwBRkSbdNUce9k4tRUDQvjoaSvg5S2JcW8ntMjWhUqsXNtu5B8ApA
         1i5Sc4iSmUgLqSVN0WYydKUmXjoODxWMn40jUqwloFwLvRe9dsnoBl4MMKOtXgF3kLuh
         x/semGeKJD5P73we0kw/munihFV/APyRuPsxHUBwArjuZHzB5OVMuuBbz4yQzMWw2PRZ
         +wFhU+zccCREauTY/RHeEqBWX4ZzYqcKJjPNpkZlPpfzqu0ww70pGM/q76HTjb2NUcAO
         goHVeziBCDqLFoxe3yDoG20pSBM6IMOdv8togHC2SIDml8a31RRAm8xkeNCtAHZ2QykJ
         o4KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729586985; x=1730191785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+pOfCiSieyO3TQ+yRCELl0+ufCyFVvkQ7MbO+0NA5No=;
        b=ay/DtOeDy3YNQFtzNXTWyRsTqZTaykZnWuhRkzK6JRQ5CcUa3xm8HXUL3XYwoTATVV
         vYbdda1h7lHdJnTIOdMC2uDlv00JQcXLMHicMFBC2m/DRpWnVrJfOr5mOLsCNMlFJL1X
         aBjPImr8xoxH9VJoxtFKze/CR7uf9KIbTFdZdP8XPlaPSTvPmfK8+20AlgpOS56lzqIv
         b5+H1RboHB33oOUznVWfHI1CVVzzkcrG3OSt+XcHWQHSbqJQbObrBV6iEMDhFLh0gf1S
         3M2eUe6sc8uoL88rR2lzvzEy5EtZtqy48i+9K8TGp314KQJurxESMV0hMTt3DgWhokuS
         nxQA==
X-Forwarded-Encrypted: i=1; AJvYcCXtuMgJRolRgCGDPrr8KqOMu2vcpO7cOsfeZrYxUoaKislnIuVc8Bjiz4/TDsw1Uk8uGh3dFUw=@lists.linux.dev
X-Gm-Message-State: AOJu0Yy+7e2xkT0gWJ6E57CdlnjabsQbvyWL5aphzeALZtXmuHn6I4Tn
	R2wM8iv5+oVNV4vIPsHm9jDqpwIFP2bgDznGGjtqU+kO9jOEzMPr4aJLBb+42YQKxwgeHUO6x/t
	kW50uZde2EZxPhkBkhnbUK2nN0sg=
X-Google-Smtp-Source: AGHT+IFKl3tfsMju7iYF30A7gBpjOZyrqMNthNqd+kPzl1ymRdMCkJ/IFXR1TES+Mv3Jjwg/Hwd37FmQx1Tu4AZ9ptg=
X-Received: by 2002:a2e:be87:0:b0:2fb:55b2:b199 with SMTP id
 38308e7fff4ca-2fb83281b86mr72476071fa.37.1729586982785; Tue, 22 Oct 2024
 01:49:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241015140800.159466-1-dongml2@chinatelecom.cn>
 <20241015140800.159466-6-dongml2@chinatelecom.cn> <20d9ed5f-abde-43ee-854f-48a9f69e9c04@redhat.com>
In-Reply-To: <20d9ed5f-abde-43ee-854f-48a9f69e9c04@redhat.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Tue, 22 Oct 2024 16:50:36 +0800
Message-ID: <CADxym3atdr5Rm1CU8_AU1XaczraYN7ihTJWQiqxaStmD4iETog@mail.gmail.com>
Subject: Re: [PATCH net-next v3 05/10] net: ip: make ip_route_input_slow()
 return drop reasons
To: Paolo Abeni <pabeni@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	dsahern@kernel.org, pablo@netfilter.org, kadlec@netfilter.org, 
	roopa@nvidia.com, razor@blackwall.org, gnault@redhat.com, 
	bigeasy@linutronix.de, idosch@nvidia.com, ast@kernel.org, 
	dongml2@chinatelecom.cn, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	bridge@lists.linux.dev, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 6:52=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 10/15/24 16:07, Menglong Dong wrote:
> > @@ -2316,19 +2327,25 @@ static int ip_route_input_slow(struct sk_buff *=
skb, __be32 daddr, __be32 saddr,
> >               err =3D -EHOSTUNREACH;
> >               goto no_route;
> >       }
> > -     if (res->type !=3D RTN_UNICAST)
> > +     if (res->type !=3D RTN_UNICAST) {
> > +             reason =3D SKB_DROP_REASON_IP_INVALID_DEST;
> >               goto martian_destination;
> > +     }
> >
> >  make_route:
> >       err =3D ip_mkroute_input(skb, res, in_dev, daddr, saddr, dscp, fl=
keys);
> > -out: return err;
> > +     if (!err)
> > +             reason =3D SKB_NOT_DROPPED_YET;
> > +
> > +out: return reason;
>
> Since you are touching this line, please rewrite the code with a more
> natural indentation:
>
> out:
>         return reason;
>

Okay!

> Thanks,
>
> Paolo
>
