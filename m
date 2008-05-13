Message-ID: <4829EAD2.3060401@free.fr>
Date: Tue, 13 May 2008 21:24:02 +0200
From: Benoit PAPILLAULT <benoit.papillault@free.fr>
MIME-Version: 1.0
References: <1210152122.32216.95.camel@gentoo-jocke.transmode.se>	<2e59e6970805071916r701987fdx49bab341420ba2d@mail.gmail.com>	<1210233718.32216.121.camel@gentoo-jocke.transmode.se>	<2e59e6970805122010v50dcd5al101ae3466b897ad6@mail.gmail.com>
	<20080513102806.55f16b36@extreme>
In-Reply-To: <20080513102806.55f16b36@extreme>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: [Bridge] RSTP implementation choice
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@vyatta.com>
Cc: Bridge@lists.linux-foundation.org, joakim.tjernlund@transmode.se

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Stephen Hemminger a =E9crit :

| That said, we really need to get the STP updated to RSTP. There are
currently
| four options:

I agree since RSTP is now part of 802.1D-2004 and is backward compatible
with STP (with some limitations of course).

|
| 1) Existing userlevel RSTP daemon based on rstplib.
| 2) New RSTP code (from EMC) as daemon
| 3) Update of old STP kernel code to RSTP, this was done on ancient 2.4
|    for embedded system
| 4) Port EMC RSTP code to kernel
|
| There doesn't appear to be lots of advantages to user space RSTP long term
| and the conversion process would be more painful.
|
| EMC code is slightly uglier (sorry) but has advantage of being recently
| interop tested.
|
| I don't have an easy answer, otherwise I would have just chosen one
and gone
| with it.

I like the userspace implementation (I intend to dig into it a bit
more). RSTP does not handle lots of traffic so it's fine to have it in
user mode. It would avoid to have the kernel bloated a bit more.

Moreover, I'm trying to design a new bridge protocol and it would help
to implement it in userspace with a clean rtnetlink API.

After all, routing protocols are not implemented into the kernel. Only
routing tables are.

My 2 cents,
Benoit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFIKerSOR6EySwP7oIRAhjPAKCT0z70+0GMtScLoMWECSlDQgzpAwCgpY/a
xvYeDb9xFHulOz8SuecEE5M=3D
=3D9D00
-----END PGP SIGNATURE-----
