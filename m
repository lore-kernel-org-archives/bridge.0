Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2A67D81E24
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D312A813E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112; t=1678794687;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JBWcdbOe/+QB4FuxPU4RpjFDIaFQvUM2MH5HEzHxacs=;
 b=j6t8D8MbtXOx/FTacBigFqP8nBect5CBoz8gQ9AHu9y5dotazeSefudnML7HeGFjK7
 +CrNlhO3J1OdG2BAGa6nuxw8DBgv76IMX7myjR1bfGfN08crlQ3w5JLeqO4FyEkLjoXB
 Q0yXLPVA3QzUy7N6Ehne60ndATLwLG2kXlVLcdaHGK/9IpklyzB8fvv63sHMy8bxSHOt
 cU3H3k8BfaEdko1dJJ7x3EnD7VsGtAPGVnwz3iX7ysj4VTJ7907/MQlt6tDB9RJukwcd
 xtWFOIxCujuI4jUefo5ax6vQuOFyYkuFDDBxXu79caPBDwORFJOgu2vTCd8WXhjky30h
 l9EQ==
Message-ID: <4a3bfd11-491b-37bc-b843-b438db764aca@blackwall.org>
Date: Tue, 14 Mar 2023 13:51:25 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20230313145349.3557231-1-idosch@nvidia.com>
 <20230313145349.3557231-5-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20230313145349.3557231-5-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 04/11] rtnetlink: bridge: mcast: Relax
 group address validation in common code
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

On 13/03/2023 16:53, Ido Schimmel wrote:
> In the upcoming VXLAN MDB implementation, the 0.0.0.0 and :: MDB entries
> will act as catchall entries for unregistered IP multicast traffic in a
> similar fashion to the 00:00:00:00:00:00 VXLAN FDB entry that is used to
> transmit BUM traffic.
> 
> In deployments where inter-subnet multicast forwarding is used, not all
> the VTEPs in a tenant domain are members in all the broadcast domains.
> It is therefore advantageous to transmit BULL (broadcast, unknown
> unicast and link-local multicast) and unregistered IP multicast traffic
> on different tunnels. If the same tunnel was used, a VTEP only
> interested in IP multicast traffic would also pull all the BULL traffic
> and drop it as it is not a member in the originating broadcast domain
> [1].
> 
> Prepare for this change by allowing the 0.0.0.0 group address in the
> common rtnetlink MDB code and forbid it in the bridge driver. A similar
> change is not needed for IPv6 because the common code only validates
> that the group address is not the all-nodes address.
> 
> [1] https://datatracker.ietf.org/doc/html/draft-ietf-bess-evpn-irb-mcast#section-2.6
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  net/bridge/br_mdb.c  | 6 ++++++
>  net/core/rtnetlink.c | 5 +++--
>  2 files changed, 9 insertions(+), 2 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


