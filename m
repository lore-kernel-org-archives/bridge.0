Return-Path: <code@simerda.eu>
Message-ID: <f7fc9c30-0514-0bfb-ee98-f3944d752d7f@simerda.eu>
Date: Tue, 1 Mar 2022 23:30:46 +0100
MIME-Version: 1.0
Content-Language: en-US
References: <20220301100321.951175-1-tobias@waldekranz.com>
 <20220301162142.2rv23g4cyd2yacbs@skbuf> <87fso1nzdt.fsf@waldekranz.com>
From: =?UTF-8?Q?Pavel_=c5=a0imerda?= <code@simerda.eu>
In-Reply-To: <87fso1nzdt.fsf@waldekranz.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v2 net-next 00/10] net: bridge: Multiple
	Spanning Trees
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Tobias Waldekranz <tobias@waldekranz.com>, Vladimir Oltean <olteanv@gmail.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Petr Machata <petrm@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>, Vivien Didelot <vivien.didelot@gmail.com>, Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, Cooper Lees <me@cooperlees.com>, navolnenoze@simerda.eu, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Matt Johnston <matt@codeconstruct.com.au>, davem@davemloft.net, linux-kernel@vger.kernel.org



On 01/03/2022 22:20, Tobias Waldekranz wrote:
> On Tue, Mar 01, 2022 at 18:21, Vladimir Oltean <olteanv@gmail.com> wrote:
>> Hi Tobias,
>>
>> On Tue, Mar 01, 2022 at 11:03:11AM +0100, Tobias Waldekranz wrote:
>>> A proposal for the corresponding iproute2 interface is available here:
>>>
>>> https://github.com/wkz/iproute2/tree/mst
>>
>> Please pardon my ignorance. Is there a user-mode STP protocol application
>> that supports MSTP, and that you've tested these patches with?
>> I'd like to give it a try.
> 
> I see that Stephen has already pointed you to mstpd in a sibling
> message.
> 
> It is important to note though, that AFAIK mstpd does not actually
> support MSTP on a vanilla Linux system. The protocol implementation is
> in place, and they have a plugin architecture that makes it easy for people
> to hook it up to various userspace SDKs and whatnot, but you can't use
> it with a regular bridge.
> 
> A colleague of mine has been successfully running a modified version of
> mstpd which was tailored for v1 of this series (RFC). But I do not
> believe he has had the time to rework it for v2. That should mostly be a
> matter of removing code though, as v2 allows you to manage the MSTIs
> directly, rather than having to translate it to an associated VLAN.

Hello,

we experimented with mstpd with pretty reasonable kernel modifications. Vanilla kernel wasn't capable of transferring the correct mapping from mstpd to the hardware due to lack of vlan2msti mapping and per-msti port state (rather than just per-vlan port state).

https://github.com/mstpd/mstpd/pull/112

I didn't pursue this for a while, though.

Regards,
Pavel
