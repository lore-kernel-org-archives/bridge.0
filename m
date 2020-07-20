Return-Path: <hch@lst.de>
Date: Mon, 20 Jul 2020 19:43:22 +0200
From: Christoph Hellwig <hch@lst.de>
Message-ID: <20200720174322.GA21785@lst.de>
References: <20200720124737.118617-1-hch@lst.de>
 <20200720124737.118617-4-hch@lst.de> <20200720163748.GA1292162@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720163748.GA1292162@gmail.com>
Subject: Re: [Bridge] [PATCH 03/24] net: add a new sockptr_t type
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, linux-sctp@vger.kernel.org, Christoph Hellwig <hch@lst.de>, linux-s390@vger.kernel.org, rds-devel@oss.oracle.com, Daniel Borkmann <daniel@iogearbox.net>, dccp@vger.kernel.org, bridge@lists.linux-foundation.org, linux-afs@lists.infradead.org, lvs-devel@vger.kernel.org, coreteam@netfilter.org, mptcp@lists.01.org, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, linux-can@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, linux-hams@vger.kernel.org, tipc-discussion@lists.sourceforge.net, linux-x25@vger.kernel.org, Eric Dumazet <edumazet@google.com>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, netdev@vger.kernel.org, linux-decnet-user@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org, netfilter-devel@vger.kernel.org, linux-crypto@vger.kernel.org, bpf@vger.kernel.org, linux-wpan@vger.kernel.org, "David S. Miller" <davem@davemloft.net>

On Mon, Jul 20, 2020 at 09:37:48AM -0700, Eric Biggers wrote:
> How does this not introduce a massive security hole when
> CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE?
> 
> AFAICS, userspace can pass in a pointer >= TASK_SIZE,
> and this code makes it be treated as a kernel pointer.

Yeah, we'll need to validate that before initializing the pointer.

But thinking this a little further:  doesn't this mean any
set_fs(KERNEL_DS) that has other user pointers than the one it is
intended for has the same issue?  Pretty much all of these are gone
in mainline now, but in older stable kernels there might be some
interesting cases, especially in the compat ioctl handlers.
