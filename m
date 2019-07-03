Return-Path: <wenxu@ucloud.cn>
References: <20190703124040.19279-1-pablo@netfilter.org>
	<ecb6d9e8-7923-07ba-8940-c69fc251f4c3@ucloud.cn>
	<20190703141507.mnhzqapu4iaan5d7@salvia>
From: wenxu <wenxu@ucloud.cn>
Message-ID: <4f3561be-adec-bda4-0e4f-d23ed82acf0f@ucloud.cn>
Date: Wed, 3 Jul 2019 22:59:47 +0800
MIME-Version: 1.0
In-Reply-To: <20190703141507.mnhzqapu4iaan5d7@salvia>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] [PATCH] netfilter: nft_meta: fix bridge port vlan ID
	selector
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: nikolay@cumulusnetworks.com, bridge@lists.linux-foundation.org, netfilter-devel@vger.kernel.org

Agree with you, After add the rcu patch I will resent the series fo nft_meta_bridge!.

在 2019/7/3 22:15, Pablo Neira Ayuso 写道:
> Hi,
>
> I'm planning to revert from nf-next
>
>         da4f10a4265b netfilter: nft_meta: add NFT_META_BRI_PVID support
>
> because:
>
> * Nikolay wants us to use the helpers, however, through the existing
>   approach this creates a dependency between nft_meta and the bridge
>   module. I think I suggested this already, but it seems there is a
>   need for nft_meta_bridge, otherwise nft_meta pulls in the bridge
>   modules as a dependency.
>
> * NFT_META_BRI_PVID needs to be rename to NFT_META_BRI_IIFPVID.
>
> * We need new helpers to access this information from rcu path, I'm
>   attaching a patch for such helper for review.
>
> so we take the time to get this right :-)
