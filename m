Return-Path: <lorenzo@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1643209238;
 bh=ZmlWB7oHgY4EUnBee2pldpeTuBsyuIALVfTUMB0azg0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=pqbjYQZfZ7lixZCQlNjBWxdELqePWgf6CgBwjPK2K1FpZxU69BYSrU5NDWr+VShbD
 MKE9vO0yVgcGcKncMgHq24YGoVp8WbZLhiZxdWHwUtwYEKA853hnlN+8hsLnmGEHJq
 O2lcF7NeLzLxIpVObp6DM8OZax/rcyfrgVumVzLh1lgeatJuPUxKrnEEkA//r08TtD
 5qcGQFptJMe02O2qH9XaH60zKnBl5Ci+k9+I2DyWkCdf6TVz0k5SRpO/bxTx6hSX4M
 RHUYElrvOXB9C7Up0paU3kPBri8zlo70vMWsK8693nziN7Mtjh5esVUK0sfLjUzjkr
 TVG5ymCpRUmOQ==
Date: Wed, 26 Jan 2022 16:00:34 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
Message-ID: <YfFiEgNHwo7o78vq@lore-desk>
References: <cover.1643044381.git.lorenzo@kernel.org>
 <720907692575488526f06edc2cf5c8f783777d4f.1643044381.git.lorenzo@kernel.org>
 <61553c87-a3d3-07ae-8c2f-93cf0cb52263@nvidia.com>
 <YfEwLrB6JqNpdUc0@lore-desk>
 <113d070a-6df1-66c2-1586-94591bc5aada@nvidia.com>
 <878rv23bkk.fsf@toke.dk>
 <499142da-2b16-4d94-48b0-8141506e79e3@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="OSlkpr/o/h7btl8h"
Content-Disposition: inline
In-Reply-To: <499142da-2b16-4d94-48b0-8141506e79e3@nvidia.com>
Subject: Re: [Bridge] [RFC bpf-next 1/2] net: bridge: add unstable
 br_fdb_find_port_from_ifindex helper
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@nvidia.com>
Cc: "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, daniel@iogearbox.net, Roopa Prabhu <roopa@nvidia.com>, netdev@vger.kernel.org, dsahern@kernel.org, Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>, komachi.yoshiki@gmail.com, ast@kernel.org, davem@davemloft.net, Ido Schimmel <idosch@idosch.org>, memxor@gmail.com, brouer@redhat.com, kuba@kernel.org, bpf@vger.kernel.org, andrii.nakryiko@gmail.com, lorenzo.bianconi@redhat.com


--OSlkpr/o/h7btl8h
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On 26/01/2022 14:50, Toke H=F8iland-J=F8rgensen wrote:
> > Nikolay Aleksandrov <nikolay@nvidia.com> writes:
> >=20
> >> On 26/01/2022 13:27, Lorenzo Bianconi wrote:
> >>>> On 24/01/2022 19:20, Lorenzo Bianconi wrote:
> >>>>> Similar to bpf_xdp_ct_lookup routine, introduce
> >>>>> br_fdb_find_port_from_ifindex unstable helper in order to accelerate
> >>>>> linux bridge with XDP. br_fdb_find_port_from_ifindex will perform a
> >>>>> lookup in the associated bridge fdb table and it will return the
> >>>>> output ifindex if the destination address is associated to a bridge
> >>>>> port or -ENODEV for BOM traffic or if lookup fails.
> >>>>>
> >>>>> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> >>>>> ---
> >>>>>  net/bridge/br.c         | 21 +++++++++++++
> >>>>>  net/bridge/br_fdb.c     | 67 +++++++++++++++++++++++++++++++++++--=
----
> >>>>>  net/bridge/br_private.h | 12 ++++++++
> >>>>>  3 files changed, 91 insertions(+), 9 deletions(-)
> >>>>>
> >>>>
> >>>> Hi Lorenzo,
> >>>
> >>> Hi Nikolay,
> >>>
> >>> thx for the review.
> >>>
> >>>> Please CC bridge maintainers for bridge-related patches, I've added =
Roopa and the
> >>>> bridge mailing list as well. Aside from that, the change is certainl=
y interesting, I've been
> >>>> thinking about a similar helper for some time now, few comments belo=
w.
> >>>
> >>> yes, sorry for that. I figured it out after sending the series out.
> >>>
> >>>>
> >>>> Have you thought about the egress path and if by the current bridge =
state the packet would
> >>>> be allowed to egress through the found port from the lookup? I'd gue=
ss you have to keep updating
> >>>> the active ports list based on netlink events, but there's a lot of =
egress bridge logic that
> >>>> either have to be duplicated or somehow synced. Check should_deliver=
() (br_forward.c) and later
> >>>> egress stages, but I see how this is a good first step and perhaps w=
e can build upon it.
> >>>> There are a few possible solutions, but I haven't tried anything yet=
, most obvious being
> >>>> yet another helper. :)
> >>>
> >>> ack, right but I am bit worried about adding too much logic and slow =
down xdp
> >>> performances. I guess we can investigate first the approach proposed =
by Alexei
> >>> and then revaluate. Agree?
> >>>
> >>
> >> Sure, that approach sounds very interesting, but my point was that
> >> bypassing the ingress and egress logic defeats most of the bridge
> >> features. You just get an fdb hash table which you can build today
> >> with ebpf without any changes to the kernel. :) You have multiple
> >> states, flags and options for each port and each vlan which can change
> >> dynamically based on external events (e.g. STP, config changes etc)
> >> and they can affect forwarding even if the fdbs remain in the table.
> >=20
> > To me, leveraging all this is precisely the reason to have BPF helpers
> > instead of just replicating state in BPF maps: it's very easy to do that
> > and show a nice speedup, and then once you get all the corner cases
> > covered that the in-kernel code already deals with, you've chipped away
> > at that speedup and spent a lot of time essentially re-writing the
> > battle-tested code already in the kernel.
> >=20
> > So I think figuring out how to do the state sync is the right thing to
> > do; a second helper would be fine for this, IMO, but I'm not really
> > familiar enough with the bridge code to really have a qualified opinion.
> >=20
> > -Toke
> >=20
>=20
> Right, sounds good to me. IMO it should be required in order to get a mea=
ningful bridge
> speedup, otherwise the solution is incomplete and you just do simple look=
ups that ignore
> all of the state that could impact the forwarding decision.

ack, I agree but I need to review it first since I am not so familiar
with that codebase :)
Doing so we can compare this solution with the one proposed by Alexei.

Regards,
Lorenzo

>=20
> Cheers,
>  Nik

--OSlkpr/o/h7btl8h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYfFiEgAKCRA6cBh0uS2t
rBX0AP970Tqrve/nXSLkopFCEuLZea5q0NCx3xs7Gbf0S76AAAD8CTp3W8h7ZG17
TTj9kv5ZzIJ/AyBF9f0UGoVCRYGvuwI=
=2a4l
-----END PGP SIGNATURE-----

--OSlkpr/o/h7btl8h--
