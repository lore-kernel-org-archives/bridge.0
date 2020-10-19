Return-Path: <Henrik.Bjoernlund@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1603097558; x=1634633558;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=tJ/a1JvUOjBjoPtEuJeWoMkuf2rsk+6hMQF3y1Sz3mw=;
 b=qMeEnYvdXeZAw3yedp76hOAh+rTbpXp+oJIsZnoDFSWkwqF4xEGevHO3
 87cxwYnGZ2CD69MSj0SZEJaaW0JMiLh/NXhjltZrZK3jl6VCrEJrHYfr9
 73RkfI9FyWY/IWdwSyxZuBJtZ2B5vrq3WpOBwxJ3M8yr2tWpY6dmKqbJf
 3OmIgJnE1YDFczeB4XjcgkjPrB6ohVUWYGv2G/E55gDi7qkaB32/jdMWV
 5g77R7WZLeX81wpsENGe6Tr60uTNUpQj5P4JmMM/ZwJU68pX0TZqVqE4P
 S05IP+8RvDYgUVPbNZU1OdIZ6OyHAlFVvPKreRff7BHqRG9B9p8sSaQcj Q==;
Date: Mon, 19 Oct 2020 08:51:04 +0000
From: Henrik Bjoernlund <henrik.bjoernlund@microchip.com>
Message-ID: <20201019085104.2hkz2za2o2juliab@soft-test08>
References: <20201015115418.2711454-1-henrik.bjoernlund@microchip.com>
 <20201015115418.2711454-8-henrik.bjoernlund@microchip.com>
 <20201015103431.25d66c8b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20201015103431.25d66c8b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Subject: Re: [Bridge] [PATCH net-next v6 07/10] bridge: cfm: Netlink SET
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

Thank you for the review. Comments below.

The 10/15/2020 10:34, Jakub Kicinski wrote:
> 
> On Thu, 15 Oct 2020 11:54:15 +0000 Henrik Bjoernlund wrote:
> > +     [IFLA_BRIDGE_CFM_MEP_CONFIG_MDLEVEL]     = {
> > +     .type = NLA_U32, .validation_type = NLA_VALIDATE_MAX, .max = 7 },
> 
>         NLA_POLICY_MAX(NLA_U32, 7)

I will change as requested.

> 
> Also why did you keep the validation in the code in patch 4?

In patch 4 there is no CFM NETLINK so I desided to keep the validation in the
code until NETLINK was added that is now doing the check.
I this a problem?

-- 
/Henrik
