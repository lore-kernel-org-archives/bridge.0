Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69E1EEB5
	for <bridge@lists.linux.dev>; Mon, 23 Sep 2024 09:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727083809; cv=none; b=ZQYuuijQaR+0OF44HrDjwbj8t+GSkk4SN3iJGadgaKRF8HWKkRiL+Zqnl2IFCRF3A0pYhYdWzbjECl476zLLnV8Nc8HF6WLE6ybKtzj/aOYDfWJVAje0GJfJ1iTwmOG19DfCPHA2+dO/HxPvKZ6F8Eix1ttSlhSK40eaNlqARLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727083809; c=relaxed/simple;
	bh=xveS8An5yPxN/MxZ/eWTONl87PHoFBR9KHYvY0iw02A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YZYz9L+MGl+DdgsKVHfk8X620KjgtM1MjBXV4YzXV1uwEuVDNPc6T1jnwE6PXYKIm88t9oDqI4OcxqYMSobO0/VYvAluQeX+WF68Hz6kdYOvLpqxpnURzbZs6e36zBj1FgtIGNbOI07Lc+WNmaMzGXTQnCBW+3va9r7vvSXiGjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FztKB+gT; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FztKB+gT"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c3d20eed0bso4719856a12.0
        for <bridge@lists.linux.dev>; Mon, 23 Sep 2024 02:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727083806; x=1727688606; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vuk3CfC/8d2trmHsLKwiAc84e3WNXWpr9l6TZadOWI4=;
        b=FztKB+gTzPVVcWqGiElZByub+NCw8UU3+3Q0yNry9m3xV5ZTqaYhy6xJM6HTm87JkY
         J8eT8ZjP6pXKVancO1WvWLkmFVigncu2P2ycgozYfC5hM6uDbcuuesIGs4BXWxDNk86W
         hARNsmx20cBmEwPuJRUptaWS5aD6g4ZTMKuhGkapmAEXJquAuJN16eBOhh+kbAH1pJIH
         u+ZGh5rY8kr/tQvzZx7sW3+MYpgqgmLhHcBIbkHdu1YEKzAp5YF+UDdy6cnjXCf9XSMv
         l1+6r/RGrdD8iWptkutFjWaU13zVLADrExVg40GpxT/CneCbw1btze3QW62JSE21o6EA
         7i5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727083806; x=1727688606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vuk3CfC/8d2trmHsLKwiAc84e3WNXWpr9l6TZadOWI4=;
        b=NQq4GtO2mZ5QGqE1Gy9HBuV6rB3MXC3Ifz1qKnlVCybLmPwsm/oNkvEkmBqXF7xmlG
         1X7wRWDdm1AaPOWYoMpmRtGhckSknXG496/8IpBMMXxccY5sJ78evZRwOyIcRNOxNYkG
         UxBIQ8KAJ7bZyxfviA/FvBEGg0cOf8UFHLeaGDg/HBoYbMMvrkndMOlp3IrRUukW23jb
         bLBKMQQIGdspHnjicNgBcx9wlWEC7o5EurUrdC4k4PW64y0dY6FTGJmTO5mGjLteUYN+
         uqucoyIBrPmKZsiT/FAMKegqriJAKIIkRyXnCIOwMjy4SSfDVuBwo9PGt2PeB5yKwPDt
         vHpg==
X-Forwarded-Encrypted: i=1; AJvYcCXNmHITco6YlXJjDQzWBPzobmuuUifi2+3R/ibfWwLbOIWyUNYI0L1HAKrVHrvlI7cI2nEPPMQ=@lists.linux.dev
X-Gm-Message-State: AOJu0Yyuxcks/BPC5D/dId6/Z1FDseauZbDbD++xcuZKugRQlAPM60IF
	pyBiY13t+tl6noFkIj/B8PDoAfvcIUXdfr/uZ2A/6EHySm/t6LejLT0woWWhUlYjffBoY4KkAng
	U3jMmdwJm3Zvgska1DTveNTW5RepHOG79hOHZ
X-Google-Smtp-Source: AGHT+IFVRkOuz/0hqyC4TUZW9wr9CQzEnHCIPDxI2kRUa/SbM68opPu+QAgvUStGeDqWB+N5a4dUu9svuUD/5ab7oWo=
X-Received: by 2002:a05:6402:2b94:b0:5a1:c43:82ca with SMTP id
 4fb4d7f45d1cf-5c464a5d40emr9977738a12.26.1727083805807; Mon, 23 Sep 2024
 02:30:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <EC5AC714C75A855E+20240923091535.77865-1-yushengjin@uniontech.com>
In-Reply-To: <EC5AC714C75A855E+20240923091535.77865-1-yushengjin@uniontech.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 23 Sep 2024 11:29:54 +0200
Message-ID: <CANn89i+4wbef3k6at_Kf+8MBmU4HhE9nxMRvROR_OxsZptffjA@mail.gmail.com>
Subject: Re: [PATCH] net/bridge: Optimizing read-write locks in ebtables.c
To: yushengjin <yushengjin@uniontech.com>
Cc: pablo@netfilter.org, kadlec@netfilter.org, roopa@nvidia.com, 
	razor@blackwall.org, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	bridge@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2024 at 11:16=E2=80=AFAM yushengjin <yushengjin@uniontech.c=
