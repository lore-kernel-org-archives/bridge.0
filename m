Return-Path: <naresh.kamboju@linaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fTzo6vxMfYlgbUOwSMawZfNKJyreGjClP9wAsvVTm1E=;
 b=UD6VtD2nxoM4yb0LGkCOvaX/zF9yrw4fA6tqSCoTSL82aBwK6yqzv0t2Hz5VkIh/da
 U7yhPJqRFbxApmj84K1i+pXiVe6aku3GXsqXD1Gr0E24zeni9vl8X2Ft59zum4tg7ABv
 RrVdeW5K4K/YjAP3pmiafa7WtuBsVd0+fZX5olSmVMK1nHp8tsPBxPm6G7+7eGn9ZFlP
 7QR+rmk3sAqSdk47QNGEv0p5waWj28vyuS07t6VnIvCCZr3ShLf4G62vnrE7edmJgc/L
 Gcwk1m4LZIpMUGOrRG4xWX95uINhn33c5huopzBpkKNnX1oTDbgg4cVNeuZjHsHCufPR
 57SA==
MIME-Version: 1.0
References: <20210721162403.1988814-1-vladimir.oltean@nxp.com>
 <20210721162403.1988814-6-vladimir.oltean@nxp.com>
 <CA+G9fYtaM=hexrmMvDXzeHZKuLCp53kRYyyvbBXZzveQzgDSyA@mail.gmail.com>
 <YP7ByrIz4LvrvIY5@lunn.ch>
In-Reply-To: <YP7ByrIz4LvrvIY5@lunn.ch>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 27 Jul 2021 09:33:10 +0530
Message-ID: <CA+G9fYtxDUJLRG7sv0aHox=+i7fFaCnLEjA0aaDRXPh+3h57hA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, Ido Schimmel <idosch@idosch.org>, Ioana Ciornei <ioana.ciornei@nxp.com>, Horatiu Vultur <horatiu.vultur@microchip.com>, Marek Behun <kabel@blackhole.sk>, Florian Fainelli <f.fainelli@gmail.com>, Steen Hegelund <Steen.Hegelund@microchip.com>, bridge@lists.linux-foundation.org, Linux-Next Mailing List <linux-next@vger.kernel.org>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Vivien Didelot <vivien.didelot@gmail.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Jiri Pirko <jiri@resnulli.us>, Stephen Rothwell <sfr@canb.auug.org.au>, Vadym Kochan <vkochan@marvell.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, Lars Povlsen <lars.povlsen@microchip.com>, Netdev <netdev@vger.kernel.org>, UNGLinuxDriver@microchip.com, Taras Chornyi <tchornyi@marvell.com>, "David S. Miller" <davem@davemloft.net>, Tobias Waldekranz <tobias@waldekranz.com>

On Mon, 26 Jul 2021 at 19:38, Andrew Lunn <andrew@lunn.ch> wrote:
>
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

It was my bad,
I will follow your suggestions in future reports.
Thank you !

>
>      Andrew

- Naresh
