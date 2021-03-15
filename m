Return-Path: <nikolay@nvidia.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yrcEKyxLLfRA2ghTLDadh5n8T6ImHMxOr/Vcv2QkIzw=;
 b=QgaS5YaL0z3cfaLgSdsowf89CNS5dhcmBunrLjX4t94hK5QadJurpLvy9R/oH6Ytt660PxmYQz4tmmap2N748Ghhf0bgBAImV133ApUCdGCZrPV6C6bbng+3oZhbKnRBCjcU9NJs8J6RhhLDNrxqyiq1DTyBOqsIWU2oAfV43NaFwEM3xGc/E/73a5xng1Ve6+weG+XMog3a8GAc33QYqaPxKaZxbMxz+j1I7gy1zeVD+cDo8IwlQ4sjOoAGKKDnqHGwgnDrlKlyMOu6ZJJm0ilzW/gOdij2yIi6AKdn4BlYsdiCHmKfKHoHR02iHUtieVMzZl4LdTDUfNNHWXHaIQ==
References: <20210315153835.190174-1-razor@blackwall.org>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
Message-ID: <ad95c2f3-a3c8-cd56-1e83-e4a7d53c7f7f@nvidia.com>
Date: Mon, 15 Mar 2021 17:44:19 +0200
In-Reply-To: <20210315153835.190174-1-razor@blackwall.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net-next] net: bridge: mcast: remove
	unreachable EHT code
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <razor@blackwall.org>, netdev@vger.kernel.org
Cc: kuba@kernel.org, bridge@lists.linux-foundation.org, davem@davemloft.net, roopa@nvidia.com

On 15/03/2021 17:38, Nikolay Aleksandrov wrote:
> From: Nikolay Aleksandrov <nikolay@nvidia.com>
> 
> In the initial EHT versions there were common functions which handled
> allow/block messages for both INCLUDE and EXCLUDE modes, but later they
> were separated. It seems I've left some common code which cannot be
> reached because the filter mode is checked before calling the respective
> functions, i.e. the host filter is always in EXCLUDE mode when using
> __eht_allow_excl() and __eht_block_excl() thus we can drop the host_excl
> checks inside and simplify the code a bit.
> 
> Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
> ---
>  net/bridge/br_multicast_eht.c | 54 ++++++++++-------------------------
>  1 file changed, 15 insertions(+), 39 deletions(-)
> 

Oh well, sent the wrong patch version. I'll send the proper version as v2.
Self-NAK and sorry for the noise


