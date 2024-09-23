Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1527F56B72
	for <bridge@lists.linux.dev>; Mon, 23 Sep 2024 10:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727086593; cv=none; b=M8BLS/zL3GhnDfPz/ot3QudsKi5fkkg5wSH5nxqsEcRUPie4Nmf7MyqMij0FB/n2WCDdi26RNR5GbOEpsvW56kj/ovTUw/tJdfB8mFS0/hqGDBJKLIPP6i2AM+cU8EQOc5DhKNOyEEvUP8ZP+058kX8rskKAfg9D/Ibi+1K0iNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727086593; c=relaxed/simple;
	bh=s+e2I81/u1djzKANWX+BHKnVKSk7mf2smUP6ixSsLZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ktZOPe0EgjVK9QTx/lUTLeb0BVXPi520nNq4MWFwzBBL4t+4fmkOBrEBw84sTVEzRoX1/Yfg8pQtv7GvQYbn/Z/AeDAzVr0zRcCnw8AVNlBDINmp2ifwvTw0VsEPSBL6p0zqsSwRhH+bXlPw5X38z2m0adNsuv+5Q5e6bDJpoF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qAOYhBKG; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qAOYhBKG"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c46c2bf490so1622334a12.3
        for <bridge@lists.linux.dev>; Mon, 23 Sep 2024 03:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727086588; x=1727691388; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z3e+4tzy78SD0uTGInfbmqrqn1zNjwwAT0I86sCzn14=;
        b=qAOYhBKGC8blqMmXBusAmnIVZgLzeIm/RM++NVgSBIohpVA0U06YthPS+SsuHDs4RE
         guYp314RT5SHj3GgV10JqbeUGjaMmg9kRoxBVbSGUFyL2L8vqxZlXhlymQCUSJD6vzm7
         uIQgOQuSXHHC0L5SgiDVl3vL7ptZV9dwwtNmJU6Cb0jy+zBxVLY9XvP0g5Sr7/8CS1w5
         x93Q8Gl8xURtX+NZ+NkmdoZvf6sYiMa1lTOLaR7Is3P1sLLs6Fx8k4LYDpio6fVIbzxg
         QiSUQk2mM4OJ/Lkn8IOXcjrGTT4onCdDjgMFdvfh+blQuZe0Iez5k33Uxoh8L4XlX1nC
         MvjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727086588; x=1727691388;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z3e+4tzy78SD0uTGInfbmqrqn1zNjwwAT0I86sCzn14=;
        b=B/ocdD+zNqlsCEtq7zi3IBArnWwYU/vv3d/19tYrsK2e6q2Ll96sFlPVrxI3sPDtO8
         zJBS0miLY5PJiocUR20sGafDk2A6/x0tfY+MeadNTGeqk8xyBebuA4pvFWk5JBdhgF9E
         ogkkTpvp7ZYDXNE0OsG8H4UejMyUp+gYMVFwEc84i3M8H6DF+NSWg+RJaxxYTGKaGoxp
         DlnAedqhgzjRilSgwPztQ9sOP4c84ItYg/E5aV6nuiHjrqrw2iMSeacJAd3dyTzRFLAZ
         bWW18tZ1SUqkqLTx1My4HYK+2kHF2G7zjFTEpZRf1Xjyyt13ACvJxG5bZH0Mjp2Cbp4E
         Bbzg==
X-Forwarded-Encrypted: i=1; AJvYcCWeAkNJikI6jgUrVw+47EGaJ6omM67h2Uo81+ylKRD7KLU9GLt/QfuLY5ESwRtJEzGEixFN6DA=@lists.linux.dev
X-Gm-Message-State: AOJu0YxeDlQdZiD6y50/hcObRvPf5KWfv6IZeZbMqOKgShbMhbiDkQxU
	Tc3NQr11LbjlAw0f2w/VNBhI6lx218gRzJLClCmvrcb8j6k94s13ta//RJamNvbxrlX5MzKuXB6
	ywiBPO7bnyKVDDkZfdPUrL2yzBCxaQ4+nknDy
