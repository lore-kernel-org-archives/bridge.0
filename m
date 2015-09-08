Return-Path: <tobias.powalowski@googlemail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=googlemail.com; s=20120113;
	h=subject:to:references:from:message-id:date:user-agent:mime-version
	:in-reply-to:content-type;
	bh=BWGxzb0XO2KiJPJX+SmuT4nnvjxotiqG7tOuvq3TP98=;
	b=hYezki+zdmb4KZcDMS2fzZ/uOV5ny9bN1yoHZPdMRsmCbyV4p0yWXhXMmc/AoK4RPn
	h+LbzVcX569mXVz7ZiiG8idjmm19pZmocAr9od25cRDLW6Wpg9+H0JEs+m69DHXtSqd3
	9ItOfHVwL3RjMekaz5tpv/c3B3+0Ohcz1mO/GBYIIgO5zKSsmzZHx/SEz5pecBmiH8O9
	Q8Vn+io+VBlk7pwo8h1Ku8KL8H3q4SUuc4xjVVCiU5QFagPoS6SU1e3ulJPPLHDYN/1c
	F6YrSNjvmGYiCDRqsbAi5Lyjgbe8ORhNHKYzJHPkGZRkZat0YprTHAioGiG09zL8Dbiu
	lIQw==
References: <55ED8723.9070501@googlemail.com> <20150908022303.GA1562@odroid>
	<55EE81D2.1040002@googlemail.com> <20150908112247.GE1562@odroid>
From: Tobias Powalowski <tobias.powalowski@googlemail.com>
Message-ID: <55EED8CA.2070904@googlemail.com>
Date: Tue, 8 Sep 2015 14:47:06 +0200
MIME-Version: 1.0
In-Reply-To: <20150908112247.GE1562@odroid>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="XtlX5chmXXhwMtWxrw5CcusuFMFM2Rtuj"
Subject: Re: [Bridge] net: Export IGMP/MLD message validation code
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XtlX5chmXXhwMtWxrw5CcusuFMFM2Rtuj
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Am 08.09.2015 um 13:22 schrieb Linus L=C3=BCssing:
> Hi Tobias,
>
> On Tue, Sep 08, 2015 at 08:36:02AM +0200, Tobias Powalowski wrote:
>> Am 08.09.2015 um 04:24 schrieb Linus L=C3=BCssing:
>>> Hi tpowa,
>>>
>>> Thanks for your feedback.
>>>
>>>
>>> On Mon, Sep 07, 2015 at 02:46:27PM +0200, Tobias Powalowski wrote:
>>>> Hi,
>>>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3D9afd85c9e4552b276e2f4cfefd622bdeeffbbf26
>>>>
>>>> This commit introduces a weird behaviour on my dlna server.
>>> Did you experience this on the released 4.2 kernel or on a 4.2 releas=
e
>>> candidate?
>> This was on 4.2 final release.
> Ok.
>
>>>> This commit was merged into 4.2 series, which makes my dlna services=

>>>> disappear real soon after starting from discovering from other clien=
ts.
>>>> Localhost seems not to be affected but every external discovery is b=
roken.
>>>> The dlna services run on a bridge device. Mythtv and Minidlna both
>>>> disappear after some minutes of running.
>>>> Git bisect shows first commit as reason, trying now a 4.2 with those=
 3
>>>> patches reverted:
>>>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3Da516993f0ac1694673412eb2d16a091eafa77d2a
>>>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3Dfcba67c94abe83e0e69a65737000ccbb16a4fa03
>>>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3D9afd85c9e4552b276e2f4cfefd622bdeeffbbf26
>>>>
>>>> Do you need any more information to get this really weird bug fixed?=

>>> If you have this issue with the vanilla, released 4.2 kernel, then
>>> a "tcpdump -i br0 'icmp6 or ip6 proto 0'" for about five minutes and
>>> a "bridge mdb show" would be helpful.
>> Here comes the next interesting thing:
>> If I run
>> tcpdump -i br0 'ip6 proto 0'
>> all is working fine.
> This rings a bell. Somebody told me about such weird behaviour
> back in March already on IRC, so way before 4.2 or any commits you've
> cited. Unfortunately I wasn't able to reproduce it back then and
> didn't hear from him on this issue anymore - I'll try to get an update
> from him.
>
> br_multicast.c has no knowledge about promiscious mode. Maybe
> someone else from the bridge mailinglist might have an idea how
> prom. mode on the bridge interface could affect things?
>
>> If I stop this task it stops showing the dlna services.
>> promiscious mode enabled doesn't make it fail.
>> [ 1212.138260] device br0 entered promiscuous mode
>> works
>> [ 1246.908027] device br0 left promiscuous mode
>> does not work
>>
>> bridge mdb show
>> dev br0 port enp2s0 grp 224.0.1.60 temp
>> dev br0 port enp2s0 grp 239.255.255.250 temp
>>
>>> Also which distros are the dlna server and dlna client running,
>>> how are they connected?
>> I have only archlinux environments, all external connections are affec=
ted.
>> My Panasonic TV is not working and my Sony Xperia Z1 compact mobile
>> phones are also not working.
>> VLC on Windows 7 shows the same. So this is a generic issue I guess.
> Just to check two (sometimes too) "obvious" points: No ebtables or ipta=
bles
> on the device with the bridge? DLNA server isn't bound to enp2s0
> and is either unbound (binds to 0.0.0.0) or binds to br0?
>
Hi,
DLNA is not bound to any interface ebtables is not installed and
iptables don't show any active rule.
Any output of a network command which might help?
Thanks for investigation on this bug.

greetings
tpowa

--=20
Tobias Powalowski
Archlinux Developer & Package Maintainer (tpowa)
http://www.archlinux.org
tpowa@archlinux.org



--XtlX5chmXXhwMtWxrw5CcusuFMFM2Rtuj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV7tjKAAoJEHcd9mJ+32gf6OAH/1sGy26hs+4xyioUFGxOmAM5
HH1lD6sheN2TKhlLfofNgVR7REE8mM+uVvShrDT+AyvHmQitUY0CvOjdTVS/hwS4
fjtiaCQabVpkO7O0hT2YYwwmd2bUtvwlpVTWETRPOL3mX8OGxUtWiS5vwiZeRyDF
LrEOaCn6AbP5zRLipObchr6d4LuksimK+CtpylctyoIcfBGndmUNHhjNwtDsGNyl
I7kLVPYpWXTyvOHL2iesl55IwLYOVlGH7ahIAppmPUQkwGeJxPctyXq4ArfhUUxL
168Et991CevMkKtyT9SvYYiQg2pS1KtKQUrVOg1ZrqVfcm2av7kSVVr+zF1dUUM=
=IYi9
-----END PGP SIGNATURE-----

--XtlX5chmXXhwMtWxrw5CcusuFMFM2Rtuj--
