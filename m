Return-Path: <netdev@kapio-technology.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2A87E4010E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 26EED403A2
MIME-Version: 1.0
Date: Sat, 08 Oct 2022 13:34:16 +0200
From: netdev@kapio-technology.com
In-Reply-To: <YzrmaixRZ3k/alPh@shredder>
References: <20220928150256.115248-1-netdev@kapio-technology.com>
 <20220928150256.115248-10-netdev@kapio-technology.com>
 <YzrmaixRZ3k/alPh@shredder>
Message-ID: <c25d21e4f3a8d825a4ceb3069b05c6d9@kapio-technology.com>
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v6 net-next 9/9] selftests: forwarding: add
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
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Nikolay Aleksandrov <razor@blackwall.org>, Kurt Kanzenbach <kurt@linutronix.de>, Eric Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org, Joachim Wiberg <troglobit@gmail.com>, Shuah Khan <shuah@kernel.org>, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, Florent Fourcot <florent.fourcot@wifirst.fr>, bridge@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>, Vivien Didelot <vivien.didelot@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Landen Chao <Landen.Chao@mediatek.com>, Jiri Pirko <jiri@resnulli.us>, Amit Cohen <amcohen@nvidia.com>, Christian Marangi <ansuelsmth@gmail.com>, Hauke Mehrtens <hauke@hauke-m.de>, Hans Schultz <schultz.hans@gmail.com>, Sean Wang <sean.wang@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, Yuwei Wang <wangyuweihx@gmail.com>, Petr Machata <petrm@nvidia.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, Vladimir Oltean <olteanv@gmail.com>, davem@davemloft.net

On 2022-10-03 15:40, Ido Schimmel wrote:
>> +locked_port_station_move()
>> +{
>> +	local mac=a0:b0:c0:c0:b0:a0
>> +
>> +	RET=0
>> +	check_locked_port_support || return 0
>> +
>> +	bridge link set dev $swp1 locked on
> 
> It is quite pointless to check that an entry cannot roam to a port that
> has learning disabled... Need:
> 
> bridge link set dev $swp1 locked on learning on
> 
>> +
>> +	$MZ $h1 -q -t udp -a $mac -b rand
>> +	bridge fdb show dev $swp1 | grep "$mac vlan 1" | grep -q "master 
>> br0"
> 
> bridge fdb get ...
> 
> Same in other places
> 

It seems that the output of 'bridge fdb get' does not respect the dev it 
is given as input and outputs the (MAC,vlan) when found on another 
dev...
