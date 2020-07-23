Return-Path: <david.laight@aculab.com>
From: David Laight <David.Laight@ACULAB.COM>
Date: Thu, 23 Jul 2020 14:56:33 +0000
Message-ID: <5fc6b1716f1b4534bda95bab49512754@AcuMS.aculab.com>
References: <20200723060908.50081-1-hch@lst.de>
 <20200723060908.50081-4-hch@lst.de>
 <c3dc5b4d84e64230bb6ca8df7bb70705@AcuMS.aculab.com>
 <20200723144455.GA12280@lst.de>
In-Reply-To: <20200723144455.GA12280@lst.de>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCH 03/26] bpfilter: reject kernel addresses
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: 'Christoph Hellwig' <hch@lst.de>
Cc: Alexei Starovoitov <ast@kernel.org>, "linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>, "linux-afs@lists.infradead.org" <linux-afs@lists.infradead.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>, Daniel Borkmann <daniel@iogearbox.net>, "dccp@vger.kernel.org" <dccp@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "lvs-devel@vger.kernel.org" <lvs-devel@vger.kernel.org>, "coreteam@netfilter.org" <coreteam@netfilter.org>, "mptcp@lists.01.org" <mptcp@lists.01.org>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>, "linux-hams@vger.kernel.org" <linux-hams@vger.kernel.org>, "tipc-discussion@lists.sourceforge.net" <tipc-discussion@lists.sourceforge.net>, "linux-x25@vger.kernel.org" <linux-x25@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-decnet-user@lists.sourceforge.net" <linux-decnet-user@lists.sourceforge.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, "netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>, "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>

From: 'Christoph Hellwig'
> Sent: 23 July 2020 15:45
>=20
> On Thu, Jul 23, 2020 at 02:42:11PM +0000, David Laight wrote:
> > From: Christoph Hellwig
> > > Sent: 23 July 2020 07:09
> > >
> > > The bpfilter user mode helper processes the optval address using
> > > process_vm_readv.  Don't send it kernel addresses fed under
> > > set_fs(KERNEL_DS) as that won't work.
> >
> > What sort of operations is the bpf filter doing on the sockopt buffers?
> >
> > Any attempts to reject some requests can be thwarted by a second
> > application thread modifying the buffer after the bpf filter has
> > checked that it allowed.
> >
> > You can't do security by reading a user buffer twice.
>=20
> I'm not saying that I approve of the design, but the current bpfilter
> design uses process_vm_readv to access the buffer, which obviously does
> not work with kernel buffers.

Is this a different bit of bpf that that which used to directly
intercept setsockopt() requests and pass them down from a kernel buffer?

I can't held feeling that bpf is getting 'too big for its boots' and
will have a local-user privilege escalation hiding in it somewhere.

I've had to fix my 'out of tree' driver to remove the [sg]etsockopt()
calls. Some of the replacements will go badly wrong if I've accidentally
lost track of the socket type.
I do have a daemon process sleeping in the driver - so I can wake it up
and make the requests from it with a user buffer.
I may have to implement that to get the negotiated number of 'ostreams'
to an SCTP connection.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)

