Return-Path: <davem@davemloft.net>
Date: Sun, 01 Jun 2014 22:05:36 -0700 (PDT)
Message-Id: <20140601.220536.2044599890570404047.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <53869842.4060202@huawei.com>
References: <53869842.4060202@huawei.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next] bridge: fix the unbalanced
 promiscuous count when add_if failed
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: wangweidong1@huawei.com
Cc: stephen@networkplumber.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, vyasevic@redhat.com

From: Wang Weidong <wangweidong1@huawei.com>
Date: Thu, 29 May 2014 10:15:30 +0800

> As commit 2796d0c648c94("bridge: Automatically manage port
> promiscuous mode."), make the add_if use dev_set_allmulti
> instead of dev_set_promiscuous, so when add_if failed, we
> should do dev_set_allmulti(dev, -1).
> 
> Signed-off-by: Wang Weidong <wangweidong1@huawei.com>

Applied, thank you.
