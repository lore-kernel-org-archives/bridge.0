Return-Path: <netdev@kapio-technology.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D8C9D419E6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 989A440632
MIME-Version: 1.0
Date: Tue, 12 Jul 2022 14:28:35 +0200
From: netdev@kapio-technology.com
In-Reply-To: <Ysp/1k6uwcmJIon0@shredder>
References: <20220707152930.1789437-1-netdev@kapio-technology.com>
 <20220707152930.1789437-7-netdev@kapio-technology.com>
 <Ysp/1k6uwcmJIon0@shredder>
Message-ID: <d70b897745d12f0c9cf298a114764de0@kapio-technology.com>
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v4 net-next 6/6] selftests: forwarding: add
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
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Vivien Didelot <vivien.didelot@gmail.com>, Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, linux-kselftest@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Vladimir Oltean <olteanv@gmail.com>, Shuah Khan <shuah@kernel.org>, davem@davemloft.net

On 2022-07-10 09:29, Ido Schimmel wrote:
> On Thu, Jul 07, 2022 at 05:29:30PM +0200, Hans Schultz wrote:
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
> I was under the impression that we agreed that learning does not need 
> to
> be enabled in the bridge driver
> 

Sorry, you are right. I forgot to change it here.

>> +
>> +	ping_do $h1 192.0.2.2
>> +	check_fail $? "MAB: Ping worked on locked port without FDB entry"
>> +
>> +	bridge fdb show | grep `mac_get $h1` | grep -q "locked"
>> +	check_err $? "MAB: No locked fdb entry after ping on locked port"
>> +
>> +	bridge fdb replace `mac_get $h1` dev $swp1 master static
>> +
>> +	ping_do $h1 192.0.2.2
>> +	check_err $? "MAB: Ping did not work with fdb entry without locked 
>> flag"
>> +
>> +	bridge fdb del `mac_get $h1` dev $swp1 master
>> +	bridge link set dev $swp1 learning off
>> +	bridge link set dev $swp1 locked off
>> +
>> +	log_test "Locked port MAB"
>> +}
>>  trap cleanup EXIT
>> 
>>  setup_prepare
>> --
>> 2.30.2
>> 
