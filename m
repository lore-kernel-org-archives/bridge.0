Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=bytmtoINOEdkBtL4V2XAs15+q8GmAS7yZKBoJvhkgLk=;
 b=akE2ozj4n+Syf78UgJqCInvzuDDz+8VmFwiwu0NVDiPEtd9yuZancJkUYDsXQzYUbp
 ObndXxrSoodxkK60wJ6CouUlchzBZ3QP8k4bGVwfdMaQGNShPX5gMyLHokdta2A9EPEP
 DEApGNbbS247uAc79ayPDzMVwo1pC/QOSoxC2xFMT3tSTWuPrGkZqDtrKvfi0c+4YG1v
 kKxdMB4aFm280e4uW/KM2G4eO3f0iQkqyTYgX5pdNZKGS+IqNofZo2HkZD+KsnCZs9kZ
 RaHYXbRaeC1CMggg6p0Lw0mzj7wAvEO/tfwHENqV3oJSpWqbcOcPesH9LsuuO+2V3Sd2
 SRuQ==
References: <20210212151600.3357121-1-olteanv@gmail.com>
 <20210212151600.3357121-6-olteanv@gmail.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <9a1efd0d-9930-cbc7-5450-ffb47a0034e4@gmail.com>
Date: Fri, 12 Feb 2021 10:10:37 -0800
MIME-Version: 1.0
In-Reply-To: <20210212151600.3357121-6-olteanv@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v5 net-next 05/10] net: switchdev: pass flags
 and mask to both {PRE_, }BRIDGE_FLAGS attributes
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <olteanv@gmail.com>, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Jiri Pirko <jiri@resnulli.us>, Vignesh Raghavendra <vigneshr@ti.com>, Vadym Kochan <vkochan@marvell.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Ioana Ciornei <ioana.ciornei@nxp.com>, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, Taras Chornyi <tchornyi@marvell.com>, Ido Schimmel <idosch@idosch.org>, Claudiu Manoil <claudiu.manoil@nxp.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, linux-omap@vger.kernel.org, Vivien Didelot <vivien.didelot@gmail.com>



On 2/12/2021 7:15 AM, Vladimir Oltean wrote:
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> This switchdev attribute offers a counterproductive API for a driver
> writer, because although br_switchdev_set_port_flag gets passed a
> "flags" and a "mask", those are passed piecemeal to the driver, so while
> the PRE_BRIDGE_FLAGS listener knows what changed because it has the
> "mask", the BRIDGE_FLAGS listener doesn't, because it only has the final
> value. But certain drivers can offload only certain combinations of
> settings, like for example they cannot change unicast flooding
> independently of multicast flooding - they must be both on or both off.
> The way the information is passed to switchdev makes drivers not
> expressive enough, and unable to reject this request ahead of time, in
> the PRE_BRIDGE_FLAGS notifier, so they are forced to reject it during
> the deferred BRIDGE_FLAGS attribute, where the rejection is currently
> ignored.
> 
> This patch also changes drivers to make use of the "mask" field for edge
> detection when possible.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
