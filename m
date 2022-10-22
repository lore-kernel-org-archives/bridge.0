Return-Path: <oleksandr.mazur@plvision.eu>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A9C3860A81
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9186E60A7B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tvmbch68C+3zASsIKbsejJsxYG+EONBUWTShZwaaSFI=;
 b=rONYCLZ107uM1AQG4yw7/06z92HLAObMjDTRoyCJmloEmXIXiNYsRnMPiJuCMYeIMFsfsji1lBq/pJHMSSCLZbsKsWJLPIckmBvgDIinnrqcqK24Fzg7L6s61fSweL+SG6Nor457FplXUmiCa7hCqUjk02zk6FZBQf8J/XfzZR4=
From: Oleksandr Mazur <oleksandr.mazur@plvision.eu>
Date: Sat, 22 Oct 2022 12:55:14 +0000
Message-ID: <GV1P190MB20196AE55C37EB6B88B54CB6E42C9@GV1P190MB2019.EURP190.PROD.OUTLOOK.COM>
References: <20221020225719.l5iw6vndmm7gvjo3@skbuf>
 <82d23b100b8d2c9e4647b8a134d5cbbf@kapio-technology.com>
 <20221021112216.6bw6sjrieh2znlti@skbuf>
 <7bfaae46b1913fe81654a4cd257d98b1@kapio-technology.com>
 <20221021163005.xljk2j3fkikr6uge@skbuf>
 <d1fb07de4b55d64f98425fe66156c4e4@kapio-technology.com>
 <20221021173014.oit3qmpkrsjwzbgu@skbuf>
 <b88e331e016ad3801f1bf1a0dec507f3@kapio-technology.com>
 <20221021181411.sv52q4yxr5r7urab@skbuf>
 <GV1P190MB2019CFA0EB9B5E717F39B621E42C9@GV1P190MB2019.EURP190.PROD.OUTLOOK.COM>
 <20221022113238.beo5zhufl2x645lf@skbuf>
In-Reply-To: <20221022113238.beo5zhufl2x645lf@skbuf>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Nikolay Aleksandrov <razor@blackwall.org>, Kurt Kanzenbach <kurt@linutronix.de>, Eric Dumazet <edumazet@google.com>, "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "netdev@kapio-technology.com" <netdev@kapio-technology.com>, Joachim Wiberg <troglobit@gmail.com>, Shuah Khan <shuah@kernel.org>, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, Ido Schimmel <idosch@nvidia.com>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, Russell King <linux@armlinux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Roopa Prabhu <roopa@nvidia.com>, "kuba@kernel.org" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Vivien Didelot <vivien.didelot@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Landen Chao <Landen.Chao@mediatek.com>, Jiri Pirko <jiri@resnulli.us>, Amit Cohen <amcohen@nvidia.com>, Christian Marangi <ansuelsmth@gmail.com>, Hauke Mehrtens <hauke@hauke-m.de>, Hans Schultz <schultz.hans@gmail.com>, Sean Wang <sean.wang@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, Matthias Brugger <matthias.bgg@gmail.com>, Yuwei Wang <wangyuweihx@gmail.com>, Petr Machata <petrm@nvidia.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Florent Fourcot <florent.fourcot@wifirst.fr>, "UNGLinuxDriver@microchip.com" <UNGLinuxDriver@microchip.com>, "davem@davemloft.net" <davem@davemloft.net>

=0A=
> I hope the following script will exemplify what I mean.=0A=
..=0A=
Oh, i get it now.=0A=
=0A=
Frankly speaking we haven't stumbled across such scenario / issue before. B=
ut i can tell it does indeed seems a bit broken;=0A=
=0A=
I think there are 2 options here:=0A=
  1. The setup itself seems insecure, and user should be aware of such beha=
vior / issue;=0A=
  2. Bridge indeed should not learn MACs if BR_PORT_LOCKED is set. E.g. lea=
rning condition should be something like: not BR_PORT_locked and learning i=
s on; =0A=
=0A=
=0A=
> I don't understand the last step. Why is the BR_PORT_LOCKED flag disabled=
?=0A=
> If disabled, the port will receive frames with any unknown MAC SA,=0A=
> not just the authorized ones.=0A=
=0A=
Sorry for the confusion. Basically, what i described what i would expect fr=
om a daemon (e.g. daemon would disable LOCKED); So just ignore that part.=
