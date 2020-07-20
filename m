Return-Path: <ebiggers@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1595267745;
 bh=gKIze89vWBzrFx6zTW6q8+6OGOi2eEHSp9M1U5xgK5Q=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=IVyIlrMN24MPKjy4d8SMWaW7uCiUcpLg3yjCC0C2S6ZfKpknKzmS2DwkqaZUR6kcj
 eH3tVcf8T0FWz3MgsFZPKw/95GZuUU1R6RXP6YgHYNC1Xrh1jm83A8jQXDelAkEKiB
 ufMchI7Ce61Y9ZnRUJK/bZ/+BU6OKViPemeOOMWQ=
Date: Mon, 20 Jul 2020 10:55:43 -0700
From: Eric Biggers <ebiggers@kernel.org>
Message-ID: <20200720175543.GF1292162@gmail.com>
References: <20200720124737.118617-1-hch@lst.de>
 <20200720124737.118617-4-hch@lst.de>
 <20200720163748.GA1292162@gmail.com>
 <20200720174322.GA21785@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720174322.GA21785@lst.de>
Subject: Re: [Bridge] [PATCH 03/24] net: add a new sockptr_t type
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Christoph Hellwig <hch@lst.de>
Cc: Alexei Starovoitov <ast@kernel.org>, linux-sctp@vger.kernel.org, linux-afs@lists.infradead.org, linux-s390@vger.kernel.org, rds-devel@oss.oracle.com, Daniel Borkmann <daniel@iogearbox.net>, dccp@vger.kernel.org, bridge@lists.linux-foundation.org, lvs-devel@vger.kernel.org, coreteam@netfilter.org, mptcp@lists.01.org, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, linux-can@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, linux-hams@vger.kernel.org, tipc-discussion@lists.sourceforge.net, linux-x25@vger.kernel.org, Eric Dumazet <edumazet@google.com>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, netdev@vger.kernel.org, linux-decnet-user@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org, netfilter-devel@vger.kernel.org, linux-crypto@vger.kernel.org, bpf@vger.kernel.org, linux-wpan@vger.kernel.org, "David S. Miller" <davem@davemloft.net>

On Mon, Jul 20, 2020 at 07:43:22PM +0200, Christoph Hellwig wrote:
> On Mon, Jul 20, 2020 at 09:37:48AM -0700, Eric Biggers wrote:
> > How does this not introduce a massive security hole when
> > CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE?
> > 
> > AFAICS, userspace can pass in a pointer >= TASK_SIZE,
> > and this code makes it be treated as a kernel pointer.
> 
> Yeah, we'll need to validate that before initializing the pointer.
> 
> But thinking this a little further:  doesn't this mean any
> set_fs(KERNEL_DS) that has other user pointers than the one it is
> intended for has the same issue?  Pretty much all of these are gone
> in mainline now, but in older stable kernels there might be some
> interesting cases, especially in the compat ioctl handlers.

Yes.  I thought that eliminating that class of bug is one of the main
motivations for your "remove set_fs" work.  See commit 128394eff343
("sg_write()/bsg_write() is not fit to be called under KERNEL_DS") for a case
where this type of bug was fixed.

Are you aware of any specific cases that weren't already fixed?  If there are
any, they need to be urgently fixed.

- Eric