X-Google-Smtp-Source: AGHT+IE/qAmJKSsYjmvCIHgJn7RfIoWZCtJ9IuS9SWi9uecUmHEmRL78Z96iZ101d55iTEU2O+UavIBQPdwIpftuEGI=
X-Received: by 2002:a05:6402:90b:b0:5c4:8b7:d93d with SMTP id
 4fb4d7f45d1cf-5c464a42b12mr18761649a12.18.1727086588119; Mon, 23 Sep 2024
 03:16:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <EC5AC714C75A855E+20240923091535.77865-1-yushengjin@uniontech.com>
 <CANn89i+4wbef3k6at_Kf+8MBmU4HhE9nxMRvROR_OxsZptffjA@mail.gmail.com> <80515DEDE931DC2A+7fa48c7a-2955-4afb-821f-a0108a72009f@uniontech.com>
In-Reply-To: <80515DEDE931DC2A+7fa48c7a-2955-4afb-821f-a0108a72009f@uniontech.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 23 Sep 2024 12:16:14 +0200
Message-ID: <CANn89iJCBRCM3aHDy-7gxWu_+agXC9M1R=hwFuh2G9RSLu_6bg@mail.gmail.com>
Subject: Re: [PATCH] net/bridge: Optimizing read-write locks in ebtables.c
To: yushengjin <yushengjin@uniontech.com>
Cc: pablo@netfilter.org, kadlec@netfilter.org, roopa@nvidia.com, 
	razor@blackwall.org, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	bridge@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2024 at 12:06=E2=80=AFPM yushengjin <yushengjin@uniontech.c=
om> wrote:
>
>
> =E5=9C=A8 23/9/2024 =E4=B8=8B=E5=8D=885:29, Eric Dumazet =E5=86=99=E9=81=
=93:
> > On Mon, Sep 23, 2024 at 11:16=E2=80=AFAM yushengjin <yushengjin@unionte=
ch.com> wrote:
> >> When conducting WRK testing, the CPU usage rate of the testing machine=
 was
> >> 100%. forwarding through a bridge, if the network load is too high, it=
 may
