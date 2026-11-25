Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795595693;
	b=ARAkozYWz1KZGYfsJySSf+JCj30V1RBMlbzR4e4UqWjoJHIYQdo4Hqp4aUIx/VGDQzjK
	 yd0tWFc6URW4w7kTRX2deh8tILq59jbtgVRHWxz2tmTymLlZdehNq7IeUKOhPukyo3LRY
	 qGTaawvkJxAbgShXsQ8mADN1XjmEJ5OJUHjQYWO4wCHADCH1micN3t2Hjg90xov1KYKtl
	 DqDITjoexNtIz4dg66YMXnbD2IMQh0jbUoIBKOnoYQhzprOpIlYxfPgdadYCaHxUN3yL8
	 AY9RItG3QOo0WLjH0DahNTdpqKMya7i3PvvScC4J0uMPKoIrF53oceS33L8G3bViNXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795595693;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:To:
	 Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=V24Aq6kbDrsjlo6n/xUdmssdTYaesbR21Q1hwpsxJYs=;
	b=lnDPTePUsLJw2z+qmcy7agU2r1vX+cjCd+s2WZNNIqkyY5ylCnceePnY5/7VSvgkd8ep
	 ezltS1EAOvsWXSO1yXGv2dJMwFjWUa2UON7w4zDhe5s9Fn2+oArrWFYxoNyH+MZB1ULNF
	 Y/406N0840/s3gVY9ykuCagva/uon2fZEibb44FU5y80Z+kAIBKNG6rfvYTiySRknYc6A
	 62UbBpjCLKY0CiHsa/159SAzWtVCoEWQNoxbJGDpd2bBmYM6GfJa6vRF4v0ZW7ukZOVv9
	 tDcJ8YReA8qPAJyC34KgZ8OYnm8u1jPhtdP6ZxYzmnkVLSdJ2sfMgeRpEEFntge7c1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=blackwall.org;
	spf=none smtp.mailfrom=blackwall.org;
	dkim=pass header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=HVrqD8Ca;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD41606A321
	for <bridge@lists.linux.dev>; Wed, 25 Nov 2026 08:34:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BFD41606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=HVrqD8Ca
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4a3e706b5dfso3414228f8f.2
        for <bridge@lists.linux.dev>; Wed, 25 Nov 2026 00:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1795595691; x=1796200491; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=V24Aq6kbDrsjlo6n/xUdmssdTYaesbR21Q1hwpsxJYs=;
        b=HVrqD8CaKL/q+jVVFDtr2JEMESyMzmOIp6DI8r0+Pf5lgpISbC5lQGhMfk67aRTUL2
         DAV9Hn9zz/vuAhJuqrmuijCqEpNmb47+Mk0NgFBA0vlkbfWwBBR/7RxvNbV+6uNChera
         8Ux+6mPC2Ew+Tdh59P/BgPvtok1+3YN6rz/FgvDAuTvVJFCn8wurBau0sZmOhjzUqyHf
         4fnIEqpCzHHvwbpwpdqTxbfMAobHs275EiTdYRZVGBv5ibCfq/+bR3lq+ZF6d8Zt4Uio
         QRlXfxXTA9z1UkRAcpJ8qUpNmjcgGMUwdGVJD9ma1OJpknpNbLjzacqfbjWSZrA9kWcR
         J8iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795595691; x=1796200491;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V24Aq6kbDrsjlo6n/xUdmssdTYaesbR21Q1hwpsxJYs=;
        b=zTM9xIbJguNy0ccxhTtClzAygMpVV5oztDa7YZmOStTcrE0ZKNMXxlBzlXbAbXTLw8
         6Zu5FpMe8IWOGoP6Oz5kwO5ll2ih4ZuYpIKptJ1Wjd0CmsoRPFSArkpTCsePVsKzfrw9
         VsS2V8z5KoxgiDEy30Bmg4otRCWewmN8c9svXhCghdTu6lgLsuSRKFj3mFCbQpfJiNYE
         9TUQTrGchxnuRCGLtEregdX7IB8M1Vr3r4TqXQSY44jhKzYfo8uhG+AuInDUaqvXVUaN
         f74AK/Nz1CYH5TuwM56EQZy6jN1NAGkT0s91LnY222trVva0tYV9KlIXNgz7EOGsX44N
         8xpQ==
X-Forwarded-Encrypted: i=1; AL+hErGQ79u9ptkMrOxtNZq9T8B/V7QUi4bc/JawNUEPqqziWOV7BDlF4cyeQKqqmL3O+1TTJP1PE+0=@lists.linux.dev
X-Gm-Message-State: APuU4Z/ZCW2HMuczh3SFYwKVk8XRgpIfSnvNi3YG0m2BQp5Q8r+GOJ38
	ME8up6qC7s90fHWRPJRIZiwRmC085upoTUqcF+W4/8eiRSEl3nsrD6cL8ENGd0lezgw=
