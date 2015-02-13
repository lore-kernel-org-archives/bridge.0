Return-Path: <fw@strlen.de>
Date: Fri, 13 Feb 2015 17:37:03 +0100
From: Florian Westphal <fw@strlen.de>
Message-ID: <20150213163703.GC15141@breakpoint.cc>
References: <1423560744-19011-1-git-send-email-imrep.amz@gmail.com>
	<20150211.142936.951620487173949333.davem@davemloft.net>
	<54DE2174.6040001@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54DE2174.6040001@gmail.com>
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
Cc: imrep@amazon.de, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, aliguori@amazon.com, David Miller <davem@davemloft.net>

Imre Palik <imrep.amz@gmail.com> wrote:
> On 02/11/15 23:29, David Miller wrote:
> > If I apply this, someone is going to try to submit a patch for every
> > damn protocol layer to add a stupid hack like this.
> 
> Actually this is one of those patches.  There is already a "stupid hack like this" for iptables and arptables.  (Implemented before git history, and giving me 10% speedup.  Many thanks, whoever did it.)
> 
> I also searched various LKML archives, and it seems the existing "stupid hacks" for iptables and arptables haven't resulted in any related patch submission in the last ten years.  (Or my google-fu is weak.)
> 
> Moreover, I cannot imagine any other reasonable on/off switch for bridge-netfilter than these three.  Of course, my imagination might be lacking there.

Why do you load the bridge netfilter module if you don't want it?
Loading it registers the internal hooks for the call-ip(6)tables and
sabotage hooks with NF_BRIDGE protocol so most of the NF_HOOK(NF_BRIDGE, ...
calls become active.

