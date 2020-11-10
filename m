Return-Path: <kuba@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1604970690;
 bh=VIZZlsx0jAouiq3t1QoP1KOVqGLlr6W8TTq9SFQmF3M=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=ZDdpsC4f8aqGBsvCk04lvbv0d6EX6OwnUZQ8Kn2DH/eYK5s0qyuLyqh/40P72GSHj
 gO0NKtOZBSE+OKHVkTt1hcu6PVLpjT418GiUss1boJKJbeEDnWiUS4IxsIZOA1W48X
 DFJ4X+AOo3vhe5aICWqcYtc919Zb/8mpCVdi7sGE=
Date: Mon, 9 Nov 2020 17:11:29 -0800
From: Jakub Kicinski <kuba@kernel.org>
Message-ID: <20201109171129.6b156947@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20201106215049.1448185-1-horatiu.vultur@microchip.com>
References: <20201106215049.1448185-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next] bridge: mrp: Use hlist_head instead
 of list_head for mrp
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

On Fri, 6 Nov 2020 22:50:49 +0100 Horatiu Vultur wrote:
> Replace list_head with hlist_head for MRP list under the bridge.
> There is no need for a circular list when a linear list will work.
> This will also decrease the size of 'struct net_bridge'.
> 
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>

Applied, thanks!
