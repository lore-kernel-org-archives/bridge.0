Return-Path: <rasmus.villemoes@prevas.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QeE9PIWmK8ZtnPPsM5maKWOUEmzyBru4XDJdBahPyPA=;
 b=QqCb9hPPSXOLo1mz9e1IGbXkOVb/Hf6pbmpsh8HRzQROiR3N/4Qhuq1Vl5qYMIxtSgcl/95lcT4kyslT4e4bZKI5e1ye1Ef14YjW8K2Y9Maj8OGPLl8ivENGSX2yKJX/IvoQgAISO30PV4YsEsKO41jMCH4iRWAWC2/wdE7w5YA=
References: <20210118181319.25419-1-rasmus.villemoes@prevas.dk>
 <20210118185618.75h45rjf6qqberic@soft-dev3.localdomain>
 <20210118194632.zn5yucjfibguemjq@skbuf>
 <20210118202036.wk2fuwa3hysg4dmj@soft-dev3.localdomain>
 <20210118212735.okoov5ndybszd6m5@skbuf>
 <20210119083240.37cxv3lxi25hwduj@soft-dev3.localdomain>
 <YAcAIcwfp8za9JUo@lunn.ch>
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Message-ID: <6770bb94-e615-8f14-f83b-8bf95b5739de@prevas.dk>
Date: Mon, 25 Jan 2021 22:36:48 +0100
In-Reply-To: <YAcAIcwfp8za9JUo@lunn.ch>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net] net: mrp: use stp state as substitute for
 unimplemented mrp state
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Andrew Lunn <andrew@lunn.ch>, Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, Tobias Waldekranz <tobias@waldekranz.com>

On 19/01/2021 16.52, Andrew Lunn wrote:
> On Tue, Jan 19, 2021 at 09:32:40AM +0100, Horatiu Vultur wrote:
>> The 01/18/2021 21:27, Vladimir Oltean wrote:
>>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>>
>>> On Mon, Jan 18, 2021 at 09:20:36PM +0100, Horatiu Vultur wrote:
>>>> The 01/18/2021 19:46, Vladimir Oltean wrote:
>>>>>
>>>>> On Mon, Jan 18, 2021 at 07:56:18PM +0100, Horatiu Vultur wrote:
>>>>>> The reason was to stay away from STP, because you can't run these two
>>>>>> protocols at the same time. Even though in SW, we reuse port's state.
>>>>>> In our driver(which is not upstreamed), we currently implement
>>>>>> SWITCHDEV_ATTR_ID_MRP_PORT_STATE and just call the
>>>>>> SWITCHDEV_ATTR_ID_PORT_STP_STATE.
>>>>>
>>>>> And isn't Rasmus's approach reasonable, in that it allows unmodified
>>>>> switchdev drivers to offload MRP port states without creating
>>>>> unnecessary code churn?
>>>>
>>>> I am sorry but I don't see this as the correct solution. In my opinion,
>>>> I would prefer to have 3 extra lines in the driver and have a better
>>>> view of what is happening. Than having 2 calls in the driver for
>>>> different protocols.
>>>
>>> I think the question boils down to: is a MRP-unaware driver expected to
>>> work with the current bridge MRP code?
>>
>> If the driver has switchdev support, then is not expected to work with
>> the current bridge MRP code.
> 
>>
>> For example, the Ocelot driver, it has switchdev support but no MRP
>> support so this is not expected to work.
> 
> Then ideally, we need switchdev core to be testing for the needed ops
> and returning an error which prevents MRP being configured when it
> cannot work.

Why are we now discussing crippling switchdev code instead of making it
work? Yeah, this is not all that is needed to make MRP work with
existing switchdev/dsa drivers, but it's certainly part of the puzzle.
The patch at the beginning of this thread did that.

Another approach that I'd probably prefer even more, given that Horatiu
said that even in the only driver (and an out-of-tree at that) currently
knowing about SWITCHDEV_ATTR_ID_MRP_PORT_STATE actually just translates
that to the equivalent SWITCHDEV_ATTR_ID_PORT_STP_STATE, is to simply do
that translation back in br_mrp_port_switchdev_set_state() (i.e., not
having the translation as a fallback). We'd keep the netlink
IFLA_BRIDGE_MRP_PORT_STATE_STATE because that's already uapi, and there
_might_ be some future driver that would need to do something different,
but until then I don't see the point of duplicating code down the call
stack.

Rasmus
