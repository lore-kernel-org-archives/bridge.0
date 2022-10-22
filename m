Return-Path: <oleksandr.mazur@plvision.eu>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2A0F6416F3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F2E13416E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=giJfGDLtqc2o+ahaFbLTwbplaYbC2dMlAFVID8Z/3bM=;
 b=MOfwVinifEVmZswwTgK3Pa7RpL0XlfvYBZmiFoAZ1hEfQOFZgIQxUYrLob1/iBo4oyMqtd9ZrJETPynOszbhXRKf1zT+793p2UwiYkIdgREzA81B5gZM/6aJA00Fwdr0RsJWl7a+M4A3WuB9TQcmo3gmcK/TIWgMVTL3KeQvzF8=
From: Oleksandr Mazur <oleksandr.mazur@plvision.eu>
Date: Sat, 22 Oct 2022 08:50:20 +0000
Message-ID: <GV1P190MB2019CFA0EB9B5E717F39B621E42C9@GV1P190MB2019.EURP190.PROD.OUTLOOK.COM>
References: <20221020132538.reirrskemcjwih2m@skbuf>
 <2565c09bb95d69142522c3c3bcaa599e@kapio-technology.com>
 <20221020225719.l5iw6vndmm7gvjo3@skbuf>
 <82d23b100b8d2c9e4647b8a134d5cbbf@kapio-technology.com>
 <20221021112216.6bw6sjrieh2znlti@skbuf>
 <7bfaae46b1913fe81654a4cd257d98b1@kapio-technology.com>
 <20221021163005.xljk2j3fkikr6uge@skbuf>
 <d1fb07de4b55d64f98425fe66156c4e4@kapio-technology.com>
 <20221021173014.oit3qmpkrsjwzbgu@skbuf>
 <b88e331e016ad3801f1bf1a0dec507f3@kapio-technology.com>
 <20221021181411.sv52q4yxr5r7urab@skbuf>
In-Reply-To: <20221021181411.sv52q4yxr5r7urab@skbuf>
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
To: Vladimir Oltean <olteanv@gmail.com>, "netdev@kapio-technology.com" <netdev@kapio-technology.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Nikolay Aleksandrov <razor@blackwall.org>, Kurt Kanzenbach <kurt@linutronix.de>, Eric Dumazet <edumazet@google.com>, "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, Joachim Wiberg <troglobit@gmail.com>, Shuah Khan <shuah@kernel.org>, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, Ido Schimmel <idosch@nvidia.com>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, Russell King <linux@armlinux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Roopa Prabhu <roopa@nvidia.com>, "kuba@kernel.org" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Vivien Didelot <vivien.didelot@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Landen Chao <Landen.Chao@mediatek.com>, Jiri Pirko <jiri@resnulli.us>, Amit Cohen <amcohen@nvidia.com>, Christian Marangi <ansuelsmth@gmail.com>, Hauke Mehrtens <hauke@hauke-m.de>, Hans Schultz <schultz.hans@gmail.com>, Sean Wang <sean.wang@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, Matthias Brugger <matthias.bgg@gmail.com>, Yuwei Wang <wangyuweihx@gmail.com>, Petr Machata <petrm@nvidia.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Florent Fourcot <florent.fourcot@wifirst.fr>, "UNGLinuxDriver@microchip.com" <UNGLinuxDriver@microchip.com>, "davem@davemloft.net" <davem@davemloft.net>

=0A=
On Fri, Oct 21, 2022 at 07:39:34PM +0200, netdev@kapio-technology.com wrote=
:=0A=
>> Well, with this change, to have MAB working, the bridge would need learn=
ing on=0A=
>> of course, but how things work with the bridge according to the flags, t=
hey=0A=
>> should also work in the offloaded case if you ask me. There should be no=
=0A=
>> difference between the two, thus MAB in drivers would have to be with=0A=
>> learning on.=0A=
=0A=
>Am I proposing for things to work differently in the offload and=0A=
>software case, and not realizing it? :-/=0A=
=0A=
>The essence of my proposal was to send a bug fix now which denies=0A=
>BR_LEARNING to be set together with BR_PORT_LOCKED. The fact that=0A=
>link-local traffic is learned by the software bridge is something=0A=
>unintended as far as I understand.=0A=
=0A=
>You tried to fix it here, and as far as I could search in my inbox, that=
=0A=
>didn't go anywhere:=0A=
>https://lore.kernel.org/netdev/47d8d747-54ef-df52-3b9c-acb9a77fa14a@blackw=
all.org/T/#u=0A=
=0A=
>I thought only mv88e6xxx offloads BR_PORT_LOCKED, but now, after=0A=
>searching, I also see prestera has support for it, so let me add=0A=
>Oleksandr Mazur to the discussion as well. I wonder how they deal with=0A=
>this? Has somebody come to rely on learning being enabled on a locked=0A=
>port?=0A=
=0A=
Hello,=0A=
=0A=
>The fact that=0A=
>link-local traffic is learned by the software bridge is something=0A=
>unintended as far as I understand.=0A=
=0A=
In prestera driver, if port is in blocked state only the PAE frames can be =
trapped, so i'm not sure where other traffic might come from that you are t=
alking. Or maybe i didn't get the issue here right, sorry?=0A=
=0A=
Also, basically, prestera driver does not rely on the learning flag if the =
port's flag BR_PORT_LOCKED is set. What this means, is that we discard any =
learning changes on the port if LOCKED is still set (done inside firmware, =
if i recall correctly). E.g. learning is always off, if port is in BR_PORT_=
LOCKED state, or in a block state but also has a static fdb entry (aka mac-=
auth entry).=0A=
=0A=
The concept we follow is basically:=0A=
  - some userspace daemon blocks the port;=0A=
  - speaks with the <auth-center> (PAE traffic);=0A=
  - the daemon itself populates the FDB with authenticated MACs (adding sta=
tic FDB MACs);=0A=
  - forces learning flag disable, disables the PORT_LOCKED flag. At this po=
int switch can basically receive only the traffic from authorized addresses=
 (fdb still has static entries; learning disabled).=0A=
=0A=
Hope that helps.=0A=
Cheers.=
