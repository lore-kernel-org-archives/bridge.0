Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794193928;
	b=TJuoAwOp04zrhQQBAyMzJMZfs4pWUgQV+U1kXoqAypBD4Wj55xYpVIMRnipqEUo4FFCP
	 4DDUjbwyy9hWMJFf3tGOSQZcSmF3nkxNBpjXdKYQ6LKxWE3MDrFitTLagUoGa39ZEWy98
	 d2oOc2JcBnZ1bHX54XpAqD19s2C6BCsQZgtWg0jOtuhFqfqd7IEGnwfoPiA0/LsKLJdRN
	 WANKIWY5utmHQekKxztPaaAcDA3peG7JMEe6qzQszG90FBwdPaU8HIti1DMCEqCvc5fIk
	 Rj1zRcW+hlP9U6QpTBAZvmeTM2htOBIFG+9l6OLL844n1xS63/WEEYjnBmkTIfy6Y1g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794193928;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=SS4X10tnH1zMkf70V4OKi2rc8i/EWRIUyaIhQlrMvdc=;
	b=Sw+jXULgCVQ8w+nn3C6frK4qlizUQ2VLv4R9MnU0OD9/um6dDi3lAZ6hKQwxIjwIKiD5
	 i7heZaP2D4R3Yu68a9/3cOQV77FBCS/2/UmZiqrcjf2TeNEsQDjWdgsn7yUrSwhL3jj03
	 d+KJF66x6GJdVCMywyyyvJfW1NYo/NrrZ6n0zaiGvWo0vnz9sdOjFsvRGsPxPZ1nPcbvw
	 bsz1LABTzLV1GriDKoBLbbzFcgfMdFVLJ56Om4+bocY5LvHWoBTvjg3MOZMTVY9jkmcaR
	 Txg2lEQ1R4mH2HJ0ZLKqh+6lTiFAxw4QRR1TwLEy85NscKJrOd2m6IxFwVzkOydy5hQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uXlulTjQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.48
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B09A606D801
	for <bridge@lists.linux.dev>; Mon,  9 Nov 2026 03:12:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B09A606D801
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uXlulTjQ
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5c08539c827so243436e87.2
        for <bridge@lists.linux.dev>; Sun, 08 Nov 2026 19:12:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794193926; cv=none;
        d=google.com; s=arc-20260327;
        b=WiQcApzmZ5BPcufEtfdPWW5J9MUsC10cWLddkOJkXVbsm6801t7ZsbywHor35nUrE7
         ihEmlTdrGgrnjSCtJ9vhASbrNqgpDD6VqI+aKkI9RQX/5Es9xGm9Pcc0peqGoVDb4yUj
         tleZy9jLP7h1wdr5hWSJ1oAviXZRyS6YBsw6UgQuNUvSKEVzFPl+Jk0BXymvFFYVcxN9
         MjDbGd/jn1fLTJ6PJcc6UZpXlzzZckrI0xZgwk26wNmjwHBCNg91GGkFipjD7n/T7A4m
         tQllN6cd40qInqVOVbNkNgXTEImUP9M0nIgUBtk2bsYFCD3sKfMvCX1StJRQUqlvU/a8
         AFHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SS4X10tnH1zMkf70V4OKi2rc8i/EWRIUyaIhQlrMvdc=;
        fh=/ZngOebEp+v3NePNybTrsQf/8fR1r0oh83fCRA72wlY=;
        b=nvaMgB3QIYZC9Wm8k/9n50x4vYAecPfHzGJ7SDIdgl2uxeK9glyX9zLBnqbhgu6Vr4
         8b1retT1zCBZNUA0dC6yJ2XpWkdbBnhrrfP5ZxHHJZhOIh+ZK/adHbgAvWYb/jCKuEBV
         PR6ccw4ltpewZj8eH7KDtBgqZPAXHfpJO0yM23uz9aIlxQJC36lLuD/dEkoaXXuWZSaU
         z51NN6hSRkSYIZGg1hEEjwUZybje0FAYlHjep+APB2p1Y5JUVUcerRTR8sYZ9W5Vb0GC
         cgRe+gTyY/ylX5bV3s2pj4jzewAifZC01RRhn6MlLeLkQ97HF2LuEL6p+05AESBFgFrq
         YvZg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794193926; x=1794798726; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SS4X10tnH1zMkf70V4OKi2rc8i/EWRIUyaIhQlrMvdc=;
        b=uXlulTjQHf0BVG3qWDRchYtlBxB1kbQ73UhmZqJxBZDKB2rOmedzp/LCtTDBdEIuHq
         urKq9EpKhF1jyS/eli3pIyrzDEAty/AJoLnX0VTbiag9xxzhNqBP9jEZeTN9UEAorSL7
         36kR5MoMGrt5eN5yT1pFQDeL39w/ayfU8V/flfw/cecz0uNdPusjBnoshUdyn0VaiQ0y
         D9oR/aaWQFl1rIzOpK7HKMWy54tCOrUwKMHydJibstQRcZzBvqip3PYvw9AoLy/E0q8T
         MxxR8gIuo/2vWw/4jY+i9eCMpLklOSiKB1IMppx7XbeprG7yx0E3qCKD2Wg1tRDfVLzn
         yLEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794193926; x=1794798726;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SS4X10tnH1zMkf70V4OKi2rc8i/EWRIUyaIhQlrMvdc=;
        b=wEP+xuJSoT932c2LBrUFsUFyoMAyRAIev0+qaiuiXJt39Y/s3dj/38Be5v5DviHg6G
         zlVnqhGdtJMoD1aW4gMEgj3F1FNXC9K4iFOeoN+HAlxzwJazWTHp4YsEj7IdZ/Od2zSZ
         Fan8muLM3xbwkAfSr+hXrEr9zhha7LZ++yz+4hbsoHUqPvgs2xXEVYKSN5okUknbSE4L
         podU97FTvyBW5Lu5T2Qbj4xxRVHZed/Zqgv+l0ynKoKGCGAOn/so0PE4gZp1ihuIxvok
         GCwIduI2Wb3it8v879TuRZ+YRmLfWWyooYknq+2h8ZBWP2AI3sFpgHwGMyzEo5r4e5PF
         f6FA==
