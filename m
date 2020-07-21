Return-Path: <david.laight@aculab.com>
From: David Laight <David.Laight@ACULAB.COM>
Date: Tue, 21 Jul 2020 09:55:20 +0000
Message-ID: <9b7ae3245bad474db2a3889bc1c1a329@AcuMS.aculab.com>
References: <20200720124737.118617-1-hch@lst.de>
 <20200720124737.118617-4-hch@lst.de> <20200720163748.GA1292162@gmail.com>
In-Reply-To: <20200720163748.GA1292162@gmail.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCH 03/24] net: add a new sockptr_t type
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: 'Eric Biggers' <ebiggers@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Alexei Starovoitov <ast@kernel.org>, "linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>, "linux-afs@lists.infradead.org" <linux-afs@lists.infradead.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>, Daniel Borkmann <daniel@iogearbox.net>, "dccp@vger.kernel.org" <dccp@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "lvs-devel@vger.kernel.org" <lvs-devel@vger.kernel.org>, "coreteam@netfilter.org" <coreteam@netfilter.org>, "mptcp@lists.01.org" <mptcp@lists.01.org>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>, "linux-hams@vger.kernel.org" <linux-hams@vger.kernel.org>, "tipc-discussion@lists.sourceforge.net" <tipc-discussion@lists.sourceforge.net>, "linux-x25@vger.kernel.org" <linux-x25@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-decnet-user@lists.sourceforge.net" <linux-decnet-user@lists.sourceforge.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, "netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>, "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>

From: Eric Biggers
> Sent: 20 July 2020 17:38
...
> How does this not introduce a massive security hole when
> CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE?
>=20
> AFAICS, userspace can pass in a pointer >=3D TASK_SIZE,
> and this code makes it be treated as a kernel pointer.

One thought I've had is that on 64-bit architectures there
is almost always some part of the KVA that can never be valid
and is larger than the maximum size of a user VA.

If the user address is offset into this invalid area
then it can always be distinguished from a kernel address.

Indeed it may be worth considering offsetting kernel
addresses as well.

This forces code to use the correct accessors.

It doesn't solve the problem for 32bit systems with
CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE since
they are likely to have all 32bit addresses available
to both use and kernel.

If you end up with a 'fat pointer' then it may be worth
adding the length and making it a 'buffer descriptor'.
This can then be passed by address and the reduced
number of parameters will probably offset the cost
of the extra indirection.

The read/write functions could then take the 'buffer descriptor',
offset and length as parameters.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)

