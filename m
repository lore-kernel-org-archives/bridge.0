Return-Path: <green@linuxhacker.ru>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=windows-1252
From: Oleg Drokin <green@linuxhacker.ru>
In-Reply-To: <59758948-d899-a32f-12af-a56b8c0da6c1@cogentembedded.com>
Date: Sat, 27 Aug 2016 12:36:49 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <D79B6506-31BF-4B39-A81C-F3900F062164@linuxhacker.ru>
References: <1472267428-810527-1-git-send-email-green@linuxhacker.ru>
	<11e50e3c-2e1f-4614-07e3-3bd144af4f94@cogentembedded.com>
	<95BF7F27-59F7-4BDA-941B-BB00C60423A4@linuxhacker.ru>
	<59758948-d899-a32f-12af-a56b8c0da6c1@cogentembedded.com>
Subject: Re: [Bridge] [PATCH] bridge: Fix format string for %ul
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org


On Aug 27, 2016, at 12:18 PM, Sergei Shtylyov wrote:

> Hello.
>=20
> On 8/27/2016 6:58 PM, Oleg Drokin wrote:
>=20
>>>> %ul would print an unsigned value and a letter l,
>>>> likely it was %lu that was meant to print the long int,
>>>> but in reality the values printed there are just regular signed
>>>=20
>>>  Signed? Then you need probably "%d" or "%i"=85
>>=20
>> They are signed in the struct definition, but in reality they
>> designate time, so could not be negative, I imagine?
>=20
>   That doesn't matter. If the type is signed, it should be printed as =
signed.
> Doesn't gcc complain about the format specifiers not matching the =
values passed?

only if the size differs.

I don't care either way.
I can change the struct to unsigned too, but if we want super =
correctness,
the problem lies deeper.

E.g. if we look how those times are derived, the age comes as:
static inline int br_get_ticks(const unsigned char *src)
{
        unsigned long ticks =3D get_unaligned_be16(src);

        return DIV_ROUND_UP(ticks * HZ, STP_HZ);
}

So we divide unsigned value by positive value and get a signed result ;)

there's a struct net_bridge_port with similar members in this are that =
are
unsigned long, so I guess we should convert to unsigned long in the
struct br_config_bpdu, do you want a patch for that separately or as =
part of this one?

>=20
>>>> ints, so just dropping the l altogether.
>>>>=20
>>>> Signed-off-by: Oleg Drokin <green@linuxhacker.ru>
>>> [...]
>=20
> MBR, Sergei

