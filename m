Return-Path: <igor.mitsyanko.os@quantenna.com>
References: <20180310030308.12947-1-igor.mitsyanko.os@quantenna.com>
	<20180310030308.12947-2-igor.mitsyanko.os@quantenna.com>
	<20180310163050.GF29174@lunn.ch>
From: Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>
Message-ID: <5f3c4e75-b611-ffbd-1aaa-6ee41c5c513e@quantenna.com>
Date: Mon, 12 Mar 2018 11:44:14 -0700
MIME-Version: 1.0
In-Reply-To: <20180310163050.GF29174@lunn.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 1/5] bridge: initialize port flags
 with switchdev defaults
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Andrew Lunn <andrew@lunn.ch>
Cc: ivecera@redhat.com, jiri@resnulli.us, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, sergey.matyukevich.os@quantenna.com, ashevchenko@quantenna.com, smaksimenko@quantenna.com, dlebed@quantenna.com

On 03/10/2018 08:30 AM, Andrew Lunn wrote:
>> +
>> +     ret = switchdev_port_attr_get(dev, &attr);
>> +     if (ret)
>> +             return BR_LEARNING | BR_FLOOD | BR_MCAST_FLOOD | BR_BCAST_FLOOD;
> 
> 
> Hi Igor
> 
> Please check if ret == -EOPNOTSUPP and only then use the defaults. A
> real error should be propagated, causing new_nbp to fail. You might
> also consider what to do when ENODATA is returned.
> 
>       Andrew
> 

Hi Andrew,
ok, will change it so an error is propagated.
There is one more comment from Stephen suggesting that flags must be set 
in switchdev, rather then queried: this approach should take care about 
ENODATA I assume.
