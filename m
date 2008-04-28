Date: Mon, 28 Apr 2008 13:57:54 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20080428135754.2ae382b4@extreme>
In-Reply-To: <20080128153914.GA5880@localhost>
References: <4766a3d1.02ab100a.0be8.6fdc@mx.google.com>
	<20071217085349.729e5c17@deepthought>
	<20080128153914.GA5880@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCH] Add vlan id to bridge forward database
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jaime Medrano <jaime.medrano@gmail.com>
Cc: bridge@lists.osdl.org

On Mon, 28 Jan 2008 16:39:14 +0100
Jaime Medrano <jaime.medrano@gmail.com> wrote:

> I'm resending this mail since I got no answer.
>=20
> Is there any major problem in this?
>=20
> Stephen Hemminger wrote:
> >
> > What about the nested vlan case?
> >
>=20
> Below is a new patch that handles the double-tagging case. I'm not sure
> if it is worth a more generic case. =C2=BFAre triple-tagging and so reall=
y used?
>=20
> > This is a user/kernel ABI change. Does it break old tools?
>=20
> New patch gets rid of the unused field but it still doesn't break old too=
ls.
>=20
> Anyway, the user part is not really needed. I just think it could be usef=
ul.
>=20
> Regards,
> Jaime.
>=20
> ---
> Subject: [PATCH] Add vlan id to bridge forward database
>=20
> This makes forwarding table aware of 802.1Q vlan ids and stores
> id with MACs in the table. Up to two vlan tags are handled.
>=20
> It solves problems when having same MAC on diffent pairs
> (vlan, port). Current code gets confused at that situation.
>=20
> Local MACs are managed as present on every vlan.

I looked at this, and thought about cleaning it up and putting in
next release but right now can't see how it could work with
vlan accelerated hardware.

Your patch doesn't work if hardware does vlan acceleration. Vlan accelerati=
on
strips the tag off so skb->data points to actual contents and tag is passed
up to vlan_receive_skb out of band. By the time the bridge sees the packet =
the
actual tag is gone.

You might be able to get tag by using some API to reference the VLAN device,
but it all gets complex and racy. Plus not sure if it is really even techni=
cally
correct.
