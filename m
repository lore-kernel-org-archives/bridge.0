Message-ID: <4A677ACA.3060100@ipfire.org>
Date: Wed, 22 Jul 2009 22:47:06 +0200
From: Michael Tremer <michael.tremer@ipfire.org>
MIME-Version: 1.0
References: <4A6638A5.208@ipfire.org> <4A668C49.7080209@superduper.net>
	<4A66C14C.4090300@ipfire.org> <4A677703.4060507@free.fr>
In-Reply-To: <4A677703.4060507@free.fr>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] Bridging untagged and tagged VLANs
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: =?ISO-8859-1?Q?Nicolas_de_Peslo=FCan?= <nicolas.2p.debian@free.fr>
Cc: bridge@lists.linux-foundation.org

Oops, just sent the email when your one scrabbled to my inbox.

https://lists.linux-foundation.org/pipermail/bridge/2009-July/006626.html

I applied that ebtables rule to the chain but no packages got to the=20
vlan interface (eth0.30) anymore.

Michael


Nicolas de Peslo=FCan wrote:
> Michael Tremer wrote:
>>
>> In this mail on
>> http://www.mail-archive.com/bridge@lists.osdl.org/msg01440.html
>> there is the following sentence: "- Add native support for an untagged
>> vlan.  Currently an untagged vlan can be implimented using ebtables or
> > similar."
>>
>> Do you know how to do this?
>
> For as far as I remember, the right way to do it with ebtables is :
>
> brctl addbr br0
> vconfig add eth0 30
> brctl addif br0 eth0.30
> brctl addif br0 eth0
>
> ebtables --table broute -A BROUTING --protocol 802_1Q --vlan-id 30=20
> --jump DROP
>
> Normally, a DROP target in BROUTING let the frame being ROUTED. The=20
> exact behavior  is "give it to upper layer", which is IP in most case.=20
> But, for a 802.1q tagged frame, the upper layer is "remove the 802.1q=20
> header and give it again to lower layer, on the right interface".
>
> So this ebtables entry deny the bridge the opportunity to eat frames=20
> having a 802.1q vlan id =3D 30, giving the opportunity to the vlan stack =

> to remove the vlan header and give it to eth0.30...
>
> Not tested, because I don't have a bridge available right now, but=20
> this should work.
>
> Of course, if you add several eth0.X interfaces to the bridge, you=20
> should add the corresponding ebtables entry. For very special=20
> configuration, --in-interface eth0 might be necessary too.
>
> Just thinking about it, the --vlan-id 30 might be useless. Juste=20
> having --protocol 802_1Q might be enough for simple configuration.=20
> Just try and told us.
>
> HTH.
>
>     Nicolas.

