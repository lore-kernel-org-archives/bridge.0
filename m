Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 80C03429CF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 57BBF429CA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ni5qRfYvZFsymzma6ZOjk3L3LwaxH0Q0qj+WSjXryNg=;
 b=lzyKKlVfBtu4E19a5HXbvOlfH03T7LO7t0w24toNmp+P5tRXo/J1JTSr666Si1hjeu
 QewnfPtAIwMewEUWV5YSdGUJ+xbY7n6PNYkU5VJW0zg2eO/LlqMREb1nYLOMZ6MIAakH
 ETaHXxw+26Guc/nf1Ppv4PSsLXC464TCdE+OV74e3X/nLcBOX6MmmncTtPkhX2WqzwGP
 9PeJdp0+cptUGcZKEunPL7SZPKLafezyvnAWWmELGlmqCJvBXGRB05cAGK0DqifrfIOO
 q2JH+p2td6gCBElGkavGzvMZJD7dxAQCyobfMqvL4KiYj74mYZXqh0zRHN9xjPUMx19U
 a2+g==
Message-ID: <fb2a9ee9-ff66-3590-9aa9-88f5b037d786@blackwall.org>
Date: Fri, 3 Feb 2023 10:59:25 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <cover.1675359453.git.petrm@nvidia.com>
 <8bd6e90beed928790059134471ecbb9c3d327894.1675359453.git.petrm@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <8bd6e90beed928790059134471ecbb9c3d327894.1675359453.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v3 07/16] net: bridge: Maintain number
 of MDB entries in net_bridge_mcast_port
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Roopa Prabhu <roopa@nvidia.com>, netdev@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux-foundation.org

On 02/02/2023 19:59, Petr Machata wrote:
> The MDB maintained by the bridge is limited. When the bridge is configured
> for IGMP / MLD snooping, a buggy or malicious client can easily exhaust its
> capacity. In SW datapath, the capacity is configurable through the
> IFLA_BR_MCAST_HASH_MAX parameter, but ultimately is finite. Obviously a
> similar limit exists in the HW datapath for purposes of offloading.
> 
> In order to prevent the issue of unilateral exhaustion of MDB resources,
> introduce two parameters in each of two contexts:
> 
> - Per-port and per-port-VLAN number of MDB entries that the port
>   is member in.
> 
> - Per-port and (when BROPT_MCAST_VLAN_SNOOPING_ENABLED is enabled)
>   per-port-VLAN maximum permitted number of MDB entries, or 0 for
>   no limit.
> 
> The per-port multicast context is used for tracking of MDB entries for the
> port as a whole. This is available for all bridges.
> 
> The per-port-VLAN multicast context is then only available on
> VLAN-filtering bridges on VLANs that have multicast snooping on.
> 
> With these changes in place, it will be possible to configure MDB limit for
> bridge as a whole, or any one port as a whole, or any single port-VLAN.
> 
> Note that unlike the global limit, exhaustion of the per-port and
> per-port-VLAN maximums does not cause disablement of multicast snooping.
> It is also permitted to configure the local limit larger than hash_max,
> even though that is not useful.
> 
> In this patch, introduce only the accounting for number of entries, and the
> max field itself, but not the means to toggle the max. The next patch
> introduces the netlink APIs to toggle and read the values.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> ---
> 
> Notes:
>     v3:
>     - Access mdb_max_/_n_entries through READ_/WRITE_ONCE
>     - Move extack setting to br_multicast_port_ngroups_inc_one().
>       Since we use NL_SET_ERR_MSG_FMT_MOD, the correct context
>       (port / port-vlan) can be passed through an argument.
>       This also removes the need for more READ/WRITE_ONCE's
>       at the extack-setting site.
>     
>     v2:
>     - In br_multicast_port_ngroups_inc_one(), bounce
>       if n>=max, not if n==max
>     - Adjust extack messages to mention ngroups, now that
>       the bounces appear when n>=max, not n==max
>     - In __br_multicast_enable_port_ctx(), do not reset
>       max to 0. Also do not count number of entries by
>       going through _inc, as that would end up incorrectly
>       bouncing the entries.
> 
>  net/bridge/br_multicast.c | 136 +++++++++++++++++++++++++++++++++++++-
>  net/bridge/br_private.h   |   2 +
>  2 files changed, 137 insertions(+), 1 deletion(-)

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


