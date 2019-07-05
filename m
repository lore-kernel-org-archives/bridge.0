Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=4peepLiWhCkWmJMx6sNyd4wCIbHYDrXG09wLZE8Lxtc=;
	b=WuvrBzJuIaPhIsJY2lVj5+75oQzyfNhGBKNHDIEFWqo92/jIr+1VspbpsiPsDzJSQA
	Q1SYdbnJR4rOGf9zfl/Uaz+WEE0tjO2eB6FvPoYbGj/xsNch+8A+Z7gawDLtDz/ShT9B
	8tosHgNaNTU7sGjt7pRvrVdA5DNSXMbGbM4VA=
References: <1562224955-3979-1-git-send-email-wenxu@ucloud.cn>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <2b5f91c9-c564-ea90-89c9-85443cae4bd7@cumulusnetworks.com>
Date: Fri, 5 Jul 2019 11:16:12 +0300
MIME-Version: 1.0
In-Reply-To: <1562224955-3979-1-git-send-email-wenxu@ucloud.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH 1/7 nf-next] netfilter: separate bridge meta
 key from nft_meta into meta_bridge
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
> Separate bridge meta key from nft_meta to meta_bridge for other key
> support. So there is n dependency between nft_meta and the bridge
> module
> 
> Signed-off-by: wenxu <wenxu@ucloud.cn>
> ---
>  include/net/netfilter/nft_meta.h       |  44 ++++++++++++
>  net/bridge/netfilter/Kconfig           |   6 ++
>  net/bridge/netfilter/Makefile          |   1 +
>  net/bridge/netfilter/nft_meta_bridge.c | 127 +++++++++++++++++++++++++++++++++
>  net/netfilter/nf_tables_core.c         |   1 +
>  net/netfilter/nft_meta.c               |  81 ++++++++-------------
>  6 files changed, 207 insertions(+), 53 deletions(-)
>  create mode 100644 include/net/netfilter/nft_meta.h
>  create mode 100644 net/bridge/netfilter/nft_meta_bridge.c
> 

Reviewed-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>


