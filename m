Return-Path: <kuba@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1606340086;
 bh=3lVrLTTsCdkal7E8HZY0NZKVZlVawWDZoX8smDNr+OU=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=itRkywL78OBNGH52rhDRkPoFkhM3SRjKqcUj37jk1l+Ecdj83u88Pt4/wAxr0+wq6
 hu4Ps/mY1fYVxNvdzw8GiZgYjq4BngFEhtGk9scnsLM7qmAfjQ6Je3pNpYd8RrAaVz
 es3lIG3e/2qvKxpWP7vEm848nIIQvEGFFMCZM5LM=
Date: Wed, 25 Nov 2020 13:34:44 -0800
From: Jakub Kicinski <kuba@kernel.org>
Message-ID: <20201125133444.22f09660@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20201124082525.273820-1-horatiu.vultur@microchip.com>
References: <20201124082525.273820-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v2] bridge: mrp: Implement LC mode for
	MRP
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, nikolay@nvidia.com, roopa@nvidia.com, davem@davemloft.net

On Tue, 24 Nov 2020 09:25:25 +0100 Horatiu Vultur wrote:
> Extend MRP to support LC mode(link check) for the interconnect port.
> This applies only to the interconnect ring.
> 
> Opposite to RC mode(ring check) the LC mode is using CFM frames to
> detect when the link goes up or down and based on that the userspace
> will need to react.
> One advantage of the LC mode over RC mode is that there will be fewer
> frames in the normal rings. Because RC mode generates InTest on all
> ports while LC mode sends CFM frame only on the interconnect port.
> 
> All 4 nodes part of the interconnect ring needs to have the same mode.
> And it is not possible to have running LC and RC mode at the same time
> on a node.
> 
> Whenever the MIM starts it needs to detect the status of the other 3
> nodes in the interconnect ring so it would send a frame called
> InLinkStatus, on which the clients needs to reply with their link
> status.
> 
> This patch adds InLinkStatus frame type and extends existing rules on
> how to forward this frame.
> 
> Acked-by: Nikolay Aleksandrov <nikolay@nvidia.com>
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>

Applied, thanks!
