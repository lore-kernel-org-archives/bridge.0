Return-Path: <olteanv@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5857660E51
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6049560F3A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=y83I/EEj5O1WzvhlqMvy69bC2C3kma+TguYlktElg+U=;
 b=aqI400aFX+Hv1if94yQ/9coImAcoL5xm5EE9Z8Pnq+JQ7MqId0ZuB5eW9kjAqCiUrN
 KMZPlHItsw5EctvNgdlnTcP5laLuqUz+SV1o33najcKCsjf0QARB5ow9Z44sTZTOmSeg
 UrpNC6fH6ciHR2X4rGmdJWOSbH4r9VMHXzYepV/zYSLDnnNwqU+kf3Zv2sg7HE61xVNl
 7t3a9w2kLyvF5PibwmB0qSxZXtgVyxt+2/Ir7YJLUZG06dtskhoVW5tz2mc4jA71zIm4
 UhnubOmNzJl78yCv0QqxYV7AfFoBR+16JycwYyxr/dmdd6j59K4vgycD/Tzgpk9gib2d
 VCVw==
Date: Fri, 21 Oct 2022 14:22:16 +0300
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20221021112216.6bw6sjrieh2znlti@skbuf>
References: <20221018165619.134535-1-netdev@kapio-technology.com>
 <20221018165619.134535-1-netdev@kapio-technology.com>
 <20221018165619.134535-11-netdev@kapio-technology.com>
 <20221018165619.134535-11-netdev@kapio-technology.com>
 <20221020132538.reirrskemcjwih2m@skbuf>
 <2565c09bb95d69142522c3c3bcaa599e@kapio-technology.com>
 <20221020225719.l5iw6vndmm7gvjo3@skbuf>
 <82d23b100b8d2c9e4647b8a134d5cbbf@kapio-technology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82d23b100b8d2c9e4647b8a134d5cbbf@kapio-technology.com>
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

On Fri, Oct 21, 2022 at 08:47:42AM +0200, netdev@kapio-technology.com wrote:
> On 2022-10-21 00:57, Vladimir Oltean wrote:
> > On Thu, Oct 20, 2022 at 10:20:50PM +0200, netdev@kapio-technology.com
> > wrote:
> > > In general locked ports block traffic from a host based on if there
> > > is a
> > > FDB entry or not. In the non-offloaded case, there is only CPU
> > > assisted
> > > learning, so the normal learning mechanism has to be disabled as any
> > > learned entry will open the port for the learned MAC,vlan.
> > 
> > Does it have to be that way? Why can't BR_LEARNING on a BR_PORT_LOCKED
> > cause the learned FDB entries to have BR_FDB_LOCKED, and everything
> > would be ok in that case (the port will not be opened for the learned
> > MAC/VLAN)?
> 
> I suppose you are right that basing it solely on BR_FDB_LOCKED is possible.
> 
> The question is then maybe if the common case where you don't need learned
> entries for the scheme to work, e.g. with EAPOL link local packets, requires
> less CPU load to work and is cleaner than if using BR_FDB_LOCKED entries?

I suppose the real question is what does the bridge currently do with
BR_LEARNING + BR_PORT_LOCKED, and if that is sane and useful in any case?
It isn't a configuration that's rejected, for sure. The configuration
could be rejected via a bug fix patch, then in net-next it could be made
to learn these addresses with the BR_FDB_LOCKED flag.

To your question regarding the common case (no MAB): that can be supported
just fine when BR_LEARNING is off and BR_PORT_LOCKED is on, no?
No BR_FDB_LOCKED entries will be learned.
