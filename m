Return-Path: <pablo@netfilter.org>
Date: Thu, 18 Jul 2019 20:30:10 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
Message-ID: <20190718183010.s243aiunyycpz3np@salvia>
References: <20190709070126.29972-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190709070126.29972-1-yuehaibing@huawei.com>
Subject: Re: [Bridge] [PATCH net-next] netfilter: nft_meta: Fix build error
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: YueHaibing <yuehaibing@huawei.com>
Cc: wenxu@ucloud.cn, nikolay@cumulusnetworks.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, fw@strlen.de, linux-kernel@vger.kernel.org, kadlec@netfilter.org, coreteam@netfilter.org, netfilter-devel@vger.kernel.org, davem@davemloft.net

On Tue, Jul 09, 2019 at 03:01:26PM +0800, YueHaibing wrote:
> If NFT_BRIDGE_META is y and NF_TABLES is m, building fails:
> 
> net/bridge/netfilter/nft_meta_bridge.o: In function `nft_meta_bridge_get_init':
> nft_meta_bridge.c:(.text+0xd0): undefined reference to `nft_parse_register'
> nft_meta_bridge.c:(.text+0xec): undefined reference to `nft_validate_register_store'

I took this one from Arnd instead:

https://patchwork.ozlabs.org/patch/1130262/

Thanks.
