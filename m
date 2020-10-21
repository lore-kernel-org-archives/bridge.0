Return-Path: <Henrik.Bjoernlund@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1603271940; x=1634807940;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=+rVpCXr52dnGbmc7Y9HfkgfgWTlzu8JQ4Bcf4/Mlfb4=;
 b=EHQxjPOqMffduTdpi4fZS5GVSs9nel9YEG8CNaVxtoSt57Y1gde1etJc
 vxndFgaFKcfyhcsc0Y7h4m+mlHwtpm671D8M19ESUJeEMlwQCOVlqr4+t
 +oS5aqIlB2CF/qWpAPZpmPidFA6Afw3qt6sL/w1Olfx+R4rr4hoSmkomS
 IDhXfN41oLxP119cT7mb1Z2dQ/JgG7dWBSbVds7nxWlLxg02fdp/EYkYp
 cbnkZXh7xUtGgxKGIqqqkcNVKEAsHXB5LINl6XNz6SQXRJ4M32yocEkfL
 kwHLJHat5AC/JU+PiTreIhHQhJcXvjVOpMUyVcVqUZyxSZTkIjkjW1FFP w==;
Date: Wed, 21 Oct 2020 09:17:29 +0000
From: Henrik Bjoernlund <henrik.bjoernlund@microchip.com>
Message-ID: <20201021091729.a6wlccjlin5muejt@soft-test08>
References: <20201015115418.2711454-1-henrik.bjoernlund@microchip.com>
 <20201015115418.2711454-8-henrik.bjoernlund@microchip.com>
 <20201015103431.25d66c8b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <20201019085104.2hkz2za2o2juliab@soft-test08>
 <20201019092143.258cb256@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20201019092143.258cb256@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
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

The 10/19/2020 09:21, Jakub Kicinski wrote:> 
> On Mon, 19 Oct 2020 08:51:04 +0000 Henrik Bjoernlund wrote:
> > Thank you for the review. Comments below.
> >
> > The 10/15/2020 10:34, Jakub Kicinski wrote:
> > >
> > > On Thu, 15 Oct 2020 11:54:15 +0000 Henrik Bjoernlund wrote:
> > > > +     [IFLA_BRIDGE_CFM_MEP_CONFIG_MDLEVEL]     = {
> > > > +     .type = NLA_U32, .validation_type = NLA_VALIDATE_MAX, .max = 7 },
> > >
> > >         NLA_POLICY_MAX(NLA_U32, 7)
> >
> > I will change as requested.
> >
> > >
> > > Also why did you keep the validation in the code in patch 4?
> >
> > In patch 4 there is no CFM NETLINK so I desided to keep the validation in the
> > code until NETLINK was added that is now doing the check.
> > I this a problem?
> 
> Nothing calls those functions until patch 7, so there's no need for
> that code to be added.

I will change as requested.

-- 
/Henrik
