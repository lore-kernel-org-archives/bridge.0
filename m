Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047343;
	b=wn2LfCmDcogqclnH/YadGF1U6X2pfSgifiVpGl5rXtDzZPASosu6EUF301N3IfXvaSGN
	 bX4MSXAB5i0nCbc0nFdF+IvcYwIgQZVtatoz+isyP57lAmm43JDG9SisPA2Om2a+u0LDq
	 S/MzNFlSgGcq73zwlhwrc1LN2xRr+MC9ce6tcAtKCKzGWhxCNGiDFbmnwnjy5zYkntwE9
	 B95fHFCAL+LrC/efzw4avITDKj9VLGWko+6xGhR2K6nbg+wcuNW7PfZvox/612U3a2kms
	 lKDENg6R32L0zh15uvdHKJAoQNaMqDPUNMge1P00GC4csmUB1+aNfyt8i5Klq7Dmjtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047343;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=kPfxxEoDedkpzijCZq5OLG208Bd3QgI6noPt3uH0hgY=;
	b=K4tTLvm22C2AtWgYMz4cmrI47OMOsoM5ygGddSKk1K07MfOExkY4oeAcL2C9AOVst7XK
	 V7hx3yZLZy7/XE1k9T57EhLdavCkMsYoQScIGJG1iRVaM/cFah7QeY3KVQ6VqRNXO2UqZ
	 o6tANNRUoDZXhZXE/VZBGmWW6MvyVKMyEOyIbhDs3rH5ZKzLC+Hx8/SqMxgJZr3P4wl6y
	 8yFLCr4N0PHl7v9PsxG0hAk8L32R4wETCoBiBAWAAlf/irLuapfqu4Enf7cjHcd2vr9Dk
	 JlVaRYCbzMnUpdsfdCTIfl6+ZpxVynMRCZvvWwj5i9XBe10e96jfkcg9RdwlONVlgOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=openai.com;
	spf=pass smtp.mailfrom=openai.com;
	dkim=pass header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=aJ36C+Ua;
	arc=none smtp.remote-ip=209.85.160.176
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67811606A33B
	for <bridge@lists.linux.dev>; Sat,  7 Nov 2026 10:29:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67811606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=aJ36C+Ua
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-53bb57f1310so17572211cf.2
        for <bridge@lists.linux.dev>; Sat, 07 Nov 2026 02:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1794047342; x=1794652142; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kPfxxEoDedkpzijCZq5OLG208Bd3QgI6noPt3uH0hgY=;
        b=aJ36C+Ua9Uv84IM+FGrG5HF1RcUOW65KO+xurtmfBkAnit+hgMcvWedwEDl/SgYveP
         2QsvvJNwh1wMJUpuPTtB6JzTbWlMqv47j4M08liI1FNi1d9pAUd++SJDP+C69M0lO6vb
         cbf6IeP2pXpd2rGDjoRya43rwYEf7NE3G8b9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794047342; x=1794652142;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kPfxxEoDedkpzijCZq5OLG208Bd3QgI6noPt3uH0hgY=;
        b=OlCyOsVRHvXRNB6EhZ1h9Yi1gbhWaQfXdbYFWusQOO/tcBl4/HvXGskIdVsqf5kYlk
         urv7hwxzEm6wsRqGYeMfv970fiAHEFWU4ze+BzQV72WYZoSTZnBujuu420RHkK6NlbO1
         HX1/TW0024pHSeh+0o1ip+xfnBe2M2z+1liMuzsWgs4GyoZyRwgheP75rMGVaYgxd0O5
         WhXU3ahDMHM4uUusipuJ3m8Yu+P8y42E5gVkp8tj6pNreCtUowZsyIMCUyeKzVMYmfDt
         Gb6xgnVxNXso8fGe8oawldV+Tjcvy5ae8n0/Yl6xY4RozCnk6+x/xFtNORAeA/CA3m8s
         o5bw==
