Message-ID: <45D3D99A.9050108@mattstone.net>
Date: Thu, 15 Feb 2007 03:55:06 +0000
From: Matt Richards <matt@mattstone.net>
MIME-Version: 1.0
References: <45CE9940.2060501@mattstone.net>
	<bdfc5d6e0702131517v7e7ed5dbk8bb2f30d4d8842c0@mail.gmail.com>
In-Reply-To: <bdfc5d6e0702131517v7e7ed5dbk8bb2f30d4d8842c0@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig378B8B0BF2850F67C3938D72"
Subject: Re: [Bridge] bridge wont forward when ip address changes
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Andy Gospodarek <andy@greyhouse.net>, bridge@lists.osdl.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig378B8B0BF2850F67C3938D72
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Andy Gospodarek wrote:
> On 2/10/07, Matt Richards <matt@mattstone.net> wrote:
>> hello :)
>>
>> I have been using the bridge utils for a long time now and its been ve=
ry
>> good but there are a couple of issues that I came across when trying t=
o
>> setup a wireless bridge...
>>
>> Firstly I currently have a setup like the following ...
>>
>> Computer A --- Wired Network --- linux box ---- wireless link ------
>> linux box ----- Wired Network --- Computer B
>>
>> I have bridged the wireless interfaces and the wired interfaces togeth=
er
>> on both of the linux box's and data can travel across the wireless
>> bridge without any trouble but if I attempt to change the IP addresses=
 /
>> subnet of Computers A and B the bridges seem to stop forwarding packet=
s
>> and no data get through at all, its like they aren't learning the new
>> addresses.
>>
>> If I restart the 2 Linux boxes then everything starts flowing properly=

>> again.
>>
>> The 'Linux boxes' are a couple of Motorola Wireless Access points
>> running OpenWRT.
>>
>> Does anybody know why this might be happening and what I might be able=

>> to do about it?
>>
>
> I wonder if this is ARP related?  I've noticed some interesting
> behavior when bridging wired and wireless devices.  Have you noticed
> that you can communicate after the IP switch if you send a gratuitous
> ARP from any of the wireless devices?
>
hello,
no i haven't tried tried that, i did notice that if i try to make a
computer talk to another device after the ip change the arp table would
contain the IP with an invalid state and no mac address or a mac address
of all F's i think it was.

Sending arp packets wouldn't be a solution as this will be used in a
computer lab to connect sockets that are in parts of the room where its
not easy to run cables and therefore wouldn't be ideal for people to use
when learning about network operating systems.

One thing I have just thought of, while reading an email from the
openvpn mailing list, is that if i setup an openvpn tunnel with tap
interfaces over the wireless link and bridge the switches to the tap
interface then the problem should go away if it is to do with the
wireless interfaces.

Is a little weird tho, I had to lower to mtu to get the devices to ping
in the first place.

Matty.



--------------enig378B8B0BF2850F67C3938D72
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFF09mdrmnybSDmzlsRAqwOAJ9r6IcpJfISFRm566A4+gxBE8pvQQCglMtU
qutF2f6D3OvoQQ8N0fxP2zg=
=ryZn
-----END PGP SIGNATURE-----

--------------enig378B8B0BF2850F67C3938D72--

