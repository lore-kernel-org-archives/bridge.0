Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=nnXH9OEkX6/64CRIXpm2q4YcE5R0RLwwDJpdnIFDAWY=;
 b=a46eeZbS67P014IPIYYEuugVBwQdVkgc3xe0nHoGpHa+CLu7h3/0rDHMm1C9u0Vaqa
 GG6yKIfhXq34B2c+8u8MmZz/P8VknqBLIWzPDzPE5/00VCC4jSFXgeTKTC2wGXJFy4po
 chD8bkSL5cNkfThbloN9qTqGuQWNoVdPsm6e0ey1QHpVLG6oAxNjaLNpThgTzEHom8O3
 rlR5IsNd9LSI3RhMjDl0t54xClnANAGUaIY+79MwKaKe9CAoBzAEPbX7sz5Dq3JuoZjW
 XJLk4RjT0csljKhvY94qUxjlJ53IISuVPtHFebdaSySPN9o7sgHspaWRzl0/RrZs8zdI
 3kTg==
Date: Mon, 26 Jul 2021 17:37:00 +0300
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20210726143700.6lszvah4jqde3o54@skbuf>
References: <20210721162403.1988814-1-vladimir.oltean@nxp.com>
 <20210721162403.1988814-6-vladimir.oltean@nxp.com>
 <CA+G9fYtaM=hexrmMvDXzeHZKuLCp53kRYyyvbBXZzveQzgDSyA@mail.gmail.com>
 <YP7ByrIz4LvrvIY5@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YP7ByrIz4LvrvIY5@lunn.ch>
Subject: Re: [Bridge] [PATCH v6 net-next 5/7] net: bridge: switchdev: let
 drivers inform which bridge ports are offloaded
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, Ido Schimmel <idosch@idosch.org>, Ioana Ciornei <ioana.ciornei@nxp.com>, UNGLinuxDriver@microchip.com, Horatiu Vultur <horatiu.vultur@microchip.com>, Marek Behun <kabel@blackhole.sk>, Florian Fainelli <f.fainelli@gmail.com>, Naresh Kamboju <naresh.kamboju@linaro.org>, bridge@lists.linux-foundation.org, Linux-Next Mailing List <linux-next@vger.kernel.org>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Vivien Didelot <vivien.didelot@gmail.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Jiri Pirko <jiri@resnulli.us>, Stephen Rothwell <sfr@canb.auug.org.au>, Vadym Kochan <vkochan@marvell.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, Lars Povlsen <lars.povlsen@microchip.com>, Netdev <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Taras Chornyi <tchornyi@marvell.com>, Steen Hegelund <Steen.Hegelund@microchip.com>, Tobias Waldekranz <tobias@waldekranz.com>

Hello Naresh,

On Mon, Jul 26, 2021 at 04:08:10PM +0200, Andrew Lunn wrote:
> On Mon, Jul 26, 2021 at 07:21:20PM +0530, Naresh Kamboju wrote:
> > On Wed, 21 Jul 2021 at 21:56, Vladimir Oltean <vladimir.oltean@nxp.com> wrote:
> > >
> > > On reception of an skb, the bridge checks if it was marked as 'already
> > > forwarded in hardware' (checks if skb->offload_fwd_mark == 1), and if it
> > > is, it assigns the source hardware domain of that skb based on the
> > > hardware domain of the ingress port. Then during forwarding, it enforces
> > > that the egress port must have a different hardware domain than the
> > > ingress one (this is done in nbp_switchdev_allowed_egress).
> 
> > [Please ignore if it is already reported]
> > 
> > Following build error noticed on Linux next 20210723 tag
> > with omap2plus_defconfig on arm architecture.
> 
> Hi Naresh
> 
> Please trim emails when replying. It is really annoying to have to
> page down and down and down to find your part in the email, and you
> always wonder if you accidentally jumped over something when paging
> down at speed.

I agree with what Andrew said.
I've sent this patch to address the build issue you reported. Thanks.
https://patchwork.kernel.org/project/netdevbpf/patch/20210726142536.1223744-1-vladimir.oltean@nxp.com/
