Return-Path: <davem@davemloft.net>
Date: Tue, 18 Dec 2018 15:50:41 -0800 (PST)
Message-Id: <20181218.155041.273935089211418130.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20181217094623.32668-1-yuehaibing@huawei.com>
References: <20181217094623.32668-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next] net: bridge: remove unneeded variable
	'err'
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: yuehaibing@huawei.com
Cc: nikolay@cumulusnetworks.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>
Date: Mon, 17 Dec 2018 17:46:23 +0800

> function br_multicast_toggle now always return 0,
> so the variable 'err' is unneeded.
> Also cleanup dead branch in br_changelink.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied.
