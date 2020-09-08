Return-Path: <pablo@netfilter.org>
Date: Tue, 8 Sep 2020 12:56:15 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
Message-ID: <20200908105615.GA17880@salvia>
References: <20200904125653.15170-1-wanghai38@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200904125653.15170-1-wanghai38@huawei.com>
Subject: Re: [Bridge] [PATCH net-next] netfilter: ebt_stp: Remove unused
 macro BPDU_TYPE_TCN
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Wang Hai <wanghai38@huawei.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, fw@strlen.de, linux-kernel@vger.kernel.org, kadlec@netfilter.org, coreteam@netfilter.org, netfilter-devel@vger.kernel.org, nikolay@nvidia.com, roopa@nvidia.com, kuba@kernel.org, davem@davemloft.net

On Fri, Sep 04, 2020 at 08:56:53PM +0800, Wang Hai wrote:
> BPDU_TYPE_TCN is never used after it was introduced.
> So better to remove it.

Applied, thanks.
