Return-Path: <netdev@kapio-technology.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1FAF560E30
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0567360B09
MIME-Version: 1.0
Date: Sun, 22 Jan 2023 12:08:42 +0100
From: netdev@kapio-technology.com
In-Reply-To: <20230118230135.szu6a7kvt2mjb3i5@skbuf>
References: <20230117185714.3058453-1-netdev@kapio-technology.com>
 <20230117185714.3058453-3-netdev@kapio-technology.com>
 <20230117231750.r5jr4hwvpadgopmf@skbuf>
 <e4acb7edb300d41a9459890133b928b4@kapio-technology.com>
 <20230118230135.szu6a7kvt2mjb3i5@skbuf>
Message-ID: <746b27d5f83b95f17eca18e22843951a@kapio-technology.com>
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [RFC PATCH net-next 2/5] net: dsa: propagate flags
 down towards drivers
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Nikolay Aleksandrov <razor@blackwall.org>, Kurt Kanzenbach <kurt@linutronix.de>, Eric Dumazet <edumazet@google.com>, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>, Russell King <linux@armlinux.org.uk>, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>, =?UTF-8?Q?Cl=C3=A9ment_L=C3=A9ger?= <clement.leger@bootlin.com>, Christian Marangi <ansuelsmth@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Landen Chao <Landen.Chao@mediatek.com>, Jiri Pirko <jiri@resnulli.us>, Hauke Mehrtens <hauke@hauke-m.de>, Sean Wang <sean.wang@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, "moderated list:ARM/Mediatek SoC
 support" <linux-mediatek@lists.infradead.org>, Matthias Brugger <matthias.bgg@gmail.com>, "moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>, netdev@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, "maintainer:MICROCHIP KSZ SERIES ETHERNET
 SWITCH DRIVER" <UNGLinuxDriver@microchip.com>, "open list:RENESAS RZ/N1
 A5PSW SWITCH DRIVER" <linux-renesas-soc@vger.kernel.org>, davem@davemloft.net

On 2023-01-19 00:01, Vladimir Oltean wrote:
> On Wed, Jan 18, 2023 at 11:35:08PM +0100, netdev@kapio-technology.com 
> wrote:

>> When the new dynamic flag is true, all drivers will ignore it in patch 
>> #3,
>> so basically nothing will change by that.
> 
> This is not true, because it assumes that DSA never called 
> port_fdb_add()
> up until now for bridge FDB entries with the BR_FDB_STATIC flag unset,
> which is incorrect (it did).
> 
> So what will change is that drivers which used to react to those bridge
> FDB entries will stop doing so.
> 

So the solution to this problem could be to only set the is_dyn flag in 
combination with the added_by_user flag. So an 'and' operation with the 
two in br_switchdev_fdb_populate()?
