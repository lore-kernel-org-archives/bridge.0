Return-Path: <schultz.hans@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=w9yc5QCXnoNRlnxAIpP6dQxCkCMVrsMOMCyEys6TQis=;
 b=T2qHWC580J0XVLFbwGxYKtYvqDl7Fg+++QEHEAJ08FnAgvnWRvbH9tCpVG3QOVmLk/
 yFwG/XGkPnhcxMaWLjTEA7ICqKHju9w1x216TK4uT0H2Zpc1+UAB6COEozAQXivxEcxW
 Qx26zGBeD0BWVZEBFDjQLntzuP0Tjjapln8HbiI6GQU9dAzYuQFfJu8dpZsUpXrke9KA
 lvX9Rt4KwKGT7dklcPUwVMztOoljO/CQUhdsTPgevwTyVYYk1K9843AujWQBFlfTo7jq
 g+X3Kg8zWYBkd8uAub/wUAy6WTeQk7NNUC6FsdmCXyCKLLSJVgVT93v3RMe20R1Mcsla
 IEaQ==
From: Hans Schultz <schultz.hans@gmail.com>
In-Reply-To: <YjNMS6aFG+93ejj5@shredder>
References: <20220317093902.1305816-1-schultz.hans+netdev@gmail.com>
 <20220317093902.1305816-5-schultz.hans+netdev@gmail.com>
 <YjNMS6aFG+93ejj5@shredder>
Date: Fri, 18 Mar 2022 16:45:24 +0100
Message-ID: <86mthnw9gr.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Bridge] [PATCH v2 net-next 4/4] selftests: forwarding: add
 test of MAC-Auth Bypass to locked port tests
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@idosch.org>, Hans Schultz <schultz.hans@gmail.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Vivien Didelot <vivien.didelot@gmail.com>, Ido Schimmel <idosch@nvidia.com>, linux-kselftest@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Vladimir Oltean <olteanv@gmail.com>, Shuah Khan <shuah@kernel.org>, davem@davemloft.net

On tor, mar 17, 2022 at 16:57, Ido Schimmel <idosch@idosch.org> wrote:
> On Thu, Mar 17, 2022 at 10:39:02AM +0100, Hans Schultz wrote:
>> Verify that the MAC-Auth mechanism works by adding a FDB entry with the
>> locked flag set. denying access until the FDB entry is replaced with a
>> FDB entry without the locked flag set.
>> 
>> Signed-off-by: Hans Schultz <schultz.hans+netdev@gmail.com>
>> ---
>>  .../net/forwarding/bridge_locked_port.sh      | 29 ++++++++++++++++++-
>>  1 file changed, 28 insertions(+), 1 deletion(-)
>> 
>> diff --git a/tools/testing/selftests/net/forwarding/bridge_locked_port.sh b/tools/testing/selftests/net/forwarding/bridge_locked_port.sh
>> index 6e98efa6d371..2f9519e814b6 100755
>> --- a/tools/testing/selftests/net/forwarding/bridge_locked_port.sh
>> +++ b/tools/testing/selftests/net/forwarding/bridge_locked_port.sh
>> @@ -1,7 +1,7 @@
>>  #!/bin/bash
>>  # SPDX-License-Identifier: GPL-2.0
>>  
>> -ALL_TESTS="locked_port_ipv4 locked_port_ipv6 locked_port_vlan"
>> +ALL_TESTS="locked_port_ipv4 locked_port_ipv6 locked_port_vlan locked_port_mab"
>>  NUM_NETIFS=4
>>  CHECK_TC="no"
>>  source lib.sh
>> @@ -170,6 +170,33 @@ locked_port_ipv6()
>>  	log_test "Locked port ipv6"
>>  }
>>  
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
>> +
>> +	ping_do $h1 192.0.2.2
>> +	check_fail $? "MAB: Ping worked on port just locked"
>> +
>> +	if ! bridge fdb show | grep `mac_get $h1` | grep -q "locked"; then
>> +		RET=1
>> +		retmsg="MAB: No locked fdb entry after ping on locked port"
>> +	fi
>
> bridge fdb show | grep `mac_get $h1 | grep -q "locked"
> check_err $? "MAB: No locked fdb entry after ping on locked port"
>
>> +
>> +	bridge fdb del `mac_get $h1` dev $swp1 master
>> +	bridge fdb add `mac_get $h1` dev $swp1 master static
>
> bridge fdb replace `mac_get $h1` dev $swp1 master static
>
Unfortunately for some reason 'replace' does not work in several of the
tests, while when replaced with 'del+add', they work.

>> +
>> +	ping_do $h1 192.0.2.2
>> +	check_err $? "MAB: Ping did not work with fdb entry without locked flag"
>> +
>> +	log_test "Locked port MAB"
>
> Clean up after the test to revert to initial state:
>
> bridge fdb del `mac_get $h1` dev $swp1 master
> bridge link set dev $swp1 locked off
>
>
>> +}
>>  trap cleanup EXIT
>>  
>>  setup_prepare
>> -- 
>> 2.30.2
>> 
