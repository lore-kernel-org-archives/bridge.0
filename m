Return-Path: <davem@davemloft.net>
Date: Mon, 29 Jul 2019 09:50:56 -0700 (PDT)
Message-Id: <20190729.095056.757433801392494014.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20190729092841.4260-1-nikolay@cumulusnetworks.com>
References: <20190728182230.28818-1-nikolay@cumulusnetworks.com>
	<20190729092841.4260-1-nikolay@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net v2] net: bridge: delete local fdb on device
 init failure
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: nikolay@cumulusnetworks.com
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, syzbot+88533dc8b582309bf3ee@syzkaller.appspotmail.com

From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Mon, 29 Jul 2019 12:28:41 +0300

> On initialization failure we have to delete the local fdb which was
> inserted due to the default pvid creation. This problem has been present
> since the inception of default_pvid. Note that currently there are 2 cases:
> 1) in br_dev_init() when br_multicast_init() fails
> 2) if register_netdevice() fails after calling ndo_init()
> 
> This patch takes care of both since br_vlan_flush() is called on both
> occasions. Also the new fdb delete would be a no-op on normal bridge
> device destruction since the local fdb would've been already flushed by
> br_dev_delete(). This is not an issue for ports since nbp_vlan_init() is
> called last when adding a port thus nothing can fail after it.
> 
> Reported-by: syzbot+88533dc8b582309bf3ee@syzkaller.appspotmail.com
> Fixes: 5be5a2df40f0 ("bridge: Add filtering support for default_pvid")
> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
> ---
> v2: reworded the commit message and comment so they're not plural, we're
>     talking about a single bridge local fdb added on the init vlan creation
>     of the default pvid
> 
> Tested with the provided reproducer and can no longer trigger the leak.
> Also tested the br_multicast_init() failure manually by making it always
> return an error.

Applied and queued up for -stable, thank you.
