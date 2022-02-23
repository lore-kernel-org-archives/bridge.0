Return-Path: <schultz.hans@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=Ubrw+ZDagpKqchc9nEqG4/IhR0XOEwvwWfaGS8w0bPI=;
 b=NsUjsj9C9+wZTdQqvrfMMvSP9T3mo7HyPzUPj7Pc14q7FQi0XIR49ZZAkRFHroK/c8
 SkbI3OuUO95RJMaffYEbNdAEZQ1c01WHvidP+7cAomt8PYshgHzZTRnrjxHSBHlff9wu
 LLl0z1uV42OD0u9cRA2u5usRnnZ6cx/JYSFRjqIxIsW8RddRJchhf6bLg4dKyI8bofFI
 CNoEpz+XllQ1Od5nbo82jD0Q38WF3aWCjpEpjly2tw3jcMQkATztiZbn3lx5yRGvt6L2
 i8J+RQpxcU/8YjfYRvWcMjmmiYWr+ePYD7Xu1zwi9JZk7F8+yiLaCOVDA5kNujb4I9p+
 THnQ==
From: Hans Schultz <schultz.hans@gmail.com>
In-Reply-To: <YhUWvhkhRVY+/Osd@shredder>
References: <20220222132818.1180786-1-schultz.hans+netdev@gmail.com>
 <20220222132818.1180786-6-schultz.hans+netdev@gmail.com>
 <YhUWvhkhRVY+/Osd@shredder>
Date: Wed, 23 Feb 2022 08:59:37 +0100
Message-ID: <861qzuxbbq.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Bridge] [PATCH net-next v4 5/5] selftests: forwarding: tests
 of locked port feature
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@idosch.org>, Hans Schultz <schultz.hans@gmail.com>
Cc: Petr Machata <petrm@nvidia.com>, Andrew Lunn <andrew@lunn.ch>, Baowen Zheng <baowen.zheng@corigine.com>, Florian Fainelli <f.fainelli@gmail.com>, Amit Cohen <amcohen@nvidia.com>, netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Vivien Didelot <vivien.didelot@gmail.com>, Ido Schimmel <idosch@nvidia.com>, Stephen Suryaputra <ssuryaextr@gmail.com>, Po-Hsu Lin <po-hsu.lin@canonical.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, linux-kselftest@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Vladimir Oltean <olteanv@gmail.com>, Shuah Khan <shuah@kernel.org>, davem@davemloft.net

On tis, feb 22, 2022 at 19:00, Ido Schimmel <idosch@idosch.org> wrote:
> On Tue, Feb 22, 2022 at 02:28:18PM +0100, Hans Schultz wrote:
>> diff --git a/tools/testing/selftests/net/forwarding/bridge_locked_port.sh b/tools/testing/selftests/net/forwarding/bridge_locked_port.sh
>> new file mode 100755
>> index 000000000000..a8800e531d07
>> --- /dev/null
>> +++ b/tools/testing/selftests/net/forwarding/bridge_locked_port.sh
>> @@ -0,0 +1,180 @@
>> +#!/bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +
>> +ALL_TESTS="locked_port_ipv4 locked_port_ipv6 locked_port_vlan"
>> +NUM_NETIFS=4
>> +CHECK_TC="no"
>> +source lib.sh
>> +
>> +h1_create()
>> +{
>> +	simple_if_init $h1 192.0.2.1/24 2001:db8:1::1/64
>> +	vrf_create "vrf-vlan-h1"
>> +	ip link set dev vrf-vlan-h1 up
>> +	vlan_create $h1 100 vrf-vlan-h1 198.51.100.1/24 ::ffff:c633:6401/64
>
> Hi,
>
> Why did you change it from 2001:db8:3::1/64 to ::ffff:c633:6401/64? It
> was actually OK the first time...

I used an online converter (https://iplocation.io/ipv4-to-ipv6) to
convert 198.51.100.1 into an 'equivalent' ipv6 address even though I
know they are of different spaces.

>
> Anyway, looking at locked_port_vlan() I see that you are only testing
> IPv4 so you can just drop this address:
>
> vlan_create $h1 100 vrf-vlan-h1 198.51.100.1/24
>
> Same for $h2
>
> LGTM otherwise. Feel free to add my tag to the next version
>
>
>> +}
