Return-Path: <david.laight@aculab.com>
From: David Laight <David.Laight@ACULAB.COM>
Date: Thu, 23 Jul 2020 11:16:16 +0000
Message-ID: <621e193e4af74d8198ed87d6a9ce8260@AcuMS.aculab.com>
References: <20200723060908.50081-1-hch@lst.de>
 <20200723060908.50081-14-hch@lst.de>
In-Reply-To: <20200723060908.50081-14-hch@lst.de>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCH 13/26] bpfilter: switch bpfilter_ip_set_sockopt
 to sockptr_t
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
> Sent: 23 July 2020 07:09
>=20
> This is mostly to prepare for cleaning up the callers, as bpfilter by
> design can't handle kernel pointers.

You've failed to fix the sense of the above...

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)