X-Forwarded-Encrypted: i=1; AL+hErEilpHxvBCuWL9Z+fIhRZPQI0v4Nc9UYsFA9RNpIFVwLrSkB25GFkg+9deCX17saH+LuLY59Ec=@lists.linux.dev
X-Gm-Message-State: APuU4Z9Zhf+IpS2q+GuQYbR8+Hkh2/Dn5RcBnQkm0/Hjfy7cxTHWcAxB
	OYYL8d3SXmcCUph1WzFwOPh+zTWs62KxuhrGwq88Pel7Kx2Se9bLi4cEXFwMIHoQbHTqtni1aC6
	qnTM3rlgTUXD9bftMvoEVOcHjlZXlmMo=
X-Gm-Gg: AYBFou3R1a2FqbrVFXtzWBBi15j4LqTfN4Thq8cC1wOFKj8EJgRtX6JA30wwupTcG1C
	q06vxl2n/oKg317O+5Or5tnUKRXSKBZk0ir+H11B0Jx2jEWzNbfMNmTs6W0DYKMvrNcYkAJG9p6
	RN6S7sn1CqQZPVYaQdMR/kPYokkzOJ0QpoQSZHZc8BQYzjuUddAIeeAM/iNSUm5NSmHfaKt5/OE
	OmUDjEZdVlt1m4AMGS+Y6WL9BZftHUw7kGZF+qRai8W3tmHn5xnwrIEwd3Mfc1I+YhrkDvhbuDL
	JguIUR+Gr8ovPUq9/tnhx7yqqBd0RzjwoL60FVDEp+PVBEtylCdzEspnakquurk1pMTtzJ+7Wua
	0ls4mGD8aWMZ4cOtlrKqWYMk4Ta0OrbCsV6iOLqLL9+7m71TbssbddymR8T8sKKsajtxISec7/Y
	88145nCQr3GgXqxW4+Pp0tFnDcZJQ3UQ+PD1YTpoSe68R4XyZP/ZrV
