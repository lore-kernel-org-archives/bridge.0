Return-Path: <tyhicks@canonical.com>
References: <1531497949-1766-1-git-send-email-tyhicks@canonical.com>
	<20180718.131734.1797450417729100374.davem@davemloft.net>
	<20180718.134152.1719446664161643330.davem@davemloft.net>
From: Tyler Hicks <tyhicks@canonical.com>
Message-ID: <dad209c0-563c-d8ea-5f8b-ed4c0021f283@canonical.com>
Date: Wed, 18 Jul 2018 20:07:11 -0500
MIME-Version: 1.0
In-Reply-To: <20180718.134152.1719446664161643330.davem@davemloft.net>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="JSw5pJ8zZCD2mj6t5JXgDnuM08QitYcsk"
Subject: Re: [Bridge] [PATCH v2 net-next 0/7] Make /sys/class/net per net
 namespace objects belong to container
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: David Miller <davem@davemloft.net>
Cc: bridge@lists.linux-foundation.org, gregkh@linuxfoundation.org, containers@lists.linux-foundation.org, dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org, ebiederm@xmission.com, netdev@vger.kernel.org, tj@kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JSw5pJ8zZCD2mj6t5JXgDnuM08QitYcsk
Content-Type: multipart/mixed; boundary="SYyfqBDulpHiaenaVSsRmxzdaLsVgPkeX";
 protected-headers="v1"
From: Tyler Hicks <tyhicks@canonical.com>
To: David Miller <davem@davemloft.net>
Cc: gregkh@linuxfoundation.org, tj@kernel.org, stephen@networkplumber.org,
 dmitry.torokhov@gmail.com, ebiederm@xmission.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 bridge@lists.linux-foundation.org, containers@lists.linux-foundation.org
Message-ID: <dad209c0-563c-d8ea-5f8b-ed4c0021f283@canonical.com>
Subject: Re: [PATCH v2 net-next 0/7] Make /sys/class/net per net namespace
 objects belong to container
References: <1531497949-1766-1-git-send-email-tyhicks@canonical.com>
 <20180718.131734.1797450417729100374.davem@davemloft.net>
 <20180718.134152.1719446664161643330.davem@davemloft.net>
In-Reply-To: <20180718.134152.1719446664161643330.davem@davemloft.net>

--SYyfqBDulpHiaenaVSsRmxzdaLsVgPkeX
Content-Type: text/plain; charset=iso-8859-7
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 07/17/2018 11:41 PM, David Miller wrote:
> From: David Miller <davem@davemloft.net>
> Date: Wed, 18 Jul 2018 13:17:34 +0900 (KST)
>=20
>> Ok, I can't let this series rot forever, so I'll apply it to net-next.=

>=20
> Unfortunately, I had to revert, this breaks the build:
>=20
> arch/x86/kernel/cpu/intel_rdt_rdtgroup.c:1506:7: error: too few argumen=
ts to function =A1__kernfs_create_file=A2
>   kn =3D __kernfs_create_file(parent_kn, name, 0444, 0,
>=20

I've got a fix for this. New __kernfs_create_file() users were added
since the v1 of the patch set (defconfig didn't build that code for me).

However, I'm starting to question my assumption that sufficient access
control checks are all in place for the attributes affected by patch #5.
I see a few affected attributes which don't make any capable() calls and
I'm not yet through the entire list.

My current plan is to roll in my build failure fix, drop patch #5,
retest and resubmit as a v3. I wasn't able to get to that today but
should be able to by the end of the week.

Tyler


--SYyfqBDulpHiaenaVSsRmxzdaLsVgPkeX--

--JSw5pJ8zZCD2mj6t5JXgDnuM08QitYcsk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEPgU+cN5AsTrekT5+1pIAPaoCxwoFAltP5D8ACgkQ1pIAPaoC
xwpKHw/+MIZqS7/PRgROGbYnvtD8DL0Uq9pmxlgxpzF5X4u7IkDXaj8qy835Aiq9
Scs0Up65fKSV1EA9hy89qzwlo8infV+1TpmXMG3OomMsBhmM9wW0xvnnqNZupXvn
rbW1mWl05v/Q/trVdkO2cXsxo2okTXWUWbXYZwmL9gOn1yjqcSzysLPYR4EbHHgR
4br/3cqTrUgifFvcVLnvj4oWX5DxLOSQWLa009dIcow08U8fodZuXSgsi6QPYSF6
YNN5mOwhOY/U+p7mw7txaJ6GG3HEThJfE7+CGwOiEKUdtpUaGaZb/EmEvQMQifBC
9QUDbKcI1RGQnT3ZH8W+g+FD1PV8dMqkfnKXLCvnv10KRHLLDAHDnAJQIAfQyOvi
9M2vPymfVETcOUrtHopvaSkDUEJmzpZbkvapJvc4wetp29PBayE4D0dyK+3OpQsL
/PQfcP0rQmciDZ6DB+ofq+s5cwzJiNLzSljul62Whi1xA2WjoCO7LOnk6ekTQeI9
nTMhitm/9pSVnkv/Ri/KVW0bphlgSdf8WyouYBKTiLVlUjYaIT5ZAM0Tm/PzQyDa
7RMT7iDpH8EVZUZgA7mkZ4BaD7Ok2XAX7oOk4BDn94tIBc9U5XDqKqhpI1P4lIUm
E+CUcB9LBqlD6rT5zb2LNNFwyN/BKjV0j7kAzsK6xNKYIrCdN5A=
=G7fw
-----END PGP SIGNATURE-----

--JSw5pJ8zZCD2mj6t5JXgDnuM08QitYcsk--
