Return-Path: <olteanv@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5603C60FE6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2D30560C08
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=rb7S6vKA6tSNNVoIcDf+GZRHLmeFhGnBw8uqyS4EvKE=;
 b=I251BBbKoBayGE5g2oWlZqS5LjG0YRgMzPCPUIWwahKxLJoAdPFxy12b6BrIdZayZA
 cpMMVYpgRHwelBAjYmtk5IrxLZ0r3LqsKVGxJjSU9ClhUJNetNeWjCjOEETfHUaoekoD
 vLIX+z+dwPXXnAWJE+qwbR3+rDxXkDn2UQm2Dkho6gMTPtae76H83ll4Cgti5jGge+uO
 ridSd998Opy2oB9AEcUzA+Kextvgi4A7vkHdpVdxgHAmMtDeS4329C/Wi6o7waEU92/g
 LuiCL2vz18o4hsXUNw47Oa1UA88sa92FUjUkEvTqcZL6wvzqSSe+aAbAupeQKqpvEpNe
 bYZQ==
Date: Wed, 6 Jul 2022 16:28:34 +0300
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20220706132834.rdw7mmpbwt55kt4r@skbuf>
References: <20220524152144.40527-1-schultz.hans+netdev@gmail.com>
 <20220524152144.40527-4-schultz.hans+netdev@gmail.com>
 <20220627180557.xnxud7d6ol22lexb@skbuf>
 <CAKUejP7ugMB9d3MVX3m9Brw12_ocFoT+nuJJucYdQH70kzC7=w@mail.gmail.com>
 <CAKUejP5u9rrH8tODODG0a1PLXfLhk7NLe5LUYkefkbs15uU=BQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKUejP5u9rrH8tODODG0a1PLXfLhk7NLe5LUYkefkbs15uU=BQ@mail.gmail.com>
Subject: Re: [Bridge] [PATCH V3 net-next 3/4] net: dsa: mv88e6xxx:
 mac-auth/MAB implementation
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Hans S <schultz.hans@gmail.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>, Ido Schimmel <idosch@nvidia.com>, Vivien Didelot <vivien.didelot@gmail.com>, Hans Schultz <schultz.hans+netdev@gmail.com>, linux-kselftest@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org

On Tue, Jul 05, 2022 at 05:05:52PM +0200, Hans S wrote:
> Hi, does anybody know what it going on with this variable?
> struct dsa_port *dp ->ageing_time;
> 
> I experience that it changes value like a factor ~10 at times.

Could you be a bit more specific? Are you talking about STP Topology
Change Notification BPDUs, which trigger this code path?

diff --git a/net/bridge/br_stp.c b/net/bridge/br_stp.c
index 7d27b2e6038f..9b25bc2dcb3e 100644
--- a/net/bridge/br_stp.c
+++ b/net/bridge/br_stp.c
@@ -671,10 +671,10 @@ void __br_set_topology_change(struct net_bridge *br, unsigned char val)
 
 		if (val) {
 			t = 2 * br->forward_delay;
-			br_debug(br, "decreasing ageing time to %lu\n", t);
+			br_info(br, "decreasing ageing time to %lu\n", t);
 		} else {
 			t = br->bridge_ageing_time;
-			br_debug(br, "restoring ageing time to %lu\n", t);
+			br_info(br, "restoring ageing time to %lu\n", t);
 		}
 
 		err = __set_ageing_time(br->dev, t);

Coincidentally the default values of 2 * br->forward_delay and br->bridge_ageing_time
are 1 order of magnitude apart from each other.

[  139.998310] br0: topology change detected, propagating
[  140.003490] br0: decreasing ageing time to 3000
[  175.193054] br0: restoring ageing time to 30000

What's the problem anyway?
