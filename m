Return-Path: <launayflorian@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=oJU+yhEF6uANH8LMyOSkhxC5rgf801ijG9i4cePKCok=;
	b=mlw4rrkrEg7k/ZWbSZQtU966A1gdOsBqJeCt3tlqdKCHW7jnEgOFzEbVqxXA5lD6++
	HdtiJostiaG60ZWcKjzvvVSyAxAmEcJ/F6WmZH8O9UOvQiPt7ZFtRfH51iNygiQr/9c3
	3Y2GeBj0LCrEtfleDvwRp1OZ4X69J3gAUdmkcNpzZT1QN+whvpsXzbdPuxybo9uhCkA9
	X8Cw/4dHIwkxfwOgIsIL0qy17IM6ESzQQcYRKfcVZKYrkda5eS1Ol2/USyZwqohPQ5u4
	Gu7SGMkqvJ65uiL8zrFBsveciwnZeroVg7tj3BTkxH9RjmcrWzhMd7P3XhNB+JEtCa76
	L+RA==
References: <20181107134859.19896-1-christian@brauner.io>
From: Florian LAUNAY <launayflorian@gmail.com>
Message-ID: <aca5e0b4-7c2a-4bd5-41ba-9a6ac965b9c6@gmail.com>
Date: Thu, 7 Mar 2019 15:58:09 +0100
MIME-Version: 1.0
In-Reply-To: <20181107134859.19896-1-christian@brauner.io>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 0/2] br_netfilter: enable in
	non-initial netns
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Christian Brauner <christian@brauner.io>, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, bridge@lists.linux-foundation.org
Cc: nikolay@cumulusnetworks.com, roopa@cumulusnetworks.com, fw@strlen.de, tyhicks@canonical.com, kadlec@blackhole.kfki.hu, pablo@netfilter.org

Hi everyone,

Can someone help move this topic forward ?
This issue simply prevents any advanced use of docker in LXC.

Thank you in advance!
Florian LAUNAY

On 07/11/2018 14:48, Christian Brauner wrote:
> Hey everyone,
> 
> Over time I have seen multiple reports by users who want to run applications
> (Kubernetes e.g. via [1]) that require the br_netfilter module in
> non-initial network namespaces [2], [3], [4], [5] (There are more issues
> where this requirement is reported.).
> Currently, the /proc/sys/net/bridge folder is only created in the
> initial network namespace. This patch series ensures that the
> /proc/sys/net/bridge folder is available in each network namespace if
> the module is loaded and disappears from all network namespaces when the
> module is unloaded.
> The patch series also makes the sysctls:
> 
> bridge-nf-call-arptables
> bridge-nf-call-ip6tables
> bridge-nf-call-iptables
> bridge-nf-filter-pppoe-tagged
> bridge-nf-filter-vlan-tagged
> bridge-nf-pass-vlan-input-dev
> 
> apply per network namespace. This unblocks some use-cases where users
> would like to e.g. not do bridge filtering for bridges in a specific
> network namespace while doing so for bridges located in another network
> namespace.
> The netfilter rules are afaict already per network namespace so it
> should be safe for users to specify whether a bridge device inside their
> network namespace is supposed to go through iptables et al. or not.
> Also, this can already be done by setting an option for each individual
> bridge via Netlink. It should also be possible to do this for all
> bridges in a network namespace via sysctls.
> 
> Thanks!
> Christian
> 
> [1]: https://github.com/zimmertr/Bootstrap-Kubernetes-with-Ansible
> [2]: https://github.com/lxc/lxd/issues/5193
> [3]: https://discuss.linuxcontainers.org/t/bridge-nf-call-iptables-and-swap-error-on-lxd-with-kubeadm/2204
> [4]: https://github.com/lxc/lxd/issues/3306
> [5]: https://gitlab.com/gitlab-org/gitlab-runner/issues/3705
> 
> Christian Brauner (2):
>    br_netfilter: add struct netns_brnf
>    br_netfilter: namespace bridge netfilter sysctls
> 
>   include/net/net_namespace.h          |   3 +
>   include/net/netfilter/br_netfilter.h |   3 +-
>   include/net/netns/netfilter.h        |  16 +++
>   net/bridge/br_netfilter_hooks.c      | 166 ++++++++++++++++++---------
>   net/bridge/br_netfilter_ipv6.c       |   2 +-
>   5 files changed, 134 insertions(+), 56 deletions(-)
> 
