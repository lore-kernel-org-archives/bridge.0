Return-Path: <davem@davemloft.net>
Date: Tue, 13 Oct 2015 04:52:16 -0700 (PDT)
Message-Id: <20151013.045216.838190689363270571.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1444665355-28448-1-git-send-email-razor@blackwall.org>
References: <1444665355-28448-1-git-send-email-razor@blackwall.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next] bridge: fix gc_timer mod/del race
	condition
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: razor@blackwall.org
Cc: jiri@resnulli.us, nikolay@cumulusnetworks.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, sfeldma@gmail.com

From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Mon, 12 Oct 2015 17:55:55 +0200

> From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
> 
> commit c62987bbd8a1 ("bridge: push bridge setting ageing_time down to
> switchdev") introduced a timer race condition because the gc_timer can
> get rearmed after it's supposedly stopped and flushed in br_dev_delete()
> leading to a use of freed memory. So take rtnl to sync with bridge
> destruction when setting ageing_timer.
> Here's the trace reproduced with these two commands running in parallel:
> while :; do echo 10000 > /sys/class/net/br0/bridge/ageing_timer; done;
> while :; do brctl addbr br0; ip l set br0 up; ip l set br0 down;
> brctl delbr br0; done;
 ...
> Fixes: c62987bbd8a1 ("bridge: push bridge setting ageing_time down to switchdev")
> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

Applied, thanks.
