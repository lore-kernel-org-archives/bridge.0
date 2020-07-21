Return-Path: <viro@ftp.linux.org.uk>
Date: Tue, 21 Jul 2020 06:28:21 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
Message-ID: <20200721052821.GS2786714@ZenIV.linux.org.uk>
References: <20200720124737.118617-1-hch@lst.de>
 <20200720124737.118617-3-hch@lst.de>
 <20200721024016.2talwdt5hjqvirr6@ltop.local>
 <20200721052326.GA10071@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721052326.GA10071@lst.de>
Sender: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [Bridge] [PATCH 02/24] bpfilter: fix up a sparse annotation
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Christoph Hellwig <hch@lst.de>
Cc: Alexei Starovoitov <ast@kernel.org>, linux-sctp@vger.kernel.org, linux-afs@lists.infradead.org, linux-s390@vger.kernel.org, rds-devel@oss.oracle.com, Daniel Borkmann <daniel@iogearbox.net>, dccp@vger.kernel.org, bridge@lists.linux-foundation.org, lvs-devel@vger.kernel.org, coreteam@netfilter.org, mptcp@lists.01.org, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, linux-can@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, linux-hams@vger.kernel.org, tipc-discussion@lists.sourceforge.net, linux-x25@vger.kernel.org, Eric Dumazet <edumazet@google.com>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, netdev@vger.kernel.org, linux-decnet-user@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org, netfilter-devel@vger.kernel.org, linux-crypto@vger.kernel.org, bpf@vger.kernel.org, linux-wpan@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

On Tue, Jul 21, 2020 at 07:23:26AM +0200, Christoph Hellwig wrote:
> On Tue, Jul 21, 2020 at 04:40:16AM +0200, Luc Van Oostenryck wrote:
> > >  	req.pid = current->pid;
> > >  	req.cmd = optname;
> > > -	req.addr = (long __force __user)optval;
> > > +	req.addr = (__force long)optval;
> > 
> > For casts to integers, even '__force' is not needed (since integers
> > can't be dereferenced, the concept of address-space is meaningless
> > for them, so it's never useful to warn when it's dropped and
> > '__force' is thus not needed).
> 
> That's what I thought. but if I remove it here I actually do get a
> warning:
> 
> CHECK   net/bpfilter/bpfilter_kern.c
> net/bpfilter/bpfilter_kern.c:52:21: warning: cast removes address space '__user' of expression

Cast to unsigned long.  Or to uintptr_t if you want to be fancy.
