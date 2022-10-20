Return-Path: <olteanv@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 16FEC8432B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4E4A98432A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lmwon3whKue/CVr8WrW952+rwBDr0RPAb1kYusMk964=;
 b=h80IgPyAct7MK5zRLczRsF/1fG3PBVUcnjpRONux/l7QMniZAgQZF7KLJ/b8Xb57nV
 eNAHIneSfPVRYfQcjBU3UbTc8pcRnTz9EZFVSA2Wme8B885eczCZhwaStsn2GzrZ+2Yh
 enoURpRTuzQsVnhi3X9wa5HCqzTl9P29ZaZd/6G3Bqi5N6nREPYEZxVqPLjXeaVZq0Ps
 fqwmyJ29Jjtsc72JKjktuIL9cU5LUimNJgQZFh2PNUR3x6l8gj7g9UKGLd4ZQxSomeBp
 sbCQCd8BswmIENyTJcTrmwGkm6PzlkR13ILiaHEOGbZjT+4lhpa2zKxGvQ6fu5DKQUUB
 em4A==
Date: Thu, 20 Oct 2022 17:11:04 +0300
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20221020141104.7h7kpau6cnpfqvh4@skbuf>
References: <20221018165619.134535-1-netdev@kapio-technology.com>
 <20221018165619.134535-1-netdev@kapio-technology.com>
 <20221018165619.134535-6-netdev@kapio-technology.com>
 <20221018165619.134535-6-netdev@kapio-technology.com>
 <20221020130224.6ralzvteoxfdwseb@skbuf> <Y1FMAI9BzDRUPi5Y@shredder>
 <20221020133506.76wroc7owpwjzrkg@skbuf> <Y1FTzyPdTbAF+ODT@shredder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1FTzyPdTbAF+ODT@shredder>
Subject: Re: [Bridge] [PATCH v8 net-next 05/12] net: dsa: propagate the
 locked flag down through the DSA layer
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@nvidia.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Nikolay Aleksandrov <razor@blackwall.org>, Kurt Kanzenbach <kurt@linutronix.de>, Eric Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org, "Hans J. Schultz" <netdev@kapio-technology.com>, Joachim Wiberg <troglobit@gmail.com>, Shuah Khan <shuah@kernel.org>, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, Florent Fourcot <florent.fourcot@wifirst.fr>, bridge@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>, Vivien Didelot <vivien.didelot@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Landen Chao <Landen.Chao@mediatek.com>, Jiri Pirko <jiri@resnulli.us>, Amit Cohen <amcohen@nvidia.com>, Christian Marangi <ansuelsmth@gmail.com>, Hauke Mehrtens <hauke@hauke-m.de>, Hans Schultz <schultz.hans@gmail.com>, Sean Wang <sean.wang@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, Yuwei Wang <wangyuweihx@gmail.com>, Petr Machata <petrm@nvidia.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, davem@davemloft.net

On Thu, Oct 20, 2022 at 04:57:35PM +0300, Ido Schimmel wrote:
> > Right now this packet isn't generated, right?
> 
> Right. We don't support BR_PORT_LOCKED so these checks are not currently
> enabled in hardware. To be clear, only packets received via locked ports
> are able to trigger the check.

You mean BR_PORT_MAB, not BR_PORT_LOCKED, right? AFAIU, "locked" means
drop unknown MAC SA, "mab" means "install BR_FDB_LOCKED entry on port"
(and also maybe still drop, if "locked" is also set on port).

Sad there isn't any good documentation about these flags in the patches
that Hans is proposing.
