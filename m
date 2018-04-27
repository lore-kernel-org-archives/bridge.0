Return-Path: <davem@davemloft.net>
Date: Fri, 27 Apr 2018 13:21:01 -0400 (EDT)
Message-Id: <20180427.132101.2075912512197945461.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180426030705.6632-1-yuehaibing@huawei.com>
References: <20180426030705.6632-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next] bridge: use hlist_entry_safe
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: yuehaibing@huawei.com
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org

From: YueHaibing <yuehaibing@huawei.com>
Date: Thu, 26 Apr 2018 11:07:05 +0800

> Use hlist_entry_safe() instead of open-coding it.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied, thanks.
