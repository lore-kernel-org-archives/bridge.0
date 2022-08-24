Return-Path: <netdev@kapio-technology.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8B7FB417C3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8332F417B8
MIME-Version: 1.0
Date: Wed, 24 Aug 2022 22:29:20 +0200
From: netdev@kapio-technology.com
In-Reply-To: <YwHZ1J9DZW00aJDU@shredder>
References: <5a4cfc6246f621d006af69d4d1f61ed1@kapio-technology.com>
 <YvkM7UJ0SX+jkts2@shredder>
 <34dd1318a878494e7ab595f8727c7d7d@kapio-technology.com>
 <YwHZ1J9DZW00aJDU@shredder>
Message-ID: <7016ed2ce9a30537e4278e37878900d8@kapio-technology.com>
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v4 net-next 3/6] drivers: net: dsa: add locked
 fdb entry flag to drivers
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@nvidia.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Vivien Didelot <vivien.didelot@gmail.com>, Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, linux-kselftest@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Vladimir Oltean <olteanv@gmail.com>, Shuah Khan <shuah@kernel.org>, davem@davemloft.net

On 2022-08-21 09:08, Ido Schimmel wrote:
> 
> I assume you want a hub to simulate multiple MACs behind the same port.
> You don't need a hub for that. You can set the MAC using mausezahn. See
> '-a' option:
> 
> "
>    -a <src-mac|keyword>
>        Use specified source MAC address with hexadecimal notation such
> as 00:00:aa:bb:cc:dd.  By default the interface MAC address will be
> used. The  keywords  ''rand''
>        and  ''own''  refer to a random MAC address (only unicast
> addresses are created) and the own address, respectively. You can also
> use the keywords mentioned below
>        although broadcast-type source addresses are officially invalid.
> "
> 


Ido, I am not so known to the selftests, so I am wondering why I don't 
see either check_err or check_fail fail, whichever I use, when I think 
they should and then they are not really checking...


         local mac=10:20:30:30:20:10


         $MZ $h1 -t udp -a $mac -b rand
         bridge fdb show dev $swp1 | grep -q "$mac vlan 1 master br0 
locked"
         check_err $? "MAB station move: no locked entry on first 
injection"

         $MZ $h2 -t udp -a $mac -b rand
         bridge fdb show dev $swp1 | grep -q "$mac vlan 1 master br0 
locked"
         check_err $? "MAB station move: locked entry did not move"

What is wrong here?

For a mv88e6xxx test I guess I can make a check to verify that this 
driver is in use?
