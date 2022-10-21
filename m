Return-Path: <olteanv@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 64BA283495
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 81C79833A3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=eODYg6i1slVemJXiAd3VXkmdvCvejpnoks2e1b1sQZA=;
 b=kWmjcACfBGi4HGfSDqndyHtIVP5QX7I1bLM11RrayrZIHqCnhQks9SjBSlMCCHEK80
 3Olz0moI9h1U0OlYkoEqiu2hmUXnePYex6ofPDYB+7XQyM6xvTTUlsKpGxQ7A00r8Qiz
 2+yiokVqPbgJw3B97d9FN4gxPBWlld6vPoLR+yVJp0cxnR4nuH0HQlVF9u+Mt8Y9WJsF
 S5C1i/6ryyquWA+8VoY9IbDLwHRD3s79dKSRYFUQ8vmbRB9XAksydxeCCCfLeVenCyhs
 T5+eBUYX/+qKlh6s7y2e4VyeezWIF2MQsYA3j9ja+JFF71uvZwts4f4aPzxQtv5neO41
 vulQ==
Date: Fri, 21 Oct 2022 20:30:14 +0300
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20221021173014.oit3qmpkrsjwzbgu@skbuf>
References: <20221018165619.134535-11-netdev@kapio-technology.com>
 <20221018165619.134535-11-netdev@kapio-technology.com>
 <20221020132538.reirrskemcjwih2m@skbuf>
 <2565c09bb95d69142522c3c3bcaa599e@kapio-technology.com>
 <20221020225719.l5iw6vndmm7gvjo3@skbuf>
 <82d23b100b8d2c9e4647b8a134d5cbbf@kapio-technology.com>
 <20221021112216.6bw6sjrieh2znlti@skbuf>
 <7bfaae46b1913fe81654a4cd257d98b1@kapio-technology.com>
 <20221021163005.xljk2j3fkikr6uge@skbuf>
 <d1fb07de4b55d64f98425fe66156c4e4@kapio-technology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1fb07de4b55d64f98425fe66156c4e4@kapio-technology.com>
Subject: Re: [Bridge] [PATCH v8 net-next 10/12] net: dsa: mv88e6xxx:
 mac-auth/MAB implementation
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@kapio-technology.com
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Nikolay Aleksandrov <razor@blackwall.org>, Kurt Kanzenbach <kurt@linutronix.de>, Eric Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org, Joachim Wiberg <troglobit@gmail.com>, Shuah Khan <shuah@kernel.org>, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>, Vivien Didelot <vivien.didelot@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Landen Chao <Landen.Chao@mediatek.com>, Jiri Pirko <jiri@resnulli.us>, Amit Cohen <amcohen@nvidia.com>, Christian Marangi <ansuelsmth@gmail.com>, Hauke Mehrtens <hauke@hauke-m.de>, Hans Schultz <schultz.hans@gmail.com>, Sean Wang <sean.wang@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, Yuwei Wang <wangyuweihx@gmail.com>, Petr Machata <petrm@nvidia.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Florent Fourcot <florent.fourcot@wifirst.fr>, UNGLinuxDriver@microchip.com, davem@davemloft.net

On Fri, Oct 21, 2022 at 07:18:59PM +0200, netdev@kapio-technology.com wrote:
> On 2022-10-21 18:30, Vladimir Oltean wrote:
> > On Fri, Oct 21, 2022 at 03:16:21PM +0200, netdev@kapio-technology.com wrote:
> > > As it is now in the bridge, the locked port part is handled before learning
> > > in the ingress data path, so with BR_LEARNING and BR_PORT_LOCKED, I think it
> > > will work as it does now except link local packages.
> > 
> > If link-local learning is enabled on a locked port, I think those
> > addresses should also be learned with the BR_FDB_LOCKED flag. The
> > creation of those locked FDB entries can be further suppressed by the
> > BROPT_NO_LL_LEARN flag.
> > 
> > > If your suggestion of BR_LEARNING causing BR_FDB_LOCKED on a locked port, I
> > > guess it would be implemented under br_fdb_update() and BR_LEARNING +
> > > BR_PORT_LOCKED would go together, forcing BR_LEARNING in this case, thus also
> > > for all drivers?
> > 
> > Yes, basically where this is placed right now (in br_handle_frame_finish):
> 
> As I don't know what implications it would have for other drivers to have learning
> forced enabled on locked ports, I cannot say if it is a good idea or not.
> Right now learning is not forced either way as is, but the consensus is that learning
> should be off with locked ports, which it would be either way in the common case I
> think.

I don't think I fully understand what you mean by forcing BR_LEARNING.
A bridge port gets created with a default set of flags as can be seen in new_nbp().
Those flags include BR_LEARNING but don't include BR_PORT_LOCKED.

The user can decide he wants to make the port use 802.1X without MAB, so
he enables BR_PORT_LOCKED and disables BR_LEARNING, all with the same
netlink command (ip link set swp0 type bridge_slave learning off locked on).

How was the driver forced into anything?
