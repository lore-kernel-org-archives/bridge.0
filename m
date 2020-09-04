Return-Path: <kuba@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599231779;
 bh=wycQ6jI9pjOiTB5GIp2mZuyFyDlyeuQ9huVpOEiGNBc=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=htsQ614gJzrBICf3ZITx+iZk2nx7WN/yqvMGOxY3MATmyUrnWJsSI9Pg0c3Jq56tm
 63i5K7T62hgsFtEj1HoH3hQQu95Nn0y+RDaLW8QQ+6nXu2QzYeu2fLGevjksP5N8mq
 KZ9E3hS88vzoqWlLX6qsM7yhXbGaZrZ6HsHaovXg=
Date: Fri, 4 Sep 2020 08:02:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
Message-ID: <20200904080257.6b2a643f@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200904091527.669109-5-henrik.bjoernlund@microchip.com>
References: <20200904091527.669109-1-henrik.bjoernlund@microchip.com>
 <20200904091527.669109-5-henrik.bjoernlund@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH RFC 4/7] bridge: cfm: Kernel space
 implementation of CFM.
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

On Fri, 4 Sep 2020 09:15:24 +0000 Henrik Bjoernlund wrote:
> +	rcu_read_lock();
> +	b_port = rcu_dereference(mep->b_port);
> +	if (!b_port)
> +		return NULL;
> +	skb = dev_alloc_skb(CFM_CCM_MAX_FRAME_LENGTH);
> +	if (!skb)
> +		return NULL;

net/bridge/br_cfm.c:171:23: warning: context imbalance in 'ccm_frame_build' - different lock contexts for basic block
