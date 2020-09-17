Return-Path: <davem@davemloft.net>
Date: Wed, 16 Sep 2020 17:13:55 -0700 (PDT)
Message-Id: <20200916.171355.1205456391955745862.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20200915145724.2065042-1-nikolay@cumulusnetworks.com>
References: <20200915145724.2065042-1-nikolay@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next] net: bridge: mcast: don't ignore
 return value of __grp_src_toex_excl
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: nikolay@cumulusnetworks.com
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, roopa@nvidia.com

From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Tue, 15 Sep 2020 17:57:24 +0300

> When we're handling TO_EXCLUDE report in EXCLUDE filter mode we should
> not ignore the return value of __grp_src_toex_excl() as we'll miss
> sending notifications about group changes.
> 
> Fixes: 5bf1e00b6849 ("net: bridge: mcast: support for IGMPV3/MLDv2 CHANGE_TO_INCLUDE/EXCLUDE report")
> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

Applied, thank you.
