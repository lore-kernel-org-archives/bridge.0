Return-Path: <netdev@kapio-technology.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E78BD40543
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2F91B40534
MIME-Version: 1.0
Date: Sun, 28 Aug 2022 14:00:29 +0200
From: netdev@kapio-technology.com
In-Reply-To: <YwpgvkojEdytzCAB@shredder>
References: <20220826114538.705433-1-netdev@kapio-technology.com>
 <20220826114538.705433-7-netdev@kapio-technology.com>
 <YwpgvkojEdytzCAB@shredder>
Message-ID: <7654860e4d7d43c15d482c6caeb6a773@kapio-technology.com>
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
>> +locked_port_mab()
>> +{
>> +	RET=0
>> +	check_locked_port_support || return 0
>> +
>> +	ping_do $h1 192.0.2.2
>> +	check_err $? "MAB: Ping did not work before locking port"
>> +
>> +	bridge link set dev $swp1 locked on
>> +	bridge link set dev $swp1 learning on
> 
> "locked on learning on" is counter intuitive and IMO very much a
> misconfiguration that we should have disallowed when the "locked" 
> option
> was introduced. It is my understanding that the only reason we are even
> talking about it is because mv88e6xxx needs it for MAB for some reason.

As the way mv88e6xxx implements "learning off" is to remove port 
association for ingress packets on a port, but that breaks many other 
things such as refreshing ATU entries and violation interrupts, so it is 
needed and the question is then what is the worst to have 'learning on' 
on a locked port or to have the locked port enabling learning in the 
driver silently?

Opinions seem to differ. Note that even on locked ports without MAB, 
port association on ingress is still needed in future as I have a 
dynamic ATU patch set coming, that uses age out violation and hardware 
refreshing to let the hardware keep the dynamic entries as long as the 
authorized station is sending, but will age the entry out if the station 
keeps silent for the ageing time. But that patch set is dependent on 
this patch set, and I don't think I can send it before this is 
accepted...

> Please avoid leaking this implementation detail to user space and
> instead use the "MAB" flag to enable learning if you need it in
> mv88e6xxx.
> 
