Return-Path: <kuba@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605570636;
 bh=revZMqDAKvfAcrUyCPRAeYx6moZKw5JnA44m4JeGMTE=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=h+EpHgMkUfqxXUZ3mXGyslpE/q6cYzWQPBWkOGHJKqlV0kaDxcq2M+mnMiep3Gy08
 RxDT0VeWuv2pnGt35DfjxBvPZqewxbsoC6APeyUZ/Zxuat0eQk/XLapB5y+vLXC0JI
 iYCWPTqrj+EjEMFvIXuJ53HkUNBWKKm3nYVxUZsw=
Date: Mon, 16 Nov 2020 15:50:35 -0800
From: Jakub Kicinski <kuba@kernel.org>
Message-ID: <20201116155035.7f9e761c@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <58ea9963-77ad-a7cf-8dfd-fc95ab95f606@gmail.com>
References: <58ea9963-77ad-a7cf-8dfd-fc95ab95f606@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net] net: bridge: add missing counters to
 ndo_get_stats64 callback
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: bridge@lists.linux-foundation.org, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, David Miller <davem@davemloft.net>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>

On Fri, 13 Nov 2020 10:27:27 +0100 Heiner Kallweit wrote:
> In br_forward.c and br_input.c fields dev->stats.tx_dropped and
> dev->stats.multicast are populated, but they are ignored in
> ndo_get_stats64.
> 
> Fixes: 28172739f0a2 ("net: fix 64 bit counters on 32 bit arches")
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
> Patch will not apply cleanly on kernel versions that don't have
> dev_fetch_sw_netstats() yet.

Looks straightforward enough, I'll backport manually.

Applied, thanks!
