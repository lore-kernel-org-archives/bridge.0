Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558CB30AD05
	for <bridge@lists.linux.dev>; Thu,  1 Oct 2026 12:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790857197; cv=none; b=Y708yhCrQa2bKjh6D0d5/niKOtY72q/npPvSC7uc4WJKHYqOvhr79MYFwVRwuvhhrAOPX2Yrb6KFGLagImPwXxDbLYhUGzCimDJnv8tPV17sgs7RMWRRZ7Ffce73bWlKcb+MKPMwSdUh/92tccRcuvd9eWZerWSMv4YX292Lnh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790857197; c=relaxed/simple;
	bh=nRbfMwngHUKsiqlMccbHxJzWFiHdULg4qLygabHKz1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mmaCP2wxp3i+FddbZgdobC963KYtRKi5OFEOpxk3oaTNuQkvaflVr4Gv9pGNHsdtYJqsk3lmteSBXa1DPHp5hwEwdtm768jymH+kAmOd772NM3gWARPzCKP3mgLuTVXyWds3Mt9cBX/OpGg+Sn/R7YF5r5q1vDKdJkcO8sr8lLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GPiHviEe; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPiHviEe"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ce364488dso10463295e9.0
        for <bridge@lists.linux.dev>; Thu, 01 Oct 2026 05:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790857194; x=1791461994; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VqJs1lu9yYEnrWjWAn/NSnJmVPwl6cd9S/MSijAAG84=;
        b=GPiHviEeijxM33Tmdr1EHrUU54QqpeHcCdclXaJ9OaV+Yv8L9fjx9EA1fOQHmVRFBh
         Kidc3vqhise5XjdqL9wEkNJFvCiKH2rEKbiagrRMYlnyuwz9T3QiH9Sf1MSztq/Stfud
         /8hU7uhwCubDMJW+VT6lhKKIC2Pvv6F1TWYe6FvKTqkorSoI5Jbx3JeVn/iZqYIxf1O2
         gUkTubIFWTe5k6keyCpLINeNe3MrWy5tGOkKgTRz6y/JPqAuni48IStpyhdztmEFZ06/
         ac/2XfNMGz9H+N91oVNb7qYnkI8txPUvlkHIsgNkp8/Nqo2kMLLCllnSRtiYbhdu8f47
         Uj7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790857194; x=1791461994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VqJs1lu9yYEnrWjWAn/NSnJmVPwl6cd9S/MSijAAG84=;
        b=UbwRz7Cqa4dj5C9nZVkAk96wyokY203X7ry5agMSgYFNaD43GvspsUkpry+bwtUHBE
         21EvWsGpUVApcpY7FwSafng6M0OXwcTwgv3YYap/aL24gL/PiuBZgXq4g5+5jejfiIVc
         b00ktpAWMnECC26OS/fNNlToEoMp2dNunmuSwXzfJrK7EA4H5UCGzh8ifxaostf/aL0W
         20m2frgxulDAzCH+DKyJ9FPlpQVyIhy9vPH9tjuSe4fRq+SLTl8L4pbtPWOtLEVb7MDt
         /Er2bZtTVDAfFbIwMiPoGllI/tDUwAYd4/tdajrUyjA40IpMu6lFlUHcF0RGKGezpsox
         /3GA==
X-Forwarded-Encrypted: i=1; AKwUvBwIsFiE9SR2SKK46aX4KEW2jkFWylqgYA3mtHfEnpOg8NqJbZyg5jDL5+eF0Lo1jfdt3Fwk1pw=@lists.linux.dev
X-Gm-Message-State: AFuF++muXLFytc9dhDGjWxQaM6Gsx0G0ADC5KEsTBReKZHSdlbmcgFsf
	BdEg9lwXy9If10BvFBU/JprkBJi/6+osqSlkEiK50Tp7D7JVA/WmwSys