om> wrote:
>
> When conducting WRK testing, the CPU usage rate of the testing machine wa=
s
> 100%. forwarding through a bridge, if the network load is too high, it ma=
y
> cause abnormal load on the ebt_do_table of the kernel ebtable module, lea=
ding
> to excessive soft interrupts and sometimes even directly causing CPU soft
> deadlocks.
>
> After analysis, it was found that the code of ebtables had not been optim=
ized
> for a long time, and the read-write locks inside still existed. However, =
other
> arp/ip/ip6 tables had already been optimized a lot, and performance bottl=
enecks
> in read-write locks had been discovered a long time ago.
>
> Ref link: https://lore.kernel.org/lkml/20090428092411.5331c4a1@nehalam/
>
> So I referred to arp/ip/ip6 modification methods to optimize the read-wri=
te
> lock in ebtables.c.
>
> test method:
> 1) Test machine creates bridge :
> ``` bash
> brctl addbr br-a
> brctl addbr br-b
> brctl addif br-a enp1s0f0 enp1s0f1
> brctl addif br-b enp130s0f0 enp130s0f1
> ifconfig br-a up
> ifconfig br-b up
> ```
> 2) Testing with another machine:
> ``` bash
> ulimit -n 2048
> ./wrk -t48 -c2000 -d6000 -R10000 -s request.lua http://4.4.4.2:80/4k.html=
 &
> ./wrk -t48 -c2000 -d6000 -R10000 -s request.lua http://5.5.5.2:80/4k.html=
 &
> ```
>
> Signed-off-by: yushengjin <yushengjin@uniontech.com>
> ---
>  include/linux/netfilter_bridge/ebtables.h |  47 +++++++-
>  net/bridge/netfilter/ebtables.c           | 132 ++++++++++++++++------
>  2 files changed, 145 insertions(+), 34 deletions(-)
>
> diff --git a/include/linux/netfilter_bridge/ebtables.h b/include/linux/ne=
tfilter_bridge/ebtables.h
> index fd533552a062..dd52dea20fb8 100644
> --- a/include/linux/netfilter_bridge/ebtables.h
> +++ b/include/linux/netfilter_bridge/ebtables.h
> @@ -93,7 +93,6 @@ struct ebt_table {
>         char name[EBT_TABLE_MAXNAMELEN];
>         struct ebt_replace_kernel *table;
>         unsigned int valid_hooks;
> -       rwlock_t lock;
>         /* the data used by the kernel */
>         struct ebt_table_info *private;
>         struct nf_hook_ops *ops;
> @@ -124,4 +123,50 @@ static inline bool ebt_invalid_target(int target)
>
>  int ebt_register_template(const struct ebt_table *t, int(*table_init)(st=
ruct net *net));
>  void ebt_unregister_template(const struct ebt_table *t);
> +
> +/**
> + * ebt_recseq - recursive seqcount for netfilter use
> + *
> + * Packet processing changes the seqcount only if no recursion happened
> + * get_counters() can use read_seqcount_begin()/read_seqcount_retry(),
> + * because we use the normal seqcount convention :
> + * Low order bit set to 1 if a writer is active.
> + */
> +DECLARE_PER_CPU(seqcount_t, ebt_recseq);
> +
> +/**
> + * ebt_write_recseq_begin - start of a write section
> + *
> + * Begin packet processing : all readers must wait the end
> + * 1) Must be called with preemption disabled
> + * 2) softirqs must be disabled too (or we should use this_cpu_add())
> + * Returns :
> + *  1 if no recursion on this cpu
> + *  0 if recursion detected
> + */
> +static inline unsigned int ebt_write_recseq_begin(void)
> +{
> +       unsigned int addend;
> +
> +       addend =3D (__this_cpu_read(ebt_recseq.sequence) + 1) & 1;
> +
> +       __this_cpu_add(ebt_recseq.sequence, addend);
> +       smp_mb();
> +
> +       return addend;
> +}
> +
> +/**
> + * ebt_write_recseq_end - end of a write section
> + * @addend: return value from previous ebt_write_recseq_begin()
> + *
> + * End packet processing : all readers can proceed
> + * 1) Must be called with preemption disabled
> + * 2) softirqs must be disabled too (or we should use this_cpu_add())
> + */
> +static inline void ebt_write_recseq_end(unsigned int addend)
> +{
> +       smp_wmb();
> +       __this_cpu_add(ebt_recseq.sequence, addend);
> +}

Why not reusing xt_recseq, xt_write_recseq_begin(), xt_write_recseq_end(),
instead of copy/pasting them ?

This was added in

commit 7f5c6d4f665bb57a19a34ce1fb16cc708c04f219    netfilter: get rid
of atomic ops in fast path

If this is an include mess, just move them in a separate include file.
