Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=1rNLXcvXKP3m/fnPThWaXf4M817aZUPGjPuR43utm5Q=;
 b=bQRtat1Xo7i63Co4iAOtYmLAkcqeWBNEsuqqBTZC/sdXBIAuIhxW+yEfTW7tMgqXNR
 NaqrHFZLhkELQZJs+Rxzc6q22fgJ7363f58/IxCP6HhoDlKmUBej3Ud7JVC3V9cSXGem
 M/20hpLtqmJRy0w3i1zTiJH+zAlGzK3m6GyQGGjRlikreB00qh2GmmGAic23HCI1QYq2
 7wWLGrtE2dwuCysbP8+AGFZbanuCLPhXOwBiXqaUzPlZkm2CV1xqkaDh9CWquq87io07
 dKu37qYD14SYEK9H9QJq9UyJdO0odBc/pu/TO6ffraYdMRCrTMr1SUVKvxJ4U+2g8Y/S
 erXw==
Date: Wed, 10 Feb 2021 12:45:49 +0200
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20210210104549.ga3lgjafn5x3htwj@skbuf>
References: <20210210091445.741269-1-olteanv@gmail.com>
 <a8e9284b-f0a6-0343-175d-8c323371ef8d@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8e9284b-f0a6-0343-175d-8c323371ef8d@nvidia.com>
Subject: Re: [Bridge] [PATCH v3 net-next 00/11] Cleanup in brport flags
 switchdev offload for DSA
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@nvidia.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Vadym Kochan <vkochan@marvell.com>, linux-omap@vger.kernel.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Ioana Ciornei <ioana.ciornei@nxp.com>, linux-kernel@vger.kernel.org, Vivien Didelot <vivien.didelot@gmail.com>, Taras Chornyi <tchornyi@marvell.com>, Ido Schimmel <idosch@idosch.org>, Claudiu Manoil <claudiu.manoil@nxp.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, UNGLinuxDriver@microchip.com, "David S. Miller" <davem@davemloft.net>

Hi Nikolay,

On Wed, Feb 10, 2021 at 12:31:43PM +0200, Nikolay Aleksandrov wrote:
> Hi Vladimir,
> Let's take a step back for a moment and discuss the bridge unlock/lock sequences
> that come with this set. I'd really like to avoid those as they're a recipe
> for future problems. The only good way to achieve that currently is to keep
> the PRE_FLAGS call and do that in unsleepable context but move the FLAGS call
> after the flags have been changed (if they have changed obviously). That would
> make the code read much easier since we'll have all our lock/unlock sequences
> in the same code blocks and won't play games to get sleepable context.
> Please let's think and work in that direction, rather than having:
> +	spin_lock_bh(&p->br->lock);
> +	if (err) {
> +		netdev_err(p->dev, "%s\n", extack._msg);
> +		return err;
>  	}
> +
> 
> which immediately looks like a bug even though after some code checking we can
> verify it's ok. WDYT?
> 
> I plan to get rid of most of the br->lock since it's been abused for a very long
> time because it's essentially STP lock, but people have started using it for other
> things and I plan to fix that when I get more time.

This won't make the sysfs codepath any nicer, will it?
