Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E75642EEDA
	for <bridge@lists.linux.dev>; Tue, 12 May 2026 09:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778577913; cv=pass; b=NSj5+uirWdP8sGe48u13o25xYHLJ/Z6Fy4JlQ1GNRyG0WeHNvuBIhHZ57X19l0Gvomh/nRN+G5iOX/S0WRIGEr/OpYWId32r6R0hSv+xGccZC+WLndtsiVNxfAviBmXqmSiFrzD4r2EDnHosPuPxFYy5MRK0pINz4nZOwYiTYPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778577913; c=relaxed/simple;
	bh=o/6U62XbaDSLrBCYv6/owErRRDaqpMXcRYRw5nP61t8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J3JMTMftN/hdcSInROTXDH5Oq6d4z7SD9JWn3N8xWEE97loLbwhzN841AiPNN7oK3jCkbfSaseCvRCCLOeVBTCjYDs71Mi0L7czsa7blSEEAPGSjmiZdl6yt7/5rSNuIj5LHC0L8oFhwsP0OKuSrP9BAKQ4ZM0NGZCpBarvC41g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NRaFDPoG; arc=pass smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NRaFDPoG"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8bc3ef10cc4so60023176d6.1
        for <bridge@lists.linux.dev>; Tue, 12 May 2026 02:25:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778577910; cv=none;
        d=google.com; s=arc-20240605;
        b=gEnjjorSjSSlsdtn4ML5YVUwBvBcz2dvPKo/9kE+1Bpf7cnaM+Z8h3csTHp7A9KkU2
         yD6NkcmYGie0nlq2jql39JfPcko+KdLFElcD6LcYwzKzS/D74pFwkw5p6EvkUrSgYV1x
         /lsyovkUD65fNbh4iG604OvzWfNZSWowcaZSfaZP/6pu9u6s+jJaSPPGDws0gs2g9mkK
         6BlOrFFi073FK6NFDtLyRCd+5zil0XwcokEs3L8UhV5y8eXKxGhsYDqScZp+RyCT44tS
         qOeT5/pe8vu14GD3/LFVLi8C4P9xRYJyg0K7eVaCN1IRNxcjwT+/+TxZ3IkYSHdx7Ewo
         YCIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=02U6ivPZFeN9WHQFlvflnUeZjcIBBlBqBFePfdQqFyg=;
        fh=DZIYk+qPjYVi6QWQDqgJhPBBtxL1KyZcPErTFxJuKSg=;
        b=RBAOQeOYa2yxIqywYk/RvnHflfwGqS1NY0iSCXc+xuqN01asNqiEop+JluqAA9KSuJ
         1QiOOtmzG3oKOCeIX3Df8KOU2I+tex5W8Lu2GUbvMpcgybH4ZXZcyPbpmIIxvvs2DmS3
         5rOuUPYr9Qm9hDzK5b+8+kfrNqmIFWKj0jL2dyNhqJCdEPdg5bY9uLN7e1cQQuTPMk4/
         2QNfiBzxzjUQuANWGxLLsm5aqyEM7Jbio4UiGatYg/bZeUnZI2Ni46v1oCT8+Eo7TRHS
         0CwjDZdZnrE3tFHAq6mqtKQ9nWOq/4E1W8bht+pOw5a8weUQVFWRvXRlLHIfS830Td+M
         RvkQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778577910; x=1779182710; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=02U6ivPZFeN9WHQFlvflnUeZjcIBBlBqBFePfdQqFyg=;
        b=NRaFDPoGaNH4d7YMKF3dl5hrcDVFEz/5fanNKz7ImHP4HyuLLaKqLCDTqFuD0pVHo2
         Kpyd/nZU6oOyvNsJtKmiFlLdiwzwjz1bjz/ReR/RGAm39fr77BdOeU9Gs4gEN0yHxBnQ
         0F1CharhtgbxQAPe60jKTe1hS0AxprlW32WFA3ZwC0KLOIp+IsZKf9DJOoibYa/YY6q8
         6Lbb8kLwEoXSwDnma+iFJbARSUFpgaTg9rgWgbATPWdy3kIzLIShwFIGzr72gWQiebpb
         ECZsm7W5hKx3e0648gfifB6izGzOGzjXkFHklbkTC4jKOj9h75OMp47Gsk66l8eqcdCh
         qJZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778577910; x=1779182710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=02U6ivPZFeN9WHQFlvflnUeZjcIBBlBqBFePfdQqFyg=;
        b=HbqjIwmsju54SnNEGqPKwI3DdP9YpNEVPtpjNd6elyrgPy/vCMdmbshmdPR2UqGokB
         gfRXW0uOokQXgYXR7/+10GmGlGS93bGHEcBJUlJyy7oyYemtZ+cGLjY3pGh4B+pluhkZ
         kL1MeuuboreO7IooJ++LYl+84Mmja5F5HGigEJJ/nEsqeiCO796urnfQbUIzBr1aJmr0
         bQV7QojJXN5ixn3UCUO/3hD/GSanqkhk/wxU/RlStIEz1H9CFbV4aHy9lCLDrHtouDTA
         tPt+WZbXOwyiVw/Y841SIn98RuS83EyiFGvEdPdtq+RettatYAkn4YiSnED1YcYmktnf
         jSkg==
