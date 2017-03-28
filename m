Return-Path: <jengelh@inai.de>
Date: Tue, 28 Mar 2017 15:51:05 +0200 (CEST)
From: Jan Engelhardt <jengelh@inai.de>
In-Reply-To: <20170328125048.GA25091@singhal-Inspiron-5558>
Message-ID: <alpine.LSU.2.20.1703281548580.21255@n3.vanv.qr>
References: <20170328125048.GA25091@singhal-Inspiron-5558>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [Bridge] [PATCH] net: Remove unnecessary cast on void pointer
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: simran singhal <singhalsimran0@gmail.com>
Cc: gregkh@linuxfoundation.org, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, James Morris <jmorris@namei.org>, outreachy-kernel@googlegroups.com, coreteam@netfilter.org, netfilter-devel@vger.kernel.org, kadlec@blackhole.kfki.hu, Patrick McHardy <kaber@trash.net>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, davem@davemloft.net, pablo@netfilter.org

On Tuesday 2017-03-28 14:50, simran singhal wrote:

>The following Coccinelle script was used to detect this:
>@r@
>expression x;
>void* e;
>type T;
>identifier f;
>@@
>(
>  *((T *)e)
>|
>  ((T *)x)[...]
>|
>  ((T*)x)->f
>|
>
>- (T*)
>  e
>)
>
>Signed-off-by: simran singhal <singhalsimran0@gmail.com>
>---
> net/bridge/netfilter/ebtables.c         |  2 +-
> net/ipv4/netfilter/arp_tables.c         | 20 ++++++++------------
> net/ipv4/netfilter/ip_tables.c          | 20 ++++++++------------
> net/ipv6/netfilter/ip6_tables.c         | 20 ++++++++------------
> net/netfilter/ipset/ip_set_bitmap_gen.h |  4 ++--
> net/netfilter/ipset/ip_set_core.c       |  2 +-
> net/netfilter/nf_conntrack_proto.c      |  2 +-
> net/netfilter/nft_set_hash.c            |  2 +-
> net/netfilter/xt_hashlimit.c            | 10 +++++-----
> 9 files changed, 35 insertions(+), 47 deletions(-)
>
>diff --git a/net/bridge/netfilter/ebtables.c b/net/bridge/netfilter/ebtables.c
>index 79b6991..bdc629e 100644
>--- a/net/bridge/netfilter/ebtables.c
>+++ b/net/bridge/netfilter/ebtables.c
>@@ -1713,7 +1713,7 @@ static int compat_copy_entry_to_user(struct ebt_entry *e, void __user **dstptr,
> 	if (*size < sizeof(*ce))
> 		return -EINVAL;
> 
>-	ce = (struct ebt_entry __user *)*dstptr;
>+	ce = *dstptr;
> 	if (copy_to_user(ce, e, sizeof(*ce)))
> 		return -EFAULT;
> 
>diff --git a/net/ipv4/netfilter/arp_tables.c b/net/ipv4/netfilter/arp_tables.c
>index 6241a81..f046c12 100644
>--- a/net/ipv4/netfilter/arp_tables.c
>+++ b/net/ipv4/netfilter/arp_tables.c
>@@ -310,7 +310,7 @@ static int mark_source_chains(const struct xt_table_info *newinfo,
> 	for (hook = 0; hook < NF_ARP_NUMHOOKS; hook++) {
> 		unsigned int pos = newinfo->hook_entry[hook];
> 		struct arpt_entry *e
>-			= (struct arpt_entry *)(entry0 + pos);
>+			= (entry0 + pos);

At this point you can also drop the now-unnecessary parentheses in all 
the lines you changed.
