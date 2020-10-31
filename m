Return-Path: <kuba@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1604105833;
 bh=986U1WT2eTEVzODFd0gdq4cGAXDe6PZrM3EnpbUmszc=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Yq2MLhjsts1DAWWm3hf2WQg+dUHPEb5Dn8Oijl9B5NkTlRoG/GeamZW9uF+Gl4GnT
 x8sJUCxB9lztjXA0DUZcLQvEV9YY7WGqIdetGcAHwdGAo5AlRAG3c0egovRSbDe6St
 AoRf5XJ1bmPQ8zj0JIjIvxAXNdf0mA+65iMkve8g=
Date: Fri, 30 Oct 2020 17:57:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
Message-ID: <20201030175712.6431ac84@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
In-Reply-To: <20201028233831.610076-1-vladimir.oltean@nxp.com>
References: <20201028233831.610076-1-vladimir.oltean@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v4 net-next] net: bridge: mcast: add support
 for raw L2 multicast groups
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: andrew@lunn.ch, f.fainelli@gmail.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, vivien.didelot@gmail.com, idosch@idosch.org, jiri@mellanox.com, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, "David S. Miller" <davem@davemloft.net>

On Thu, 29 Oct 2020 01:38:31 +0200 Vladimir Oltean wrote:
> From: Nikolay Aleksandrov <nikolay@nvidia.com>
> 
> Extend the bridge multicast control and data path to configure routes
> for L2 (non-IP) multicast groups.
> 
> The uapi struct br_mdb_entry union u is extended with another variant,
> mac_addr, which does not change the structure size, and which is valid
> when the proto field is zero.
> 
> To be compatible with the forwarding code that is already in place,
> which acts as an IGMP/MLD snooping bridge with querier capabilities, we
> need to declare that for L2 MDB entries (for which there exists no such
> thing as IGMP/MLD snooping/querying), that there is always a querier.
> Otherwise, these entries would be flooded to all bridge ports and not
> just to those that are members of the L2 multicast group.
> 
> Needless to say, only permanent L2 multicast groups can be installed on
> a bridge port.
> 
> Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Applied, thanks!
