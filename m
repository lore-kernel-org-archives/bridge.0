Return-Path: <Henrik.Bjoernlund@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1602508054; x=1634044054;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=TKhEx3NIOhBw3NXbPso9bAlFvFT04OKekx/d4GF2W9A=;
 b=MufksNu6dVL7qZZM3l8RAHbdN3wPCYXdftgJMRXGn9ohPQeYABr7tDo8
 fhBsSJiJxLkW7jzg3O45ee7RjAcf85H7misOxYDkuGKJSuwOEvA3vZr4J
 wXWQ9Jc0+kotAMGckbe0Z0rcig3wuHWuTjzRoAsxMfJQSixRzK+4QLJ7l
 z6E4SRhp9QAWp60pkMvd/NQV+PAnT7/3oTcI/ZCcQEG5zSzcO0Trac+bS
 LoWpBfR3ZyNmSZU1+kElbV0hOh4cwf6dXLTQmqkTm3SxvYqH8CgIiy2Hx
 NTlbZSEsW5C/J2xk1Knyq9Fxi8pHVY/kCC58RBOQDDkhIT2VEjHMp7o43 Q==;
Date: Mon, 12 Oct 2020 13:05:47 +0000
From: Henrik Bjoernlund <henrik.bjoernlund@microchip.com>
Message-ID: <20201012130547.7tj3sdkmzcqjcssf@soft-test08>
References: <20201009143530.2438738-1-henrik.bjoernlund@microchip.com>
 <20201009143530.2438738-8-henrik.bjoernlund@microchip.com>
 <20201009184556.6cfe6fbc@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20201009184556.6cfe6fbc@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Subject: Re: [Bridge] [PATCH net-next v4 07/10] bridge: cfm: Netlink SET
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

Thanks for the review. Comments below.

The 10/09/2020 18:45, Jakub Kicinski wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> On Fri, 9 Oct 2020 14:35:27 +0000 Henrik Bjoernlund wrote:
> > +static inline struct mac_addr nla_get_mac(const struct nlattr *nla)
> 
> static inlines are generally not needed in C sources and just hide
> unused code. Please drop the inline annotation.
> 
I removed this function
> > +{
> > +     struct mac_addr mac;
> > +
> > +     nla_memcpy(&mac.addr, nla, sizeof(mac.addr));
> > +
> > +     return mac;
> > +}
> > +
> > +static inline struct br_cfm_maid nla_get_maid(const struct nlattr *nla)
> 
> ditto

I removed this function.

> 
> > +{
> > +     struct br_cfm_maid maid;
> > +
> > +     nla_memcpy(&maid.data, nla, sizeof(maid.data));
> 
> returning a 48B struct from a helper is a little strange, but I guess
> it's not too bad when compiler inlines the thing?
> 
I removed this function. 

> > +     return maid;
> > +}
> > +
> > +static const struct nla_policy
> > +br_cfm_policy[IFLA_BRIDGE_CFM_MAX + 1] = {
> > +     [IFLA_BRIDGE_CFM_UNSPEC]                = { .type = NLA_REJECT },
> 
> Not needed, REJECT is treated the same as 0 / uninit, right?
> 
Did not change anything here. I would like to keep this if it does no harm.

> > +     [IFLA_BRIDGE_CFM_MEP_CREATE]            = { .type = NLA_NESTED },
> 
> Consider using NLA_POLICY_NESTED() to link up the next layers.
> 
I change to use the NLA_POLICY_NESTED macro.

> > +     [IFLA_BRIDGE_CFM_MEP_DELETE]            = { .type = NLA_NESTED },
> > +     [IFLA_BRIDGE_CFM_MEP_CONFIG]            = { .type = NLA_NESTED },
> > +     [IFLA_BRIDGE_CFM_CC_CONFIG]             = { .type = NLA_NESTED },
> > +     [IFLA_BRIDGE_CFM_CC_PEER_MEP_ADD]       = { .type = NLA_NESTED },
> > +     [IFLA_BRIDGE_CFM_CC_PEER_MEP_REMOVE]    = { .type = NLA_NESTED },
> > +     [IFLA_BRIDGE_CFM_CC_RDI]                = { .type = NLA_NESTED },
> > +     [IFLA_BRIDGE_CFM_CC_CCM_TX]             = { .type = NLA_NESTED },
> > +};

-- 
/Henrik
