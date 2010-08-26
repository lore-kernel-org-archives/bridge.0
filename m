Message-ID: <4C76EA69.7050301@tiolive.com>
Date: Fri, 27 Aug 2010 00:27:53 +0200
From: =?ISO-8859-1?Q?Fran=E7ois_Schmidts?= <francois@tiolive.com>
MIME-Version: 1.0
References: <4C752DD9.7040302@tiolive.com>	<4C75724F.2000400@free.fr>	<20100825133959.6b409cd8@nehalam>	<4C758FD5.4020801@tiolive.com>	<4C76C2A4.9070706@free.fr>	<4C76D5D7.2040503@free.fr>
	<20100826144043.3fda9403@nehalam>
In-Reply-To: <20100826144043.3fda9403@nehalam>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] Number of addresses limitation
Reply-To: francois@tiolive.com
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@linux-foundation.org>, bridge@lists.linux-foundation.org

  On 26/08/2010 23:40, Stephen Hemminger wrote:
> On Thu, 26 Aug 2010 23:00:07 +0200
> Nicolas de Peslo=FCan<nicolas.2p.debian@free.fr>  wrote:
>
>> Le 26/08/2010 21:38, Nicolas de Peslo=FCan a =E9crit :
>>> Le 25/08/2010 23:49, Fran=E7ois Schmidts a =E9crit :
>>>>      On 25/08/2010 22:39, Stephen Hemminger wrote:
>>>>> On Wed, 25 Aug 2010 21:43:11 +0200
>>>>> Nicolas de Peslo=FCan<nicolas.2p.debian@free.fr>     wrote:
>>>>>
>>>>>> Le 25/08/2010 16:51, Fran=E7ois Schmidts a =E9crit :
>>>>>>>        Hi,
>>>>>>>
>>>>>>> I'm using bridge-utils to add a bunch of tap interfaces to my compu=
ter
>>>>>>> so I can run different qemu vm at the same time without using nat to
>>>>>>> give them network access. It works fine.
>>>>>>>
>>>>>>> But at the same time I would like to add a lot of IPv6s addresses t=
o the
>>>>>>> bridge interface (br0). I find myself limitated to more or less 56
>>>>>>> addresses. If I add one more, one of the addresses already existing=
 just
>>>>>>> disappear from the br0 interface.
>>>>>>>
>>>>>>> Is there something I could do to remove or extent this limitation ?
>>>>>> Did you try the same IPv6 configuration on a normal ethernet NIC ? D=
o you think this is a bridge
>>>>>> only related problem ?
>>>>>>
>>>>> Also what tools are you using? Don't use ifconfig (iputils) for IPv6;
>>>>> only ip command (iproute2) works correctly with multiple addresses.
>>>> I use something like "ip addr add<prefix>::number/64 dev br0" in a loop
>>>> to add quickly multiple addresses to the bridge.
>>>> As far as I have tested it on classic interfaces like eth0, it works
>>>> fine and I can see my 200 addresses (if I added 200 of them) in the
>>>> output of ifconfig.
>>> I just tested on a 2.6.32 kernel, and get the following results :
>>>
>>> Whatever interface I use (bridge or normal Ethernet interface), I'm abl=
e to add 200 IPv6 address.
>>>
>>> "ifconfig" display all the IPv6 address on the interface.
>>> "ip addr show" only display about 53 of them.
>>>
>>> Can you try and ping the 200 IPv6 address from another host, to know wh=
ether this is a real IP
>>> problem or only a display bug. It might be an iproute2 bug on the addr =
show part.
>> Another test showed that one can ping the 200 addresses. So this really =
look like an iproute2 or
>> netlink problem, and unrelated to bridge.
>>
> I just put 2000 addresses onto dummy device and the all show up
> with ip addr.  Do you have old tools, the issue is likely the size
> of the buffer in netlink interface between ip command and kernel.
> Current version has 16K buffer, but it could easily be increased.
Thanks for all your answers.

I tested all of this all over again and I couldn't recreate the bug,=20
neither on my local machine or on the distant dev server I use for test=20
and where the limitation showed up the first time. I added 2000=20
addresses on both which were reachable to ping without difficulties.

The problem may have come from a display bug from the tool I used then=20
to list IP addresses.

Sorry to have bothered you with an "nonexistent" bug and thanks again.
