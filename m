MIME-Version: 1.0
Date: Tue, 12 Jan 2010 16:58:49 -0600
Message-ID: <2e59e6971001121458s497910bdx90c1c05aab076a08@mail.gmail.com>
From: "richardvoigt@gmail.com" <richardvoigt@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] Re :Re: Re :Re: Bridging LACP (802.3ad) frames not
	working
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ross Vandegrift <ross@kallisti.us>
Cc: bridge@lists.linux-foundation.org

On Tue, Jan 12, 2010 at 4:04 PM, Ross Vandegrift <ross@kallisti.us> wrote:
> On Tue, Jan 12, 2010 at 09:40:30PM +0000, jhautbois@gmail.com wrote:
>> This is exactly the problem.
>> But, sounds like it is not possible... ?
>
> You could run a custom version of the bridge driver to enable bridging
> of frames sent to the bridge-management MAC addresses. =C2=A0Some folks
> have talked about doing similar things to enable bridging of STP.
>
> Doing that with STP makes a bit more sense to me (since there are
> valid networks that could be constructed that way). =C2=A0But you'll be
> breaking a pretty fundamental assumption of LACP....

LACP is between peers, not to the nearest connected device (generally
an ethernet cable).  As long as the intermediate link acts just like a
wire and passes everything, LACP shouldn't care.  And there are some
reasonable cases to want a Linux box to look like a piece of cable
(e.g. wiretap, timed lockdown, satellite network simulator which
inserts delay and errors, etc.) to the surrounding network.  Of
course, whether seeing just one link out of an aggregation bundle is
useful is debatable, but Linux ought to be able to support it.  I've
been bitten before by adding a new switch into an STP setup and having
it eat STP packets even though STP processing was disabled.  So count
me as another vote for (at least the possibility of) layer 1-esque
transparent bridging.

>
> --
> Ross Vandegrift
> ross@kallisti.us
>
> "If the fight gets hot, the songs get hotter. =C2=A0If the going gets tou=
gh,
> the songs get tougher."
> =C2=A0 =C2=A0 =C2=A0 =C2=A0--Woody Guthrie
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.9 (GNU/Linux)
>
> iEYEARECAAYFAktM8gAACgkQMlMoONfO+HC6UwCgkLsC/ZE4ovcxX1e+A/NV3ELz
> Rp4AoIFyCMtgrMYkxK2k81b9M3n6/v0U
> =3DA5kn
> -----END PGP SIGNATURE-----
>
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/bridge
>
