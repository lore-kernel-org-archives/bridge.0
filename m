Message-Id: <4B17BFE5020000C70007C8C6@soto.provo.novell.com>
Date: Thu, 03 Dec 2009 13:40:53 -0700
From: "Patrick Mullaney" <pmullaney@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Subject: Re: [Bridge] [PATCH 3/3] macvlan: allow in-kernel modules to create
	and	 manage macvlan devices
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: arnd@arndb.de
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, alacrityvm-devel@lists.sourceforge.net

On Fri, 2009-11-27 at 23:14 +0100, Arnd Bergmann wrote:
> On Friday 13 November 2009, Patrick Mullaney wrote:
> >=20
> > The macvlan driver didn't allow for creation/deletion of devices
> > by other in-kernel modules. This patch provides common routines
> > for both in-kernel and netlink based management. This patch
> > also enables macvlan device support for gro for lower level
> > devices that support gro.
>=20
> I wonder if doing this way round is a good idea, why don't
> you just use netlink to set up the endpoint device like
> the current macvlan and macvtap do? I think doing it consistently
> for all backends would be a significant advantage.

sorry for the late response - I'm thinking about re-implementing
this along the lines that you are talking about. Especially in light
of your new configuration options. The reason(probably short sighted)
for the previous approach was that the creation step was already being
handled in our venet driver(but it doesn't have to be).

Thanks for the suggestion.
Patrick

>=20
> 	Arnd <><

