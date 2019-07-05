Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=hZ+xm6CrUEywAVzXTfhFxGsIwIJgpN0+1W8s2x/bags=;
	b=c3IzIeVMeule+KQO+Y5hOKFEAcp51mU3jBwWgfNIszd5EwFwOzPrcwrBiO0yh4hMVg
	IR0QIQ96MLJHjrDefnKjJTbRIPIm6dsiiPNS+lfblbTO6vE3CGL2B/FuDwPrpHSF0P1J
	7mbU1JuBtnp1e3PXHrUqqkSabTQ0/5JwR9BZk=
References: <1562224955-3979-1-git-send-email-wenxu@ucloud.cn>
	<1562224955-3979-6-git-send-email-wenxu@ucloud.cn>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <89cf54d6-c36f-d59b-a414-5829aebd4552@cumulusnetworks.com>
Date: Fri, 5 Jul 2019 11:28:28 +0300
MIME-Version: 1.0
In-Reply-To: <1562224955-3979-6-git-send-email-wenxu@ucloud.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH 6/7 nf-next] netfilter: nft_meta_bridge: Add
 NFT_META_BRI_IIFVPROTO support
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: wenxu@ucloud.cn, pablo@netfilter.org
Cc: bridge@lists.linux-foundation.org, netfilter-devel@vger.kernel.org

On 04/07/2019 10:22, wenxu@ucloud.cn wrote:
> From: wenxu <wenxu@ucloud.cn>
> 
> This patch provide a meta to get the bridge vlan proto
> 
> nft add rule bridge firewall zones counter meta br_vlan_proto 0x8100
> 
> Signed-off-by: wenxu <wenxu@ucloud.cn>
> ---
>  include/uapi/linux/netfilter/nf_tables.h |  2 ++
>  net/bridge/netfilter/nft_meta_bridge.c   | 12 ++++++++++++
>  2 files changed, 14 insertions(+)
> 


Reviewed-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

