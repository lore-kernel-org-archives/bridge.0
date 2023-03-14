Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0FBD0403C7
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F2C95400B8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112; t=1678796671;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yes7QEaOi79y6U8Z5dhSkT9SxmbIBFirhjY5n/2F+XM=;
 b=QT6d/8fsy65eJA1Yf4vpCTO36EWCWaDL2H1NFl0C1cJVlMDBafH5itEV4D0aLg0uVJ
 fHzId/68SRkeRveCrIUeNcYWMLGqSusyfJO/Kjv+swe9/ahi5es68FtzugfEhDWB6RNS
 ihou2CKBrXQxRXcHQk3wlAFIWcxu4xrEiKN+AWYFnHffP1X5V2pZpolWyfDWbiO6HKx/
 6KjNU53i/257nsZbV6PBfoIyOZcfjXn/mqI6eUoY6TVMwCzj3cqrhpdromCmVV8ND6on
 KuiaDr1V/xULLa+Q3xhT4+vRVSMDPkTDHjeVqiN+nfoA/H07zRKs/YW5y+F0xQuaefZ0
 t6NQ==
Message-ID: <ea099909-a205-ed4c-5382-64a01435c23a@blackwall.org>
Date: Tue, 14 Mar 2023 14:24:29 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20230313145349.3557231-1-idosch@nvidia.com>
 <20230313145349.3557231-8-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20230313145349.3557231-8-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 07/11] vxlan: mdb: Add MDB control
	path support
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
> Implement MDB control path support, enabling the creation, deletion,
> replacement and dumping of MDB entries in a similar fashion to the
> bridge driver. Unlike the bridge driver, each entry stores a list of
> remote VTEPs to which matched packets need to be replicated to and not a
> list of bridge ports.
> 
> The motivating use case is the installation of MDB entries by a user
> space control plane in response to received EVPN routes. As such, only
> allow permanent MDB entries to be installed and do not implement
> snooping functionality, avoiding a lot of unnecessary complexity.
> 
> Since entries can only be modified by user space under RTNL, use RTNL as
> the write lock. Use RCU to ensure that MDB entries and remotes are not
> freed while being accessed from the data path during transmission.
> 
> In terms of uAPI, reuse the existing MDB netlink interface, but add a
> few new attributes to request and response messages:
> 
> * IP address of the destination VXLAN tunnel endpoint where the
>   multicast receivers reside.
> 
> * UDP destination port number to use to connect to the remote VXLAN
>   tunnel endpoint.
> 
> * VXLAN VNI Network Identifier to use to connect to the remote VXLAN
>   tunnel endpoint. Required when Ingress Replication (IR) is used and
>   the remote VTEP is not a member of originating broadcast domain
>   (VLAN/VNI) [1].
> 
> * Source VNI Network Identifier the MDB entry belongs to. Used only when
>   the VXLAN device is in external mode.
> 
> * Interface index of the outgoing interface to reach the remote VXLAN
>   tunnel endpoint. This is required when the underlay destination IP is
>   multicast (P2MP), as the multicast routing tables are not consulted.
> 
> All the new attributes are added under the 'MDBA_SET_ENTRY_ATTRS' nest
> which is strictly validated by the bridge driver, thereby automatically
> rejecting the new attributes.
> 
> [1] https://datatracker.ietf.org/doc/html/draft-ietf-bess-evpn-irb-mcast#section-3.2.2
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
> 
> Notes:
>     v1:
>     * Remove restrictions regarding mixing of multicast and unicast remote
>       destination IPs in an MDB entry. While such configuration does not
>       make sense to me, it is no forbidden by the VXLAN FDB code and does
>       not crash the kernel.
>     * Fix check regarding all-zeros MDB entry and source.
> 
>  drivers/net/vxlan/Makefile        |    2 +-
>  drivers/net/vxlan/vxlan_core.c    |    8 +
>  drivers/net/vxlan/vxlan_mdb.c     | 1341 +++++++++++++++++++++++++++++
>  drivers/net/vxlan/vxlan_private.h |   31 +
>  include/net/vxlan.h               |    5 +
>  include/uapi/linux/if_bridge.h    |   10 +
>  6 files changed, 1396 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/net/vxlan/vxlan_mdb.c


Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>

