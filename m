Return-Path: <fw@strlen.de>
Date: Mon, 7 Mar 2022 12:43:36 +0100
From: Florian Westphal <fw@strlen.de>
Message-ID: <20220307114336.GA21350@breakpoint.cc>
References: <20220307004149.25171-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220307004149.25171-1-jiapeng.chong@linux.alibaba.com>
Subject: Re: [Bridge] [PATCH] netfilter: bridge: clean up some inconsistent
	indenting
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: netdev@vger.kernel.org, razor@blackwall.org, bridge@lists.linux-foundation.org, fw@strlen.de, linux-kernel@vger.kernel.org, kadlec@netfilter.org, Abaci Robot <abaci@linux.alibaba.com>, coreteam@netfilter.org, netfilter-devel@vger.kernel.org, roopa@nvidia.com, kuba@kernel.org, davem@davemloft.net, pablo@netfilter.org

Jiapeng Chong <jiapeng.chong@linux.alibaba.com> wrote:
> Eliminate the follow smatch warning:
> 
> net/bridge/netfilter/nf_conntrack_bridge.c:385 nf_ct_bridge_confirm()
> warn: inconsistent indenting.

Applied to nf-next, thanks.
