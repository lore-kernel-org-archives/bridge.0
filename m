Date: Mon, 17 Mar 2008 11:35:37 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20080317113537.496d9347@extreme>
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


Minor stuff:
1. Please use shorter variable names, rather than:
              unsigned short vlan_first_id;
      I would choose:
              u16 vlan1;

2. You probably can use skb->protocol rather than having to look at the pac=
ket
    contents to check for 8021Q.

3. Don't use __constant_htons(), just use htons().
   The macro is smart enough to handle the
   constant case, and it reads better, without the __constant_prefix.


Major stuff:
1. This won't work with hardware accel VLAN receive. The tag is not put in
   the skb?