X-Received: by 2002:a05:6512:3088:b0:5c0:471:f028 with SMTP id
 2adb3069b0e04-5c14bfedffcmr703341e87.22.1794193925282; Sun, 08 Nov 2026
 19:12:05 -0800 (PST)
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Post: <mailto:bridge@lists.linux.dev>
List-Help: <mailto:bridge+help@lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
List-Owner: <mailto:bridge+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261109025425.328445-1-jiayuan.chen@linux.dev>
In-Reply-To: <20261109025425.328445-1-jiayuan.chen@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 9 Nov 2026 11:11:26 +0800
X-Gm-Features: AclHuK-8zzYe5mJdMRhvHJ2iaIG2lKRoeKrY7lhKeXbLBk5rPZ5G9f2uOL9YkTM
Message-ID: <CAL+tcoDvFNAZubOjw9+Z1eyaVeiBzt_Xg3KMNucY879bg-ZLow@mail.gmail.com>
Subject: Re: [PATCH net-next 00/14] net: annotate data-races around sysctl knobs
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>, 
	Phil Sutter <phil@nwl.cc>, Nikolay Aleksandrov <razor@blackwall.org>, Paul Moore <paul@paul-moore.com>, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, Julian Anastasov <ja@ssi.bg>, Allison Henderson <achender@kernel.org>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	"D. Wythe" <alibuda@linux.alibaba.com>, Dust Li <dust.li@linux.alibaba.com>, 
	Sidraya Jayagond <sidraya@linux.ibm.com>, Mahanta Jambigi <mjambigi@linux.ibm.com>, 
	Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>, 
	linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	coreteam@netfilter.org, bridge@lists.linux.dev, 
	linux-security-module@vger.kernel.org, mptcp@lists.linux.dev, 
	lvs-devel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	rds-devel@oss.oracle.com, linux-sctp@vger.kernel.org, 
	linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 9, 2026 at 10:55=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.de=
v> wrote:
>
> While testing the recent sysctl range fixes I noticed that a lot of our
> sysctl knobs are read with plain loads while the handlers update them
> with WRITE_ONCE() and no lock, so KCSAN reports them as data races. I
> then used an LLM to go through every ctl_table under net/ and list the
> readers that were left behind. This series annotates them with
> READ_ONCE(), and adds WRITE_ONCE() to a few custom handlers and netlink
> paths that store to the same fields with plain writes. Most of it is a
> plain READ_ONCE() at each read; where a function reads the same knob
> twice to make one decision, it now reads it once into a local, so the
> comparison and the value it acts on cannot come from two different
> writes.
>
> There are no Fixes tags. Done one knob per patch this would be well over
> a hundred commits, so I grouped them by subsystem and feature instead to
> keep the review manageable. If maintainers prefer, I can split it up
> further with a Fixes tag on each one, as several smaller series.

Over the last year, I've been thinking about the annotation stuff
especially around sysctls, which, I suppose, shouldn't actually affect
the real workload but does affect the outcome of the syzbot.

Out of sheer curiosity, my question would be what is the point of
trying to change all of them? Or what kind of benefits can we get from
the big series?

Thanks,
Jason

