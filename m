Return-Path: <david.laight@aculab.com>
From: David Laight <David.Laight@ACULAB.COM>
Date: Tue, 21 Jul 2020 10:14:20 +0000
Message-ID: <6727969f2f6e467fa2d43f9773cefa27@AcuMS.aculab.com>
References: <20200720124737.118617-1-hch@lst.de>
 <20200720124737.118617-4-hch@lst.de>
In-Reply-To: <20200720124737.118617-4-hch@lst.de>
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
To: 'Christoph Hellwig' <hch@lst.de>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, Eric Dumazet <edumazet@google.com>
Cc: "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>, "linux-decnet-user@lists.sourceforge.net" <linux-decnet-user@lists.sourceforge.net>, "tipc-discussion@lists.sourceforge.net" <tipc-discussion@lists.sourceforge.net>, "linux-x25@vger.kernel.org" <linux-x25@vger.kernel.org>, "dccp@vger.kernel.org" <dccp@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "lvs-devel@vger.kernel.org" <lvs-devel@vger.kernel.org>, "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, "linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>, "coreteam@netfilter.org" <coreteam@netfilter.org>, "netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>, "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>, "linux-hams@vger.kernel.org" <linux-hams@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>, "linux-afs@lists.infradead.org" <linux-afs@lists.infradead.org>, "mptcp@lists.01.org" <mptcp@lists.01.org>

From: Christoph Hellwig
> Sent: 20 July 2020 13:47
>=20
> Add a uptr_t type that can hold a pointer to either a user or kernel
> memory region, and simply helpers to copy to and from it.  For
> architectures like x86 that have non-overlapping user and kernel
> address space it just is a union and uses a TASK_SIZE check to
> select the proper copy routine.  For architectures with overlapping
> address spaces a flag to indicate the address space is used instead.
>=20
...
> +#else /* CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE */
> +typedef struct {
> +=09union {
> +=09=09void=09=09*kernel;
> +=09=09void __user=09*user;
> +=09};
> +=09bool=09=09is_kernel : 1;
> +} sockptr_t;

If you need to do that you might as well make it a struct
where either the kernel or user address is defined.
Far safer for all architectures.

Indeed you could add the length (to save passing an
extra parameter through the layers).

The system call code could even copy the code into a
kernel buffer (setting both pointers).
So that code that didn't need to access beyond the end
of the implied buffer (most of it) could just access the
kernel buffer.

For getsockopt() you'd need some way of supressing the
'default' copy back of the user buffer.

This would also allow some of the sctp getsockopt to
read (usually 4 bytes) from the 'user' buffer without
the wrapper code always having to read in the entire
user buffer.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)