X-Forwarded-Encrypted: i=1; AFNElJ+/4n5huxD3A1f0BqD3ecryWp2uZdBpKKQrJCq9AS2TbYhE6juAQbjQfRsTZ+Ni0mPh5BgfM0M=@lists.linux.dev
X-Gm-Message-State: AOJu0YwZ3qET4CtuFENqqzx+x3Un6Ant781YKscKVsKq2YpOhqdVj2/n
	MV1S6rMegZndtxPFlGqKFXww/JyXV8386S4Y5UV7UF6aNVKgXEMzV7VrIEkrtiPGChWLu2+wVvk
	SRamM64F1mmoGZD+gK/LcSPf5PvDZJAQ=
X-Gm-Gg: Acq92OHfs9ygH8r7XxomcAIutucTcXdNiVNKB4P6OBRyQnV+MJAkIwWBEYl+tUthaDh
	o7WmsnERJRd8CYyBkqRlpdmeQia2tSCKWGCXDUlMkNzCHl7BOb7SZ+OwHc+KF/gGDSM1aQOStiF
	v8bhRR79VgTF5uMmy1olemcHkSBQKXXi+npuIfM8Rm+ebmpGvPt/n+cMcJsxYQfjKfyQm5wO6lp
	nEiFPD9HxZbcAf74bsDhkpU3Zc+3WgO7eW5dAXUPkUfSpwUahnqGnCccliwfZIeYuMruMD3S9DN
	IfQX27g=
X-Received: by 2002:a05:6214:5890:b0:8bf:6a92:84af with SMTP id
 6a1803df08f44-8c1a379722amr191655806d6.21.1778577909973; Tue, 12 May 2026
 02:25:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1778504155.git.tonanli66@gmail.com> <ad183a40c4d906f39e03590b371fdcfdffb863c6.1778504155.git.tonanli66@gmail.com>
 <1bfd86a2-e7f8-42ef-8486-4d7fa91b2199@blackwall.org> <CAPuPA7JzZC1veoLtdmsGdqZ4xuy7Znu=z=+7FsyX0_iUQxcZAQ@mail.gmail.com>
 <c2bbd2ab-e4f9-4142-a3d4-531f3d5ce6d7@blackwall.org>
In-Reply-To: <c2bbd2ab-e4f9-4142-a3d4-531f3d5ce6d7@blackwall.org>
From: Yuan Tan <yuantan098@gmail.com>
Date: Tue, 12 May 2026 02:24:57 -0700
X-Gm-Features: AVHnY4KD0TfTyan543XHPWM1ak4nMXTSylUMLtAxLtkGNTo-flKx6QChPyrFj_8
Message-ID: <CAPuPA7+jMHLjpY-RWK6-EQqs-NjrGUmanuPVVTDZJv1yeRk1oA@mail.gmail.com>
Subject: Re: [PATCH net 1/1] net: bridge: guard local finish against missing port
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Ren Wei <n05ec@lzu.edu.cn>, bridge@lists.linux.dev, netdev@vger.kernel.org, 
	idosch@nvidia.com, fw@strlen.de, davem@davemloft.net, yifanwucs@gmail.com, 
	tomapufckgml@gmail.com, bird@lzu.edu.cn, tonanli66@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 2:03=E2=80=AFAM Nikolay Aleksandrov <razor@blackwal=
