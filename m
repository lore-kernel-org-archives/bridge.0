Return-Path: <dan.carpenter@oracle.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=zAw1u07pbRDu+xvWXDwgv7P7rAeqqEG3qCROxNYz4Qw=;
 b=WcR2EviD0S8hW4M2rvwjYzJmQw4FXWXPBUrrFqEw1sUnEyiMbxupFvOgeiaqsO35y4jQ
 CPzN4RPWZ6CN7vjd6wBYwrtQUBjUMj9m0EAj6CSAN7hZzaajn1ZSnKnNebi9STjS87+w
 JKL62APs7QzHF9pg28671gwh0ONBuSPHok4+1ywoLlXr3HhK4IfhyKSbOVhikEcTfkxF
 9stgAB1nQtebaQ/IRHWLcG1ceA7kwj4KhpyGXBYsO9ItnyKUCR3Cg7SuHMkRyzT2Y+Ua
 jnI2GFQJ+lm1iENMft9tc6tPnnqNuUZR+w0R92TuT1D5sfFSWNj5/xpNnLmioaAkH55q Bw== 
Date: Thu, 21 May 2020 17:59:21 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
Message-ID: <20200521145921.GJ30374@kadam>
References: <0000000000007b211005a6187dc9@google.com>
 <20200521140803.GI30374@kadam>
 <CACT4Y+bzz-h5vNGH0rDMUiuGZVX01oXawXAPbjtnNHb1KVWSvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+bzz-h5vNGH0rDMUiuGZVX01oXawXAPbjtnNHb1KVWSvg@mail.gmail.com>
Subject: Re: [Bridge] KASAN: slab-out-of-bounds Read in br_mrp_parse
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, netdev <netdev@vger.kernel.org>, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, syzkaller-bugs <syzkaller-bugs@googlegroups.com>, LKML <linux-kernel@vger.kernel.org>, horatiu.vultur@microchip.com, syzbot <syzbot+9c6f0f1f8e32223df9a4@syzkaller.appspotmail.com>, syzkaller <syzkaller@googlegroups.com>, kuba@kernel.org, David Miller <davem@davemloft.net>

On Thu, May 21, 2020 at 04:28:05PM +0200, 'Dmitry Vyukov' via syzkaller-bugs wrote:
> On Thu, May 21, 2020 at 4:08 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> >
> > On Wed, May 20, 2020 at 11:23:18AM -0700, syzbot wrote:
> > > Hello,
> > >
> > > syzbot found the following crash on:
> > >
> > > HEAD commit:    dda18a5c selftests/bpf: Convert bpf_iter_test_kern{3, 4}.c..
> > > git tree:       bpf-next
> >                   ^^^^^^^^
> >
> > I can figure out what this is from reading Next/Trees but it would be
> > more useful if it were easier to script.
> 
> Hi Dan,
> 
> Is there a canonical way to refer to a particular branch of a particular tree?
> >From what I observed on mailing lists people seem to say "linux-next"
> or "upstream tree" and that seems to mean specific things that
> everybody understands.

git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git#master

I kind of hate that format because you have to replace the # with a
space, but it's what everyone uses.

regards,
dan carpenter

