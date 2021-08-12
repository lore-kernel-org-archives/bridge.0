Return-Path: <dqfext@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-disposition:content-transfer-encoding;
 bh=nKkNOKnR0BjeJ53ALM7gQ03JCstACfSRC5kNtfzT4yk=;
 b=P0XbE8UYynS6GdhVuBw2y3O0dZ+pvc02m/UylndyPNK85wfDC6Gq59QMnx+hMXD4nI
 yCmncJO5qEPDBI0Y9J84bgG6LxAOOx+WTVY8OLTgn1KYIyLATAWYU2FuapnCogqrjuO/
 rBckONFW6CLiyURRvVq4zBgjBcfyOA06tcb0Lrk4f4VPPd3ZK7QMsVYUi+F+P9OJAAoX
 wXH4q72e3n7sZQqX5TPQKpGhmQWalzjvSnKs+DjrTRnKrmjLtdQtnINr85PSLhnsvKzC
 IbirWZdD7XapV5M0ZEMmq36msmXy9bwiBNuChoaDNSmxmHCj0hqb3Ch8xkfvo/tM+c+n
 ZqaA==
From: DENG Qingfang <dqfext@gmail.com>
Date: Thu, 12 Aug 2021 14:04:10 +0800
Message-Id: <20210812060410.1848228-1-dqfext@gmail.com>
In-Reply-To: <20210811215833.yst5tzgfvih2q4y2@skbuf>
References: <20210811135247.1703496-1-dqfext@gmail.com>
 <YRRDcGWaWHgBkNhQ@shredder> <20210811214506.4pf5t3wgabs5blqj@skbuf>
 <YRRGsL60WeDGQOnv@shredder> <20210811215833.yst5tzgfvih2q4y2@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] [PATCH net-next] net: bridge: switchdev: allow port
	isolation to be offloaded
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, "open list:ETHERNET BRIDGE" <netdev@vger.kernel.org>, "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>, open list <linux-kernel@vger.kernel.org>, Ido Schimmel <idosch@idosch.org>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>

On Thu, Aug 12, 2021 at 12:58:33AM +0300, Vladimir Oltean wrote:
> On Thu, Aug 12, 2021 at 12:52:48AM +0300, Ido Schimmel wrote:
> > 
> > If the purpose is correctness, then this is not the only flag that was
> > missed. BR_HAIRPIN_MODE is also relevant for the data path, for example.
> 
> I never wanted to suggest that I'm giving a comprehensive answer, I just
> answered Qingfang's punctual question here:
> https://lore.kernel.org/netdev/CALW65jbotyW0MSOd-bd1TH_mkiBWhhRCQ29jgn+d12rXdj2pZA@mail.gmail.com/
> 
> Tobias also pointed out the same issue about BR_MULTICAST_TO_UNICAST in
> conjunction with tx_fwd_offload (although the same is probably true even
> without it):
> https://patchwork.kernel.org/project/netdevbpf/cover/20210426170411.1789186-1-tobias@waldekranz.com/
> 
> > Anyway, the commit message needs to be reworded to reflect the true
> > purpose of the patch.
> 
> Agree, and potentially extended with all the bridge port flags which are
> broken without switchdev driver intervention.

So, what else flags should be added to BR_PORT_FLAGS_HW_OFFLOAD?
