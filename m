Return-Path: <kuba@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1602716400;
 bh=qUBUKi9Uhs8lwmVMgMRaCqfD9agAtCwndy7lYGBk0yU=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=fgN6ZvZYNVWAQiqZrNS9uUImAjj6mzR5LbgtovtEqMUMFtkfG1qqut3r6Tf05xKLL
 feG1uoZaCrWOsFy2kzvfGYHLCaXRULH7DQGNDtE6K8whEkEfWTksRpxsaVoJY3zAPw
 YOUnMIoYH4dSKrS6J/nAmipv7jfckZntPP/3vrm8=
Date: Wed, 14 Oct 2020 15:59:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
Message-ID: <20201014155958.12e38308@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
In-Reply-To: <20201012140428.2549163-6-henrik.bjoernlund@microchip.com>
References: <20201012140428.2549163-1-henrik.bjoernlund@microchip.com>
 <20201012140428.2549163-6-henrik.bjoernlund@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v5 05/10] bridge: cfm: Kernel space
 implementation of CFM. CCM frame TX added.
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

On Mon, 12 Oct 2020 14:04:23 +0000 Henrik Bjoernlund wrote:
> +	skb = dev_alloc_skb(CFM_CCM_MAX_FRAME_LENGTH);
> +	if (!skb)
> +		return NULL;
> +
> +	rcu_read_lock();
> +	b_port = rcu_dereference(mep->b_port);
> +	if (!b_port) {
> +		rcu_read_unlock();
> +		return NULL;
> +	}

At a quick scan I noticed you appear to be leaking the skb here.
So let me point out some more nit picks.
