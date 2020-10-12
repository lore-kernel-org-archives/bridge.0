Return-Path: <Henrik.Bjoernlund@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1602508468; x=1634044468;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=AziLle62dzQqXG3eHawz0SiT4sBXo6D4inxNSWkuyGU=;
 b=Z6oYIVIOv3q8stFUe3z77LlvZqR8nrBUeJqDTdXO2CgEfZ23AMtEAQp4
 Fub7sqn9/5IxGJhlCDs4StUBE48xS7fX+5sVyAUQU+dVu+fRDHePK59jA
 o6TXsybeMyxY8ez2k9aCG1NGjhcJ8I//aqGpDHb8i6VIHtUFiSEMXY8nZ
 Lo+JC4cFdcdJfjQDunzEIoJAjuK2BhWE0O6HpO+ICISj8jrVdlbCu9mhK
 ZEbHJmq2sZQ7AOnjL0KKyuLPd4cq6T75PqPC6yFbUqnIAJxNWRSJhSQKu
 GSVvMYRLBSIQlt9u2q3Xe98BEa1ghD1qhwzdVy3xKT8YyTA8LRW0j93xZ A==;
Date: Mon, 12 Oct 2020 13:12:27 +0000
From: "henrik.bjoernlund@microchip.com" <henrik.bjoernlund@microchip.com>
Message-ID: <20201012131227.l7on7k3n2nogoace@soft-test08>
References: <20201009143530.2438738-1-henrik.bjoernlund@microchip.com>
 <20201009143530.2438738-5-henrik.bjoernlund@microchip.com>
 <491685c20c840f3962433bed13f53aa5418696f5.camel@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <491685c20c840f3962433bed13f53aa5418696f5.camel@nvidia.com>
Subject: Re: [Bridge] [PATCH net-next v4 04/10] bridge: cfm: Kernel space
 implementation of CFM. MEP create/delete.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@nvidia.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "UNGLinuxDriver@microchip.com" <UNGLinuxDriver@microchip.com>, "idosch@mellanox.com" <idosch@mellanox.com>, "jiri@mellanox.com" <jiri@mellanox.com>, Roopa Prabhu <roopa@nvidia.com>, "kuba@kernel.org" <kuba@kernel.org>, "horatiu.vultur@microchip.com" <horatiu.vultur@microchip.com>, "davem@davemloft.net" <davem@davemloft.net>

Thanks for the review.

The 10/09/2020 21:42, Nikolay Aleksandrov wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> On Fri, 2020-10-09 at 14:35 +0000, Henrik Bjoernlund wrote:
> > This is the first commit of the implementation of the CFM protocol
> > according to 802.1Q section 12.14.
> >
> > It contains MEP instance create, delete and configuration.
> >
> > Connectivity Fault Management (CFM) comprises capabilities for
> > detecting, verifying, and isolating connectivity failures in
> > Virtual Bridged Networks. These capabilities can be used in
> > networks operated by multiple independent organizations, each
> > with restricted management access to each other<E2><80><99>s equipment.
> >
> > CFM functions are partitioned as follows:
> >     - Path discovery
> >     - Fault detection
> >     - Fault verification and isolation
> >     - Fault notification
> >     - Fault recovery
> >
> > Interface consists of these functions:
> > br_cfm_mep_create()
> > br_cfm_mep_delete()
> > br_cfm_mep_config_set()
> > br_cfm_cc_config_set()
> > br_cfm_cc_peer_mep_add()
> > br_cfm_cc_peer_mep_remove()
> >
> > A MEP instance is created by br_cfm_mep_create()
> >     -It is the Maintenance association End Point
> >      described in 802.1Q section 19.2.
> >     -It is created on a specific level (1-7) and is assuring
> >      that no CFM frames are passing through this MEP on lower levels.
> >     -It initiates and validates CFM frames on its level.
> >     -It can only exist on a port that is related to a bridge.
> >     -Attributes given cannot be changed until the instance is
> >      deleted.
> >
> > A MEP instance can be deleted by br_cfm_mep_delete().
> >
> > A created MEP instance has attributes that can be
> > configured by br_cfm_mep_config_set().
> >
> > A MEP Continuity Check feature can be configured by
> > br_cfm_cc_config_set()
> >     The Continuity Check Receiver state machine can be
> >     enabled and disabled.
> >     According to 802.1Q section 19.2.8
> >
> > A MEP can have Peer MEPs added and removed by
> > br_cfm_cc_peer_mep_add() and br_cfm_cc_peer_mep_remove()
> >     The Continuity Check feature can maintain connectivity
> >     status on each added Peer MEP.
> >
> > Signed-off-by: Henrik Bjoernlund  <henrik.bjoernlund@microchip.com>
> > Reviewed-by: Horatiu Vultur  <horatiu.vultur@microchip.com>
> > ---
> >  include/uapi/linux/cfm_bridge.h |  23 +++
> >  net/bridge/Makefile             |   2 +
> >  net/bridge/br_cfm.c             | 278 ++++++++++++++++++++++++++++++++
> >  net/bridge/br_if.c              |   1 +
> >  net/bridge/br_private.h         |  10 ++
> >  net/bridge/br_private_cfm.h     |  61 +++++++
> >  6 files changed, 375 insertions(+)
> >  create mode 100644 include/uapi/linux/cfm_bridge.h
> >  create mode 100644 net/bridge/br_cfm.c
> >  create mode 100644 net/bridge/br_private_cfm.h
> >
> 
> Acked-by: Nikolay Aleksandrov <nikolay@nvidia.com>
> 

-- 
/Henrik
