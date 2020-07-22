Return-Path: <alexei.starovoitov@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nqelWpCqH7nOe0oSyngzrBNpGRC3PyDyz91JHpls3Xk=;
 b=QbFOpYWq197fvdaI4E7hogiJ5z6DhlnMwFbSAyObyOYxQk/ojAWvAxU5xeCwIzRoyp
 bGpv6okHRbaDCk3F5IJgGXS3Wesi1t0HKLxD0rWbntKFa+o4FEuZ/aNqddB2gT9rJhFi
 ekTLt46VwAAqYYSOS+Ti6gpiM2sULyDbPlDxrV2EC1wYfvYmkCiCMfUA2sia4+eUOZSm
 DpKqJKTrsnJtuquGnG9/42hXesw1S5DhQmqbpijEy6OLbaHF8RyBbV+paN+wC914K+DB
 Om2JyFGEZL8bVoXG7xFZFOn3b/hxnJAALpQKOVax/+9YzLSzmIzDLinAT6/sMjMDDXxC
 pBiA==
MIME-Version: 1.0
References: <20200720124737.118617-1-hch@lst.de>
 <20200720204756.iengwcguikj2yrxt@ast-mbp.dhcp.thefacebook.com>
 <20200722075657.GB26554@lst.de>
In-Reply-To: <20200722075657.GB26554@lst.de>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 22 Jul 2020 10:09:41 -0700
Message-ID: <CAADnVQKy0+rsRftEzp4PvxQtj7uOwybz0Nd4_h0FR37p2Q=X4w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Bridge] get rid of the address_space override in setsockopt
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Christoph Hellwig <hch@lst.de>
Cc: Alexei Starovoitov <ast@kernel.org>, linux-sctp@vger.kernel.org, linux-afs@lists.infradead.org, linux-s390 <linux-s390@vger.kernel.org>, rds-devel@oss.oracle.com, Daniel Borkmann <daniel@iogearbox.net>, dccp@vger.kernel.org, "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>, lvs-devel@vger.kernel.org, coreteam@netfilter.org, mptcp@lists.01.org, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, linux-can@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, linux-hams@vger.kernel.org, tipc-discussion@lists.sourceforge.net, linux-x25@vger.kernel.org, Eric Dumazet <edumazet@google.com>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, Network Development <netdev@vger.kernel.org>, linux-decnet-user@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>, linux-bluetooth@vger.kernel.org, netfilter-devel <netfilter-devel@vger.kernel.org>, Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, bpf <bpf@vger.kernel.org>, linux-wpan@vger.kernel.org, "David S. Miller" <davem@davemloft.net>

On Wed, Jul 22, 2020 at 12:56 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Mon, Jul 20, 2020 at 01:47:56PM -0700, Alexei Starovoitov wrote:
> > > a kernel pointer.  This is something that works for most common sockopts
> > > (and is something that the ePBF support relies on), but unfortunately
> > > in various corner cases we either don't use the passed in length, or in
> > > one case actually copy data back from setsockopt, so we unfortunately
> > > can't just always do the copy in the highlevel code, which would have
> > > been much nicer.
> >
> > could you rebase on bpf-next tree and we can route it this way then?
> > we'll also test the whole thing before applying.
>
> The bpf-next tree is missing all my previous setsockopt cleanups, so
> there series won't apply.

Right. I've realized that after sending that email two days ago.
Now bpf-next->net-next PR is pending and as soon as it's merged
bpf-next will have all the recent bits.
