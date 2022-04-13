Return-Path: <troglobit@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=c2bCHm3MCZr2B3PgN7LvCqMZxNJbNpRAkdIyjksl5Ug=;
 b=RPRjQPiYcmjBFXKTRJS2jFYk+wDtGsXTaCYujYsdiqiKyXY3a8/WgUhSSgFWPZ6Ij6
 uITMAeo5+RHQzY1fZ5uBG2J0cB4CN5hjYiVU3jDWP4180NCWxygEC3KfyB+1tRgNLOjG
 DtcYZZS2DRzrUZVY0+i0CfmDE4njQI7LNddp8NPGoMH7F/cQZYQF0jHkEGzQe03+Ibcu
 2WGu6oZ0xB5XzgvlrbWAslgly0A0pOTwvDCcRZamgBrx7720H/6BhtMfzs/HmN/7EZ+t
 db1BxBVqlPlASMGcQR0KS84YEgavEzYYsPvzIcE5z2DSxfxlN3/FjlwAEj7PoqLTVzl7
 IE8A==
From: Joachim Wiberg <troglobit@gmail.com>
In-Reply-To: <76490693-ea6d-7174-0546-b9361ab5088c@blackwall.org>
References: <20220411133837.318876-1-troglobit@gmail.com>
 <20220411133837.318876-4-troglobit@gmail.com>
 <76490693-ea6d-7174-0546-b9361ab5088c@blackwall.org>
Date: Wed, 13 Apr 2022 11:22:23 +0200
Message-ID: <87mtgp9w34.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Bridge] [PATCH RFC net-next 03/13] net: bridge: minor refactor
	of br_setlink() for readability
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <razor@blackwall.org>, Roopa Prabhu <roopa@nvidia.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Vladimir Oltean <vladimir.oltean@nxp.com>, Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, Tobias Waldekranz <tobias@waldekranz.com>

On Tue, Apr 12, 2022 at 21:36, Nikolay Aleksandrov <razor@blackwall.org> wrote:
> On 11/04/2022 16:38, Joachim Wiberg wrote:
>> The br_setlink() function extracts the struct net_bridge pointer a bit
>> sloppy.  It's easy to interpret the code wrong.  This patch attempts to
>> clear things up a bit.
> I think you can make it more straight-forward, remove the first br = netdev_priv
> and do something like (completely untested):
> ...
> struct net_bridge_port *p = NULL;
> ...
> if (netif_is_bridge_master(dev)) {
>  br = netdev_priv(dev);
> } else {
>  p = br_port_get_rtnl(dev);
>  if (WARN_ON(!p))
> 	return -EINVAL;
>  br = p->br;
> }
>
> So br is always and only set in this block.

Yes, this is much better, thank you!  I took the misguided approach of
minmizing my change.  I'll update and include in the non-RFC patch
series I send next.
