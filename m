Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=73Z6yaJsbbbf40V41AoK++cX14SZrBNYZG3bmClY4Bw=;
	b=d6A9vpWiEVL4F9MfpBZtNmambPX5TD74hHk4/m94ZZJ32OR7y41As3AoBuhMqn5Fvm
	A60sXgnHhItyvcr8+f/b44l0kevZgPqUq1QkZzuMsE+QgE6yvmA3HuVrLc/ptgrIoQHq
	OTweLldz3cbbKaDZ/aXxE+LMdTJNFhA9EQBmc=
References: <20190703124040.19279-1-pablo@netfilter.org>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <f7763540-dd87-9ba6-3d18-451427eaeb0d@cumulusnetworks.com>
Date: Wed, 3 Jul 2019 15:42:28 +0300
MIME-Version: 1.0
In-Reply-To: <20190703124040.19279-1-pablo@netfilter.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Pablo Neira Ayuso <pablo@netfilter.org>, netfilter-devel@vger.kernel.org
Cc: wenxu@ucloud.cn, bridge@lists.linux-foundation.org

On 03/07/2019 15:40, Pablo Neira Ayuso wrote:
> Use br_vlan_enabled() and br_vlan_get_pvid() helpers as Nikolay
> suggests.
> 
> Rename NFT_META_BRI_PVID to NFT_META_BRI_IIFPVID before this patch hits
> the 5.3 release cycle, to leave room for matching for the output bridge
> port in the future.
> 
> Reported-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
> Fixes: da4f10a4265b ("netfilter: nft_meta: add NFT_META_BRI_PVID support")
> Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
> ---
>  include/uapi/linux/netfilter/nf_tables.h |  4 ++--
>  net/netfilter/nft_meta.c                 | 17 ++++++++++-------
>  2 files changed, 12 insertions(+), 9 deletions(-)
> 

Awesome, thanks!
Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

