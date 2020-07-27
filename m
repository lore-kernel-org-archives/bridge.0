Return-Path: <david.laight@aculab.com>
From: David Laight <David.Laight@ACULAB.COM>
Date: Mon, 27 Jul 2020 13:24:45 +0000
Message-ID: <8c747034a5b641d18734de5f4d3a7507@AcuMS.aculab.com>
References: <20200723060908.50081-1-hch@lst.de>
 <20200723060908.50081-20-hch@lst.de> <20200727121505.GA1804864@shredder>
In-Reply-To: <20200727121505.GA1804864@shredder>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCH 19/26] net/ipv6: switch ipv6_flowlabel_opt to
	sockptr_t
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: 'Ido Schimmel' <idosch@idosch.org>, Christoph Hellwig <hch@lst.de>
Cc: Alexei Starovoitov <ast@kernel.org>, "linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>, "linux-afs@lists.infradead.org" <linux-afs@lists.infradead.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>, Daniel Borkmann <daniel@iogearbox.net>, "dccp@vger.kernel.org" <dccp@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "lvs-devel@vger.kernel.org" <lvs-devel@vger.kernel.org>, "coreteam@netfilter.org" <coreteam@netfilter.org>, "mptcp@lists.01.org" <mptcp@lists.01.org>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>, "linux-hams@vger.kernel.org" <linux-hams@vger.kernel.org>, "tipc-discussion@lists.sourceforge.net" <tipc-discussion@lists.sourceforge.net>, "linux-x25@vger.kernel.org" <linux-x25@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-decnet-user@lists.sourceforge.net" <linux-decnet-user@lists.sourceforge.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, "netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>, "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>

From: Ido Schimmel
> Sent: 27 July 2020 13:15
> On Thu, Jul 23, 2020 at 08:09:01AM +0200, Christoph Hellwig wrote:
> > Pass a sockptr_t to prepare for set_fs-less handling of the kernel
> > pointer from bpf-cgroup.
> >
> > Note that the get case is pretty weird in that it actually copies data
> > back to userspace from setsockopt.
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  include/net/ipv6.h       |  2 +-
> >  net/ipv6/ip6_flowlabel.c | 16 +++++++++-------
> >  net/ipv6/ipv6_sockglue.c |  2 +-
> >  3 files changed, 11 insertions(+), 9 deletions(-)
> >
> > diff --git a/include/net/ipv6.h b/include/net/ipv6.h
> > index 262fc88dbd7e2f..4c9d89b5d73268 100644
> > --- a/include/net/ipv6.h
> > +++ b/include/net/ipv6.h
> > @@ -406,7 +406,7 @@ struct ipv6_txoptions *fl6_merge_options(struct ipv=
6_txoptions *opt_space,
> >  =09=09=09=09=09 struct ip6_flowlabel *fl,
> >  =09=09=09=09=09 struct ipv6_txoptions *fopt);
> >  void fl6_free_socklist(struct sock *sk);
> > -int ipv6_flowlabel_opt(struct sock *sk, char __user *optval, int optle=
n);
> > +int ipv6_flowlabel_opt(struct sock *sk, sockptr_t optval, int optlen);
> >  int ipv6_flowlabel_opt_get(struct sock *sk, struct in6_flowlabel_req *=
freq,
> >  =09=09=09   int flags);
> >  int ip6_flowlabel_init(void);
> > diff --git a/net/ipv6/ip6_flowlabel.c b/net/ipv6/ip6_flowlabel.c
> > index 27ee6de9beffc4..6b3c315f3d461a 100644
> > --- a/net/ipv6/ip6_flowlabel.c
> > +++ b/net/ipv6/ip6_flowlabel.c
> > @@ -371,7 +371,7 @@ static int fl6_renew(struct ip6_flowlabel *fl, unsi=
gned long linger, unsigned lo
> >
> >  static struct ip6_flowlabel *
> >  fl_create(struct net *net, struct sock *sk, struct in6_flowlabel_req *=
freq,
> > -=09  char __user *optval, int optlen, int *err_p)
> > +=09  sockptr_t optval, int optlen, int *err_p)
> >  {
> >  =09struct ip6_flowlabel *fl =3D NULL;
> >  =09int olen;
> > @@ -401,7 +401,8 @@ fl_create(struct net *net, struct sock *sk, struct =
in6_flowlabel_req *freq,
> >  =09=09memset(fl->opt, 0, sizeof(*fl->opt));
> >  =09=09fl->opt->tot_len =3D sizeof(*fl->opt) + olen;
> >  =09=09err =3D -EFAULT;
> > -=09=09if (copy_from_user(fl->opt+1, optval+CMSG_ALIGN(sizeof(*freq)), =
olen))
> > +=09=09sockptr_advance(optval, CMSG_ALIGN(sizeof(*freq)));
> > +=09=09if (copy_from_sockptr(fl->opt + 1, optval, olen))
> >  =09=09=09goto done;
> >
> >  =09=09msg.msg_controllen =3D olen;
> > @@ -604,7 +605,7 @@ static int ipv6_flowlabel_renew(struct sock *sk, st=
ruct in6_flowlabel_req *freq)
> >  }
> >
> >  static int ipv6_flowlabel_get(struct sock *sk, struct in6_flowlabel_re=
q *freq,
> > -=09=09void __user *optval, int optlen)
> > +=09=09sockptr_t optval, int optlen)
> >  {
> >  =09struct ipv6_fl_socklist *sfl, *sfl1 =3D NULL;
> >  =09struct ip6_flowlabel *fl, *fl1 =3D NULL;
> > @@ -702,8 +703,9 @@ static int ipv6_flowlabel_get(struct sock *sk, stru=
ct in6_flowlabel_req *freq,
> >  =09=09goto recheck;
> >
> >  =09if (!freq->flr_label) {
> > -=09=09if (copy_to_user(&((struct in6_flowlabel_req __user *) optval)->=
flr_label,
> > -=09=09=09=09 &fl->label, sizeof(fl->label))) {
> > +=09=09sockptr_advance(optval,
> > +=09=09=09=09offsetof(struct in6_flowlabel_req, flr_label));
>=20
> Christoph,
>=20
> I see a regression with IPv6 flowlabel that I bisected to this patch.
> When passing '-F 0' to 'ping' the flow label should be random, yet it's
> the same every time after this patch.
>=20
> It seems that the pointer is never advanced after the call to
> sockptr_advance() because it is passed by value and not by reference.
> Even if you were to pass it by reference I think you would later need to
> call sockptr_decrease() or something similar. Otherwise it is very
> error-prone.

Depending on the other checks you may also be able to cross from
user addresses to kernel ones.
At the minimum sockptr_advance() has to fail if the boundary
would be crossed.

> Maybe adding an offset to copy_to_sockptr() and copy_from_sockptr() is
> better?

The 'is this a kernel or user copy' needs to use the base
address from the system call.
So you do need the offset passed in to copy_to/from_sockptr().

Clearly churn can be reduced by using a #define or static inline
for the common case.

The alternative is to pass a 'fat pointer' through than can
contain an offset as well as the user/kernel bases and
expected length.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)

