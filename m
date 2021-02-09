Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=vFu+OipBrwtEdIo/aozLlKqEGgMlKw0YEDC3frRkzXg=;
 b=QQjJX0ebki87Ij2npL/1hztxP0SlB1hFS2lx86A5ddBWb7dy5CFwnMK4/Gb4226EIh
 3plOOlZETAlifZAk7yaFMarQDc+8XCwP4JaHqLnsNOOydjU7VLyKCfbIIkfpEKKnJQzC
 SxfSI4yxgIzQt9BI5ICWE+LnMM+CvoE94nv4eJMYTNU99DK8CQZUGRUFKoB9cajUP8AG
 jy+sp8sRvpyXSQCPzydklhSflwqFXQFf3Iig/u2cqQhl31nUWjJTGxSEUH+65s8YzL0o
 MYWe86Rh7OB0i3x/kB3TLKhYpjc0HMwBHzaFB5BAGO+QP+qvad8xRsCIzINft7hduZDT
 YiEA==
References: <20210209151936.97382-1-olteanv@gmail.com>
 <20210209151936.97382-8-olteanv@gmail.com>
 <20210209203724.t3gvjdzhxbkt3qu2@skbuf>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <7f907d89-542f-2652-7cf6-ea196f754eac@gmail.com>
Date: Tue, 9 Feb 2021 13:29:25 -0800
MIME-Version: 1.0
In-Reply-To: <20210209203724.t3gvjdzhxbkt3qu2@skbuf>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v2 net-next 07/11] net: dsa: kill
 .port_egress_floods overengineering
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <olteanv@gmail.com>, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Jiri Pirko <jiri@resnulli.us>, Vadym Kochan <vkochan@marvell.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Ioana Ciornei <ioana.ciornei@nxp.com>, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, Taras Chornyi <tchornyi@marvell.com>, Ido Schimmel <idosch@idosch.org>, Claudiu Manoil <claudiu.manoil@nxp.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, linux-omap@vger.kernel.org, Vivien Didelot <vivien.didelot@gmail.com>

On 2/9/21 12:37 PM, Vladimir Oltean wrote:
> On Tue, Feb 09, 2021 at 05:19:32PM +0200, Vladimir Oltean wrote:
>> From: Vladimir Oltean <vladimir.oltean@nxp.com>
>>
>> The bridge offloads the port flags through a single bit mask using
>> switchdev, which among others, contains learning and flooding settings.
>>
>> The commit 57652796aa97 ("net: dsa: add support for bridge flags")
>> missed one crucial aspect of the SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS API
>> when designing the API one level lower, towards the drivers.
>> This is that the bitmask of passed brport flags never has more than one
>> bit set at a time. On the other hand, the prototype passed to the driver
>> is .port_egress_floods(int port, bool unicast, bool multicast), which
>> configures two flags at a time.
>>
>> DSA currently checks if .port_egress_floods is implemented, and if it
>> is, reports both BR_FLOOD and BR_MCAST_FLOOD as supported. So the driver
>> has no choice if it wants to inform the bridge that, for example, it
>> can't configure unicast flooding independently of multicast flooding -
>> the DSA mid layer is standing in the way. Or the other way around: a new
>> driver wants to start configuring BR_BCAST_FLOOD separately, but what do
>> we do with the rest, which only support unicast and multicast flooding?
>> Do we report broadcast flooding configuration as supported for those
>> too, and silently do nothing?
>>
>> Secondly, currently DSA deems the driver too dumb to deserve knowing that
>> a SWITCHDEV_ATTR_ID_BRIDGE_MROUTER attribute was offloaded, because it
>> just calls .port_egress_floods for the CPU port. When we'll add support
>> for the plain SWITCHDEV_ATTR_ID_PORT_MROUTER, that will become a real
>> problem because the flood settings will need to be held statefully in
>> the DSA middle layer, otherwise changing the mrouter port attribute will
>> impact the flooding attribute. And that's _assuming_ that the underlying
>> hardware doesn't have anything else to do when a multicast router
>> attaches to a port than flood unknown traffic to it. If it does, there
>> will need to be a dedicated .port_set_mrouter anyway.
>>
>> Lastly, we have DSA drivers that have a backlink into a pure switchdev
>> driver (felix -> ocelot). It seems reasonable that the other switchdev
>> drivers should not have to suffer from the oddities of DSA overengineering,
>> so keeping DSA a pass-through layer makes more sense there.
>>
>> To simplify the brport flags situation we just delete .port_egress_floods
>> and we introduce a simple .port_bridge_flags which is passed to the
>> driver. Also, the logic from dsa_port_mrouter is removed and a
>> .port_set_mrouter is created.
>>
>> Functionally speaking, we simply move the calls to .port_egress_floods
>> one step lower, in the two drivers that implement it: mv88e6xxx and b53,
>> so things should work just as before.
>>
>> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
>> ---
> 
> Florian, Andrew, what are your opinions on this patch? I guess what I
> dislike the most about .port_egress_floods is that it combines the
> unicast and multicast settings in the same callback, for no good
> apparent reason. So that, at the very least, needs to change.
> What do you prefer between having:
> 	.port_set_unicast_floods
> 	.port_set_multicast_floods
> 	.port_set_broadcast_floods
> 	.port_set_learning
> and a single:
> 	.port_bridge_flags

Tough one, from a driver writer perspective the fewer callbacks to wire
up the better, but from a framework perspective it is certainly easier
to audit drivers if there is a callback for a narrow and specific use
case. My vote goes for the single callback, that would lead to an easier
patch set to review IMHO.
-- 
Florian
