Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=h5l91mm4OgKaf6t4atmXs6oRTo1mGTbQpbu5LCCZIuM=;
 b=PH/c8cc/nyi8SJ24Y6mtv07Cd3UG37HbaCBZFb/gGuIRXMEUpKHmM+2ZUOmF2+nqL9
 9fP2aFSMimwDJ/NO/IJ32fpVaI6KGoscHBMhYZlu/5HDW4stPD0ZoRDcjJ4r3RQCpQsl
 B2Lo76Uupeums/vpHZj1sNYxQyk/Bcp3sb0SLdAcfOXv1PppGyWsE4WqyVJV4FTIu8ST
 qPHdOEJrlLS4mFyXBzjhmThK1mXDcyUEPVPzNmKCBM54ip5fAiecL0pr0Gh6mopToQ6h
 oc3pr+iC3sOvR8LKjxp/EzHVdnrNZpvTAA66NVbpFmesm0FtAvCy+2WUP7htpdG49wUy
 qZUw==
Date: Tue, 9 Feb 2021 20:36:36 +0200
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20210209183636.l5h4zyknk5q4kvgl@skbuf>
References: <20210209151936.97382-1-olteanv@gmail.com>
 <20210209151936.97382-3-olteanv@gmail.com>
 <20210209182724.b4funpoqh6kgoj6z@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209182724.b4funpoqh6kgoj6z@skbuf>
Subject: Re: [Bridge] [PATCH v2 net-next 02/11] net: bridge: offload all
 port flags at once in br_setport
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

On Tue, Feb 09, 2021 at 08:27:24PM +0200, Vladimir Oltean wrote:
> But there's an interesting side effect of allowing
> br_switchdev_set_port_flag to run concurrently (notifier call chains use
> a rw_semaphore and only take the read side). Basically now drivers that
> cache the brport flags in their entirety are broken, because there isn't
> any guarantee that bits outside the mask are valid any longer (we can
> even enforce that by masking the flags with the mask when notifying
> them). They would need to do the same trick of updating just the masked
> part of their cached flags. Except for the fact that they would need
> some sort of spinlock too, I don't think that the basic bitwise
> operations are atomic or anything like that. I'm a bit reluctant to add
> a spinlock in prestera, rocker, mlxsw just for this purpose. What do you
> think?

My take on things is that I can change those drivers to do what ocelot
and sja1105 do, which is to just have some bool values like this:

	if (flags.mask & BR_LEARNING)
		ocelot_port->learn_ena = !!(flags.val & BR_LEARNING);

which eliminates concurrency to the shared unsigned long brport_flags
variable. No locking, no complications.
