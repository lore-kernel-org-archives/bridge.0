Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=PJhUcsspU97g7E83Bpc3xMjAAqh5e3B1I8VLV04Hlg4=;
 b=lvQlGkQMovEbhDOLkEx9FfNMFdUym7QHjOg8TV2oep0SJ3tQ8K2y2owZAeCFaow50x
 2VGtWy4UVBOA5Hgv2Um7p3LyrGWWlhoOMsocXgMiubAK4BqyJ7BiUZK3h2X8Llpv4ZQw
 k6Gz4suycc94X9lIr3rsjrX+qEQZi/OrloEcd4zZTfo40c/z+ms8sY96+2HI94Hbgyx3
 8ja3Youg4lK9LB9/A8W/qNaXmqTAfuDxcLGhYNslXyI9Olc4+3JxhEjZpUsjf3teFDlL
 2oSbRcOpVlSav3/aqavxHG5/c1qX5sqQlWvB+P/I/MrqlkhgtOERuvKS4J1xGnLwyj2w
 XsQg==
Date: Sat, 14 Aug 2021 04:11:15 +0300
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20210814011115.agzyo3cydlupafvy@skbuf>
References: <20210812142213.2251697-1-dqfext@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210812142213.2251697-1-dqfext@gmail.com>
Subject: Re: [Bridge] [PATCH net-next v2] net: bridge: switchdev: pass more
 port flags to drivers
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: DENG Qingfang <dqfext@gmail.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Jiri Pirko <jiri@resnulli.us>, "open list:ETHERNET BRIDGE" <netdev@vger.kernel.org>, "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>, open list <linux-kernel@vger.kernel.org>, Ido Schimmel <idosch@idosch.org>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, Tobias Waldekranz <tobias@waldekranz.com>

On Thu, Aug 12, 2021 at 10:22:12PM +0800, DENG Qingfang wrote:
> These 3 port flags: BR_HAIRPIN_MODE, BR_MULTICAST_TO_UNICAST, and
> BR_ISOLATED, affect the data path and should be handled by switchdev
> drivers.
> 
> Add them to BR_PORT_FLAGS_HW_OFFLOAD so they can be passed down to
> the drivers.
> 
> Suggested-by: Vladimir Oltean <olteanv@gmail.com>
> Signed-off-by: DENG Qingfang <dqfext@gmail.com>
> ---
> v1 -> v2: added more flags

If you insist to not write a competent commit message which properly
explains the motivation for the change, then please remove my
Suggested-by tag and resend. Thanks
