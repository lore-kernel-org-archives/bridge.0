Return-Path: <nikolay@nvidia.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C4Egvtb1EShprwi/yo8KmP9L+O8z0lq9T+lbjejH8q4=;
 b=PSfZstDzvss8Fd1XeOsrG9Gavr6h1+P6yC2P0X0Wl+CXwroZu+21wGY5zE1gAPb6DMgQvs7nw6NsKJC+DeAVrg5RBuaPn8F45u1+VMUcnDYGEaKKOJe6qoXcXcNlQrouCaKPpBS3x3a4F/J0WQ/zvdPifeh0XGoREdEPuvJL8SVvKvPa959TWOgw049y3OcJfbtdNjwJlbXHynQnRIevT6RilISGJ8tJtJ7o3AJAoGHJDHzzb8Ux8KrhQlWuQKTLmnzKUjNL96iOfVLHI7nAa6VrjzhdsgOzg9IAxeiWjo4w17ES5JgSdfev5OQ0am3mLFUEpZ7pUdkjBLLds/PlCQ==
References: <202108140311.dorJxbPR-lkp@intel.com>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
Message-ID: <f1da62c8-25e7-3183-7ac4-cab3888d141f@nvidia.com>
Date: Mon, 16 Aug 2021 11:37:08 +0300
In-Reply-To: <202108140311.dorJxbPR-lkp@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net-next 4/6] net: bridge: mcast: dump ipv4
	querier state
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Dan Carpenter <dan.carpenter@oracle.com>, kbuild@lists.01.org, Nikolay Aleksandrov <razor@blackwall.org>, netdev@vger.kernel.org
Cc: bridge@lists.linux-foundation.org, kbuild-all@lists.01.org, lkp@intel.com, roopa@nvidia.com

On 16/08/2021 11:33, Dan Carpenter wrote:
> Hi Nikolay,
> 
> url:    https://github.com/0day-ci/linux/commits/Nikolay-Aleksandrov/net-bridge-mcast-dump-querier-state/20210813-230258
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git b769cf44ed55f4b277b89cf53df6092f0c9082d0
> config: x86_64-randconfig-m001-20210814 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> smatch warnings:
> net/bridge/br_multicast.c:2931 br_multicast_querier_state_size() warn: sizeof(NUMBER)?
> 
> vim +2931 net/bridge/br_multicast.c
> 
> 384d7e0455593b Nikolay Aleksandrov 2021-08-13  2929  size_t br_multicast_querier_state_size(void)
> 384d7e0455593b Nikolay Aleksandrov 2021-08-13  2930  {
> 384d7e0455593b Nikolay Aleksandrov 2021-08-13 @2931  	return nla_total_size(sizeof(0)) +      /* nest attribute */
>                                                                               ^^^^^^^^^
> This looks like it's probably intentional, but wouldn't it be more
> readable to say sizeof(int) as it does below?
> 

The nest attribute has 0 size, my error was the sizeof(0), where it should've been
just 0 without sizeof.

I'll send a fix, thank you for the report.

> 384d7e0455593b Nikolay Aleksandrov 2021-08-13  2932  	       nla_total_size(sizeof(__be32)) + /* BRIDGE_QUERIER_IP_ADDRESS */
> 384d7e0455593b Nikolay Aleksandrov 2021-08-13  2933  	       nla_total_size(sizeof(int)) +    /* BRIDGE_QUERIER_IP_PORT */
> 384d7e0455593b Nikolay Aleksandrov 2021-08-13  2934  	       nla_total_size_64bit(sizeof(u64)); /* BRIDGE_QUERIER_IP_OTHER_TIMER */
> 384d7e0455593b Nikolay Aleksandrov 2021-08-13  2935  }
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 

