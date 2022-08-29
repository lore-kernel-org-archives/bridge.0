Return-Path: <fw@strlen.de>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6361540500
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6647040393
Date: Mon, 29 Aug 2022 16:03:20 +0200
From: Florian Westphal <fw@strlen.de>
Message-ID: <20220829140320.GB27814@breakpoint.cc>
References: <20220820070331.48817-1-harshit.m.mogalapalli@oracle.com>
 <20220820173555.131326-1-fw@strlen.de>
 <93eca5ab-46ee-241a-b01c-a6131b28ba29@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93eca5ab-46ee-241a-b01c-a6131b28ba29@oracle.com>
Subject: Re: [Bridge] [PATCH nf] netfilter: ebtables: reject blobs that
 don't provide all entry points
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: john.p.donnelly@oracle.com
Cc: vegard.nossum@oracle.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org, george.kennedy@oracle.com, syzkaller@googlegroups.com, netfilter-devel@vger.kernel.org, Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

john.p.donnelly@oracle.com <john.p.donnelly@oracle.com> wrote:
> On 8/20/22 12:35 PM, Florian Westphal wrote:
> > For some reason ebtables reject blobs that provide entry points that are
> > not supported by the table.
> > 
> > What it should instead reject is the opposite, i.e. rulesets that
> > DO NOT provide an entry point that is supported by the table.
> > 
> > t->valid_hooks is the bitmask of hooks (input, forward ...) that will
> > see packets.  So, providing an entry point that is not support is
> > harmless (never called/used), but the reverse is NOT, this will cause
> > crash because the ebtables traverser doesn't expect a NULL blob for
> > a location its receiving packets for.
> > 
> > Instead of fixing all the individual checks, do what iptables is doing and
> > reject all blobs that doesn't provide the expected hooks.
> > 
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Reported-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> > Signed-off-by: Florian Westphal <fw@strlen.de>
> 
> Hi,
> 
>  Could you please add the panic stack mentioned above  and syzkaller
> reproducer ID to the commit text ?

I did not see a reproducer ID.  What ended up in the tree is this:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7997eff82828304b780dc0a39707e1946d6f1ebf
