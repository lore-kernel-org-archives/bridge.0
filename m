Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D059160BC3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E789160AC6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1695291586; x=1695896386;
 darn=lists.linux-foundation.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4cxYqhV2vF1/qTyjoXVFQ+TzTovUXbNHaLzLCCyWR1E=;
 b=XLpxdNl+dMLroBX3vkKaqUUsbpkDljX8oTkaR6LrAo77/dXQ16+mMQDfAVuRrHEzc9
 qyEYjKhM8yvZrb0Mq70MrCTid0vVssQlbLy9KlWSpZS2bOGj4N2iv2rYwmMo8iqGCX9Y
 DaNd868vOtcxnfV5Jbu+GE3kd7hO7AQTc5jDKiWNhftF5X9Url3FqcgrJBsjyG2baJtO
 OKmuJrhtZ1MRpjR/CSgXPap2HIFhsA7nC6hdKpAUh9zMdM9IbmxwmDQL3RxqR2B/FXDF
 f/DcMy5gCX5X+Z1zfUHp5peoh5bd0pkI6Hw88Q5XWbMNsHFRM2QvZYePZmD7uwUYF23Z
 Z2hQ==
Message-ID: <50814314-55a3-6cff-2e9e-2abf93fa5f1b@blackwall.org>
Date: Thu, 21 Sep 2023 13:19:44 +0300
MIME-Version: 1.0
Content-Language: en-US
References: <20230919-fdb_limit-v4-0-39f0293807b8@avm.de>
 <20230919-fdb_limit-v4-5-39f0293807b8@avm.de>
 <cc14cd4a-f3bb-3d6f-5b38-ec73cad32570@blackwall.org>
 <ZQv5aNbgqxCuOKyr@u-jnixdorf.ads.avm.de>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <ZQv5aNbgqxCuOKyr@u-jnixdorf.ads.avm.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v4 5/6] net: bridge: Add a
 configurable default FDB learning limit
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Johannes Nixdorf <jnixdorf-oss@avm.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, bridge@lists.linux-foundation.org, Ido Schimmel <idosch@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, linux-kernel@vger.kernel.org, Oleksij Rempel <linux@rempel-privat.de>, Vladimir Oltean <vladimir.oltean@nxp.com>, Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, David Ahern <dsahern@gmail.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>

On 9/21/23 11:06, Johannes Nixdorf wrote:
> On Wed, Sep 20, 2023 at 02:00:27PM +0300, Nikolay Aleksandrov wrote:
>> On 9/19/23 11:12, Johannes Nixdorf wrote:
>>> Add a Kconfig option to configure a default FDB learning limit system
>>> wide, so a distributor building a special purpose kernel can limit all
>>> created bridges by default.
>>>
>>> The limit is only a soft default setting and overrideable on a per bridge
>>> basis using netlink.
>>>
>>> Signed-off-by: Johannes Nixdorf <jnixdorf-oss@avm.de>
>>> ---
>>>    net/bridge/Kconfig     | 13 +++++++++++++
>>>    net/bridge/br_device.c |  2 ++
>>>    2 files changed, 15 insertions(+)
>>>
>>> diff --git a/net/bridge/Kconfig b/net/bridge/Kconfig
>>> index 3c8ded7d3e84..c0d9c08088c4 100644
>>> --- a/net/bridge/Kconfig
>>> +++ b/net/bridge/Kconfig
>>> @@ -84,3 +84,16 @@ config BRIDGE_CFM
>>>    	  Say N to exclude this support and reduce the binary size.
>>>    	  If unsure, say N.
>>> +
>>> +config BRIDGE_DEFAULT_FDB_MAX_LEARNED
>>> +	int "Default FDB learning limit"
>>> +	default 0
>>> +	depends on BRIDGE
>>> +	help
>>> +	  Sets a default limit on the number of learned FDB entries on
>>> +	  new bridges. This limit can be overwritten via netlink on a

overwritten doesn't sound good, how about This limit can be set (or changed)

>>> +	  per bridge basis.
>>> +
>>> +	  The default of 0 disables the limit.
>>> +
>>> +	  If unsure, say 0.
>>> diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
>>> index 9a5ea06236bd..3214391c15a0 100644
>>> --- a/net/bridge/br_device.c
>>> +++ b/net/bridge/br_device.c
>>> @@ -531,6 +531,8 @@ void br_dev_setup(struct net_device *dev)
>>>    	br->bridge_ageing_time = br->ageing_time = BR_DEFAULT_AGEING_TIME;
>>>    	dev->max_mtu = ETH_MAX_MTU;
>>> +	br->fdb_max_learned = CONFIG_BRIDGE_DEFAULT_FDB_MAX_LEARNED;
>>> +
>>>    	br_netfilter_rtable_init(br);
>>>    	br_stp_timer_init(br);
>>>    	br_multicast_init(br);
>>>
>>
>> This one I'm not sure about at all. Distributions can just create the bridge
>> with a predefined limit. This is not flexible and just adds
>> one more kconfig option that is rather unnecessary. Why having a kconfig
>> knob is better than bridge creation time limit setting? You still have
>> to create the bridge, so why not set the limit then?
> 
> The problem I'm trying to solve here are unaware applications. Assuming
> this change lands in the next Linux release there will still be quite
> some time until the major applications that create bridges (distribution
> specific or common network management tools, the container solution of
> they day, for embedded some random vendor tools, etc.) will pick it
> up. In this series I chose a default of 0 to not break existing setups
> that rely on some arbitrary amount of FDB entries, so those unaware
> applications will create bridges without limits. I added the Kconfig
> setting so someone who knows their use cases can still set a more fitting
> default limit.
> 
> More specifically to our use case as an embedded vendor that builds their
> own kernels and knows they have no use case that requires huge FDB tables,
> the kernel config allows us to set a safe default limit before starting
> to teach all our applications and our upstream vendors' code about the
> new netlink attribute. As this patch is relatively simple, we can also
> keep it downstream if there is opposition to it here though.

I'm not strongly against, just IMO it is unnecessary. I won't block the 
set because of this, but it would be nice to get input from others as
well. If you can recompile your kernel to set a limit, it should be 
easier to change your app to set the same limit via netlink, but I'm not 
familiar with your use case.

