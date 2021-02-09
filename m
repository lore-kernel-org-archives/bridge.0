Return-Path: <idosch@idosch.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=apMIh8
 1zHTwrdiLkYm/FdsFavFVD8+FsPBR4HWhPa2U=; b=TeOeHWpIBlLMsdNiMMUs19
 cQ52jAyJcvO/gFYpHT4LKstRXjXlP+KZTXE2jmEJulRJBm2G+kWiuiXiC0GPoTjV
 V7b+MMxWxtC8nGDsNXAr7LXOsKJ3/Y96SxktYrBKxLf4PQ1PZU/QQxRc8OYsRHzi
 t1HfCb9Z5A+XmCLkJkD5iQX9ITZjSKCCroI4Z/kz/AEnphvke8KffOmt7izQDX9H
 kyl2/WitQ9QmObM+Y/PLEly5PHhKtvteG8Zt29HJRFrrbHZcHncbecpRTQNLHNBk
 pdqJMm4onota2IWfcztPN3tXcRoMUttvgPlUJ3cY4Zrlr38oQ+3MDcRYqqO6nVmA
 ==
Date: Tue, 9 Feb 2021 20:00:20 +0200
From: Ido Schimmel <idosch@idosch.org>
Message-ID: <20210209180020.GA262892@shredder.lan>
References: <20210209151936.97382-1-olteanv@gmail.com>
 <20210209151936.97382-2-olteanv@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209151936.97382-2-olteanv@gmail.com>
Subject: Re: [Bridge] [PATCH v2 net-next 01/11] net: switchdev: propagate
 extack to port attributes
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Vadym Kochan <vkochan@marvell.com>, linux-omap@vger.kernel.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Ioana Ciornei <ioana.ciornei@nxp.com>, linux-kernel@vger.kernel.org, Vivien Didelot <vivien.didelot@gmail.com>, Taras Chornyi <tchornyi@marvell.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, UNGLinuxDriver@microchip.com, "David S. Miller" <davem@davemloft.net>

On Tue, Feb 09, 2021 at 05:19:26PM +0200, Vladimir Oltean wrote:
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> When a struct switchdev_attr is notified through switchdev, there is no
> way to report informational messages, unlike for struct switchdev_obj.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
