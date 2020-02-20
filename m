Return-Path: <Allan.Nielsen@microchip.com>
Date: Thu, 20 Feb 2020 14:00:07 +0100
From: "Allan W. Nielsen" <allan.nielsen@microchip.com>
Message-ID: <20200220130007.o4tdhyopwrxkr33c@lx-anielsen.microsemi.net>
References: <20200124161828.12206-1-horatiu.vultur@microchip.com>
 <20200124161828.12206-4-horatiu.vultur@microchip.com>
 <20200124174315.GC13647@lunn.ch>
 <20200125113726.ousbmm4n3ab4xnqt@soft-dev3.microsemi.net>
 <20200125152023.GA18311@lunn.ch>
 <20200125191612.5dlzlvb7g2bucqna@lx-anielsen.microsemi.net>
 <20200126132843.k4rzn7vfti7lqvos@soft-dev3.microsemi.net>
 <08c2d3f8-8d70-730c-95d5-8493e6919f3e@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Disposition: inline
In-Reply-To: <08c2d3f8-8d70-730c-95d5-8493e6919f3e@cumulusnetworks.com>
Subject: Re: [Bridge] [RFC net-next v3 03/10] net: bridge: mrp: Add MRP
 interface used by netlink
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: ivecera@redhat.com, Andrew Lunn <andrew@lunn.ch>, jiri@resnulli.us, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, davem@davemloft.net, UNGLinuxDriver@microchip.com, anirudh.venkataramanan@intel.com, jeffrey.t.kirsher@intel.com, olteanv@gmail.com, Horatiu Vultur <horatiu.vultur@microchip.com>

On 20.02.2020 11:08, Nikolay Aleksandrov wrote:
>EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>
>On 26/01/2020 15:28, Horatiu Vultur wrote:
>> The 01/25/2020 20:16, Allan W. Nielsen wrote:
>>> On 25.01.2020 16:20, Andrew Lunn wrote:
>>>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>>>
>>>> On Sat, Jan 25, 2020 at 12:37:26PM +0100, Horatiu Vultur wrote:
>>>>> The 01/24/2020 18:43, Andrew Lunn wrote:
>>>>>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>>>>>
>>>>>>> br_mrp_flush - will flush the FDB.
>>>>>>
>>>>>> How does this differ from a normal bridge flush? I assume there is a
>>>>>> way for user space to flush the bridge FDB.
>>>>>
>>>>> Hi,
>>>>>
>>>>> If I seen corectly the normal bridge flush will clear the entire FDB for
>>>>> all the ports of the bridge. In this case it is require to clear FDB
>>>>> entries only for the ring ports.
>>>>
>>>> Maybe it would be better to extend the current bridge netlink call to
>>>> be able to pass an optional interface to be flushed?  I'm not sure it
>>>> is a good idea to have two APIs doing very similar things.
>>> I agree.
>> I would look over this.
>>
>
>There's already a way to flush FDBs per-port - IFLA_BRPORT_FLUSH.
>
>>>
>>> And when looking at this again, I start to think that we should have
>>> extended the existing netlink interface with new commands, instead of
>>> adding a generic netlink.
>> We could do also that. The main reason why I have added a new generic
>> netlink was that I thought it would be clearer what commands are for MRP
>> configuration. But if you think that we should go forward by extending
>> existing netlink interface, that is perfectly fine for me.
>>
>>>
>>> /Allan
>>>
>>
>
>I don't mind extending the current netlink interface but the bridge already has
>a huge (the largest) set of options and each time we add a new option we have
>to adjust RTNL_MAX_TYPE. If you do decide to go this way maybe look into nesting
>all the MRP options under one master MRP element into the bridge options, example:
>[IFLA_BR_MRP]
>  [IFLA_BR_MRP_X]
>  [IFLA_BR_MRP_Y]
>  ...
Ahh, did not see this mail before responsing to the other one.

We can make it part of the BR netlink then.

/Allan

