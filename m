Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=qQHMEF0T6nFBZ3uL8DF15gBELDockbIZxCoHf6XLRTE=;
	b=Srg7xlOdRt9mvSZDC1Ycc8YOz+j1syhSbgQR1k7hhX3zKTBr2zZqRk4PhZTNzOEmfn
	Z/U9pLcGANDchX7qU+MiUYq9t2mgGy0vvADBZJ+0S5JPsqG3eGL3esM+iVIx11jg+57e
	NEwtE2KytxDuC0xdNE7pEmdgViowpdLXoGeT1osAQhlIq/EYxJbtLeuN3pgSZ4LUUCyz
	6gkSSiWIz3b5OIkm99vkIrsAtkC0ilOhu9455cfQ89vxYh15Tyg/VX3wO+HL3VD22Kff
	rCjLV6hDw5yctXqzuDRpIlJKLGECeG7/ENSMT7kDRJca1+r0IzoFpehamjsIiKuTMbq6
	8y3g==
References: <20190222235927.10295-1-f.fainelli@gmail.com>
	<20190222235927.10295-8-f.fainelli@gmail.com>
	<20190223103207.GA13070@splinter>
	<daaa3bb6-78b1-7c19-e2fd-6ec03d56201d@gmail.com>
	<20190225094940.GA15128@splinter>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <2e91b708-a092-3839-4979-2712145a9951@gmail.com>
Date: Mon, 25 Feb 2019 11:47:12 -0800
MIME-Version: 1.0
In-Reply-To: <20190225094940.GA15128@splinter>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] [PATCH net-next 7/8] net: switchdev: Replace port attr
 set SDO with a notification
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@mellanox.com>
Cc: "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>, "andrew@lunn.ch" <andrew@lunn.ch>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>, open list <linux-kernel@vger.kernel.org>, "vivien.didelot@gmail.com" <vivien.didelot@gmail.com>, Jiri Pirko <jiri@mellanox.com>, "David S. Miller" <davem@davemloft.net>

On 2/25/19 1:49 AM, Ido Schimmel wrote:
> On Sun, Feb 24, 2019 at 08:47:27AM -0800, Florian Fainelli wrote:
>> Le 2/23/19 à 2:32 AM, Ido Schimmel a écrit :
>>> On Fri, Feb 22, 2019 at 03:59:25PM -0800, Florian Fainelli wrote:
>>>> -	if (attr->flags & SWITCHDEV_F_NO_RECURSE)
>>>> +	if (attr & SWITCHDEV_F_DEFER)
>>>> +		rc = call_switchdev_blocking_notifiers(nt, dev,
>>>> +						       &attr_info.info, NULL);
>>>> +	else
>>>> +		rc = call_switchdev_notifiers(nt, dev, &attr_info.info, NULL);
>>>
>>> I don't believe this is needed. You're calling this function from
>>> switchdev_port_attr_set_now() which is always called from process
>>> context. switchdev_port_attr_set() takes care of that. Similar to
>>> switchdev_port_obj_add().
>>
>> Except for net/bridge/br_switchdev.c when we check the bridge port's
>> flags support with PRE_BRIDGE_FLAGS. In that case we are executing from
>> the caller (atomic) context and we can't defer otherwise that trumps the
>> whole idea of being able to do a quick check and return that to the
>> caller that we cannot support specific flags. How would you recommend
>> approaching that?
> 
> In this case you can invoke call_switchdev_notifiers() directly from
> br_switchdev_set_port_flag(). Eventually switchdev_port_attr_set() will
> be gone and bridge code will invoke the notifiers directly.

That can be done, but it still requires the target driver (mlxsw,
ocelot, dsa, etc.) to support attribute notification from blocking and
non-blocking context. Are you fine with that?
-- 
Florian
