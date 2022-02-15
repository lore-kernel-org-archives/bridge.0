Return-Path: <kuba@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1644901990;
 bh=5G1G+iYda0ASt2hoy/703UMcV7F/fJHwIIgyIs2HQ98=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=MqFqeMqptslXxyLRQR+fn0lmy5fzANcj33vTrFvQIuslIPE3p7WheSnyQqIMF0Z8B
 TX4liZDUUDGGLdD8J8LxNjK3lGkNN9Sh/ICYMCnUzb4J7qwJTSNDYjg7s2GYEwZURu
 7HshVtxvfyBINL5dxW78vwy+4SAdhF6HNzMJd1vGCWcKaAGxukfbsOdSXfdU/cBMft
 yaylW0h6CX7XPBySjJSsyJuthyyFk9cPyQXs0aHF+fgoaKA5blcN+K2F7Ug5GOa8YL
 ZZrhLDtthSqP6m/hGq0TYbLnqkUFfuGTn2czrr1MtqJxw+EsC21j8rFlRHIYJO+MQ6
 s6qAfFupCaOmw==
Date: Mon, 14 Feb 2022 21:13:09 -0800
From: Jakub Kicinski <kuba@kernel.org>
Message-ID: <20220214211309.261bd9d6@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20220211131426.5433-1-oleksandr.mazur@plvision.eu>
References: <20220211131426.5433-1-oleksandr.mazur@plvision.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] net: bridge: multicast: notify switchdev
 driver whenever MC processing gets disabled
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Oleksandr Mazur <oleksandr.mazur@plvision.eu>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, "David S. Miller" <davem@davemloft.net>

On Fri, 11 Feb 2022 15:14:26 +0200 Oleksandr Mazur wrote:
> Whenever bridge driver hits the max capacity of MDBs, it disables
> the MC processing (by setting corresponding bridge option), but never
> notifies switchdev about such change (the notifiers are called only upon
> explicit setting of this option, through the registered netlink interface).
> 
> This could lead to situation when Software MDB processing gets disabled,
> but this event never gets offloaded to the underlying Hardware.
> 
> Fix this by adding a notify message in such case.

Any comments on this one?

We have drivers offloading mdb so presumably this should have a Fixes
tag and go to net, right?
