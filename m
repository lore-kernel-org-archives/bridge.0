Return-Path: <alexei.starovoitov@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=W3gFxb9MTLvTnCe3A+iabUWXBAu7mA9HyhZHWgTOkUw=;
 b=OGmrrLECo+9bEWcObjspsB7mZd1Knz6TplGXozOrISTfqD7/NX21SXnbWcSkV3fL4v
 rTtVk5lWAA2Zu7uZ6u1mrfxhancqzyg3QAj3aPjlEycGVWZJlozkhUGEvXA8Lh3Zhd9y
 MI2pFWCUVAw0qhoczi2fzDR5o+9jsXf0u50JS+cFIfuTYX6fdThXqy7BkTGCK/dg3wkY
 mbds6x2z1GfwvAA0D5GwOBd9MLDFeCqWgb4tYptazoXAosQDHX7Ytsgw6xoiVQCij+q6
 LhYcFToAHR8FWmsf1prWh4sudrDF50FXVoAgPYMNb7eWHKWg9zXFnQitJW8+uw6BZBn8
 8EhQ==
Date: Mon, 20 Jul 2020 13:47:56 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Message-ID: <20200720204756.iengwcguikj2yrxt@ast-mbp.dhcp.thefacebook.com>
References: <20200720124737.118617-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720124737.118617-1-hch@lst.de>
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
Cc: Alexei Starovoitov <ast@kernel.org>, linux-sctp@vger.kernel.org, linux-afs@lists.infradead.org, linux-s390@vger.kernel.org, rds-devel@oss.oracle.com, Daniel Borkmann <daniel@iogearbox.net>, dccp@vger.kernel.org, bridge@lists.linux-foundation.org, lvs-devel@vger.kernel.org, coreteam@netfilter.org, mptcp@lists.01.org, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, linux-can@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, linux-hams@vger.kernel.org, tipc-discussion@lists.sourceforge.net, linux-x25@vger.kernel.org, Eric Dumazet <edumazet@google.com>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, netdev@vger.kernel.org, linux-decnet-user@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org, netfilter-devel@vger.kernel.org, linux-crypto@vger.kernel.org, bpf@vger.kernel.org, linux-wpan@vger.kernel.org, "David S. Miller" <davem@davemloft.net>

On Mon, Jul 20, 2020 at 02:47:13PM +0200, Christoph Hellwig wrote:
> Hi Dave,
> 
> setsockopt is the last place in architecture-independ code that still
> uses set_fs to force the uaccess routines to operate on kernel pointers.
> 
> This series adds a new sockptr_t type that can contained either a kernel
> or user pointer, and which has accessors that do the right thing, and
> then uses it for setsockopt, starting by refactoring some low-level
> helpers and moving them over to it before finally doing the main
> setsockopt method.
> 
> Note that I could not get the eBPF selftests to work, so this has been
> tested with a testing patch that always copies the data first and passes
> a kernel pointer.  This is something that works for most common sockopts
> (and is something that the ePBF support relies on), but unfortunately
> in various corner cases we either don't use the passed in length, or in
> one case actually copy data back from setsockopt, so we unfortunately
> can't just always do the copy in the highlevel code, which would have
> been much nicer.

could you rebase on bpf-next tree and we can route it this way then?
we'll also test the whole thing before applying.

sounds like v2 is needed anyway to address Eric's addr space concern?
