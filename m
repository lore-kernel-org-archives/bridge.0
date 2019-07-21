Return-Path: <fw@strlen.de>
Date: Sun, 21 Jul 2019 02:26:23 +0200
From: Florian Westphal <fw@strlen.de>
Message-ID: <20190721002623.27wac36rkwa5v5lg@breakpoint.cc>
References: <1563625366-3602-1-git-send-email-wang6495@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1563625366-3602-1-git-send-email-wang6495@umn.edu>
Subject: Re: [Bridge] [PATCH] netfilter: ebtables: compat: fix a memory leak
	bug
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Wenwen Wang <wang6495@umn.edu>
Cc: Wenwen Wang <wenwen@cs.uga.edu>, Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, "open list:ETHERNET BRIDGE" <netdev@vger.kernel.org>, Roopa Prabhu <roopa@cumulusnetworks.com>, "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>, Florian Westphal <fw@strlen.de>, open list <linux-kernel@vger.kernel.org>, Jozsef Kadlecsik <kadlec@netfilter.org>, "open list:NETFILTER" <coreteam@netfilter.org>, "open list:NETFILTER" <netfilter-devel@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Pablo Neira Ayuso <pablo@netfilter.org>

Wenwen Wang <wang6495@umn.edu> wrote:
> From: Wenwen Wang <wenwen@cs.uga.edu>
> 
> In compat_do_replace(), a temporary buffer is allocated through vmalloc()
> to hold entries copied from the user space. The buffer address is firstly
> saved to 'newinfo->entries', and later on assigned to 'entries_tmp'. Then
> the entries in this temporary buffer is copied to the internal kernel
> structure through compat_copy_entries(). If this copy process fails,
> compat_do_replace() should be terminated. However, the allocated temporary
> buffer is not freed on this path, leading to a memory leak.
> 
> To fix the bug, free the buffer before returning from compat_do_replace().
> 
> Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>

Reviewed-by: Florian Westphal <fw@strlen.de>
