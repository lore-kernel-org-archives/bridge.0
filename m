Return-Path: <netdev@kapio-technology.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D68CB418A7
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 88EBE418C0
MIME-Version: 1.0
Date: Thu, 25 Aug 2022 15:41:49 +0200
From: netdev@kapio-technology.com
In-Reply-To: <Ywdj2+mIQFR6+drZ@shredder>
References: <5a4cfc6246f621d006af69d4d1f61ed1@kapio-technology.com>
 <YvkM7UJ0SX+jkts2@shredder>
 <34dd1318a878494e7ab595f8727c7d7d@kapio-technology.com>
 <YwHZ1J9DZW00aJDU@shredder>
 <7016ed2ce9a30537e4278e37878900d8@kapio-technology.com>
 <Ywc/qTNqVbS4E7zS@shredder>
 <7dfe15571370dfb5348a3d0e5478f62c@kapio-technology.com>
 <Ywdj2+mIQFR6+drZ@shredder>
Message-ID: <6fa538a1489a73fdf8b1fa92785185aa@kapio-technology.com>
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

On 2022-08-25 13:58, Ido Schimmel wrote:
> On Thu, Aug 25, 2022 at 12:27:01PM +0200, netdev@kapio-technology.com 
> wrote:
> 
> Instead of skipping it you can check that roaming fails when "sticky" 
> is
> set.
> 

I think that the sticky flag topic generally is beyond the MAB feature, 
and it doesn't really fit into the bridge_locked_port.sh.
But anyhow I guess I can add it to the bridge_sticky_fdb.sh tests.

>> 
>> The bridge_locked_port.sh test is linked in
>> tools/testing/selftests/drivers/net/dsa/, but if I cannot check if the
>> mv88e6xxx driver or other switchcores are in use, I cannot do more.
> 
> Since the behavior of the HW data path is reflected to the software
> bridge and user space via "sticky" / "blackhole" / "extern_learn", you
> should be able to add test cases to the generic selftest. For example,
> if "blackhole" is set, then simple ping is expected to fail. Otherwise
> it is expected to pass.

The problem here is that the "blackhole" flag can only be set now from 
the mv88e6xxx driver under a locked port, and the locked port itself 
will not allow ping to work anyhow without a FDB entry free of the 
"locked" flag, as the MAB tests verify.
And disabling MAB on the locked port on the mv88e6xxx will clean the 
locked entries.

So I see it as a flag for future use, otherwise I will have to add a 
userspace command to enable the "blackhole" flag.


I have now made station move tests for both the locked port and MAB 
cases.
