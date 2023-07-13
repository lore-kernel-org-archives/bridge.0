Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org ECF72813ED
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 03812813EB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20221208.gappssmtp.com; s=20221208; t=1689240565; x=1691832565;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bsVmfGKx3JXZYIZAj2sAzKGn4PToD7TqBYHKEzg5nto=;
 b=I8bje+1DsdXED3Msu/ohJ8XAdIQufu8VtS9hLYTHg4kAo519quxxoLGdanAr2QyOfA
 eiaICWM9cx1qmz3vvVTlsoKxrKGdzjpeVChoU3Ly7VRZK8soYyRUi2ET0NPz8RmmJXKT
 U4lbbXJTEr9i/gQXGAl0v0n0kT8DaaMXBno8tOKXGDKhPvsgm7Z00eF6PdMYPRbH3QSe
 LRTnc5/YjBS5H16fTZNVBi77LXN6gvYGL8fAokrOUnObS6P1JQ8VTlM4IFm52nSnUdNi
 vl/N+U1sn0xzmAyL1qKv87eY7lLixri+SutfmoVeKVEnJZ1Jc6bIcDW9yQVxFc5V31pJ
 g1sw==
Message-ID: <d003b6e7-6db1-f5e3-d356-237e4bf3a34c@blackwall.org>
Date: Thu, 13 Jul 2023 12:29:22 +0300
MIME-Version: 1.0
References: <20230713070925.3955850-1-idosch@nvidia.com>
 <20230713070925.3955850-2-idosch@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20230713070925.3955850-2-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [RFC PATCH net-next 1/4] ip_tunnels: Add nexthop ID
 field to ip_tunnel_key
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: petrm@nvidia.com, taspelund@nvidia.com, roopa@nvidia.com, edumazet@google.com, dsahern@gmail.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

On 13/07/2023 10:09, Ido Schimmel wrote:
> Extend the ip_tunnel_key structure with a field indicating the ID of the
> nexthop object via which the skb should be routed.
> 
> The field is going to be populated in subsequent patches by the bridge
> driver in order to indicate to the VXLAN driver which FDB nexthop object
> to use in order to reach the target host.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>   include/net/ip_tunnels.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
> index ed4b6ad3fcac..e8750b4ef7e1 100644
> --- a/include/net/ip_tunnels.h
> +++ b/include/net/ip_tunnels.h
> @@ -52,6 +52,7 @@ struct ip_tunnel_key {
>   	u8			tos;		/* TOS for IPv4, TC for IPv6 */
>   	u8			ttl;		/* TTL for IPv4, HL for IPv6 */
>   	__be32			label;		/* Flow Label for IPv6 */
> +	u32			nhid;
>   	__be16			tp_src;
>   	__be16			tp_dst;
>   	__u8			flow_flags;

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>

