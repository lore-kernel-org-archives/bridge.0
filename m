Return-Path: <Jason@zx2c4.com>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
 :references:in-reply-to:from:date:message-id:subject:to:cc
 :content-type; s=mail; bh=K4YAt33ilBR3hd1+7JojCPxtvSA=; b=nEjdWp
 cUQVj0KWRd87puFx0fk1HADPVt/5ckkL0vcSiVAoyePGSTncp+KafcroE0itJJAR
 hvCKOHIgNqwby+4I13HG5z9ibnxBmqHfVx+jKtrPfvHTnJrmPNg1WsagEKVyYT8s
 0wLLBcv/NIyWIJ2xwHqa/F7Ekuot/H5qUld6hDSAXP06OIRI6q+V7cdk8Ye2E95N
 oE2iYHJELOZGqN2H10I58K4qjsUNSGzPFklfgHdPIOfnKUBe2eF7SiuhT2DW4gmx
 Zlh/4Lwi80eH4MYYZz1R0kvQtczs/XnszWGNGZW6geww/y9D6tsJ0FqJg7QkrUqh
 r9lHeJJo9aIu1+DA==
MIME-Version: 1.0
References: <20200723060908.50081-1-hch@lst.de>
 <20200723060908.50081-13-hch@lst.de>
 <20200727150310.GA1632472@zx2c4.com> <20200727150601.GA3447@lst.de>
 <CAHmME9ric=chLJayn7Erve7WBa+qCKn-+Gjri=zqydoY6623aA@mail.gmail.com>
 <20200727162357.GA8022@lst.de>
 <908ed73081cc42d58a5b01e0c97dbe47@AcuMS.aculab.com>
In-Reply-To: <908ed73081cc42d58a5b01e0c97dbe47@AcuMS.aculab.com>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Tue, 28 Jul 2020 10:17:28 +0200
Message-ID: <CAHmME9pUbRmJq1Qcj10eENt15cuQHkiXJNKrUDmmC18n2mLKDA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Bridge] [PATCH 12/26] netfilter: switch nf_setsockopt to
	sockptr_t
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: David Laight <David.Laight@aculab.com>
Cc: Kernel Hardening <kernel-hardening@lists.openwall.com>, Alexei Starovoitov <ast@kernel.org>, "linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>, Daniel Borkmann <daniel@iogearbox.net>, "dccp@vger.kernel.org" <dccp@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "linux-afs@lists.infradead.org" <linux-afs@lists.infradead.org>, "lvs-devel@vger.kernel.org" <lvs-devel@vger.kernel.org>, "coreteam@netfilter.org" <coreteam@netfilter.org>, "mptcp@lists.01.org" <mptcp@lists.01.org>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>, "linux-hams@vger.kernel.org" <linux-hams@vger.kernel.org>, "tipc-discussion@lists.sourceforge.net" <tipc-discussion@lists.sourceforge.net>, "linux-x25@vger.kernel.org" <linux-x25@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, Netdev <netdev@vger.kernel.org>, "linux-decnet-user@lists.sourceforge.net" <linux-decnet-user@lists.sourceforge.net>, LKML <linux-kernel@vger.kernel.org>, "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, "netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>, Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>

On Tue, Jul 28, 2020 at 10:07 AM David Laight <David.Laight@aculab.com> wrote:
>
> From: Christoph Hellwig
> > Sent: 27 July 2020 17:24
> >
> > On Mon, Jul 27, 2020 at 06:16:32PM +0200, Jason A. Donenfeld wrote:
> > > Maybe sockptr_advance should have some safety checks and sometimes
> > > return -EFAULT? Or you should always use the implementation where
> > > being a kernel address is an explicit bit of sockptr_t, rather than
> > > being implicit?
> >
> > I already have a patch to use access_ok to check the whole range in
> > init_user_sockptr.
>
> That doesn't make (much) difference to the code paths that ignore
> the user-supplied length.
> OTOH doing the user/kernel check on the base address (not an
> incremented one) means that the correct copy function is always
> selected.

Right, I had the same reaction in reading this, but actually, his code
gets rid of the sockptr_advance stuff entirely and never mutates, so
even though my point about attacking those pointers was missed, the
code does the better thing now -- checking the base address and never
mutating the pointer. So I think we're good.

>
> Perhaps the functions should all be passed a 'const sockptr_t'.
> The typedef could be made 'const' - requiring non-const items
> explicitly use the union/struct itself.

I was thinking the same, but just by making the pointers inside the
struct const. However, making the whole struct const via the typedef
is a much better idea. That'd probably require changing the signature
of init_user_sockptr a bit, which would be fine, but indeed I think
this would be a very positive change.

Jason
