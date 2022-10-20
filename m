Return-Path: <olteanv@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org ED35B404D1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 292F0400A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JuxcgTkIRC5WG6rM4q/CSaRgfUH0Ti3MoOBIFAp7H8s=;
 b=XBJzFhduueKPu1ACZxmcj5cXRa0nb0p5dX8b6x8utN2F40sVgNnz2Vwo93T3WLnBcx
 Yx3WwrvmN9Nuh/q4vOjOu0pqXnDTWqYB4KV9B3sCwZOf7c8OCwjoNM/D1TNvmc045ZzX
 Poo3JVc6Gu+DF650q6sVaij7GSbGVXbKX5JW9xSnGo2M+EdB4pcsbE0152s/sylYv+Nc
 ALPztrqDuyQF/Ci2P4snXxWjZKRtHnNH3GhbYR/zFvz6RX+vOKF1y9KazvTME97oRexc
 94w80ZyNJO0Z5bBflaDs/V5ISm1JA/Dg+OYU7d/pyJvJYa/mJ0Vv6e7Q6YanX5FVgqB4
 eYew==
Date: Fri, 21 Oct 2022 01:57:19 +0300
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20221020225719.l5iw6vndmm7gvjo3@skbuf>
References: <20221018165619.134535-1-netdev@kapio-technology.com>
 <20221018165619.134535-1-netdev@kapio-technology.com>
 <20221018165619.134535-11-netdev@kapio-technology.com>
 <20221018165619.134535-11-netdev@kapio-technology.com>
 <20221020132538.reirrskemcjwih2m@skbuf>
 <2565c09bb95d69142522c3c3bcaa599e@kapio-technology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2565c09bb95d69142522c3c3bcaa599e@kapio-technology.com>
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

On Thu, Oct 20, 2022 at 10:20:50PM +0200, netdev@kapio-technology.com wrote:
> In general locked ports block traffic from a host based on if there is a
> FDB entry or not. In the non-offloaded case, there is only CPU assisted
> learning, so the normal learning mechanism has to be disabled as any
> learned entry will open the port for the learned MAC,vlan.

Does it have to be that way? Why can't BR_LEARNING on a BR_PORT_LOCKED
cause the learned FDB entries to have BR_FDB_LOCKED, and everything
would be ok in that case (the port will not be opened for the learned
MAC/VLAN)?

> Thus learning is off for locked ports, which of course includes MAB.
> 
> So the 'learning' is based on authorizing MAC,vlan addresses, which
> is done by userspace daemons, e.g. hostapd or what could be called
> mabd.
