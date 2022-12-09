Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 955F881E9E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B62BF81E6D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SIxveZre+8NlzeDt7utvIp6t4jf30eHuNZN/6H3+xYM=;
 b=4ND5KS73UpftC8y+BoMtMe5FgelG7H82ffwcQBcpgSXKkJ1TEMXurxFSSareiCH4Vf
 5TmTChu0WoG3Zig+wLrT2LJv9fhHP0UL95Ws/BNmtoytDEsiTeZ8oukU8l0KHniMEJRc
 3g8cx4Wi96SoY5jS8lGi/2AR6SPcRTWXVL86T+vSpmoRbKb0zo/ts2nptxI3eLpYVj/w
 FqzFL/wUaqdr20BUgaoln08Slc/o2qge3teqTs2+fNq1j2gEdfenuOSoIaRaNxHhcE/s
 DkBJsvCXyHDK9ADYtFm3OaprTO1xTROWzU/ZgSfNf06JW02fWp9QMzZet0Mum6hTgtoh
 Fc3Q==
Message-ID: <bc17a159-41d9-6627-080a-272464ee05fe@blackwall.org>
Date: Fri, 9 Dec 2022 09:32:19 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20221208152839.1016350-1-idosch@nvidia.com>
 <20221208152839.1016350-8-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20221208152839.1016350-8-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 07/14] bridge: mcast: Add a flag for
 user installed source entries
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: mlxsw@nvidia.com, edumazet@google.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

On 08/12/2022 17:28, Ido Schimmel wrote:
> There are a few places where the bridge driver differentiates between
> (S, G) entries installed by the kernel (in response to Membership
> Reports) and those installed by user space. One of them is when deleting
> an (S, G) entry corresponding to a source entry that is being deleted.
> 
> While user space cannot currently add a source entry to a (*, G), it can
> add an (S, G) entry that later corresponds to a source entry created by
> the reception of a Membership Report. If this source entry is later
> deleted because its source timer expired or because the (*, G) entry is
> being deleted, the bridge driver will not delete the corresponding (S,
> G) entry if it was added by user space as permanent.
> 
> This is going to be a problem when the ability to install a (*, G) with
> a source list is exposed to user space. In this case, when user space
> installs the (*, G) as permanent, then all the (S, G) entries
> corresponding to its source list will also be installed as permanent.
> When user space deletes the (*, G), all the source entries will be
> deleted and the expectation is that the corresponding (S, G) entries
> will be deleted as well.
> 
> Solve this by introducing a new source entry flag denoting that the
> entry was installed by user space. When the entry is deleted, delete the
> corresponding (S, G) entry even if it was installed by user space as
> permanent, as the flag tells us that it was installed in response to the
> source entry being created.
> 
> The flag will be set in a subsequent patch where source entries are
> created in response to user requests.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  net/bridge/br_multicast.c | 3 ++-
>  net/bridge/br_private.h   | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
> index 8432b4ea7f28..48170bd3785e 100644
> --- a/net/bridge/br_multicast.c
> +++ b/net/bridge/br_multicast.c
> @@ -552,7 +552,8 @@ static void br_multicast_fwd_src_remove(struct net_bridge_group_src *src,
>  			continue;
>  
>  		if (p->rt_protocol != RTPROT_KERNEL &&
> -		    (p->flags & MDB_PG_FLAGS_PERMANENT))
> +		    (p->flags & MDB_PG_FLAGS_PERMANENT) &&
> +		    !(src->flags & BR_SGRP_F_USER_ADDED))
>  			break;
>  
>  		if (fastleave)
> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
> index a3db99d79a3d..74f17b56c9eb 100644
> --- a/net/bridge/br_private.h
> +++ b/net/bridge/br_private.h
> @@ -300,6 +300,7 @@ struct net_bridge_fdb_flush_desc {
>  #define BR_SGRP_F_DELETE	BIT(0)
>  #define BR_SGRP_F_SEND		BIT(1)
>  #define BR_SGRP_F_INSTALLED	BIT(2)
> +#define BR_SGRP_F_USER_ADDED	BIT(3)
>  
>  struct net_bridge_mcast_gc {
>  	struct hlist_node		gc_node;

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

