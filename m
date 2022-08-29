Return-Path: <netdev@kapio-technology.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2C1E0813C2
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6A6A8813B7
MIME-Version: 1.0
Date: Mon, 29 Aug 2022 18:07:59 +0200
From: netdev@kapio-technology.com
In-Reply-To: <YwpgvkojEdytzCAB@shredder>
References: <20220826114538.705433-1-netdev@kapio-technology.com>
 <20220826114538.705433-7-netdev@kapio-technology.com>
 <YwpgvkojEdytzCAB@shredder>
Message-ID: <b28717f593461865bbfa6bf12e99a2a1@kapio-technology.com>
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v5 net-next 6/6] selftests: forwarding: add
 test of MAC-Auth Bypass to locked port tests
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

On 2022-08-27 20:21, Ido Schimmel wrote:
> On Fri, Aug 26, 2022 at 01:45:38PM +0200, Hans Schultz wrote:

>> +	$MZ $h2 -q -t udp -a $mac -b rand
>> +	bridge fdb show dev $swp2 | grep -q "$mac vlan 1 master br0"
>> +	check_err $? "Locked port station move: Entry not found on unlocked 
>> port"
> 
> Looks like this is going to fail with offloaded data path as according
> to fdb_print_flags() in iproute2 both the "extern_learn" and "offload"
> flags will be printed before "master".
> 

The output shows like:
74:e1:e1:2c:4f:18 dev eth8 vlan 1 master br0 extern_learn offload sticky 
locked blackhole

"sticky" will of course become "permanent", but I can still make it more 
resilient by piping grep.

I suppose that I will keep the "sticky_no_roaming" test even though it 
is not really needed here anymore?
