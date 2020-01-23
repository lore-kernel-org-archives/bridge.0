Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cumulusnetworks.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=/tAMaiitw1PyxFIS0OriuIYG+lTM5de1QiU8nvpGZ4U=;
 b=S9nQS5M8GRxqDnKBmZCpo/gItUgfZy/2LR/PUWL3LW9ZHOl1HDQm9yQNydKZsdTly4
 H+O6N6OoL0hGioUxzz76ffE6NdEh+tpUSXyHYFYrOVRBTkC22Ump2rR2NUFp2LVsWmvs
 qtPaUH9edp7gfYpGKBmQwWcwSoBph6tZ9c3/o=
References: <20200123132807.613-1-nikolay@cumulusnetworks.com>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <f67c2960-89ff-a6e6-14eb-27f6e4996a4a@cumulusnetworks.com>
Date: Thu, 23 Jan 2020 23:10:12 +0200
MIME-Version: 1.0
In-Reply-To: <20200123132807.613-1-nikolay@cumulusnetworks.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 0/4] net: bridge: add per-vlan state
	option
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, davem@davemloft.net

On 1/23/20 3:28 PM, Nikolay Aleksandrov wrote:
> Hi,
> This set adds the first per-vlan option - state, which uses the new vlan
> infrastructure that was recently added. It gives us forwarding control on
> per-vlan basis. The first 3 patches prepare the vlan code to support option
> dumping and modification. We still compress vlan ranges which have equal
> options, each new option will have to add its own equality check to
> br_vlan_opts_eq(). The vlans are created in forwarding state by default to
> be backwards compatible and vlan state is considered only when the port
> state is forwarding (more info in patch 4).
> I'll send the selftest for the vlan state with the iproute2 patch-set.
> 
> Thanks,
>   Nik
> 
> Nikolay Aleksandrov (4):
>    net: bridge: check port state before br_allowed_egress
>    net: bridge: vlan: add basic option dumping support
>    net: bridge: vlan: add basic option setting support
>    net: bridge: vlan: add per-vlan state
> 
>   include/uapi/linux/if_bridge.h |   2 +
>   net/bridge/Makefile            |   2 +-
>   net/bridge/br_device.c         |   3 +-
>   net/bridge/br_forward.c        |   2 +-
>   net/bridge/br_input.c          |   7 +-
>   net/bridge/br_private.h        |  58 +++++++++++++-
>   net/bridge/br_vlan.c           |  99 ++++++++++++++++++-----
>   net/bridge/br_vlan_options.c   | 142 +++++++++++++++++++++++++++++++++
>   8 files changed, 287 insertions(+), 28 deletions(-)
>   create mode 100644 net/bridge/br_vlan_options.c
> 

Hm, actually I just noticed that we send port notifications even if only changing options
which should be avoided since now we have per-vlan notifications. We should be sending
only those when changing options without create/delete.
I'll make that change and send v2 after some tests tomorrow.

Cheers,
  Nik
