Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0B33B81A1C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2E68181975
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eddf/OwrN8syk9SCGChlswO63H1xILMxSP4jGfFBdTU=;
 b=k2XO9gHmWZEtvHEcfqAHyteQULMTseCOzFrDVkM2O8JH5utOTj6auuhblgX2LU4+Hl
 w+5FYPcwaxvBfeUx3pfPyUQc+PxZisXva8dEZQ95KY3fLirIbKgE+4FUz4lrSGIkKwXy
 uXWEJ1U0WB5QKlBO8yCT2ra0G2I1JCi0qHm8feObzovgUUDvcXhBs7KAzZGzKIXY8wER
 DUxdgri1f9nxpyjky16TtAiu6kYDSgqZP73r8ReY6cZq5urblcua6x67t5AzO6SoQso2
 5kKa9Vs6S84HDJEh06W1wjVgpudQqfGfe56zU0iNC7xzfx58n+C3d1SjJWCjbetcneEY
 n45A==
Message-ID: <8a31500e-7376-618b-69a8-b8dee3a6899e@blackwall.org>
Date: Sun, 29 Jan 2023 11:40:49 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <cover.1674752051.git.petrm@nvidia.com>
 <1dcd4638d78c469eaa2f528de1f69b098222876f.1674752051.git.petrm@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <1dcd4638d78c469eaa2f528de1f69b098222876f.1674752051.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 07/16] net: bridge: Maintain number of
 MDB entries in net_bridge_mcast_port
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

On 26/01/2023 19:01, Petr Machata wrote:
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
> Note that the per-port-VLAN mcast_max_groups value gets reset when VLAN
> snooping is enabled. The reason for this is that while VLAN snooping is
> disabled, permanent entries can be added above the limit imposed by the
> configured maximum. Under those circumstances, whatever caused the VLAN
> context enablement, would need to be rolled back, adding a fair amount of
> code that would be rarely hit and tricky to maintain. At the same time,
> the feature that this would enable is IMHO not interesting: I posit that
> the usefulness of keeping mcast_max_groups intact across
> mcast_vlan_snooping toggles is marginal at best.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  net/bridge/br_multicast.c | 131 +++++++++++++++++++++++++++++++++++++-
>  net/bridge/br_private.h   |   2 +
>  2 files changed, 132 insertions(+), 1 deletion(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

