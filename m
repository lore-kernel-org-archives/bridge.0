Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E930260B33
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1186160A8A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20221208.gappssmtp.com; s=20221208; t=1689240610; x=1691832610;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Bi1FlV5GLd9b5M5p2mDsMBKOhHCbBoFwfbfjXIV037U=;
 b=fo/F5nS1tzrOazQWrA2k5bOZneI6jl2csoF40VKZqI9mpoLUVMslv2zRzN8nXpp+OG
 9wjZ01YPQ1TvxaO2rr09Sp3Dp38/3ZjREQPDskpSdbISny68o8CZatSNOSjhHIxwkrMi
 KhfyiNQX+5s3DjsZauAK6n+EgTUq3P9eof/NcSvTHqKGGiqEiQBE+5kXE0gcQ23fUJTj
 +fLJ6543CrgO2xV3aVTyCkI9bbEm94htRqKy24ROYNF/qBVgsgcR39uCQT/zglRPHQcH
 UnIMALJ41yeQce8rJ35temr7dV4AaJLbtLPITqg7zY9XcXjiZOWLZVSSMMh47UgGQyDi
 5Rxw==
Message-ID: <1bd20ab6-4792-7689-932a-a7b9ccf72402@blackwall.org>
Date: Thu, 13 Jul 2023 12:30:07 +0300
MIME-Version: 1.0
Content-Language: en-US
References: <20230713070925.3955850-1-idosch@nvidia.com>
 <20230713070925.3955850-3-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20230713070925.3955850-3-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [RFC PATCH net-next 2/4] vxlan: Add support for
 nexthop ID metadata
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
> VXLAN FDB entries can point to FDB nexthop objects. Each such object
> includes the IP address(es) of remote VTEP(s) via which the target host
> is accessible. Example:
> 
>   # ip nexthop add id 1 via 192.0.2.1 fdb
>   # ip nexthop add id 2 via 192.0.2.17 fdb
>   # ip nexthop add id 1000 group 1/2 fdb
>   # bridge fdb add 00:11:22:33:44:55 dev vx0 self static nhid 1000 src_vni 10020
> 
> This is useful for EVPN multihoming where a single host can be connected
> to multiple VTEPs. The source VTEP will calculate the flow hash of the
> skb and forward it towards the IP address of one of the VTEPs member in
> the nexthop group.
> 
> There are cases where an external entity (e.g., the bridge driver) can
> provide not only the tunnel ID (i.e., VNI) of the skb, but also the ID
> of the nexthop object via which the skb should be forwarded.
> 
> Therefore, in order to support such cases, when the VXLAN device is in
> external / collect metadata mode and the tunnel info attached to the skb
> is of bridge type, extract the nexthop ID from the tunnel info. If the
> ID is valid (i.e., non-zero), forward the skb via the nexthop object
> associated with the ID, as if the skb hit an FDB entry associated with
> this ID.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>   drivers/net/vxlan/vxlan_core.c | 44 ++++++++++++++++++++++++++++++++++
>   1 file changed, 44 insertions(+)
> 

LGTM
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

