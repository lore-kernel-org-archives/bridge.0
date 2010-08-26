Message-ID: <4C76C2A4.9070706@free.fr>
Date: Thu, 26 Aug 2010 21:38:12 +0200
From: =?ISO-8859-1?Q?Nicolas_de_Peslo=FCan?= <nicolas.2p.debian@free.fr>
MIME-Version: 1.0
References: <4C752DD9.7040302@tiolive.com>	<4C75724F.2000400@free.fr>	<20100825133959.6b409cd8@nehalam>
	<4C758FD5.4020801@tiolive.com>
In-Reply-To: <4C758FD5.4020801@tiolive.com>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] Number of addresses limitation
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: francois@tiolive.com
Cc: bridge@lists.linux-foundation.org

Le 25/08/2010 23:49, Fran=E7ois Schmidts a =E9crit :
>    On 25/08/2010 22:39, Stephen Hemminger wrote:
>> On Wed, 25 Aug 2010 21:43:11 +0200
>> Nicolas de Peslo=FCan<nicolas.2p.debian@free.fr>   wrote:
>>
>>> Le 25/08/2010 16:51, Fran=E7ois Schmidts a =E9crit :
>>>>      Hi,
>>>>
>>>> I'm using bridge-utils to add a bunch of tap interfaces to my computer
>>>> so I can run different qemu vm at the same time without using nat to
>>>> give them network access. It works fine.
>>>>
>>>> But at the same time I would like to add a lot of IPv6s addresses to t=
he
>>>> bridge interface (br0). I find myself limitated to more or less 56
>>>> addresses. If I add one more, one of the addresses already existing ju=
st
>>>> disappear from the br0 interface.
>>>>
>>>> Is there something I could do to remove or extent this limitation ?
>>> Did you try the same IPv6 configuration on a normal ethernet NIC ? Do y=
ou think this is a bridge
>>> only related problem ?
>>>
>> Also what tools are you using? Don't use ifconfig (iputils) for IPv6;
>> only ip command (iproute2) works correctly with multiple addresses.
> I use something like "ip addr add<prefix>::number/64 dev br0" in a loop
> to add quickly multiple addresses to the bridge.
> As far as I have tested it on classic interfaces like eth0, it works
> fine and I can see my 200 addresses (if I added 200 of them) in the
> output of ifconfig.

I just tested on a 2.6.32 kernel, and get the following results :

Whatever interface I use (bridge or normal Ethernet interface), I'm able to=
 add 200 IPv6 address.

"ifconfig" display all the IPv6 address on the interface.
"ip addr show" only display about 53 of them.

Can you try and ping the 200 IPv6 address from another host, to know whethe=
r this is a real IP=20
problem or only a display bug. It might be an iproute2 bug on the addr show=
 part.

	Nicolas.
