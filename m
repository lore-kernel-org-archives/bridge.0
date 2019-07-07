Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=KXHWxa+UIM+ThdVUlxz38rZf4jSw8EKB5eFGTypm9Ag=;
	b=QgKXGMFsdVMywqzdKUqCAG91YW26BFQYhEKmHy4VVOZ7lDfZLlNlRY5fmPtcGMQ/4C
	HjsPCdjYcv1i4fG4t8vt1ZV8HbOZN6jbENOWCbdRgFhdT/bD7/CiDpCF/6Ev5LmfAej1
	Nuamn/hJfbUyQW1JlNKs7Ifz4XlY7dVmQ3mPg=
References: <1562422552-26065-1-git-send-email-wenxu@ucloud.cn>
	<1562422552-26065-3-git-send-email-wenxu@ucloud.cn>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <970ad7dd-60bd-c731-287f-9ebc12ee0427@cumulusnetworks.com>
Date: Sun, 7 Jul 2019 13:18:37 +0300
MIME-Version: 1.0
In-Reply-To: <1562422552-26065-3-git-send-email-wenxu@ucloud.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH 3/5 nf-next v4] bridge: add
	br_vlan_get_info_rcu()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: wenxu@ucloud.cn, pablo@netfilter.org, fw@strlen.de
Cc: bridge@lists.linux-foundation.org, netfilter-devel@vger.kernel.org

On 06/07/2019 17:15, wenxu@ucloud.cn wrote:
> From: wenxu <wenxu@ucloud.cn>
> 
> This new function allows you to fetch vlan info from packet path.
> 
> Signed-off-by: wenxu <wenxu@ucloud.cn>
> ---
>  include/linux/if_bridge.h |  7 +++++++
>  net/bridge/br_vlan.c      | 25 +++++++++++++++++++++++++
>  2 files changed, 32 insertions(+)
> 

Looks good, thanks!
Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>


