Return-Path: <olteanv@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BCB82830E2
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 48B4F82D07
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xJswdS7kC+5Dq/oSBvb9hTl0H5TWQ6aU0davE3hjl1Y=;
 b=dvzFO2xkBvm/I20DsGFjUnIHX/SdJqe96jZQplwuGvJpQE4bAzpLO0o/eH7aNuN1tI
 UJcjmOTutwMDaISNJqVGDAnOtGq5GkpDWhHNxclYnyNCg+IdJZLja8Rf55StXWvKatpF
 yKnVmqSOFj+g5UFG75lcNmGxsSmbyHf3MG8LEsvNuYV26gmdyAMDkNCxLEkuM1c+NN+L
 Fa5Qnhk7EKEegtg5NV3PwfHWw5FJPQKv92qfP04bfdV1tdoo6uAuC13WTqfM5Xt3LblO
 BczxEoKr+pCJVLvA1jJ/hm7FlpgtHfG5xa3xhZ3VgL5kca9F+WGw25fyyz++/lAAMFDs
 dXHQ==
Date: Sat, 22 Oct 2022 15:02:00 +0300
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20221022120200.no5pl54bcfa3wcnd@skbuf>
References: <20221020225719.l5iw6vndmm7gvjo3@skbuf>
 <82d23b100b8d2c9e4647b8a134d5cbbf@kapio-technology.com>
 <20221021112216.6bw6sjrieh2znlti@skbuf>
 <7bfaae46b1913fe81654a4cd257d98b1@kapio-technology.com>
 <20221021163005.xljk2j3fkikr6uge@skbuf>
 <d1fb07de4b55d64f98425fe66156c4e4@kapio-technology.com>
 <20221021173014.oit3qmpkrsjwzbgu@skbuf>
 <b88e331e016ad3801f1bf1a0dec507f3@kapio-technology.com>
 <20221021181411.sv52q4yxr5r7urab@skbuf>
 <37dc7673fde2b8e166a5ed78431a2078@kapio-technology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37dc7673fde2b8e166a5ed78431a2078@kapio-technology.com>
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
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Nikolay Aleksandrov <razor@blackwall.org>, Kurt Kanzenbach <kurt@linutronix.de>, Eric Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org, Joachim Wiberg <troglobit@gmail.com>, Shuah Khan <shuah@kernel.org>, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>, Vivien Didelot <vivien.didelot@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Landen Chao <Landen.Chao@mediatek.com>, Jiri Pirko <jiri@resnulli.us>, Amit Cohen <amcohen@nvidia.com>, Christian Marangi <ansuelsmth@gmail.com>, Hauke Mehrtens <hauke@hauke-m.de>, Hans Schultz <schultz.hans@gmail.com>, Sean Wang <sean.wang@mediatek.com>, Oleksandr Mazur <oleksandr.mazur@plvision.eu>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, Yuwei Wang <wangyuweihx@gmail.com>, Petr Machata <petrm@nvidia.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Florent Fourcot <florent.fourcot@wifirst.fr>, UNGLinuxDriver@microchip.com, davem@davemloft.net

On Sat, Oct 22, 2022 at 09:24:56AM +0200, netdev@kapio-technology.com wrote:
> I will not say that you are not making sense as for the mv88e6xxx, as it
> needs port association in all cases with BR_PORT_LOCKED, MAB or not, and
> port association is turned on in the driver with learning turned on.
> 
> That said, there must be some resolution and agreement overall with this
> issue to move on. Right now port association is turned on in the mv88e6xxx
> driver when locking the port, thus setting learning off after locking will
> break things.

This already needs to be treated as a bug and fixed on its own. Forget
about MAB.

You're saying that when BR_LEARNING=on and BR_PORT_LOCKED=on, the
mv88e6xxx driver works properly, but the software bridge is broken
(learns from link-local multicast).

When BR_LEARNING=off and BR_PORT_LOCKED=on, the software bridge is not
broken, but the mv88e6xxx driver is, because it requires the PAV
configured properly.

And you're saying that I'm the one who suggests things should work
differently in software mode vs offloaded mode?!

Why don't you
(a) deny BR_LEARNING + BR_PORT_LOCKED in the bridge layer
(b) fix the mv88e6xxx driver to always keep the assoc_vector set
    properly for the port, if BR_LEARNING *or* BR_PORT_LOCKED is set?
