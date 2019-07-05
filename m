Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=xNaeeNQ+DrT/MDlwiypulX86a/vhe/+Mo0zzZKV7q8c=;
	b=JehHPgs6sR8BLe7UByCaHBk14ZJNP0GNmUXJbLqc1ZTfXPb8PUTWfJ2nZ6RLnGFo1L
	J1k+aGLyEvR5cwemuYJ5jXbTdE/3GDchqRdGac05YNIAXbxIgzJrDjUoZF2bZCIs0LHd
	8UsvftCyyEzzFDGFryG44SKvKD2/6OgSjMYQU=
References: <1562224955-3979-1-git-send-email-wenxu@ucloud.cn>
	<1562224955-3979-2-git-send-email-wenxu@ucloud.cn>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <ccca906e-eb4f-efa0-abc5-664be9d8044b@cumulusnetworks.com>
Date: Fri, 5 Jul 2019 11:18:49 +0300
MIME-Version: 1.0
In-Reply-To: <1562224955-3979-2-git-send-email-wenxu@ucloud.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH 2/7 nf-next] netfilter: nft_meta_bridge: Remove
 the br_private.h header
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
> Mkae the nft_bridge_meta can't direct access the bridge
> internal API.
> 
> Signed-off-by: wenxu <wenxu@ucloud.cn>
> ---
>  net/bridge/netfilter/nft_meta_bridge.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
> 

Nice, thanks!
Reviewed-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>