X-Gm-Gg: AYBFou2rTJTgssZQJ4EyqCa11Ayg1W/L/o39vlaVJBeGczcc4c6B3ZUUDeQ8Q+SxwGF
	cv5yHX7hawzrg3Co2C7aajaG0QDLWrJmTuvXIdAvDFnQ6MRyyfG7Lbe502IMm/VoziSyERuZ+Ba
	35ei0j6chofOKdQRiHvZa6fuN+d2s5Vp8PeRrMslToSz2HFrOZzTcNP81S5zvIewXoGzgXoDmdz
	wlFRO+pUVdDQEIBgqkwV5+qklfZXhD2uSb+n+4QHW0bECNLUEW8GnUpSt9302jWZe2cw7xQ5Av1
	UcKpqSoUQLvKQZp7IYjiAGopvVlAV51vleWvfXWVV8G3AJuDw9GJZBad4XXatZG51hmACHCej8d
	D5zv9x33nywEfnoncXWE4cpO1yopD7uWLPpScGi7WHwRwB2paice+xKNSEA+JbSmYoUmE7kpgMp
	pYwEoEG3lmK2PUdqvYK1+/shrQfviMht1UK5LD75B+xqZXrVlFK1OfCvBEgkYknIl3Jqm6lsao6
	JLU8Hef/LB9paqEIrFidjqLmG4R/K/1tO0qJpoAS5cvEHHn
X-Received: by 2002:a05:600c:859c:b0:49c:e37e:4389 with SMTP id 5b1f17b1804b1-4a01eaf5b37mr37503985e9.4.1790857193367;
        Thu, 01 Oct 2026 05:19:53 -0700 (PDT)
Received: from andreayoga.localdomain ([151.43.138.29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01f923320sm69506935e9.7.2026.10.01.05.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 05:19:52 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: netdev-bot+sashiko@kernel.org
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	netfilter-devel@vger.kernel.org,
	Phil Sutter <phil@nwl.cc>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	coreteam@netfilter.org,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH nf] netfilter: br_netfilter: restore VLAN tag on refragmented IPv6 packets
Date: Thu,  1 Oct 2026 14:19:34 +0200
Message-ID: <20261001121941.31364-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <179084999520.434549.4764913674478855382@kernel.org>
References: <20260928161830.351199-1-parri.andrea@gmail.com> <179084999520.434549.4764913674478855382@kernel.org>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Oct 01, 2026 at 10:19:55AM +0000, netdev-bot+sashiko@kernel.org wrote:
> For an untagged packet this helper saves vlan_proto = 0. The consumer only
> ever sets a tag and never clears one:
[...]
> So would fragments 2..N reach br_nf_push_frag_xmit()->br_dev_queue_push_xmit()
> with their ingress 802.1Q/802.1ad tag still set, while the first fragment
> goes out untagged?

Yes. Conntrack defrag keeps the original fragments on frag_list for both
IPv6 and IPv4 here (ip_frag_coalesce_ok() is true only for local
delivery), each with its ingress tag, and br_handle_vlan() clears the
tag of the head skb only. On the fast path those skbs are sent as the
fragments.

I extended my reproducer with a port that is untagged in VLAN 10 and a
static FDB entry, so the packet is not cloned. With this patch applied,
6/9 IPv6 and 6/9 IPv4 fragments left that port with "vlan 10"; only the
first fragment of each packet was untagged. This is not introduced by
this patch, but it means the changelog claim was too broad.

v2 will add a second patch that clears the tag in br_nf_push_frag_xmit()
when none was saved, as nf_ct_bridge_frag_restore() does, and narrow the
changelog of this one to the fragments ip6_fragment() builds.

The BR_VLAN_TUNNEL case does not reach the refragmentation code:
br_handle_egress_vlan_tunnel() attaches a metadata dst, so
br_nf_dev_queue_xmit() drops the packet at the !skb_valid_dst() check.

> Also, the comment "Fragments may not inherit the MAC header or VLAN tag"
> does not seem accurate for reused frag_list skbs, which keep their own tag.

Agreed, v2 rewords it.

pw-bot: cr

Thanks,
  Andrea
