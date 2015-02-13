Return-Path: <fw@strlen.de>
Date: Fri, 13 Feb 2015 20:03:30 +0100
From: Florian Westphal <fw@strlen.de>
Message-ID: <20150213190330.GD15141@breakpoint.cc>
References: <1423560744-19011-1-git-send-email-imrep.amz@gmail.com>
	<20150211.142936.951620487173949333.davem@davemloft.net>
	<54DE2174.6040001@gmail.com> <20150213163703.GC15141@breakpoint.cc>
	<54DE3851.7000206@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54DE3851.7000206@gmail.com>
Subject: Re: [Bridge] [PATCH] bridge: make it possible for packets to
 traverse the bridge withour hitting netfilter
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Imre Palik <imrep.amz@gmail.com>
Cc: imrep@amazon.de, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org, aliguori@amazon.com, David Miller <davem@davemloft.net>

Imre Palik <imrep.amz@gmail.com> wrote:
> The trouble is that there are some bridges (with low traffic) where I need netfilter, and some other bridges (carrying lots of traffic), where I don't.  Being able to set things up on a per bridge basis is a powerful thing.
> 
> I only implemented the global switch because the iptables and arptables support also have one.  If this is what bugs people here, I can remove it, and resubmit.

I see.  But I agree with David, accepting such patch would pave way
for all kinds of ugly hacks.

It seems that technically the best solution would be to allow attaching
filter rules to devices, but alas, netfilter doesn't support that.

Alternatively, you patch *might* be ok iff you can get rid of the extra
userspace-visible configuration knobs, we already have way too many of
these.

You'll also have to figure out how to avoid any run-time dependency on
br_netfilter module from the bridge core.

If you can do this, you might be able to get similar effect as your patch
by replacing

NF_HOOK with NF_HOOK_COND(..., !(br->flags & NO_NETFILTER))

or something like this.

I don't know how invasive this would be, though.
