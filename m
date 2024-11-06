Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37DC1DE3B5
	for <bridge@lists.linux.dev>; Wed,  6 Nov 2024 11:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730894243; cv=none; b=uYJH3pCIpwOPx27HgT1Q8B5SCEVLBN4MnO2v1l/bfWg9pI3igb7Y9Zn4DlmsrgRz31bw+ZxPG/8JHMy+CUplbCSNV31OTsf6C1L/Wp5zGV2TMZ3o4wYwcnPqgSUPMSyXbTlpq6+xpOutdacyM7J8j2IP4BRWdrsuhiWQk16F69A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730894243; c=relaxed/simple;
	bh=vyTp09Kt056FuIQHGo/DAlBjwjbN8kCcV3oLDoXZyOQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BKJJCtaYBN0z+oiFv7Yjk7Dlxcp3lc8UJ9C4AGTJmYrpLnhaSBcvyA5rbxbk4nYm642jF1GS9oIOk3cZQP4G8+ML46lmNptvEO0l7WRUPVZi584h1QQn+ntaRpr7XjlXDO714PQKgLo+Gz1sWhY8F/PWXhfrM6qmvCAXNxVgIjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=emEaJ8+a; arc=none smtp.client-ip=209.85.128.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="emEaJ8+a"
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-6e35bf59cf6so7952377b3.0
        for <bridge@lists.linux.dev>; Wed, 06 Nov 2024 03:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730894240; x=1731499040; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M6w3ZCB6zmWm7DPLmF3ULV02jMnZ0BDFI1Mq0GUN2Ks=;
        b=emEaJ8+a8Khmbyq3nDkEeMDo9MLNq3GF6w+oL4Ilo1kL+lAdNe/If+KbN0ggykL7Z+
         0596wDRTEjskLt6E5RqIycCTWclfZJbe4v9EMEHhR4hY6RoV8IDyyxmxoxo/7vWTiSVP
         021c+ljtYn9WhzT0ldLgN7PezzWqMQffN3i2FPrdwG05UP2wXHIQdCJgvWnmzNkknZM1
         ACxQMRl3vapqf20NIFc7NJdDA/mLjWARspj+a7b2uV55I5sod4HvOenxv2Nuh0OsNwI3
         +4gpN4rpneVlLGqypz6HqKV7ePzjZJumvDQDxV6Lt0I/dvjZX65ba/OTnhBK0rnnpz07
         enrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730894240; x=1731499040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M6w3ZCB6zmWm7DPLmF3ULV02jMnZ0BDFI1Mq0GUN2Ks=;
        b=tTGdPkZ4O39R2M0ZrB2i5s7N5MSAiRgcSSk4qWoGNDzH8HmuNu+1icmnT2F/lBKYZX
         Pdj/wBWil8KMdV7kUZVIw41wtWV+k8YnP3r2vaIS+96swocT6ZY9CgAJT6rlcjj1pqrt
         CQettL6Z3KO+ErQiCpuLhjAB+KKVjbTQmYJNXm3HlR/mkvAmvwEW/sD8/C45iEFYDB9X
         /pmUSBQ8QLobsd6vTvDsDorsG1ThkJQV8kFLbxtry6YAwbc5GO9SjJvB6GA4rxc27py0
         oUcZe6Ph32eiglQgsV6ZCQPsxkZtApTUtSiyRjtapPnaAMUwep/yUhqKEgg8WFzVa+xA
         fAaA==
X-Forwarded-Encrypted: i=1; AJvYcCUdy8Uq1fky5cQ1dah7Zjzz9i4oGzWMnx6ZtFEm4kYb9WBV6jXV0VNDWyfhPujZacr7CAO5P28=@lists.linux.dev
X-Gm-Message-State: AOJu0YwSu/DkFQGWNrI/Wbp+q175wHc1+44V+77Kmc8E750KBq5WF1ns
	9vGBXkoSj5pFsiG4rsP+tBL38Y8lPy2tVsfWd/rX0vNk1o5CRB5+cA8vpQUuyLlCr42ZqciYkrL
	lgyrxbKZODB3h2nLsfSGio+y8o9U=
X-Google-Smtp-Source: AGHT+IEXBfeFoiOB+fEMxTsXACuSVQL2ysa8XWrdoUI8KD1G2wDOAZIO6rXenVvdCBA8S96MOfWzKujBjQG2V8YVs/w=
X-Received: by 2002:a05:690c:64ca:b0:6e2:41fa:9d4 with SMTP id
 00721157ae682-6eabf02be83mr15361397b3.15.1730894240626; Wed, 06 Nov 2024
 03:57:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241030014145.1409628-1-dongml2@chinatelecom.cn>
 <20241030014145.1409628-9-dongml2@chinatelecom.cn> <7b8b83b4-f745-4f3b-8cac-2f190937667a@redhat.com>
In-Reply-To: <7b8b83b4-f745-4f3b-8cac-2f190937667a@redhat.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Wed, 6 Nov 2024 19:58:28 +0800
Message-ID: <CADxym3Z6GdXdFoXcex-h300xxAbCPtbVoxPMRNx9sKaWh7_MHw@mail.gmail.com>
Subject: Re: [PATCH RESEND net-next v4 8/9] net: ip: make ip_mkroute_input/__mkroute_input
 return drop reasons
To: Paolo Abeni <pabeni@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	horms@kernel.org, dsahern@kernel.org, pablo@netfilter.org, 
	kadlec@netfilter.org, roopa@nvidia.com, razor@blackwall.org, 
	gnault@redhat.com, bigeasy@linutronix.de, hawk@kernel.org, idosch@nvidia.com, 
	dongml2@chinatelecom.cn, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	bridge@lists.linux.dev, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 7:25=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On 10/30/24 02:41, Menglong Dong wrote:
> > @@ -1820,7 +1822,8 @@ static int __mkroute_input(struct sk_buff *skb, c=
onst struct fib_result *res,
> >                */
> >               if (out_dev =3D=3D in_dev &&
> >                   IN_DEV_PROXY_ARP_PVLAN(in_dev) =3D=3D 0) {
> > -                     err =3D -EINVAL;
> > +                     /* what do we name this situation? */
> > +                     reason =3D SKB_DROP_REASON_ARP_PVLAN_DISABLE;
>
> I don't have a better suggestion :(
>
> Please drop the comment and re-iterate the question in the commit
> message after a '---' separator, so we can merge the patch unmodified if
> nobody suggests a better one.

Okay, I'll move this comment into the commit log, which
I usually place the change logs in.

Thanks!
Menglong Dong

>
> Thanks,
>
> Paolo
>
