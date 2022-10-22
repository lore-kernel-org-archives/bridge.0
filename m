Return-Path: <olteanv@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1C912823E3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 21F7A823E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ONqnfeRbIJEBHcDA0JYek+JtscZ4zltaVyYcDCSC9kw=;
 b=fYrsxTBTWLXveezVAf3JTB5d1JyTHlrtLy9F2w+mCV3f9qlz4zaL6/KTHWUm9h/MaY
 ml7uAqQR7ELdaNdsh8CMrwhkVd2tVPYE6NutMYTX5/DbWGpLIxzkGkwQSfEL4IC7b+G4
 SvKMOXuG4rl0pJDR4qXG1aNtEM7afgMx4jmNbEo+5o9nOmH71LDVrrweaDE4lN27Mxe8
 /AmFI8FeeE1TTg2SGAzP6qrDDqejZXUWcSIds86ZMkEQdpwzyg2K4Cc+kMUIjGkGfFDi
 1gKAAyMnObim1Vzp8cBs3o667dOJYCsuMtSoeelmb9050ZwCvcYPWWS/k6FIBTPH1qSY
 doEg==
Date: Sat, 22 Oct 2022 16:39:37 +0300
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20221022133937.hfrr7sxaq2zlbnoq@skbuf>
References: <20221021112216.6bw6sjrieh2znlti@skbuf>
 <7bfaae46b1913fe81654a4cd257d98b1@kapio-technology.com>
 <20221021163005.xljk2j3fkikr6uge@skbuf>
 <d1fb07de4b55d64f98425fe66156c4e4@kapio-technology.com>
 <20221021173014.oit3qmpkrsjwzbgu@skbuf>
 <b88e331e016ad3801f1bf1a0dec507f3@kapio-technology.com>
 <20221021181411.sv52q4yxr5r7urab@skbuf>
 <GV1P190MB2019CFA0EB9B5E717F39B621E42C9@GV1P190MB2019.EURP190.PROD.OUTLOOK.COM>
 <20221022113238.beo5zhufl2x645lf@skbuf>
 <GV1P190MB20196AE55C37EB6B88B54CB6E42C9@GV1P190MB2019.EURP190.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <GV1P190MB20196AE55C37EB6B88B54CB6E42C9@GV1P190MB2019.EURP190.PROD.OUTLOOK.COM>
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
To: Oleksandr Mazur <oleksandr.mazur@plvision.eu>
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Nikolay Aleksandrov <razor@blackwall.org>, Kurt Kanzenbach <kurt@linutronix.de>, Eric Dumazet <edumazet@google.com>, "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "netdev@kapio-technology.com" <netdev@kapio-technology.com>, Joachim Wiberg <troglobit@gmail.com>, Shuah Khan <shuah@kernel.org>, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, Ido Schimmel <idosch@nvidia.com>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, Russell King <linux@armlinux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Roopa Prabhu <roopa@nvidia.com>, "kuba@kernel.org" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Vivien Didelot <vivien.didelot@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Landen Chao <Landen.Chao@mediatek.com>, Jiri Pirko <jiri@resnulli.us>, Amit Cohen <amcohen@nvidia.com>, Christian Marangi <ansuelsmth@gmail.com>, Hauke Mehrtens <hauke@hauke-m.de>, Hans Schultz <schultz.hans@gmail.com>, Sean Wang <sean.wang@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, Matthias Brugger <matthias.bgg@gmail.com>, Yuwei Wang <wangyuweihx@gmail.com>, Petr Machata <petrm@nvidia.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Florent Fourcot <florent.fourcot@wifirst.fr>, "UNGLinuxDriver@microchip.com" <UNGLinuxDriver@microchip.com>, "davem@davemloft.net" <davem@davemloft.net>

On Sat, Oct 22, 2022 at 12:55:14PM +0000, Oleksandr Mazur wrote:
> 
> > I hope the following script will exemplify what I mean.
> ..
> Oh, i get it now.
> 
> Frankly speaking we haven't stumbled across such scenario / issue
> before. But i can tell it does indeed seems a bit broken;
> 
> I think there are 2 options here:
>   1. The setup itself seems insecure, and user should be aware of such behavior / issue;

Be aware, and do what? Port locking is unfit for use if learning is left
enabled (in the way learning is currently done).

>   2. Bridge indeed should not learn MACs if BR_PORT_LOCKED is set.
>   E.g. learning condition should be something like: not BR_PORT_locked
>   and learning is on; 

Rather than violate the BR_LEARNING flag (have it set but do nothing,
which would require even more checks in the fast path), I was proposing
to not allow the BR_PORT_LOCKED | BR_LEARNING configuration at all.
My question to you was if you're aware of any regression in prestera
with such a change.

> > I don't understand the last step. Why is the BR_PORT_LOCKED flag disabled?
> > If disabled, the port will receive frames with any unknown MAC SA,
> > not just the authorized ones.
> 
> Sorry for the confusion. Basically, what i described what i would
> expect from a daemon (e.g. daemon would disable LOCKED); So just
> ignore that part.

But still, why would the daemon disable BR_PORT_LOCKED once a station is
authorized? You're describing a sample/test application, not a port
security solution...
