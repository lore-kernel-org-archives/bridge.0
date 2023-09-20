Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C41D0822DD
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7B485822D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1695206764; x=1695811564;
 darn=lists.linux-foundation.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1t+EHZZa+DoV/W1tEtqY5C53ytLGnx5U13L/26n+omc=;
 b=1jQfdg/hP05ZCnFJI0/CwTExroXpkOgX2jvyytVPa7L1BncWdNp3SETQ1sTDMFLjjq
 x5D4D8IBPbKfbLA+/xc9qdN/Wm39Ck33hHdfZV9/Jcicozp4JTPgvDhOGQUjDiNKbV2s
 E0ZP3sFvM6s9Za5vSzEepe4mhsLkKVjQNtxB5ldqWGRPXdc2LVgRdLUyPhyr/m/RKVVM
 zzP4AF1oSYWNDkwg5iFAcGOtRMI+6TbtWmfqtalrik0+6dRFbKUvX3Mz/EUoa7CKa07s
 1dgXyhE1Bx0LKAA1Rv3h79gGbV3bPMV7pHB+jVyjWR4XEEgVMN2ycYudSnK/kmMl64ua
 7LWw==
Message-ID: <1c12b8f2-b28b-f326-b24f-f1ea602832d7@blackwall.org>
Date: Wed, 20 Sep 2023 13:46:02 +0300
MIME-Version: 1.0
Content-Language: en-US
References: <20230919-fdb_limit-v4-0-39f0293807b8@avm.de>
 <20230919-fdb_limit-v4-2-39f0293807b8@avm.de>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20230919-fdb_limit-v4-2-39f0293807b8@avm.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v4 2/6] net: bridge: Set
 strict_start_type for br_policy
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Johannes Nixdorf <jnixdorf-oss@avm.de>, "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>, David Ahern <dsahern@gmail.com>, Eric Dumazet <edumazet@google.com>, Florian Fainelli <f.fainelli@gmail.com>, Ido Schimmel <idosch@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Oleksij Rempel <linux@rempel-privat.de>, Paolo Abeni <pabeni@redhat.com>, Roopa Prabhu <roopa@nvidia.com>, Shuah Khan <shuah@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org

On 9/19/23 11:12, Johannes Nixdorf wrote:
> Set any new attributes added to br_policy to be parsed strictly, to
> prevent userspace from passing garbage.
> 
> Signed-off-by: Johannes Nixdorf <jnixdorf-oss@avm.de>
> ---
>   net/bridge/br_netlink.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
> index 10f0d33d8ccf..505683ef9a26 100644
> --- a/net/bridge/br_netlink.c
> +++ b/net/bridge/br_netlink.c
> @@ -1229,6 +1229,8 @@ static size_t br_port_get_slave_size(const struct net_device *brdev,
>   }
>   
>   static const struct nla_policy br_policy[IFLA_BR_MAX + 1] = {
> +	[IFLA_BR_UNSPEC]	= { .strict_start_type =
> +				    IFLA_BR_MCAST_QUERIER_STATE + 1 },
>   	[IFLA_BR_FORWARD_DELAY]	= { .type = NLA_U32 },
>   	[IFLA_BR_HELLO_TIME]	= { .type = NLA_U32 },
>   	[IFLA_BR_MAX_AGE]	= { .type = NLA_U32 },
> 

instead of IFLA_BR_MCAST_QUERIER_STATE + 1, why not move around the 
patch and just use the new attribute name?
These are uapi, they won't change.
