Return-Path: <Henrik.Bjoernlund@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1602761155; x=1634297155;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=ZoVMllBI6FapwInWS1hyhHru/VQbiws2d3z0bAqZ7Gw=;
 b=IZ4RgBWpfOSjsBAchw7LkaohE899sQ2QCDN4EmnwSQD1oBs/omRWyAXY
 u54aa3umY6tFnFVsWhY2XeqFxjeGHOtcMBCguDz0N7zMNk/X5drwjfHA0
 43KZA7WwMob4ShZHXcrUoklHmK8fIBsP5endy7C+3u0/3qrdYmuXzWC0u
 ub2xpL4fVE2SATSP+zNlKe/ubVvQNhS5UySDPCDS1nVNQ9NBNxqKEJhPh
 +RlF6ZjwUXyCj2uM4P9OYJ2lySChBFcU1ypDifGP9ExhOKUvXgOLxS/uQ
 kOPH1lY5YdNcjvJdpOMZVVdLIQtUb0ATHD8N7NCRySBEme4hFJuLeff3i Q==;
Date: Thu, 15 Oct 2020 11:24:13 +0000
From: Henrik Bjoernlund <henrik.bjoernlund@microchip.com>
Message-ID: <20201015112413.5vzxwvykmteiesyx@soft-test08>
References: <20201012140428.2549163-1-henrik.bjoernlund@microchip.com>
 <20201012140428.2549163-9-henrik.bjoernlund@microchip.com>
 <20201014163348.2f99e349@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20201014163348.2f99e349@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
Subject: Re: [Bridge] [PATCH net-next v5 08/10] bridge: cfm: Netlink GET
 configuration Interface.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, idosch@mellanox.com, jiri@mellanox.com, nikolay@nvidia.com, roopa@nvidia.com, Horatiu Vultur <horatiu.vultur@microchip.com>, davem@davemloft.net

Thanks for your review. Comment below.
Regards
Henrik

The 10/14/2020 16:33, Jakub Kicinski wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> On Mon, 12 Oct 2020 14:04:26 +0000 Henrik Bjoernlund wrote:
> > +             if (nla_put_u32(skb, IFLA_BRIDGE_CFM_CC_CCM_TX_SEQ_NO_UPDATE,
> > +                             mep->cc_ccm_tx_info.seq_no_update))
> > +                     goto nla_put_failure;
> > +
> > +             if (nla_put_u32(skb, IFLA_BRIDGE_CFM_CC_CCM_TX_PERIOD,
> > +                             mep->cc_ccm_tx_info.period))
> > +                     goto nla_put_failure;
> > +
> > +             if (nla_put_u32(skb, IFLA_BRIDGE_CFM_CC_CCM_TX_IF_TLV,
> > +                             mep->cc_ccm_tx_info.if_tlv))
> > +                     goto nla_put_failure;
> > +
> > +             if (nla_put_u8(skb, IFLA_BRIDGE_CFM_CC_CCM_TX_IF_TLV_VALUE,
> > +                            mep->cc_ccm_tx_info.if_tlv_value))
> > +                     goto nla_put_failure;
> > +
> > +             if (nla_put_u32(skb, IFLA_BRIDGE_CFM_CC_CCM_TX_PORT_TLV,
> > +                             mep->cc_ccm_tx_info.port_tlv))
> > +                     goto nla_put_failure;
> > +
> > +             if (nla_put_u8(skb, IFLA_BRIDGE_CFM_CC_CCM_TX_PORT_TLV_VALUE,
> > +                            mep->cc_ccm_tx_info.port_tlv_value))
> > +                     goto nla_put_failure;
> 
> Consider collapsing writing related attrs in a nest into a single
> if statement:
> 
>         if (nla_put_u32(skb, IFLA_BRIDGE_CFM_CC_CCM_TX_SEQ_NO_UPDATE,
>                         mep->cc_ccm_tx_info.seq_no_update) ||
>             nla_put_u32(skb, IFLA_BRIDGE_CFM_CC_CCM_TX_PERIOD,
>                         mep->cc_ccm_tx_info.period) ||
>                 ...
I will prefer to keep it as is for my personal taste :-)

-- 
/Henrik
