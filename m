Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cumulusnetworks.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=hBMfuDIAoT4SFwZ/3u104/lWEd/i6lIYF1PY5oM5pI0=;
 b=TcBFkEytJScweYUxW7dsjokpcc4dmGJTwVS80o7KJv6ybvjVYmpNSbnBfo1rYlkv1p
 8A4p9XEfzZraCb80CH2BOACdX5cweDb+xG4uwrw1AnVl5WgAJtuFeWmg7b5mfqvEq/EE
 yRmz5CMFI+4+8U8vysnwQ8MxV0vI0it6EQmqU=
References: <20200903121832.GD8299@kadam>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <e44e5447-6420-68ba-3f45-bee090382660@cumulusnetworks.com>
Date: Thu, 3 Sep 2020 15:40:49 +0300
MIME-Version: 1.0
In-Reply-To: <20200903121832.GD8299@kadam>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v2 04/15] net: bridge: mcast: add
 support for group-and-source specific queries
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Dan Carpenter <dan.carpenter@oracle.com>, kbuild@lists.01.org, netdev@vger.kernel.org
Cc: kbuild-all@lists.01.org, lkp@intel.com, bridge@lists.linux-foundation.org, roopa@nvidia.com, davem@davemloft.net, Dan Carpenter <error27@gmail.com>

On 03/09/2020 15:18, Dan Carpenter wrote:
> Hi Nikolay,
> 
> url:    https://github.com/0day-ci/linux/commits/Nikolay-Aleksandrov/net-bridge-mcast-initial-IGMPv3-support-part-1/20200902-193339
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git dc1a9bf2c8169d9f607502162af1858a73a18cb8
> config: i386-randconfig-m021-20200902 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> New smatch warnings:
> net/bridge/br_multicast.c:359 br_ip4_multicast_alloc_query() error: use kfree_skb() here instead of kfree(skb)
> 
> Old smatch warnings:
> net/bridge/br_multicast.c:711 br_multicast_add_group() error: potential null dereference 'mp'.  (br_multicast_new_group returns null)
> 

Thanks Dan!
I also caught that while working on v3 and the IPv6 part. :) 
Since it's in code that shouldn't be ever reached it wasn't tested.
Anyway in v3 it will be fixed.

