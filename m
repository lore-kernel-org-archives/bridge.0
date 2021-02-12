Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=ezkeluSd4BagWsILaf5/hUzcBicqZlpvmIkdsGSPDRo=;
 b=at4BigjysdRTlvmAHpGvKMJOJyedyTJmIQVo3VlJXyd8c55IC1lqPE1agEyURsnTix
 A/8NnmTmCO4a+Hh8fSs+cSQnMEtM3iviPtUHmSpf10z2YyJQdxYuzrG07CwK9GkXoZ9V
 uB/0W8OLbrh3RjKaHWLIDBaNz/v2YBUINgodO3/Vy6Qz2eFoQ9+CKU1OBhahM20tESVG
 GF74+8TVi1J71NzdSiTR+C3ksWnL6DYbx9oJkTZoae4bSsAdkYhnnM29ghemS2SNdsT9
 //7MzaTi5ht9BMOnTiIqt59NH3ez7SXUkX+nwwei/hxh3ieT7B4ABZHND5N3lgRZLLH6
 xj1Q==
Date: Fri, 12 Feb 2021 10:36:06 +0200
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20210212083606.by43rrib65uuxxlu@skbuf>
References: <20210212010531.2722925-1-olteanv@gmail.com>
 <20210212010531.2722925-7-olteanv@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210212010531.2722925-7-olteanv@gmail.com>
Subject: Re: [Bridge] [PATCH v4 net-next 6/9] net: dsa: act as ass
 passthrough for bridge port flags
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Vadym Kochan <vkochan@marvell.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Ioana Ciornei <ioana.ciornei@nxp.com>, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, Taras Chornyi <tchornyi@marvell.com>, Ido Schimmel <idosch@idosch.org>, Claudiu Manoil <claudiu.manoil@nxp.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, linux-omap@vger.kernel.org, Vivien Didelot <vivien.didelot@gmail.com>

On Fri, Feb 12, 2021 at 03:05:28AM +0200, Vladimir Oltean wrote:
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> There are multiple ways in which a PORT_BRIDGE_FLAGS attribute can be
> expressed by the bridge through switchdev, and not all of them can be
> emulated by DSA mid-layer API at the same time.

Oops, odd typo in the commit title. I only remember something was not
right, I had noticed the "as" word was missing so I added it, but I
apparently did not notice why it was missing...