X-Gm-Gg: AZFdTZdefgw/wk6YHKBY6zBSrUPYB7qHEghI107KoayzNe3mX0farhi6BhJjZ4lBGJ+
	GXHqTZzm4CU3RgdHIaI0JwQTrgnL7sABGQMl13+zSfgzWmvFiqVMwXBCk917/aSbrX98ZZHQVyL
	cT+JzeuniyRrdAymoD8O7dS6Fd2KMpTv1cEU/EXt9SzUk+0QCCBz9R+W2iqsrIR5H4cWth3M2rb
	fjWpLlIZAZH5Ic4CH3qOrOXnEOMS8ftORiE8KevFPJd81Np0S3GjaaPiKAPgIEWLw0q5aVnF2xa
	oDZsvPpZBmXJbb2KqW9SFckS5g2VKqlJNIx6yF6iE56Tlj+XvTPO4oMz7E0aSaYbA+YWpdZkcB9
	VGt57Co3AIwn4vSvdu6OnWIbj2d54m7bNXtAxit/GHJFd6BREgahGqTvOI4QrTxzUndwfX9s4Jl
	Xq3qwLf7n0VqZVb2zCyUoTMdoHSbzk1buV0+tt4qHgiWr0Swcq+1IrxJ6MMwh/m4+ZBEhygc7L4
	SgiVLWo0mq3vOCQ6epqotz0MIaT1bQl+zOmivqiKXOtTfbmiNp78t3umplf9SDmKVMMf/0WObwY
	jRPI3O3TZPPKqVOQFMAK+c5Akxk+DTx1qsSHRDvAvR0ArvCAxrc798/dqUzwHtxH4YQCEgOrE37
	NXod4
X-Received: by 2002:a05:6000:2906:b0:4a3:777a:a964 with SMTP id ffacd0b85a97d-4aba58de987mr32705827f8f.0.1795595690957;
        Wed, 25 Nov 2026 00:34:50 -0800 (PST)
Received: from [192.168.0.161] (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4b70c05b9desm8842930f8f.54.2026.11.25.00.34.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 00:34:50 -0800 (PST)
Message-ID: <ec105c0a-1a6b-48ab-89ca-eae8b3f7983f@blackwall.org>
Date: Wed, 25 Nov 2026 10:34:49 +0200
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Post: <mailto:bridge@lists.linux.dev>
List-Help: <mailto:bridge+help@lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
List-Owner: <mailto:bridge+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 00/13] net: Report requester's port ID in FDB
 notifications
Content-Language: en-US, bg
To: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, bridge@lists.linux.dev,
 Ido Schimmel <idosch@nvidia.com>, Andy Roulin <aroulin@nvidia.com>,
 mlxsw@nvidia.com
