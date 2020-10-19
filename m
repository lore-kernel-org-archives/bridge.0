Return-Path: <kuba@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1603124507;
 bh=LBnNygCqE7uMUmgPFZOhgtlQx9yMmKUGgGfck+lQbM0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=1fQRPzRpMj2u3NN+KJswolxRuRhv3qRdedeyMtEqakQ3nnD+iM0txfAYnoqtOgV8j
 aEOJFZzeqA6LvMYJweEeqUBM7uJlYpsd80up4YrZxTc2iQfSGYvd4ye8c0Z5HX/+Me
 9VxrybdEsMjQAijUzPD1nAb/cfIiMU61F3IHTAOY=
Date: Mon, 19 Oct 2020 09:21:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
Message-ID: <20201019092143.258cb256@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20201019085104.2hkz2za2o2juliab@soft-test08>
References: <20201015115418.2711454-1-henrik.bjoernlund@microchip.com>
 <20201015115418.2711454-8-henrik.bjoernlund@microchip.com>
 <20201015103431.25d66c8b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <20201019085104.2hkz2za2o2juliab@soft-test08>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
To: Henrik Bjoernlund <henrik.bjoernlund@microchip.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, idosch@mellanox.com, jiri@mellanox.com, nikolay@nvidia.com, roopa@nvidia.com, Horatiu Vultur <horatiu.vultur@microchip.com>, davem@davemloft.net

On Mon, 19 Oct 2020 08:51:04 +0000 Henrik Bjoernlund wrote:
> Thank you for the review. Comments below.
> 
> The 10/15/2020 10:34, Jakub Kicinski wrote:
> > 
> > On Thu, 15 Oct 2020 11:54:15 +0000 Henrik Bjoernlund wrote:  
> > > +     [IFLA_BRIDGE_CFM_MEP_CONFIG_MDLEVEL]     = {
> > > +     .type = NLA_U32, .validation_type = NLA_VALIDATE_MAX, .max = 7 },  
> > 
> >         NLA_POLICY_MAX(NLA_U32, 7)  
> 
> I will change as requested.
> 
> > 
> > Also why did you keep the validation in the code in patch 4?  
> 
> In patch 4 there is no CFM NETLINK so I desided to keep the validation in the
> code until NETLINK was added that is now doing the check.
> I this a problem?

Nothing calls those functions until patch 7, so there's no need for
that code to be added.
