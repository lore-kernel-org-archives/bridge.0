Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=QdI/+SYCsxY3INQuhw7JvmpOSaPdcwC03yXDxoauh68=;
	b=eMcRgBYSbFPn9Ig6FBm++m3rc1Cye/pYaPigJLOeUBQFd2yutFghxgh6eE2nSJEeQI
	zB9KDtX1Lx+bSRwHWtK2UI0au2xOR3vDON4hYXT+FvLIwmhdyDUXl84uJL6U+MBxLO+e
	wl38roNL4UgcF8vyHJ6w8fLzNxZodvm+oMlEI=
References: <1562224955-3979-1-git-send-email-wenxu@ucloud.cn>
	<1562224955-3979-5-git-send-email-wenxu@ucloud.cn>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <a598a8b7-caa5-af39-609e-42e53ecf3727@cumulusnetworks.com>
Date: Fri, 5 Jul 2019 11:25:28 +0300
MIME-Version: 1.0
In-Reply-To: <1562224955-3979-5-git-send-email-wenxu@ucloud.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH 5/7 nf-next] bridge: add br_vlan_get_proto()
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
> This new function allows you to fetch bridge vlan proto.
> 
> Signed-off-by: wenxu <wenxu@ucloud.cn>
> ---
>  include/linux/if_bridge.h |  6 ++++++
>  net/bridge/br_vlan.c      | 10 ++++++++++
>  2 files changed, 16 insertions(+)
> 


Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