References: <cover.1795447450.git.petrm@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <cover.1795447450.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/11/2026 19:59, Petr Machata wrote:
> Every netlink message carries a port ID in the nlmsg_pid header field. The
> port ID identifies a netlink socket. In a request it is the port ID of the
> socket that sent it. When a change that results from a request is
> announced to the multicast listeners, the kernel puts the port ID of the
> requester in nlmsg_pid of the notification. For changes that the kernel
> initiates by itself, such as aging, nlmsg_pid is zero.
> 
> This is used by applications that both configure the kernel and listen to
> notifications from it. By comparing nlmsg_pid to the port ID of their own
> socket, they can tell their own changes apart from those made by someone
> else, and ignore the former. Commit 7b8f7a402d4c ("neighbour: fix nlmsg_pid
> in notifications") fixed this for IP neighbours, citing quagga as one such
> application. Routes and nexthops report the port ID as well.
> 
> For FDB entries, the notifications (RTM_NEWNEIGH and RTM_DELNEIGH with the
> AF_BRIDGE family) always carry zero, whoever caused them, so applications
> that manage FDB cannot do this sort of filtering. Hence this patchset.
> 
> The patchset goes through the following steps:
> 
> - FDB notifications are generated in two places. The bridge and VXLAN
>    drivers send their own from ndo_fdb_add, _del and _del_bulk, but these
>    NDOs are not given the port ID of the requester. For other drivers that
>    implement ndo_fdb_add / _del, the rtnetlink core sends a default
>    notification on their behalf. It has the port ID at hand, but does not
>    pass it on.
> 
>    The obvious way to get the port ID to the bridge and VXLAN is to add it
>    to the NDO prototypes. But ndo_fdb_add and _del already carry many
>    arguments, and one more would further complicate the already unwieldy
>    prototypes, as well as require adjustments in every driver. Instead, in
>    patch #1, convert the prototypes of ndo_fdb_add, _del and _get to take a
>    new struct ndo_fdb_parms. ndo_fdb_get already has the port ID, but it
>    shares most of its arguments with the other two, so it makes sense to
>    treat them alike.
> 
>    A dedicated structure has the advantage that both callers and callees
>    can refer to individual arguments by name instead of by position. Any
>    future additions boil down to a new field in the structure.
> 
>    In patch #2, have ndo_dflt_fdb_add and ndo_dflt_fdb_del take the
>    structure as well. That simplifies the drivers that use the helper, which
>    can now just pass the structure pointer right through.
> 
>    In patch #3, move the port ID of ndo_fdb_get from an argument into the
>    structure and adjust drivers.
> 
> - Now that the structure argument is available to the bridge driver, make
>    use of the fact in patch #4. Instead of unpacking the structure fields
>    and passing them on one by one, propagate the structure itself further
>    into the driver.
> 
>    Then in patch #5, propagate the port ID all the way to where bridge
>    notifications are generated.
> 
>    It is tempting to somehow use the parms structure more extensively in
>    VXLAN as well, but VXLAN has its own large set of protocol-specific
>    parameters. Passing the structure as such is not going to help that much.
>    It looks like VXLAN would ideally need its own VXLAN-specific parms
>    structure. But since the complexity damage here is limited to VXLAN,
>    leave the status quo and in patch #6, just add the new parameter. The
>    patchset is large enough as it is.
> 
> - Patch #7 is where the port ID in struct ndo_fdb_parms is initialized from
>    the request. With that, notifications that the bridge and VXLAN send as a
>    result of adding, replacing and deleting an entry carry the port ID.
>    Notifications that are not a result of a request still carry zero.
> 
>    Patch #8 then adds the port ID argument to ndo_fdb_del_bulk, which does
>    not use the newly-introduced parms structure, and has the bridge and
>    VXLAN drivers use the now-available port ID for notifications.
> 
>    Finally, patch #9 converts the rtnetlink fallback helper, so that the
>    notifications it sends on behalf of drivers that do not emit their own
>    carry the port ID as well.
> 
> - Patches #10 to #13 add a selftest. Patches #10 to #12 extend the rt-neigh
>    spec with attributes needed to build FDB delete requests, add the
>    NLM_F_BULK flag to the YNL Python library and add an RtnlNeighFamily
>    wrapper to the selftest library. Patch #13 then adds the test itself. The
>    test is written in Python with YNL, because the usual shell tools cannot
>    show nlmsg_pid.
> 
> Petr Machata (13):
>    net: Introduce struct ndo_fdb_parms
>    net: Pass struct ndo_fdb_parms to ndo_dflt_fdb_{add, del}()
>    net: Pass portid to ndo_fdb_get through the structure
>    net: bridge: Pass struct ndo_fdb_parms a bit further
>    net: bridge: Pass portid through FDB notifications
>    net: vxlan: Pass portid through FDB notifications
>    net: rtnetlink: Report port ID in bridge and VXLAN FDB notifications
>    net: rtnetlink: Report port ID in bulk FDB delete notifications
>    net: rtnetlink: Report port ID in fallback FDB notifications
>    netlink: specs: rt-neigh: Extend the delneigh request attributes
>    tools: ynl: Add NLM_F_BULK
>    selftests: net: lib: py: Add RtnlNeighFamily
>    selftests: net: Add a test for port ID in FDB notifications
> 
>   Documentation/netlink/specs/rt-neigh.yaml     |   4 +
>   drivers/net/ethernet/intel/i40e/i40e_main.c   |  29 +-
>   drivers/net/ethernet/intel/ice/ice_main.c     |  43 ++-
>   drivers/net/ethernet/intel/igb/igb_main.c     |  14 +-
>   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  14 +-
>   drivers/net/ethernet/mscc/ocelot_net.c        |  19 +-
>   .../net/ethernet/qlogic/qlcnic/qlcnic_main.c  |  38 ++-
>   drivers/net/macvlan.c                         |  33 +-
>   drivers/net/vxlan/vxlan_core.c                | 118 +++----
>   drivers/net/vxlan/vxlan_private.h             |   5 +-
>   drivers/net/vxlan/vxlan_vnifilter.c           |   6 +-
>   include/linux/netdevice.h                     |  43 ++-
>   include/linux/rtnetlink.h                     |   9 +-
>   net/bridge/br.c                               |   2 +-
>   net/bridge/br_fdb.c                           | 177 ++++++-----
>   net/bridge/br_netlink.c                       |   4 +-
>   net/bridge/br_private.h                       |  20 +-
>   net/bridge/br_sysfs_br.c                      |   2 +-
>   net/core/rtnetlink.c                          |  98 +++---
>   tools/net/ynl/pyynl/lib/ynl.py                |   2 +
>   tools/testing/selftests/net/Makefile          |   1 +
>   tools/testing/selftests/net/config            |   1 +
>   .../selftests/net/fdb_notify_portid.py        | 297 ++++++++++++++++++
>   .../testing/selftests/net/lib/py/__init__.py  |   6 +-
>   tools/testing/selftests/net/lib/py/ynl.py     |  10 +-
>   25 files changed, 669 insertions(+), 326 deletions(-)
>   create mode 100755 tools/testing/selftests/net/fdb_notify_portid.py
> 

LGTM, for the set:
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
