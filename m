Message-ID: <4C758FD5.4020801@tiolive.com>
Date: Wed, 25 Aug 2010 23:49:09 +0200
From: =?ISO-8859-1?Q?Fran=E7ois_Schmidts?= <francois@tiolive.com>
MIME-Version: 1.0
References: <4C752DD9.7040302@tiolive.com>	<4C75724F.2000400@free.fr>
	<20100825133959.6b409cd8@nehalam>
In-Reply-To: <20100825133959.6b409cd8@nehalam>
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
To: Stephen Hemminger <shemminger@linux-foundation.org>
Cc: bridge@lists.linux-foundation.org

  On 25/08/2010 22:39, Stephen Hemminger wrote:
> On Wed, 25 Aug 2010 21:43:11 +0200
> Nicolas de Peslo=FCan<nicolas.2p.debian@free.fr>  wrote:
>
>> Le 25/08/2010 16:51, Fran=E7ois Schmidts a =E9crit :
>>>     Hi,
>>>
>>> I'm using bridge-utils to add a bunch of tap interfaces to my computer
>>> so I can run different qemu vm at the same time without using nat to
>>> give them network access. It works fine.
>>>
>>> But at the same time I would like to add a lot of IPv6s addresses to the
>>> bridge interface (br0). I find myself limitated to more or less 56
>>> addresses. If I add one more, one of the addresses already existing just
>>> disappear from the br0 interface.
>>>
>>> Is there something I could do to remove or extent this limitation ?
>> Did you try the same IPv6 configuration on a normal ethernet NIC ? Do yo=
u think this is a bridge
>> only related problem ?
>>
> Also what tools are you using? Don't use ifconfig (iputils) for IPv6;
> only ip command (iproute2) works correctly with multiple addresses.
I use something like "ip addr add <prefix>::number/64 dev br0" in a loop=20
to add quickly multiple addresses to the bridge.
As far as I have tested it on classic interfaces like eth0, it works=20
fine and I can see my 200 addresses (if I added 200 of them) in the=20
output of ifconfig.
