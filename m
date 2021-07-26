Return-Path: <andrew@lunn.ch>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
 s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
 Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
 bh=zba7ivloW/GmHx9EVsC3PwYK2hWj1LO+rp/YmCsR4vw=; b=hYVqEEnCOvi66n624n6Bjs0jk8
 +XYjr6Sn1yEbi/Wn3v5nbe8KLCfXUzu/oLf2JE1ZAhGLDr/L4mSL5BdgOUucYEwwoCB3upLz/vzK4
 Krhrq5b74Y7mG81yq1sWrhkqOW+1IMuN5irm1YrKsb47MB86ToE5S41LBJ+M340mLIPs=;
Date: Mon, 26 Jul 2021 16:08:10 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <YP7ByrIz4LvrvIY5@lunn.ch>
References: <20210721162403.1988814-1-vladimir.oltean@nxp.com>
 <20210721162403.1988814-6-vladimir.oltean@nxp.com>
 <CA+G9fYtaM=hexrmMvDXzeHZKuLCp53kRYyyvbBXZzveQzgDSyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYtaM=hexrmMvDXzeHZKuLCp53kRYyyvbBXZzveQzgDSyA@mail.gmail.com>
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
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, Ido Schimmel <idosch@idosch.org>, Ioana Ciornei <ioana.ciornei@nxp.com>, Horatiu Vultur <horatiu.vultur@microchip.com>, Marek Behun <kabel@blackhole.sk>, Florian Fainelli <f.fainelli@gmail.com>, Steen Hegelund <Steen.Hegelund@microchip.com>, bridge@lists.linux-foundation.org, Linux-Next Mailing List <linux-next@vger.kernel.org>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Vivien Didelot <vivien.didelot@gmail.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Jiri Pirko <jiri@resnulli.us>, Stephen Rothwell <sfr@canb.auug.org.au>, Vadym Kochan <vkochan@marvell.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, Lars Povlsen <lars.povlsen@microchip.com>, Netdev <netdev@vger.kernel.org>, UNGLinuxDriver@microchip.com, Taras Chornyi <tchornyi@marvell.com>, "David S. Miller" <davem@davemloft.net>, Tobias Waldekranz <tobias@waldekranz.com>

On Mon, Jul 26, 2021 at 07:21:20PM +0530, Naresh Kamboju wrote:
> On Wed, 21 Jul 2021 at 21:56, Vladimir Oltean <vladimir.oltean@nxp.com> wrote:
> >
> > On reception of an skb, the bridge checks if it was marked as 'already
> > forwarded in hardware' (checks if skb->offload_fwd_mark == 1), and if it
> > is, it assigns the source hardware domain of that skb based on the
> > hardware domain of the ingress port. Then during forwarding, it enforces
> > that the egress port must have a different hardware domain than the
> > ingress one (this is done in nbp_switchdev_allowed_egress).

> [Please ignore if it is already reported]
> 
> Following build error noticed on Linux next 20210723 tag
> with omap2plus_defconfig on arm architecture.

Hi Naresh

Please trim emails when replying. It is really annoying to have to
page down and down and down to find your part in the email, and you
always wonder if you accidentally jumped over something when paging
down at speed.

     Andrew
