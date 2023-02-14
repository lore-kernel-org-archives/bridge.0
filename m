Return-Path: <hans@kapio-technology.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 54B7581394
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 11A5481295
From: Hans Schultz <netdev@kapio-technology.com>
In-Reply-To: <Y+EkiAyexZrPoCpP@corigine.com>
References: <20230130173429.3577450-1-netdev@kapio-technology.com>
 <20230130173429.3577450-6-netdev@kapio-technology.com>
 <Y9lkXlyXg1d1D0j3@corigine.com>
 <9b12275969a204739ccfab972d90f20f@kapio-technology.com>
 <Y9zDxlwSn1EfCTba@corigine.com> <20230203204422.4wrhyathxfhj6hdt@skbuf>
 <Y94TebdRQRHMMj/c@corigine.com>
 <4abbe32d007240b9c3aea9c8ca936fa3@kapio-technology.com>
 <Y+EkiAyexZrPoCpP@corigine.com>
Date: Tue, 14 Feb 2023 22:14:55 +0100
Message-ID: <87fsb83q5s.fsf@kapio-technology.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Bridge] [PATCH net-next 5/5] net: dsa: mv88e6xxx:
 implementation of dynamic ATU entries
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Simon Horman <simon.horman@corigine.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Nikolay Aleksandrov <razor@blackwall.org>, Kurt Kanzenbach <kurt@linutronix.de>, Eric Dumazet <edumazet@google.com>, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>, Russell King <linux@armlinux.org.uk>, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>, =?utf-8?Q?Cl=C3=A9ment_L=C3=A9ger?= <clement.leger@bootlin.com>, Christian Marangi <ansuelsmth@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Landen Chao <Landen.Chao@mediatek.com>, Jiri Pirko <jiri@resnulli.us>, Hauke Mehrtens <hauke@hauke-m.de>, Sean Wang <sean.wang@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, "moderated list:ARM/Mediatek SoC
 support" <linux-mediatek@lists.infradead.org>, Matthias Brugger <matthias.bgg@gmail.com>, "moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>, netdev@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, "maintainer:MICROCHIP KSZ SERIES ETHERNET
 SWITCH DRIVER" <UNGLinuxDriver@microchip.com>, "open list:RENESAS RZ/N1
 A5PSW SWITCH DRIVER" <linux-renesas-soc@vger.kernel.org>, Vladimir Oltean <olteanv@gmail.com>, davem@davemloft.net

On Mon, Feb 06, 2023 at 17:02, Simon Horman <simon.horman@corigine.com> wrote:
>
> Just to clarify my suggestion one last time, it would be along the lines
> of the following (completely untested!). I feel that it robustly covers
> all cases for fdb_flags. And as a bonus doesn't need to be modified
> if other (unsupported) flags are added in future.
>
> 	if (fdb_flags & ~(DSA_FDB_FLAG_DYNAMIC))
> 		return -EOPNOTSUPP;
>
> 	is_dynamic = !!(fdb_flags & DSA_FDB_FLAG_DYNAMIC)
> 	if (is_dynamic)
> 		state = MV88E6XXX_G1_ATU_DATA_STATE_UC_AGE_7_NEWEST;
>
>
> And perhaps for other drivers:
>
> 	if (fdb_flags & ~(DSA_FDB_FLAG_DYNAMIC))
> 		return -EOPNOTSUPP;
> 	if (fdb_flags)
> 		return 0;
>
> Perhaps a helper would be warranted for the above.

How would such a helper look? Inline function is not clean.

>
> But in writing this I think that, perhaps drivers could return -EOPNOTSUPP
> for the DSA_FDB_FLAG_DYNAMIC case and the caller can handle, rather tha
> propagate, -EOPNOTSUPP.

I looked at that, but changing the caller is also a bit ugly.

>
> Returning -EOPNOTSUPP is the normal way to drivers to respond to requests
> for unsupported hardware offloads. Sticking to that may be clearner
> in the long run. That said, I do agree your current patch is correct
> given the flag that is defined (by your patchset).
