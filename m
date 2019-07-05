Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=SuddDTHB7Z8B8sUF248QER9k0T7rIWuLc0Ru7WUYpI8=;
	b=CQlzpE/JiVprrt8EiTO+bozfQKK8Y/Yo4zm31B3qCHkUQTMk8a4+Eff4PLY6l6cRyr
	XkE8646Rw53crfH57uOjDtBSPOHBctswexkDT5385oZ2EEvLoQp6byYLMUSxF9OhTX/b
	y3qQhK7+weZ8ks4JNowADfs+sFpy6s6/6kQgw=
References: <1562224955-3979-1-git-send-email-wenxu@ucloud.cn>
	<1562224955-3979-3-git-send-email-wenxu@ucloud.cn>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <df83723a-4dd5-7c38-4240-9ef47fde55cf@cumulusnetworks.com>
Date: Fri, 5 Jul 2019 11:23:12 +0300
MIME-Version: 1.0
In-Reply-To: <1562224955-3979-3-git-send-email-wenxu@ucloud.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH 3/7 nf-next] bridge: add br_vlan_get_pvid_rcu()
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
> This new function allows you to fetch bridge pvid from packet path.
> 
> Signed-off-by: wenxu <wenxu@ucloud.cn>
> ---
>  include/linux/if_bridge.h |  6 ++++++
>  net/bridge/br_vlan.c      | 19 +++++++++++++++----
>  2 files changed, 21 insertions(+), 4 deletions(-)
> 

While the patch looks fine, you've taken authorship of Pablo's patch.
From technical POV:
Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>


