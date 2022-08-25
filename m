Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 992E661047
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3F14F60E36
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+2DNsbfIJrNbp61vIf1+hTet7jNQs1B8avgYMskci7s=;
 b=KKGOTphDMoOP/eK6gSicAnHHMIqRfhXUTns9PTW8E/TJTSw1AIRh6LKU25v36L6sfNBI4V2yo+ua22cosgJ4a9P4AGoCNB+pct7g/O0og4lscfWJy/0VU35UMajv0Sse7WHzDmaR8Os+PxyuKit5Koa+NWAfU+xW7xXg8MDUchB69eLO3SntOVC9xloNIjzG/sRZ/Kpw6QoY+bkxtFOpz6ZZFnnwhdQp07NDUwU2rXSMUN3QHggCWzfdceuOgm9iPqXbr9NOFkHNYEWrPqq3hOjcJGkdYexV71Lw7cseFPrFVesYanHAdDOk7aOCC1xzqeiwHk38LS8Y3tUiyrWwAg==
Date: Thu, 25 Aug 2022 12:23:53 +0300
From: Ido Schimmel <idosch@nvidia.com>
Message-ID: <Ywc/qTNqVbS4E7zS@shredder>
References: <5a4cfc6246f621d006af69d4d1f61ed1@kapio-technology.com>
 <YvkM7UJ0SX+jkts2@shredder>
 <34dd1318a878494e7ab595f8727c7d7d@kapio-technology.com>
 <YwHZ1J9DZW00aJDU@shredder>
 <7016ed2ce9a30537e4278e37878900d8@kapio-technology.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7016ed2ce9a30537e4278e37878900d8@kapio-technology.com>
MIME-Version: 1.0
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
To: netdev@kapio-technology.com
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Vivien Didelot <vivien.didelot@gmail.com>, Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, linux-kselftest@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Vladimir Oltean <olteanv@gmail.com>, Shuah Khan <shuah@kernel.org>, davem@davemloft.net

On Wed, Aug 24, 2022 at 10:29:20PM +0200, netdev@kapio-technology.com wrote:
> On 2022-08-21 09:08, Ido Schimmel wrote:
> > 
> > I assume you want a hub to simulate multiple MACs behind the same port.
> > You don't need a hub for that. You can set the MAC using mausezahn. See
> > '-a' option:
> > 
> > "
> >    -a <src-mac|keyword>
> >        Use specified source MAC address with hexadecimal notation such
> > as 00:00:aa:bb:cc:dd.  By default the interface MAC address will be
> > used. The  keywords  ''rand''
> >        and  ''own''  refer to a random MAC address (only unicast
> > addresses are created) and the own address, respectively. You can also
> > use the keywords mentioned below
> >        although broadcast-type source addresses are officially invalid.
> > "
> > 
> 
> 
> Ido, I am not so known to the selftests, so I am wondering why I don't see
> either check_err or check_fail fail, whichever I use, when I think they
> should and then they are not really checking...
> 
> 
>         local mac=10:20:30:30:20:10
> 
> 
>         $MZ $h1 -t udp -a $mac -b rand
>         bridge fdb show dev $swp1 | grep -q "$mac vlan 1 master br0 locked"
>         check_err $? "MAB station move: no locked entry on first injection"
> 
>         $MZ $h2 -t udp -a $mac -b rand
>         bridge fdb show dev $swp1 | grep -q "$mac vlan 1 master br0 locked"
>         check_err $? "MAB station move: locked entry did not move"
> 
> What is wrong here?

Did you try adding a sleep between mausezahn and the FDB dump? At least
that is what learning_test() is doing. It is possible that the packet is
not sent / processed fast enough for the bridge to learn it before the
dump.

> 
> For a mv88e6xxx test I guess I can make a check to verify that this driver
> is in use?

Not in a generic forwarding test. Maybe in
tools/testing/selftests/drivers/net/dsa/

My preference would be to get as much tests as possible in
tools/testing/selftests/net/forwarding/bridge_locked_port.sh.

I'm not sure which tests you are planning for mv88e6xxx, but we can pass
/ fail test cases based on the flags we observe in the FDB dump. For
example, if the entry has the "sticky" flag, then the expectation is
that the roaming test will fail. Otherwise, it should pass.