X-Forwarded-Encrypted: i=1; AKwUvBxeNPrre0tcUIGMxMY9xldL1N3vWSe2mtqlNQ0AB8DwWaUxc07+B3p+OFM2vWGA0qkvkiYI+oY=@lists.linux.dev
X-Gm-Message-State: APuU4Z/bkwHvqIVy+D6ZU2LbFb0JH/Op+6ucwJeVs9Op+JakBWeD+Br9
	fJa6i1WndgN5+S83WG/6xQcAFMtom2CaKuZzot+rJXHWFoRCnSjdNt5Zo8LaASWT+h0=
X-Gm-Gg: AYBFou3wKcfd3Hox1wC0GBEcboPXyVlq6M/H2BczUSAn5Vi+SXONNVuii9+QBomNgZK
	Jlv5oCihSe2mc0EdE/nSOyTO6a3vsyzmnbnU+3ctVHY4uQ/c28PgfgnqqnK2+EogxkyL991pTpg
	Iczze3TRc4AAi1wxghLuL+2ix8ZiDkNs3z4Bel9poUAepV8mnHwlMPdrG8mfF7TEWJIV3wQQZRU
	5vxnCro9OqPGaYgRJQV7K9SSaJhTDxOv4ubGDyyesV5v0sm4zCQIaHjISgR9+Ef86HcNmN5I9FJ
	u1XkUpoP8S3qdpQ6ucigoctp5dzDy7Y9gBjSABNkubR3bcnfxiA/KmZz12C3xQZZgO1zs6SW1fL
	Q1sjeZgtQ3peuyQOhrEAcHhwOZI1EZ9Wc+PAMp1XrG2QSh8GvOqelzx3628274397dHF4w2XSCs
	/ZlPDFYNAdeHShH3DSwKcHXDPkLkNSKEi3EYj+DX5IqMQcKmZ9psGnrICnqdPCab+BSXcmZjWJQ
	4iop/cNQcfSRH3D86ywHMo1HyUhfBeLb+AKN93gsgfIrPzZYqSiZco/IhQuaI9speO+7x9+Bn5m
	T69VpsZDSsY4+q9rTF8rP7NdMI4UQCB48Y53niMe88h+MzqFW2LU8aefvP+LUCj3gMG328WzY6y
	3KITPPvI=
X-Received: by 2002:a05:622a:2508:b0:537:dea7:adb1 with SMTP id d75a77b69052e-54e115b4283mr77969511cf.4.1794047342290;
        Sat, 07 Nov 2026 02:29:02 -0800 (PST)
Received: from com-75606 ([199.47.143.1])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54e2625abafsm43098871cf.16.2026.11.07.02.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 02:29:02 -0800 (PST)
Date: Sat, 7 Nov 2026 02:28:58 -0800
From: Kyle Zeng <kylebot@openai.com>
To: Florian Westphal <fw@strlen.de>
Cc: netfilter-devel@vger.kernel.org,
	Pablo Neira Ayuso <pablo@netfilter.org>, coreteam@netfilter.org,
	bridge@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, outbounddisclosures@openai.com
Subject: Re: [PATCH] netfilter: br_netfilter: reject unsafe neighbour devices
 for DNAT
Message-ID: <au79avuyDAz__s4t@com-75606>
References: <20261030042155.73844-1-kylebot@openai.com>
 <au7SdYQrIqAQOU24@strlen.de>
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Post: <mailto:bridge@lists.linux.dev>
List-Help: <mailto:bridge+help@lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
List-Owner: <mailto:bridge+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <au7SdYQrIqAQOU24@strlen.de>