>
> No functional change. KCSAN does hit these, e.g. toggling
> net.ipv6.icmp.echo_ignore_all while receiving ICMPv6 echo requests:
>
>   BUG: KCSAN: data-race in icmpv6_rcv / proc_dou8vec_minmax
>
>   write (marked) to 0xffffffff8ee2940d of 1 bytes by task 504 on cpu 0:
>    proc_dou8vec_minmax+0x1ab/0x1f0
>    proc_sys_call_handler+0x282/0x3a0
>    proc_sys_write+0x13/0x20
>    ...
>
>   read to 0xffffffff8ee2940d of 1 bytes by interrupt on cpu 3:
>    icmpv6_rcv+0x99d/0xd40
>    ip6_protocol_deliver_rcu+0x787/0x9a0
>    ip6_input_finish+0xb0/0x1b0
>    ip6_input+0xa8/0x250
>    ipv6_rcv+0x14b/0x1c0
>    ...
>
>   value changed: 0x01 -> 0x00
>
> Jiayuan Chen (14):
>   ipv4: annotate data-races around ip_rt_* sysctls
>   inet: frags: annotate data-races around fqdir->timeout and
>     fqdir->max_dist
>   ipv6: annotate data-races around addrconf sysctls
>   ipv6: annotate data-races around icmpv6 reply sysctls
>   calipso: annotate data-races around cache sysctls
>   sctp: annotate data-races around sctp sysctls
>   mptcp: annotate data-races around pernet sysctls
>   rds: annotate data-races around core rds sysctls
>   netfilter: conntrack: annotate data-races around conntrack sysctls
>   netfilter: bridge: annotate data-races around br_netfilter and nf_log
>     sysctls
>   ipvs: annotate data-races around lblc_expiration and lblcr_expiration
>   net/smc: annotate data-races around smc sysctls
>   netfilter: conntrack: annotate data-races around timeout and tcp
>     sysctls
>   netfilter: cttimeout: annotate data-races around the default timeouts
>
>  include/net/ipv6.h                            |   2 +-
>  include/net/netfilter/nf_conntrack_acct.h     |   6 +-
>  .../net/netfilter/nf_conntrack_timestamp.h    |   2 +-
>  net/bridge/br_netfilter_hooks.c               |  20 ++--
>  net/bridge/netfilter/ebt_log.c                |   2 +-
>  net/ipv4/inet_fragment.c                      |   2 +-
>  net/ipv4/ip_fragment.c                        |   6 +-
>  net/ipv4/route.c                              |  34 +++---
>  net/ipv6/addrconf.c                           |  22 ++--
>  net/ipv6/calipso.c                            |   6 +-
>  net/ipv6/icmp.c                               |  10 +-
>  net/ipv6/ndisc.c                              |   2 +-
>  net/ipv6/route.c                              |   8 +-
>  net/mptcp/ctrl.c                              |  18 +--
>  net/netfilter/ipvs/ip_vs_lblc.c               |   2 +-
>  net/netfilter/ipvs/ip_vs_lblcr.c              |   2 +-
>  net/netfilter/nf_conntrack_core.c             |   8 +-
>  net/netfilter/nf_conntrack_ecache.c           |   2 +-
>  net/netfilter/nf_conntrack_expect.c           |   2 +-
>  net/netfilter/nf_conntrack_netlink.c          |   2 +-
>  net/netfilter/nf_conntrack_proto.c            |   6 +-
>  net/netfilter/nf_conntrack_proto_generic.c    |   8 +-
>  net/netfilter/nf_conntrack_proto_gre.c        |  20 ++--
>  net/netfilter/nf_conntrack_proto_icmp.c       |  12 +-
>  net/netfilter/nf_conntrack_proto_icmpv6.c     |  12 +-
>  net/netfilter/nf_conntrack_proto_sctp.c       |  13 ++-
>  net/netfilter/nf_conntrack_proto_tcp.c        | 110 +++++++++---------
>  net/netfilter/nf_conntrack_proto_udp.c        |  24 ++--
>  net/netfilter/nf_flow_table_core.c            |   4 +-
>  net/netfilter/nf_log_syslog.c                 |   2 +-
>  net/rds/recv.c                                |   2 +-
>  net/rds/send.c                                |   8 +-
>  net/rds/threads.c                             |   4 +-
>  net/sctp/associola.c                          |   2 +-
>  net/sctp/bind_addr.c                          |   2 +-
>  net/sctp/endpointola.c                        |  14 +--
>  net/sctp/input.c                              |   2 +-
>  net/sctp/sm_make_chunk.c                      |   6 +-
>  net/sctp/sm_sideeffect.c                      |   2 +-
>  net/sctp/sm_statefuns.c                       |   6 +-
>  net/sctp/socket.c                             |  46 ++++----
>  net/sctp/sysctl.c                             |  16 +--
>  net/sctp/transport.c                          |   6 +-
>  net/smc/af_smc.c                              |   8 +-
>  net/smc/smc_clc.c                             |   8 +-
>  net/smc/smc_core.c                            |   2 +-
>  net/smc/smc_tx.c                              |   2 +-
>  47 files changed, 259 insertions(+), 246 deletions(-)
>
> --
> 2.43.0
>
>
