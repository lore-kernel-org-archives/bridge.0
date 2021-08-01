Return-Path: <pablo@netfilter.org>
Date: Sun, 1 Aug 2021 12:15:37 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
Message-ID: <20210801101537.GA20629@salvia>
References: <20210729082021.14407-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210729082021.14407-1-yajun.deng@linux.dev>
Subject: Re: [Bridge] [PATCH v3] netfilter: nf_conntrack_bridge: Fix memory
 leak when error
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Yajun Deng <yajun.deng@linux.dev>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, fw@strlen.de, linux-kernel@vger.kernel.org, kadlec@netfilter.org, coreteam@netfilter.org, netfilter-devel@vger.kernel.org

On Thu, Jul 29, 2021 at 04:20:21PM +0800, Yajun Deng wrote:
> It should be added kfree_skb_list() when err is not equal to zero
> in nf_br_ip_fragment().

Applied, thanks.
