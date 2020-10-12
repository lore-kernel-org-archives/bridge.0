Return-Path: <Henrik.Bjoernlund@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1602508255; x=1634044255;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Wx/SjgxENV21vS7rRkR80G3C+v6r1f+DHOKACkGfp3I=;
 b=wLeJ5WUGEEXfGOJems2XLpzsvLuRUJUmhpeCdB89VmJwoSqpb5bDDQnv
 dKCTFFQTMKLOVA1ypIatsYJhwTiUGfJ2LFBjESrhCh85kzWcybAdFlFbS
 Axvf6x2cBqxJDA+Pg4HvL61s6sV0gE7wvrDMjPHlvtI9w603joBIvU34Q
 ICNwu7/O5mpxjCuUcXRlMjTIjw1YcDP0F9oXBFz2/tHEPdCTI/FCxrwIc
 J6oPFeQ5bwVIx98njOR9mQzO0Rj1AkeIVzwlA68kq/d4I/XT4UxX27jLu
 M+CUq8fEtH88fBgJoTmoN+pcZhsF3rxdK/yX7VId2WnSjSUkHCdB9dEPL w==;
Date: Mon, 12 Oct 2020 13:09:07 +0000
From: "henrik.bjoernlund@microchip.com" <henrik.bjoernlund@microchip.com>
Message-ID: <20201012130907.6ncpvscoots4yzxl@soft-test08>
References: <20201009143530.2438738-1-henrik.bjoernlund@microchip.com>
 <20201009143530.2438738-10-henrik.bjoernlund@microchip.com>
 <9248a20233893a46747f3c5c867f5f0db18eb69d.camel@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <9248a20233893a46747f3c5c867f5f0db18eb69d.camel@nvidia.com>
Subject: Re: [Bridge] [PATCH net-next v4 09/10] bridge: cfm: Netlink GET
 status Interface.
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

Thanks for the review. Comments below.

The 10/09/2020 22:00, Nikolay Aleksandrov wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> On Fri, 2020-10-09 at 14:35 +0000, Henrik Bjoernlund wrote:
> > This is the implementation of CFM netlink status
> > get information interface.
> >
> > Add new nested netlink attributes. These attributes are used by the
> > user space to get status information.
> >
> > GETLINK:
> >     Request filter RTEXT_FILTER_CFM_STATUS:
> >     Indicating that CFM status information must be delivered.
> >
> >     IFLA_BRIDGE_CFM:
> >         Points to the CFM information.
> >
> >     IFLA_BRIDGE_CFM_MEP_STATUS_INFO:
> >         This indicate that the MEP instance status are following.
> >     IFLA_BRIDGE_CFM_CC_PEER_STATUS_INFO:
> >         This indicate that the peer MEP status are following.
> >
> > CFM nested attribute has the following attributes in next level.
> >
> > GETLINK RTEXT_FILTER_CFM_STATUS:
> >     IFLA_BRIDGE_CFM_MEP_STATUS_INSTANCE:
> >         The MEP instance number of the delivered status.
> >         The type is u32.
> >     IFLA_BRIDGE_CFM_MEP_STATUS_OPCODE_UNEXP_SEEN:
> >         The MEP instance received CFM PDU with unexpected Opcode.
> >         The type is u32 (bool).
> >     IFLA_BRIDGE_CFM_MEP_STATUS_VERSION_UNEXP_SEEN:
> >         The MEP instance received CFM PDU with unexpected version.
> >         The type is u32 (bool).
> >     IFLA_BRIDGE_CFM_MEP_STATUS_RX_LEVEL_LOW_SEEN:
> >         The MEP instance received CCM PDU with MD level lower than
> >         configured level. This frame is discarded.
> >         The type is u32 (bool).
> >
> >     IFLA_BRIDGE_CFM_CC_PEER_STATUS_INSTANCE:
> >         The MEP instance number of the delivered status.
> >         The type is u32.
> >     IFLA_BRIDGE_CFM_CC_PEER_STATUS_PEER_MEPID:
> >         The added Peer MEP ID of the delivered status.
> >         The type is u32.
> >     IFLA_BRIDGE_CFM_CC_PEER_STATUS_CCM_DEFECT:
> >         The CCM defect status.
> >         The type is u32 (bool).
> >         True means no CCM frame is received for 3.25 intervals.
> >         IFLA_BRIDGE_CFM_CC_CONFIG_EXP_INTERVAL.
> >     IFLA_BRIDGE_CFM_CC_PEER_STATUS_RDI:
> >         The last received CCM PDU RDI.
> >         The type is u32 (bool).
> >     IFLA_BRIDGE_CFM_CC_PEER_STATUS_PORT_TLV_VALUE:
> >         The last received CCM PDU Port Status TLV value field.
> >         The type is u8.
> >     IFLA_BRIDGE_CFM_CC_PEER_STATUS_IF_TLV_VALUE:
> >         The last received CCM PDU Interface Status TLV value field.
> >         The type is u8.
> >     IFLA_BRIDGE_CFM_CC_PEER_STATUS_SEEN:
> >         A CCM frame has been received from Peer MEP.
> >         The type is u32 (bool).
> >         This is cleared after GETLINK IFLA_BRIDGE_CFM_CC_PEER_STATUS_INFO.
> >     IFLA_BRIDGE_CFM_CC_PEER_STATUS_TLV_SEEN:
> >         A CCM frame with TLV has been received from Peer MEP.
> >         The type is u32 (bool).
> >         This is cleared after GETLINK IFLA_BRIDGE_CFM_CC_PEER_STATUS_INFO.
> >     IFLA_BRIDGE_CFM_CC_PEER_STATUS_SEQ_UNEXP_SEEN:
> >         A CCM frame with unexpected sequence number has been received
> >         from Peer MEP.
> >         The type is u32 (bool).
> >         When a sequence number is not one higher than previously received
> >         then it is unexpected.
> >         This is cleared after GETLINK IFLA_BRIDGE_CFM_CC_PEER_STATUS_INFO.
> >
> > Signed-off-by: Henrik Bjoernlund  <henrik.bjoernlund@microchip.com>
> > Reviewed-by: Horatiu Vultur  <horatiu.vultur@microchip.com>
> > ---
> >  include/uapi/linux/if_bridge.h |  29 +++++++++
> >  include/uapi/linux/rtnetlink.h |   1 +
> >  net/bridge/br_cfm_netlink.c    | 105 +++++++++++++++++++++++++++++++++
> >  net/bridge/br_netlink.c        |  16 ++++-
> >  net/bridge/br_private.h        |   6 ++
> >  5 files changed, 154 insertions(+), 3 deletions(-)
> >
> [snip]
> > diff --git a/net/bridge/br_cfm_netlink.c b/net/bridge/br_cfm_netlink.c
> > index 952b6372874e..94e9b46d5fb4 100644
> > --- a/net/bridge/br_cfm_netlink.c
> > +++ b/net/bridge/br_cfm_netlink.c
> > @@ -617,3 +617,108 @@ int br_cfm_config_fill_info(struct sk_buff *skb, struct net_bridge *br)
> >  nla_info_failure:
> >       return -EMSGSIZE;
> >  }
> > +
> > +int br_cfm_status_fill_info(struct sk_buff *skb, struct net_bridge *br)
> > +{
> > +     struct nlattr *tb;
> > +     struct br_cfm_mep *mep;
> > +     struct br_cfm_peer_mep *peer_mep;
> > +
> >
> 
> Reverse xmas tree here, too. Sorry I missed these earlier.
> 
I chande this as requested.
> 

-- 
/Henrik
