Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=atSD+AC/JhTBLnkkNDGX0tjw7svVlM9Q+yrxINFZ3wE=;
	b=Znp8eCVfVNJmz6gkdBUp/VgIf0BCdgk/0mFrzc+BJQDL6TQpwEHJcUoFduUnZA5W8e
	EEKx/byuJKGWd+vtk+YMDaqSRTnRrkaiIQ/1b05ozsGmH/VrlL4kb29sF/izX776ild0
	tTRZdtJDSjJwgX/a4S2V2h7MWyhd4iGME9dX0=
References: <1562224955-3979-1-git-send-email-wenxu@ucloud.cn>
	<1562224955-3979-4-git-send-email-wenxu@ucloud.cn>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <33319d6b-1666-c083-6297-d618e2ae51f4@cumulusnetworks.com>
Date: Fri, 5 Jul 2019 11:24:27 +0300
MIME-Version: 1.0
In-Reply-To: <1562224955-3979-4-git-send-email-wenxu@ucloud.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH 4/7 nf-next] netfilter: nft_meta_bridge: add
 NFT_META_BRI_IIFPVID support
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
> nft add table bridge firewall
> nft add chain bridge firewall zones { type filter hook prerouting priority - 300 \; }
> nft add rule bridge firewall zones counter ct zone set vlan id map { 100 : 1, 200 : 2 }
> 
> As above set the bridge port with pvid, the received packet don't contain
> the vlan tag which means the packet should belong to vlan 200 through pvid.
> With this pacth user can get the pvid of bridge ports.
> 
> So add the following rule for as the first rule in the chain of zones.
> 
> nft add rule bridge firewall zones counter meta vlan set meta briifpvid
> 
> Signed-off-by: wenxu <wenxu@ucloud.cn>
> ---
>  include/uapi/linux/netfilter/nf_tables.h |  2 ++
>  net/bridge/netfilter/nft_meta_bridge.c   | 15 +++++++++++++++
>  2 files changed, 17 insertions(+)
> 

Reviewed-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

