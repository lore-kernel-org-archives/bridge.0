Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 078B983E19
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E1CF681CC3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C3VAm/HXAxjFwtdRn3M0NwG59vZPWh838PZ/yDFuNLg=;
 b=jRO20h/g/VejN6xrIvmfmhkiKrPVCxK5aBQKCqgFouq+efO5Z7Zd2vTAhTtBftCLt3jFUS/xrAMhcMezZn9cR6PXiD/Ksx652nL86p3wSyqAhAFr5GBeYz/ZlrOB7u8780Ta1YYSIK0l3CgzqjGBZeqZLvZoDz3LkNEYCplQvQXl/emn+VngkgS5PbjGcosmZhiRyR4EuZ7ZvMIjjTUgZ6uN4WaA2rCSfVbkYa/AwHK9Lcm33iyfoq1jDdbDQzFIN3Ti3BHtq+J9x28g5GkFrpZWW4pxkJQlk1fhOXOGmJofAJ496CDarXr3QHrTsuyBqo4cFLI2GlGaZqtrMf74sA==
Date: Thu, 25 Aug 2022 14:58:19 +0300
From: Ido Schimmel <idosch@nvidia.com>
Message-ID: <Ywdj2+mIQFR6+drZ@shredder>
References: <5a4cfc6246f621d006af69d4d1f61ed1@kapio-technology.com>
 <YvkM7UJ0SX+jkts2@shredder>
 <34dd1318a878494e7ab595f8727c7d7d@kapio-technology.com>
 <YwHZ1J9DZW00aJDU@shredder>
 <7016ed2ce9a30537e4278e37878900d8@kapio-technology.com>
 <Ywc/qTNqVbS4E7zS@shredder>
 <7dfe15571370dfb5348a3d0e5478f62c@kapio-technology.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7dfe15571370dfb5348a3d0e5478f62c@kapio-technology.com>
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

On Thu, Aug 25, 2022 at 12:27:01PM +0200, netdev@kapio-technology.com wrote:
> On 2022-08-25 11:23, Ido Schimmel wrote:
> > > 
> > > 
> > > Ido, I am not so known to the selftests, so I am wondering why I
> > > don't see
> > > either check_err or check_fail fail, whichever I use, when I think
> > > they
> > > should and then they are not really checking...
> > > 
> > > 
> > >         local mac=10:20:30:30:20:10
> > > 
> > > 
> > >         $MZ $h1 -t udp -a $mac -b rand
> > >         bridge fdb show dev $swp1 | grep -q "$mac vlan 1 master br0
> > > locked"
> > >         check_err $? "MAB station move: no locked entry on first
> > > injection"
> > > 
> > >         $MZ $h2 -t udp -a $mac -b rand
> > >         bridge fdb show dev $swp1 | grep -q "$mac vlan 1 master br0
> > > locked"
> > >         check_err $? "MAB station move: locked entry did not move"
> > > 
> > > What is wrong here?
> > 
> > Did you try adding a sleep between mausezahn and the FDB dump? At least
> > that is what learning_test() is doing. It is possible that the packet is
> > not sent / processed fast enough for the bridge to learn it before the
> > dump.
> > 
> 
> I missed the call to log_test at the end of the test.
> 
> > > 
> > > For a mv88e6xxx test I guess I can make a check to verify that this
> > > driver
> > > is in use?
> > 
> > Not in a generic forwarding test. Maybe in
> > tools/testing/selftests/drivers/net/dsa/
> > 
> > My preference would be to get as much tests as possible in
> > tools/testing/selftests/net/forwarding/bridge_locked_port.sh.
> 
> I now have a roaming test in
> tools/testing/selftests/net/forwarding/bridge_locked_port.sh, but it will
> not pass with mv88e6xxx as it is meant for the SW bridge.
> 
> I can check if the sticky flag is set on the locked entry and then skip the
> test if it is.

Instead of skipping it you can check that roaming fails when "sticky" is
set.

> 
> The bridge_locked_port.sh test is linked in
> tools/testing/selftests/drivers/net/dsa/, but if I cannot check if the
> mv88e6xxx driver or other switchcores are in use, I cannot do more.

Since the behavior of the HW data path is reflected to the software
bridge and user space via "sticky" / "blackhole" / "extern_learn", you
should be able to add test cases to the generic selftest. For example,
if "blackhole" is set, then simple ping is expected to fail. Otherwise
it is expected to pass.
