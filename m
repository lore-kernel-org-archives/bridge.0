Return-Path: <davem@davemloft.net>
Date: Tue, 03 Dec 2019 11:22:45 -0800 (PST)
Message-Id: <20191203.112245.4269861704222403.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20191203144806.10468-1-nikolay@cumulusnetworks.com>
References: <20191203144806.10468-1-nikolay@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net] net: bridge: deny dev_set_mac_address()
 when unregistering
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: nikolay@cumulusnetworks.com
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, syzkaller-bugs@googlegroups.com, syzbot+2add91c08eb181fea1bf@syzkaller.appspotmail.com

From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Tue,  3 Dec 2019 16:48:06 +0200

> We have an interesting memory leak in the bridge when it is being
> unregistered and is a slave to a master device which would change the
> mac of its slaves on unregister (e.g. bond, team). This is a very
> unusual setup but we do end up leaking 1 fdb entry because
> dev_set_mac_address() would cause the bridge to insert the new mac address
> into its table after all fdbs are flushed, i.e. after dellink() on the
> bridge has finished and we call NETDEV_UNREGISTER the bond/team would
> release it and will call dev_set_mac_address() to restore its original
> address and that in turn will add an fdb in the bridge.
> One fix is to check for the bridge dev's reg_state in its
> ndo_set_mac_address callback and return an error if the bridge is not in
> NETREG_REGISTERED.
> 
> Easy steps to reproduce:
>  1. add bond in mode != A/B
>  2. add any slave to the bond
>  3. add bridge dev as a slave to the bond
>  4. destroy the bridge device
> 
> Trace:
>  unreferenced object 0xffff888035c4d080 (size 128):
 ...
> Fixes: 43598813386f ("bridge: add local MAC address to forwarding table (v2)")
> Reported-by: syzbot+2add91c08eb181fea1bf@syzkaller.appspotmail.com
> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

Looks good, applied and queued up for -stable.

Thanks.