On Sat, Nov 07, 2026 at 08:25:41AM +0100, Florian Westphal wrote:
> Kyle Zeng <kylebot@openai.com> wrote:
> > The IPv4 and IPv6 bridge prerouting callbacks classify DNAT traffic using
> > the logical input device saved in skb->dev. The physical input port can
> > have a different bridge master when prerouting resumes, for example after
> > an NFQUEUE verdict. Netfilter reassembly can also combine the first
> > fragment's bridge information with a different fragment's input device.
> > 
> > br_nf_pre_routing_finish_bridge() replaces skb->dev with the port's
> > current bridge master, but looks up the neighbour using the existing
> > route. This can put an skb with skb->dev pointing to bridge B on an
> > unresolved neighbour of bridge A. Deleting B and resolving the neighbour
> > on A then causes a use-after-free in __dev_queue_xmit().
> > 
> > Before calling the neighbour output method, check that the neighbour
> > keeps skb->dev alive. A neighbour holds its device, and a VLAN device
> > also holds its real device, so allow a VLAN whose real device is the
> > bridge. Release the neighbour and drop the skb on a mismatch.
> > 
> > Doing this in the shared continuation covers both protocol families,
> > including a queue in the remaining bridge prerouting hooks. Leave the
> > cached-header path unchanged since it does not enqueue the skb.
> > 
> > Signed-off-by: Kyle Zeng <kylebot@openai.com>
> > ---
> > I have a reproducer for this issue and can share via DM
> > 
> >  net/bridge/br_netfilter_hooks.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> > 
> > diff --git a/net/bridge/br_netfilter_hooks.c b/net/bridge/br_netfilter_hooks.c
> > index e15355ff215a..726a2d17ed3a 100644
> > --- a/net/bridge/br_netfilter_hooks.c
> > +++ b/net/bridge/br_netfilter_hooks.c
> > @@ -307,6 +307,18 @@ int br_nf_pre_routing_finish_bridge(struct net *net, struct sock *sk, struct sk_
> >  
> >  			ret = br_handle_frame_finish(net, sk, skb);
> >  		} else {
> > +			struct net_device *dev = neigh->dev;
> > +
> > +			/* The neighbour queue must keep skb->dev alive. A VLAN
> > +			 * device also holds a reference to its real device.
> > +			 */
> > +			if (is_vlan_dev(dev))
> > +				dev = vlan_dev_real_dev(dev);
> > +			if (dev != skb->dev) {
> > +				neigh_release(neigh);
> > +				goto free_skb;
> > +			}
> > +
> 
> I don't understand the vlan check. Why is that needed?
> The call to br_nf_pre_routing_finish_bridge is gated via:
> 
>  405                         if (skb_dst(skb)->dev == dev) {
>  406                                 skb->dev = br_indev;
>  407                                 nf_bridge_update_protocol(skb);
>  408                                 nf_bridge_push_encap_header(skb);
>  409                                 br_nf_hook_thresh(NF_BR_PRE_ROUTING,
>  410                                                   net, sk, skb, skb->dev,
>  411                                                   NULL,
>  412                                                   br_nf_pre_routing_finish_bridge);
> 
> 
> ... so this patch ought to be sufficient?
> 
> --- a/net/bridge/br_netfilter_hooks.c
> +++ b/net/bridge/br_netfilter_hooks.c
> @@ -283,6 +283,10 @@ int br_nf_pre_routing_finish_bridge(struct net *net, struct sock *sk, struct sk_
>         if (!skb->dev)
>                 goto free_skb;
>         dst = skb_dst(skb);
> +
> +       if (dst->dev != skb->dev)
> +               goto free_skb;
> +
>         neigh = dst_neigh_lookup_skb(dst, skb);
> 
> (I can't see how neigh->dev != skb->dev after the extra test).


The VLAN check is intended to preserve existing VLAN DNAT behavior.

bridge-nf-filter-vlan-tagged=1, bridge-nf-pass-vlan-input-dev=1, and br0.100, the earlier test can pass with
dst->dev == dev == br0.100. The continuation then changes skb->dev to br0, so the strict comparison would
drop that valid packet.

A neighbour on br0.100 is safe here because it holds the VLAN device, which holds its underlying bridge. That is why the slow-path check compares the neighbour´s underlying device with skb->dev.
