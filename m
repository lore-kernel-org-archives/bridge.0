Return-Path: <igor.mitsyanko.os@quantenna.com>
References: <20180310030308.12947-1-igor.mitsyanko.os@quantenna.com>
	<20180310030308.12947-3-igor.mitsyanko.os@quantenna.com>
	<20180310163838.GG29174@lunn.ch>
From: Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>
Message-ID: <ca9e6a17-5807-4a57-058f-90f49700463f@quantenna.com>
Date: Mon, 12 Mar 2018 13:07:40 -0700
MIME-Version: 1.0
In-Reply-To: <20180310163838.GG29174@lunn.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 2/5] bridge: propagate BR_ flags
 updates through sysfs to switchdev
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

On 03/10/2018 08:38 AM, Andrew Lunn wrote:
> 
>> +             return 0;
>> +
>> +     err = br_switchdev_set_port_flag(p, flags, mask);
>> +     if (err)
>> +             return err;
> 
> You might want to consider the br_warn() in
> br_switchdev_set_port_flag(). Do we want to spam the kernel log?  Or
> should store_flag() do some validation before calling
> br_switchdev_set_port_flag()?
> 
>          Andrew
> 

Is there any convention for that in Linux? While I would agree that 
simply returning a error code is sufficient in this case, another user 
of br_switchdev_set_port_flag() is a netlink interface, aren't they 
supposed to be an equivalent? That is, if netlink prints into kernel 
log, sysfs should do that too?

