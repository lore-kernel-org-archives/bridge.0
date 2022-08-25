Return-Path: <netdev@kapio-technology.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CAEDA60E46
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B18C760C2C
MIME-Version: 1.0
Date: Thu, 25 Aug 2022 12:27:01 +0200
From: netdev@kapio-technology.com
In-Reply-To: <Ywc/qTNqVbS4E7zS@shredder>
References: <5a4cfc6246f621d006af69d4d1f61ed1@kapio-technology.com>
 <YvkM7UJ0SX+jkts2@shredder>
 <34dd1318a878494e7ab595f8727c7d7d@kapio-technology.com>
 <YwHZ1J9DZW00aJDU@shredder>
 <7016ed2ce9a30537e4278e37878900d8@kapio-technology.com>
 <Ywc/qTNqVbS4E7zS@shredder>
Message-ID: <7dfe15571370dfb5348a3d0e5478f62c@kapio-technology.com>
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

On 2022-08-25 11:23, Ido Schimmel wrote:
>> 
>> 
>> Ido, I am not so known to the selftests, so I am wondering why I don't 
>> see
>> either check_err or check_fail fail, whichever I use, when I think 
>> they
>> should and then they are not really checking...
>> 
>> 
>>         local mac=10:20:30:30:20:10
>> 
>> 
>>         $MZ $h1 -t udp -a $mac -b rand
>>         bridge fdb show dev $swp1 | grep -q "$mac vlan 1 master br0 
>> locked"
>>         check_err $? "MAB station move: no locked entry on first 
>> injection"
>> 
>>         $MZ $h2 -t udp -a $mac -b rand
>>         bridge fdb show dev $swp1 | grep -q "$mac vlan 1 master br0 
>> locked"
>>         check_err $? "MAB station move: locked entry did not move"
>> 
>> What is wrong here?
> 
> Did you try adding a sleep between mausezahn and the FDB dump? At least
> that is what learning_test() is doing. It is possible that the packet 
> is
> not sent / processed fast enough for the bridge to learn it before the
> dump.
> 

I missed the call to log_test at the end of the test.

>> 
>> For a mv88e6xxx test I guess I can make a check to verify that this 
>> driver
>> is in use?
> 
> Not in a generic forwarding test. Maybe in
> tools/testing/selftests/drivers/net/dsa/
> 
> My preference would be to get as much tests as possible in
> tools/testing/selftests/net/forwarding/bridge_locked_port.sh.

I now have a roaming test in 
tools/testing/selftests/net/forwarding/bridge_locked_port.sh, but it 
will not pass with mv88e6xxx as it is meant for the SW bridge.

I can check if the sticky flag is set on the locked entry and then skip 
the test if it is.

The bridge_locked_port.sh test is linked in 
tools/testing/selftests/drivers/net/dsa/, but if I cannot check if the 
mv88e6xxx driver or other switchcores are in use, I cannot do more.

> 
> I'm not sure which tests you are planning for mv88e6xxx, but we can 
> pass
> / fail test cases based on the flags we observe in the FDB dump. For
> example, if the entry has the "sticky" flag, then the expectation is
> that the roaming test will fail. Otherwise, it should pass.
