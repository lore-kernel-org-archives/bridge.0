Return-Path: <idosch@idosch.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=yab2wm
 v6Wl9fFfxmQTboj1nEHw/37YL9zHWD6ZhbdHM=; b=P0a7X4kL8bJqhrpJAdamOb
 0i6LxuNNnMztcel+ytRDNDsFLepneY8Mc49QE2m5Oq3DDNuWFKlK91QevpYZisuk
 bxFkIPG7d6P/1VjyJTk5d0wc+C2rnks+fgDdpwdvAxursDr6q737F46MxruiQaQe
 22LMoTBRphwNt1OMxmYqrxsTN7MpjwchyykWnBdp6n9elWxZEmPdIG/3do6WhNm+
 w8wSQf7B30l3gSjfGii4RMAYxskNMXYmHcmrRQ7GV5gk6XkJM8fxcD1//oazn1cD
 on5Ie7fcdjFQEdJf21BlVmCBBoPPR0aKWzQ6I6xkKjso9CQtyLn2qJ/JNJryh+Xw
 ==
Date: Tue, 9 Feb 2021 20:51:00 +0200
From: Ido Schimmel <idosch@idosch.org>
Message-ID: <20210209185100.GA266253@shredder.lan>
References: <20210209151936.97382-1-olteanv@gmail.com>
 <20210209151936.97382-5-olteanv@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209151936.97382-5-olteanv@gmail.com>
Subject: Re: [Bridge] [PATCH v2 net-next 04/11] net: bridge: offload initial
 and final port flags through switchdev
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

On Tue, Feb 09, 2021 at 05:19:29PM +0200, Vladimir Oltean wrote:
> So switchdev drivers operating in standalone mode should disable address
> learning. As a matter of practicality, we can reduce code duplication in
> drivers by having the bridge notify through switchdev of the initial and
> final brport flags. Then, drivers can simply start up hardcoded for no
> address learning (similar to how they already start up hardcoded for no
> forwarding), then they only need to listen for
> SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS and their job is basically done, no
> need for special cases when the port joins or leaves the bridge etc.

How are you handling the case where a port leaves a LAG that is linked
to a bridge? In this case the port becomes a standalone port, but will
not get this notification.
