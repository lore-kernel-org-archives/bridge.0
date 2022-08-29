Return-Path: <netdev@kapio-technology.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 443F381407
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 94DCC81406
MIME-Version: 1.0
Date: Mon, 29 Aug 2022 10:04:25 +0200
From: netdev@kapio-technology.com
In-Reply-To: <YwxwPJOx/n5SHZM5@shredder>
References: <20220826114538.705433-1-netdev@kapio-technology.com>
 <20220826114538.705433-2-netdev@kapio-technology.com>
 <Ywo16vHMqxxszWzX@shredder>
 <dd9a4156fe421f6be3a49f5b928ef77e@kapio-technology.com>
 <YwxwPJOx/n5SHZM5@shredder>
Message-ID: <7e4b58a75ece9cce4c841c33d7d66265@kapio-technology.com>
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v5 net-next 1/6] net: bridge: add locked entry
 fdb flag to extend locked port feature
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@nvidia.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Nikolay Aleksandrov <razor@blackwall.org>, Kurt Kanzenbach <kurt@linutronix.de>, Eric Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, bridge@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>, Vivien Didelot <vivien.didelot@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Landen Chao <Landen.Chao@mediatek.com>, Jiri Pirko <jiri@resnulli.us>, Christian Marangi <ansuelsmth@gmail.com>, Hauke Mehrtens <hauke@hauke-m.de>, Sean Wang <sean.wang@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, Yuwei Wang <wangyuweihx@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, Vladimir Oltean <olteanv@gmail.com>, davem@davemloft.net

On 2022-08-29 09:52, Ido Schimmel wrote:
> On Sun, Aug 28, 2022 at 12:23:30PM +0200, netdev@kapio-technology.com 
> wrote:
>> On 2022-08-27 17:19, Ido Schimmel wrote:
>> > On Fri, Aug 26, 2022 at 01:45:33PM +0200, Hans Schultz wrote:
>> > >
>> > >  	nbp_switchdev_frame_mark(p, skb);
>> > > @@ -943,6 +946,10 @@ static int br_setport(struct net_bridge_port
>> > > *p, struct nlattr *tb[],
>> > >  	br_set_port_flag(p, tb, IFLA_BRPORT_NEIGH_SUPPRESS,
>> > > BR_NEIGH_SUPPRESS);
>> > >  	br_set_port_flag(p, tb, IFLA_BRPORT_ISOLATED, BR_ISOLATED);
>> > >  	br_set_port_flag(p, tb, IFLA_BRPORT_LOCKED, BR_PORT_LOCKED);
>> > > +	br_set_port_flag(p, tb, IFLA_BRPORT_MAB, BR_PORT_MAB);
>> > > +
>> > > +	if (!(p->flags & BR_PORT_LOCKED))
>> > > +		p->flags &= ~BR_PORT_MAB;
>> 
>> The reason for this is that I wanted it to be so that if you have MAB
>> enabled (and locked of course) and unlock the port, it will 
>> automatically
>> clear both flags instead of having to first disable MAB and then 
>> unlock the
>> port.
> 
> User space can just do:
> 
> # bridge link set dev swp1 locked off mab off
> 
> I prefer not to push such logic into the kernel and instead fail
> explicitly. I won't argue if more people are in favor.

I shall do it as you suggest. It sounds fair. :-)
