Date: Wed, 12 Nov 2003 13:18:06 -0800
From: Stephen Hemminger <shemminger@osdl.org>
Message-Id: <20031112131806.2fdfccd1.shemminger@osdl.org>
In-Reply-To: <20031028112416.GA32122@prolix.local.igalia.com>
References: <20031028112416.GA32122@prolix.local.igalia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Bridge] Re: [ethernet bridge] 802.1G ampliation
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: "=?ISO-8859-1?Q?Jos=E9?= J. =?ISO-8859-1?Q?Gonz=E1lez?= Alonso" <jjgonzalez@igalia.com>
Cc: bridge@osdl.org

On Tue, 28 Oct 2003 12:24:16 +0100
Jos=E9 J. Gonz=E1lez Alonso <jjgonzalez@igalia.com> wrote:

> Hi!=20
>=20
> I am very interested in your project. Concretely, I am interested in the
> possibility of extending your implementation so that it fulfills the
> specifications of 802.1G. I read this specifications and they seem
> "simple" extensions of 802.1D standard.
>=20
> what do you think about?=20
> would be it very hard?
> Is there any documentation of your code?=20
> (to read the code directly is being a little tedious)
>=20
> Regards,
> 	Jos=E9 J. Gonz=E1lez Alonso
>=20

There have been several discussions about this, but very little in concrete=
 work.
The bridge mailing list might have others that have done something.

A long term goal is to move all the discovery and spanning tree out of the =
kernel
and into a user space process.  This user space process would use netlink to
see interface state changes and as API to the bridge driver.  Also a new im=
plementation
in user space could use the standard LLC interface to read bridge spanning =
tree traffic.

Unfortunately, I don't have a lot of time to dedicate to new feature work r=
ight now,
especially when 2.6 is trying to get released.

