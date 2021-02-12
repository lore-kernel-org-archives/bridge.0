Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=XtDi0MBEwrkwGMq8hjer8LJhgp1YzuDVXdwRv+z+ZLg=;
 b=iU1Inb9VFPF3NTBWyuFt6Kixh9kNctCuRZ8NktXv+oGPVDU1I/FlflMtneS10uKAUK
 oF0dl1800p0nfL+bbVbQcopyUhiqeXZmLaI9JJKMq+/zjImrrET8rwUhkZSjdINFRamr
 8hTlIzp2yCEsDch2VLZKAEOxuv3tf/Ykl8bZJ1vFgypXxJTp+k0yl6kqqi3fBoDog8fT
 M96MdnPkx/mCj6V9E2qiAx0Y8LrvQeD40bm0+8os6PbXuyk+8tysKSyfWQ86SwsqHDa9
 HKLNRWPefZFLAUoMiJFb/ohwJX86qEvK9YhooOWY1EvVtvn9UtC/IS3DbsDJIW18LRw2
 dILg==
Date: Fri, 12 Feb 2021 16:40:53 +0200
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20210212144053.2pumwc6mlt4l2gcj@skbuf>
References: <20210212010531.2722925-1-olteanv@gmail.com>
 <97ae293a-f59d-cc7c-21a6-f83880c69c71@ti.com>
 <ba7350f1-f9ff-b77e-65c9-cd5a4ae652d8@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba7350f1-f9ff-b77e-65c9-cd5a4ae652d8@ti.com>
Subject: Re: [Bridge] [PATCH v4 net-next 0/9] Cleanup in brport flags
 switchdev offload for DSA
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vignesh Raghavendra <vigneshr@ti.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Vadym Kochan <vkochan@marvell.com>, linux-omap@vger.kernel.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Ioana Ciornei <ioana.ciornei@nxp.com>, linux-kernel@vger.kernel.org, Vivien Didelot <vivien.didelot@gmail.com>, Taras Chornyi <tchornyi@marvell.com>, Ido Schimmel <idosch@idosch.org>, Claudiu Manoil <claudiu.manoil@nxp.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, UNGLinuxDriver@microchip.com, "David S. Miller" <davem@davemloft.net>

On Fri, Feb 12, 2021 at 08:01:33PM +0530, Vignesh Raghavendra wrote:
> Hi Vladimir,
> 
> On 2/12/21 7:47 PM, Grygorii Strashko wrote:
> > 
> > 
> > On 12/02/2021 03:05, Vladimir Oltean wrote:
> >> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> [...]
> > 
> > Sorry, but we seems just added more work for you.
> > https://lore.kernel.org/patchwork/cover/1379380/
> > 
> 
> Could you squash these when you post new version:
> Sorry for not noticing earlier.

Hey, thanks for the fixup patch and congrats on the new driver support
for the AM65 NUSS! What's functionally different compared to the other
CPSW instantiations?

Also, do I get it right that you also tested the bridge port flags
passed in the new format and that they still work ok? May I add your
Tested-by tag?