l.org> wrote:
>
> On 12/05/2026 11:57, Yuan Tan wrote:
> > On Tue, May 12, 2026 at 1:29=E2=80=AFAM Nikolay Aleksandrov <razor@blac=
kwall.org> wrote:
> >>
> >> On 12/05/2026 07:31, Ren Wei wrote:
> >>> From: Nan Li <tonanli66@gmail.com>
> >>>
> >>> The bridge local receive path may be deferred by netfilter and resume=
d
> >>> later. By the time br_handle_local_finish() runs, skb->dev may still =
be
> >>> valid while its bridge port association has already been removed.
> >>>
> >>> br_handle_local_finish() unconditionally looks up the bridge port fro=
m
> >>> skb->dev and dereferences it for source learning. If the port is no
> >>> longer attached to the bridge, the lookup returns NULL and the deferr=
ed
> >>> local receive path can no longer rely on the port state being present=
.
> >>>
> >>> Skip the learning step when the bridge port lookup fails. In that cas=
e
> >>> there is no port state left to learn on, so returning early preserves
> >>> the normal behavior for existing ports while avoiding access to stale
> >>> state.
> >>>
> >>> Fixes: 8626c56c8279 ("bridge: fix potential use-after-free when hook =
returns QUEUE or STOLEN verdict")
> >>
> >> I don't think that is the correct commit, it seems to me this bug
> >> has existed for a very long time. From a quick search I think (Florian
> >> please correct me if I'm wrong, but I think NF_QUEUE existed back then=
)
> >> it was introduced in 2010 by:
> >>    f350a0a87374 ("bridge: use rx_handler_data pointer to store net_bri=
dge_port
> >> pointer")
> >
> >
> > After checking the history, I believe f350a0a87374 is indeed the
> > commit that introduced the underlying root cause.
> >
> > The 8626c56c8279 commit in the patch is the one that actually made the
> > bug reachable in practice. I am a bit unsure which commit should be
> > used in the Fixes: tag. We have run into this situation several times
> > already, where the commit that introduced the root cause is different
> > from the commit that actually made the bug triggerable/reachable.
> >
>
> Hmm could you please elaborate? How did that commit make it reachable?
> I can see the call was done before it as well:
>                  /* Deliver packet to local host only */
> -               if (NF_HOOK(NFPROTO_BRIDGE, NF_BR_LOCAL_IN,
> -                           dev_net(skb->dev), NULL, skb, skb->dev, NULL,
> -                           br_handle_local_finish)) {
> -                       return RX_HANDLER_CONSUMED; /* consumed by filter=
 */
> -               } else {
> -                       *pskb =3D skb;
> -                       return RX_HANDLER_PASS; /* continue processing */
> -               }
> +               NF_HOOK(NFPROTO_BRIDGE, NF_BR_LOCAL_IN, dev_net(skb->dev)=
,
> +                       NULL, skb, skb->dev, NULL, br_handle_local_finish=
);
> +               return RX_HANDLER_CONSUMED;
>
> NF_HOOK() would return 1 for NF_QUEUEed packet so essentially it was doin=
g
> the same, how would did it make the bug triggerable?

I see. I was wrong. Thanks for pointing that out.

>
> > What do you think would be best?
> >
> > Also, if the Fixes: tag should be changed, would you prefer that we
> > resend the patch, or would you rather have the committer adjust the
> > Fixes: tag when applying it in order to reduce traffic on netdev?
> >
> >
>
> You should update the Fixes: tag but also wait 24h before re-posting anot=
her
> patch version.

Ok we will send the v2 with fix tag f350a0a87374 after 24h

>
> >>
> >> because that commit removed the same check for a NULL port.
> >> The patch itself is ok, it restores the check that was there before th=
e commit
> >> I mentioned.
> >>
> >>> Cc: stable@kernel.org
> >>> Reported-by: Yuan Tan <yuantan098@gmail.com>
> >>> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> >>> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> >>> Reported-by: Xin Liu <bird@lzu.edu.cn>
> >>> Signed-off-by: Nan Li <tonanli66@gmail.com>
> >>> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> >>> ---
> >>>    net/bridge/br_input.c | 3 +++
> >>>    1 file changed, 3 insertions(+)
> >>>
> >>> diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
> >>> index 2cbae0f9ae1f..5b0d7450de5f 100644
> >>> --- a/net/bridge/br_input.c
> >>> +++ b/net/bridge/br_input.c
> >>> @@ -247,6 +247,9 @@ static void __br_handle_local_finish(struct sk_bu=
ff *skb)
> >>>        struct net_bridge_port *p =3D br_port_get_rcu(skb->dev);
> >>>        u16 vid =3D 0;
> >>>
> >>> +     if (unlikely(!p))
> >>> +             return;
> >>> +
> >>>        /* check if vlan is allowed, to avoid spoofing */
> >>>        if ((p->flags & BR_LEARNING) &&
> >>>            nbp_state_should_learn(p) &&
> >>
> >>
>
