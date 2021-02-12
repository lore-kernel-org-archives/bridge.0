Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=oAkh6JJVyX7ngecxDdQvglBOLyHNnX0FyZZLG8idRao=;
 b=UNezosfMr9+hm0SI9j2bJhhnYuMnPZDZ7UXSFalWY20RPpK4uA+3gwLA+agW5jDe0o
 eXwRsUHVsu6fiFM/z9zkRbkk0qZKWuQTaJzA3McH6mSAgk1C2whm7x2pbcXYOA7ozgNE
 BD40S3X4M56Zry8V7WdWrV7gn1Nd8dE+Lp8t2dwuPr3iw3LqSiLVqNR4jiJbj3d+9A4f
 SOI7PWSpK7o3CDevo7JIWOSIcBtWpsJxciXYan3BS6GytZxqWvyg3ce1xxDoVh5q8Pg6
 kdg3mvRzsawZ+MX3PXBpiGi2HZ51TkHeTx46j86WTzPsaPsRs/H+c2dORSJjRvi1Q81q
 jFNQ==
Date: Fri, 12 Feb 2021 14:23:09 +0200
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20210212122309.ffv6zuhscwtvrhjk@skbuf>
References: <20210212010531.2722925-1-olteanv@gmail.com>
 <20210212010531.2722925-8-olteanv@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210212010531.2722925-8-olteanv@gmail.com>
Subject: Re: [Bridge] [PATCH v4 net-next 7/9] net: mscc: ocelot: use
 separate flooding PGID for broadcast
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

On Fri, Feb 12, 2021 at 03:05:29AM +0200, Vladimir Oltean wrote:
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> In preparation of offloading the bridge port flags which have
> independent settings for unknown multicast and for broadcast, we should
> also start reserving one destination Port Group ID for the flooding of
> broadcast packets, to allow configuring it individually.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> ---

After more testing with the ocelot-8021q tagger too, not just the
default NPI-based one, I noticed that I introduced a regression.

devlink-sb tells me that broadcast packets remain stuck in the ingress
queues of the front-panel ports instead of being forwarded to the CPU.
This is because I forgot this:

-----------------------------[cut here]-----------------------------
 drivers/net/dsa/ocelot/felix.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/dsa/ocelot/felix.c b/drivers/net/dsa/ocelot/felix.c
index 96d9d13c5ae0..2771560cef61 100644
--- a/drivers/net/dsa/ocelot/felix.c
+++ b/drivers/net/dsa/ocelot/felix.c
@@ -299,6 +299,7 @@ static int felix_setup_tag_8021q(struct dsa_switch *ds, int cpu)
 	cpu_flood = ANA_PGID_PGID_PGID(BIT(ocelot->num_phys_ports));
 	ocelot_rmw_rix(ocelot, 0, cpu_flood, ANA_PGID_PGID, PGID_UC);
 	ocelot_rmw_rix(ocelot, 0, cpu_flood, ANA_PGID_PGID, PGID_MC);
+	ocelot_rmw_rix(ocelot, 0, cpu_flood, ANA_PGID_PGID, PGID_BC);
 
 	felix->dsa_8021q_ctx = kzalloc(sizeof(*felix->dsa_8021q_ctx),
 				       GFP_KERNEL);
-----------------------------[cut here]-----------------------------

If there is no other feedback on this series, can I send this as a
follow-up fixup? Thanks.
