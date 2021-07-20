Return-Path: <idosch@idosch.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=oKT1WX
 Jb/HN94UGHcLFzU5g6VlqwSc1m1B9YQun33OY=; b=GQgHzO7TrAUYpGsJLVp0o0
 CwKqVARMvtwiYdLx/oHzRSuyVo0WBe9zpDc1mKSRBHRT+G+z3HBa+t5jeLwOsQMJ
 YjJ5hiiBy2TOKgmDqEUeVabaYOY5lyG4E7i73Us41m8/I3m/M1WTkC8hAd3udrUg
 gHhCKIWPcwcJZsPuZtn4nspNqhIbmvbhQrXX+V33QkvTg77zHrPg8csEGp40LrFX
 YOXLWIwllIJ9LCSO6u+zQUNWEfxaTh5CMBV1JQBmpTG+gpQj6KrvzYkz2QPnK0PW
 p5Vu4M1G9+W9Ixm63q7VwDCgL+HZHnq1va/kIpCrP29aueVJqJgSrpdIBefuiXzQ
 ==
Date: Tue, 20 Jul 2021 17:25:08 +0300
From: Ido Schimmel <idosch@idosch.org>
Message-ID: <YPbcxPKjbDxChnlK@shredder>
References: <20210720134655.892334-1-vladimir.oltean@nxp.com>
 <YPbXTKj4teQZ1QRi@shredder> <20210720141200.xgk3mlipp2mzerjl@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210720141200.xgk3mlipp2mzerjl@skbuf>
Subject: Re: [Bridge] [PATCH v5 net-next 00/10] Let switchdev drivers
 offload and unoffload bridge ports at their own convenience
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, Vivien Didelot <vivien.didelot@gmail.com>, DENG Qingfang <dqfext@gmail.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Marek Behun <kabel@blackhole.sk>, "David S. Miller" <davem@davemloft.net>, Tobias Waldekranz <tobias@waldekranz.com>

On Tue, Jul 20, 2021 at 02:12:01PM +0000, Vladimir Oltean wrote:
> On Tue, Jul 20, 2021 at 05:01:48PM +0300, Ido Schimmel wrote:
> > > The patches were split from a larger series for easier review:
> > 
> > This is not what I meant. I specifically suggested to get the TX
> > forwarding offload first and then extending the API with an argument to
> > opt-in for the replay / cleanup:
> 
> Yeah, ok, I did not get that and I had already reposted by the time you
> clarified, sorry.
> 
> Anyway, is it so bad that we cannot look at the patches in the order
> that they are in right now (even if this means that maybe a few more
> days would pass)? To me it makes a bit more sense anyway to first
> consolidate the code that is already in the tree right now, before
> adding new logic. And I don't really want to rebase the patches again to
> change the ordering and risk a build breakage without a good reason.

If you don't want to change the order, then at least make the
replay/cleanup optional and set it to 'false' for mlxsw. This should
mean that the only change in mlxsw should be adding calls to
switchdev_bridge_port_offload() / switchdev_bridge_port_unoffload() in
mlxsw_sp_bridge_port_create() / mlxsw_sp_bridge_port_destroy(),
respectively.
