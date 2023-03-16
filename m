Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CE87B60A9D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6877C607B5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112; t=1678956939;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eLCjSCBDqMq/ciVVpyfzYuWBjZ8nlT4qHwYgluMAIAM=;
 b=GuW8V60Zy8eSbpYheOlmqkZlOIriPSrSI/NlE9pBhqmlXl4T74wFhwxbwk7mgyyISH
 pATgvo7UZcUEh8H06PgZ2m0vCdckNPgmVcflZukpW8Caqy85FFrrVVbxiWDa3JTgM4ih
 bNDx/GjZTU0D4WEWtKteeeI0UWPWIEcr+qAaGDUhUC1Y0e7CFyC8haS4mj0OFTGd7dGw
 RlWXZcsgufL8I5puKi6E/txz6MjNjd/AUonJCSc57uPZIGCfRxTLyzHKyAu7+GAkeFap
 Tykjmu4DAHRtf6uoY5e2PVJsMGn+1k6Dl9AuAmnPBbLa8zksAe82B1OW5gi8FKjHZhGd
 rBdw==
Message-ID: <4e6c9f88-d241-1e5f-78c2-cf4f592750b9@blackwall.org>
Date: Thu, 16 Mar 2023 10:55:38 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20230315131155.4071175-1-idosch@nvidia.com>
 <20230315131155.4071175-10-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20230315131155.4071175-10-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v2 09/11] vxlan: Add MDB data path
	support
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

On 15/03/2023 15:11, Ido Schimmel wrote:
> Integrate MDB support into the Tx path of the VXLAN driver, allowing it
> to selectively forward IP multicast traffic according to the matched MDB
> entry.
> 
> If MDB entries are configured (i.e., 'VXLAN_F_MDB' is set) and the
> packet is an IP multicast packet, perform up to three different lookups
> according to the following priority:
> 
> 1. For an (S, G) entry, using {Source VNI, Source IP, Destination IP}.
> 2. For a (*, G) entry, using {Source VNI, Destination IP}.
> 3. For the catchall MDB entry (0.0.0.0 or ::), using the source VNI.
> 
> The catchall MDB entry is similar to the catchall FDB entry
> (00:00:00:00:00:00) that is currently used to transmit BUM (broadcast,
> unknown unicast and multicast) traffic. However, unlike the catchall FDB
> entry, this entry is only used to transmit unregistered IP multicast
> traffic that is not link-local. Therefore, when configured, the catchall
> FDB entry will only transmit BULL (broadcast, unknown unicast,
> link-local multicast) traffic.
> 
> The catchall MDB entry is useful in deployments where inter-subnet
> multicast forwarding is used and not all the VTEPs in a tenant domain
> are members in all the broadcast domains. In such deployments it is
> advantageous to transmit BULL (broadcast, unknown unicast and link-local
> multicast) and unregistered IP multicast traffic on different tunnels.
> If the same tunnel was used, a VTEP only interested in IP multicast
> traffic would also pull all the BULL traffic and drop it as it is not a
> member in the originating broadcast domain [1].
> 
> If the packet did not match an MDB entry (or if the packet is not an IP
> multicast packet), return it to the Tx path, allowing it to be forwarded
> according to the FDB.
> 
> If the packet did match an MDB entry, forward it to the associated
> remote VTEPs. However, if the entry is a (*, G) entry and the associated
> remote is in INCLUDE mode, then skip over it as the source IP is not in
> its source list (otherwise the packet would have matched on an (S, G)
> entry). Similarly, if the associated remote is marked as BLOCKED (can
> only be set on (S, G) entries), then skip over it as well as the remote
> is in EXCLUDE mode and the source IP is in its source list.
> 
> [1] https://datatracker.ietf.org/doc/html/draft-ietf-bess-evpn-irb-mcast#section-2.6
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
> 
> Notes:
>     v2:
>     * Use htons() in 'case' instead of ntohs() in 'switch'.
> 
>  drivers/net/vxlan/vxlan_core.c    |  15 ++++
>  drivers/net/vxlan/vxlan_mdb.c     | 114 ++++++++++++++++++++++++++++++
>  drivers/net/vxlan/vxlan_private.h |   6 ++
>  3 files changed, 135 insertions(+)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