> >> cause abnormal load on the ebt_do_table of the kernel ebtable module, =
leading
> >> to excessive soft interrupts and sometimes even directly causing CPU s=
oft
> >> deadlocks.
> >>
> >> After analysis, it was found that the code of ebtables had not been op=
timized
> >> for a long time, and the read-write locks inside still existed. Howeve=
r, other
> >> arp/ip/ip6 tables had already been optimized a lot, and performance bo=
ttlenecks
> >> in read-write locks had been discovered a long time ago.
> >>
> >> Ref link: https://lore.kernel.org/lkml/20090428092411.5331c4a1@nehalam=
/
> >>
> >> So I referred to arp/ip/ip6 modification methods to optimize the read-=
write
> >> lock in ebtables.c.
> >>
> >> test method:
> >> 1) Test machine creates bridge :
> >> ``` bash
> >> brctl addbr br-a
> >> brctl addbr br-b
> >> brctl addif br-a enp1s0f0 enp1s0f1
> >> brctl addif br-b enp130s0f0 enp130s0f1
> >> ifconfig br-a up
> >> ifconfig br-b up
> >> ```
> >> 2) Testing with another machine:
> >> ``` bash
> >> ulimit -n 2048
> >> ./wrk -t48 -c2000 -d6000 -R10000 -s request.lua http://4.4.4.2:80/4k.h=
tml &
> >> ./wrk -t48 -c2000 -d6000 -R10000 -s request.lua http://5.5.5.2:80/4k.h=
tml &
> >> ```
> >>
> >> Signed-off-by: yushengjin <yushengjin@uniontech.com>
> >> ---
> >>   include/linux/netfilter_bridge/ebtables.h |  47 +++++++-
> >>   net/bridge/netfilter/ebtables.c           | 132 ++++++++++++++++----=
--
> >>   2 files changed, 145 insertions(+), 34 deletions(-)
> >>
> >> diff --git a/include/linux/netfilter_bridge/ebtables.h b/include/linux=
/netfilter_bridge/ebtables.h
> >> index fd533552a062..dd52dea20fb8 100644
> >> --- a/include/linux/netfilter_bridge/ebtables.h
> >> +++ b/include/linux/netfilter_bridge/ebtables.h
> >> @@ -93,7 +93,6 @@ struct ebt_table {
> >>          char name[EBT_TABLE_MAXNAMELEN];
> >>          struct ebt_replace_kernel *table;
> >>          unsigned int valid_hooks;
> >> -       rwlock_t lock;
> >>          /* the data used by the kernel */
> >>          struct ebt_table_info *private;
> >>          struct nf_hook_ops *ops;
> >> @@ -124,4 +123,50 @@ static inline bool ebt_invalid_target(int target)
> >>
> >>   int ebt_register_template(const struct ebt_table *t, int(*table_init=
)(struct net *net));
> >>   void ebt_unregister_template(const struct ebt_table *t);
> >> +
> >> +/**
> >> + * ebt_recseq - recursive seqcount for netfilter use
> >> + *
> >> + * Packet processing changes the seqcount only if no recursion happen=
ed
> >> + * get_counters() can use read_seqcount_begin()/read_seqcount_retry()=
,
> >> + * because we use the normal seqcount convention :
> >> + * Low order bit set to 1 if a writer is active.
> >> + */
> >> +DECLARE_PER_CPU(seqcount_t, ebt_recseq);
> >> +
> >> +/**
> >> + * ebt_write_recseq_begin - start of a write section
> >> + *
> >> + * Begin packet processing : all readers must wait the end
> >> + * 1) Must be called with preemption disabled
> >> + * 2) softirqs must be disabled too (or we should use this_cpu_add())
> >> + * Returns :
> >> + *  1 if no recursion on this cpu
> >> + *  0 if recursion detected
> >> + */
> >> +static inline unsigned int ebt_write_recseq_begin(void)
> >> +{
> >> +       unsigned int addend;
> >> +
> >> +       addend =3D (__this_cpu_read(ebt_recseq.sequence) + 1) & 1;
> >> +
> >> +       __this_cpu_add(ebt_recseq.sequence, addend);
> >> +       smp_mb();
> >> +
> >> +       return addend;
> >> +}
> >> +
> >> +/**
> >> + * ebt_write_recseq_end - end of a write section
> >> + * @addend: return value from previous ebt_write_recseq_begin()
> >> + *
> >> + * End packet processing : all readers can proceed
> >> + * 1) Must be called with preemption disabled
> >> + * 2) softirqs must be disabled too (or we should use this_cpu_add())
> >> + */
> >> +static inline void ebt_write_recseq_end(unsigned int addend)
> >> +{
> >> +       smp_wmb();
> >> +       __this_cpu_add(ebt_recseq.sequence, addend);
> >> +}
> > Why not reusing xt_recseq, xt_write_recseq_begin(), xt_write_recseq_end=
(),
> > instead of copy/pasting them ?
> >
> > This was added in
> >
> > commit 7f5c6d4f665bb57a19a34ce1fb16cc708c04f219    netfilter: get rid
> > of atomic ops in fast path
> They used different seqcounts, I'm worried it might have an impact.
> >
> > If this is an include mess, just move them in a separate include file.
>
> Can i copy  ebt_write_recseq_begin(), ebt_write_recseq_endend to
> include/linux/netfilter/x_tables.h ?
>
> Or add a parameter in xt_write_recseq_begin() , xt_write_recseq_end()  to
> clarify whether it is xt_recseq or ebt_recseq.

I think you can reuse xt_recseq, xt_write_recseq_begin(),
xt_write_recseq_end() directly.

We use xt_recseq from three different users already.

If you think you need a separate variable, please elaborate.

We prefer to reuse code, obviously.
