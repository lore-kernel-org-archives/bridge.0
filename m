Return-Path: <idosch@idosch.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=6yi/O0
 LyOJ89V3sggDKStxOVOB4l9oGGCJnJDXDH4Io=; b=SmeNKoI4xLKnlWMFOlUQZc
 3VKleiE/Q7H0nBLuW0vQLhMdSU8bX/eNwmCqzta5i2lRmUTd+lANGA3NEBJqMUcR
 8LE6Ipvrj1I1rUjUPNi0/jnrhcMXGGZrqVxevV1ss5EVMIXS0FAScd1IUy7Ri9c0
 xZGhGvUrMujY/EOyvlzP7HIDMqhmq6BTLkC7BfRwU1hNSrgbe5Hs6rn2phkXDK4E
 DK51xDUEvXDtHReR/3LLgiClgn2gFkz3GMEbW72jcrxaM3lREjE1nP8L0tki/xbu
 COhHaTbHcwtUBQDdGZaMnZpca0VpKo/ZefkLr2Knzu+t0FEVJSYV8BP5Tq4A633g
 ==
Date: Wed, 21 Jul 2021 09:55:14 +0300
From: Ido Schimmel <idosch@idosch.org>
Message-ID: <YPfE0oEfwVe1u4rM@shredder>
References: <20210720134655.892334-1-vladimir.oltean@nxp.com>
 <YPbXTKj4teQZ1QRi@shredder> <20210720141200.xgk3mlipp2mzerjl@skbuf>
 <YPbcxPKjbDxChnlK@shredder> <20210720194717.qbdz5mmmxqbn3y3z@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210720194717.qbdz5mmmxqbn3y3z@skbuf>
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

On Tue, Jul 20, 2021 at 07:47:18PM +0000, Vladimir Oltean wrote:
> On Tue, Jul 20, 2021 at 05:25:08PM +0300, Ido Schimmel wrote:
> > If you don't want to change the order, then at least make the
> > replay/cleanup optional and set it to 'false' for mlxsw. This should
> > mean that the only change in mlxsw should be adding calls to
> > switchdev_bridge_port_offload() / switchdev_bridge_port_unoffload() in
> > mlxsw_sp_bridge_port_create() / mlxsw_sp_bridge_port_destroy(),
> > respectively.
> 
> Is there any specific reason why you suggested me to move the
> switchdev_bridge_port_offload() call from the top-level
> mlxsw_sp_port_bridge_join() into mlxsw_sp_bridge_port_create()
> (and similarly, from _pre_bridge_leave to _destroy)?
> 
> Even if you don't support replays right now, you'd need to move a bunch
> of code around before you would get them to work. As far as I can see,
> mlxsw_sp_bridge_port_create() is a bit too early and
> mlxsw_sp_bridge_port_destroy() is a bit too late. The port needs to be
> fairly up and running to be able to process the switchdev notifiers at
> that stage.
> 
> Do you mind if I keep the hooks where they are, which is what I do for
> all drivers? I don't think I am missing to handle any case.

I want to avoid introducing unnecessary changes. I will do them when
needed.

Thanks
