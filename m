Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 30D3660C16
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 539E160C06
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IBa8E8PwdjPXkRzD62dAtTjcrA6uST3bjufU3dsZCM8=;
 b=MTowCXDFtV7Xj5ue9879TT9Ap06V2DgRQCk6nXhSg7BXGP8l+/WIriZaVT/18QfdHS
 rTarGG0ojyrm+D6hvNUcqiQCXhn+hj659/cNhvbAGfsqSdMpDP9Ko1mymtolpS+Mp1If
 OJBKTYFg1B5enmxCb1kiHyxEBogWKsKxYaeV1tbGcVH4aMqCgZe3nwivuco7+vER6BK2
 r0SoBcatNMVKT9q9+lNsijM+kAgF1drigZLr4FRaFDidI4YNyc92L0rieAo8cJ88hhCq
 QqGZRFreCbCmDG+Auz9oV+IHq1z4+IvJmm0sBDHHjjGJXbhSLsUo8GpBpPJsUGI35DgR
 wRew==
Message-ID: <48be3497-7c8f-ac73-0760-a8b1125ab2ab@blackwall.org>
Date: Thu, 9 Feb 2023 09:18:47 +0100
MIME-Version: 1.0
Content-Language: en-US
References: <20230209071852.613102-1-idosch@nvidia.com>
 <20230209071852.613102-2-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20230209071852.613102-2-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 1/4] bridge: mcast: Use correct define
 in MDB dump
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: petrm@nvidia.com, mlxsw@nvidia.com, edumazet@google.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

On 2/9/23 09:18, Ido Schimmel wrote:
> 'MDB_PG_FLAGS_PERMANENT' and 'MDB_PERMANENT' happen to have the same
> value, but the latter is uAPI and cannot change, so use it when dumping
> an MDB entry.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>   net/bridge/br_mdb.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
> index 9f22ebfdc518..13076206e497 100644
> --- a/net/bridge/br_mdb.c
> +++ b/net/bridge/br_mdb.c
> @@ -259,7 +259,7 @@ static int __mdb_fill_info(struct sk_buff *skb,
>   #endif
>   	} else {
>   		ether_addr_copy(e.addr.u.mac_addr, mp->addr.dst.mac_addr);
> -		e.state = MDB_PG_FLAGS_PERMANENT;
> +		e.state = MDB_PERMANENT;
>   	}
>   	e.addr.proto = mp->addr.proto;
>   	nest_ent = nla_nest_start_noflag(skb,

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
