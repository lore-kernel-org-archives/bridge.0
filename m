Return-Path: <davem@davemloft.net>
Date: Wed, 20 Mar 2019 11:05:01 -0700 (PDT)
Message-Id: <20190320.110501.903028894297149241.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20190320020657.31423-1-maowenan@huawei.com>
References: <20190320020657.31423-1-maowenan@huawei.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next] net: bridge: use eth_broadcast_addr()
 to assign broadcast address
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: maowenan@huawei.com
Cc: nikolay@cumulusnetworks.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

From: Mao Wenan <maowenan@huawei.com>
Date: Wed, 20 Mar 2019 10:06:57 +0800

> This patch is to use eth_broadcast_addr() to assign broadcast address
> insetad of memset().
> 
> Signed-off-by: Mao Wenan <maowenan@huawei.com>

Applied.
