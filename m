Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 696F7615A4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8AAB461599
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+5Ce3dsplq5E+KC2YuITorNi4q0ZqK+gZ6XyNtH+Gs=;
 b=dHAGnbvQIkUnmQRPQSiJyYQiDtuOYPl8GdjgbrAZXTtstAU7KsMd7j6eAU92i3djxs0lAca92Ddb48ztrluW01v/4XIYbZ1kMi2TGqFv/Pdj6U9/Rp6ahsNW8zNuTBD77r37GFPpNSEgtxj49+aI67PdQY1+mFLKg9VTL/c4P9DzsB1pUN4d6Gam1cNgDHSxraw7h6GfPIhwa7kLAJ20EgzbO7ndAY6XEfgRLvtNrtViZT1/u/SYf6lLysrknfSDYEERV4SYmQmg1kzrdGECYCJSFS5JFbdB2AeCxFQHCrTfJKqeblSSgPpN5Jwy2Cg4l0pLgIZjtarHXy6FutMFjg==
Date: Thu, 30 Mar 2023 09:37:38 +0300
From: Ido Schimmel <idosch@nvidia.com>
Message-ID: <ZCUuMosWbyq1pK8R@shredder>
References: <20230318141010.513424-1-netdev@kapio-technology.com>
 <20230318141010.513424-7-netdev@kapio-technology.com>
 <ZBgdAo8mxwnl+pEE@shredder> <87a5zzh65p.fsf@kapio-technology.com>
 <ZCMYbRqd+qZaiHfu@shredder> <87fs9ollmn.fsf@kapio-technology.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fs9ollmn.fsf@kapio-technology.com>
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH v2 net-next 6/6] selftests: forwarding: add
 dynamic FDB test
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Hans Schultz <netdev@kapio-technology.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Nikolay Aleksandrov <razor@blackwall.org>, Kurt Kanzenbach <kurt@linutronix.de>, Eric Dumazet <edumazet@google.com>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>, =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>, Christian Marangi <ansuelsmth@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Landen Chao <Landen.Chao@mediatek.com>, Jiri Pirko <jiri@resnulli.us>, Hauke Mehrtens <hauke@hauke-m.de>, Sean Wang <sean.wang@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>, Matthias Brugger <matthias.bgg@gmail.com>, "moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, netdev@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, "maintainer:MICROCHIP KSZ SERIES ETHERNET SWITCH DRIVER" <UNGLinuxDriver@microchip.com>, "open list:RENESAS RZ/N1 A5PSW SWITCH DRIVER" <linux-renesas-soc@vger.kernel.org>, Vladimir Oltean <olteanv@gmail.com>, davem@davemloft.net

On Tue, Mar 28, 2023 at 09:30:08PM +0200, Hans Schultz wrote:
> On Tue, Mar 28, 2023 at 19:40, Ido Schimmel <idosch@nvidia.com> wrote:
> > On Sun, Mar 26, 2023 at 05:41:06PM +0200, Hans Schultz wrote:
> >> On Mon, Mar 20, 2023 at 10:44, Ido Schimmel <idosch@nvidia.com> wrote:
> >> >> +	$MZ $swp1 -c 1 -p 128 -t udp "sp=54321,dp=12345" \
> >> >> +		-a $mac -b `mac_get $h2` -A 192.0.2.1 -B 192.0.2.2 -q
> >> >> +	tc_check_packets "dev $swp2 egress" 1 1
> >> >> +	check_fail $? "Dynamic FDB entry did not age out"
> >> >
> >> > Shouldn't this be check_err()? After the FDB entry was aged you want to
> >> > make sure that packets received via $swp1 with SMAC being $mac are no
> >> > longer forwarded by the bridge.
> >> 
> >> I was thinking that check_fail() will pass when tc_check_packets() does
> >> not see any packets, thus the test passing here when no packets are forwarded?
> >
> > What do you mean by "I was *thinking*"? How is it possible that you are
> > submitting a selftest that you didn't bother running?!
> >
> 
> Sorry, but I have sent you several emails telling you about the problems
> I have with running the selftests due to changes in the phy etc. Maybe
> you have just not received all those emails?
> 
> Have you checked spamfilters?
> 
> With the kernels now, I cannot even test with the software bridge and
> selftests as the compile fails - probably due to changes in uapi headers
> compared to what the packages my system uses expects.

My spam filters are fine. I saw your emails where you basically said
that you are too lazy to setup a VM to test your patches and that your
time is more valuable than mine, which is why I should be testing them.
Stop making your problems our problems. It's hardly the first time. If
you are unable to test your patches, then invest the time in fixing your
setup instead of submitting completely broken patches and making it our
problem to test and fix them. I refuse to invest time in reviewing /
testing / reworking your submissions as long as you insist on doing less
than the bare minimum.

Good luck
