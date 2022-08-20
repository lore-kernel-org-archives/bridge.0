Return-Path: <fw@strlen.de>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7DD3A41765
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1F64840977
Date: Sat, 20 Aug 2022 18:26:57 +0200
From: Florian Westphal <fw@strlen.de>
Message-ID: <YwELUWJw1qTatIiI@strlen.de>
References: <20220820070331.48817-1-harshit.m.mogalapalli@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220820070331.48817-1-harshit.m.mogalapalli@oracle.com>
Subject: Re: [Bridge] [PATCH] netfilter: ebtables: fix a NULL pointer
 dereference in ebt_do_table()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: john.p.donnelly@oracle.com, vegard.nossum@oracle.com, coreteam@netfilter.org, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Jozsef Kadlecsik <kadlec@netfilter.org>, george.kennedy@oracle.com, Eric Dumazet <edumazet@google.com>, syzkaller@googlegroups.com, netfilter-devel@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>, Pablo Neira Ayuso <pablo@netfilter.org>

Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com> wrote:
> In ebt_do_table() function dereferencing 'private->hook_entry[hook]'
> can lead to NULL pointer dereference. So add a check to prevent that.

This looks incorrect, i.e. paperimg over the problem.

If hook_entry[hook] is NULL, how did this make it to the eval loop?

I guess ebtables lacks a sanity check on incoming ruleset?
