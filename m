Return-Path: <kuba@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1604105967;
 bh=cVlkYBQn4AVUKpo9IrkEihc7Z9GmAo1XSN3I3NkOHfU=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=W/hL/Fpon9IaclV9nSVJhHw0iiobWpti0PMBQihqHSX3+X7/iD2bkD3UGNzyQ2A93
 NFLbxqRMAW87SHo6rR1eMtEaHHvsXeUB3c0fNXpFZQh6lLeeXXOwr/zTCqBYOjOT1z
 BWHoWIbbT5XzigepQJ2RRgCQ3dBgWVnTvqZbryV0=
Date: Fri, 30 Oct 2020 17:59:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
Message-ID: <20201030175926.5e30a1e6@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
In-Reply-To: <20201028234815.613226-1-vladimir.oltean@nxp.com>
References: <20201028234815.613226-1-vladimir.oltean@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next] net: bridge: explicitly convert
 between mdb entry state and port group flags
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, "David S. Miller" <davem@davemloft.net>

On Thu, 29 Oct 2020 01:48:15 +0200 Vladimir Oltean wrote:
> When creating a new multicast port group, there is implicit conversion
> between the __u8 state member of struct br_mdb_entry and the unsigned
> char flags member of struct net_bridge_port_group. This implicit
> conversion relies on the fact that MDB_PERMANENT is equal to
> MDB_PG_FLAGS_PERMANENT.
> 
> Let's be more explicit and convert the state to flags manually.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Applied, thanks!
