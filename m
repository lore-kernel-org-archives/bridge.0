Return-Path: <davem@davemloft.net>
Date: Wed, 15 Jul 2015 17:15:41 -0700 (PDT)
Message-Id: <20150715.171541.949546821782337351.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1436794579-4188-1-git-send-email-nikolay@cumulusnetworks.com>
References: <1436794579-4188-1-git-send-email-nikolay@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net] bridge: mdb: fix double add notification
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: nikolay@cumulusnetworks.com
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, amwang@redhat.com

From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Mon, 13 Jul 2015 06:36:19 -0700

> Since the mdb add/del code was introduced there have been 2 br_mdb_notify
> calls when doing br_mdb_add() resulting in 2 notifications on each add.
> 
> Example:
>  Command: bridge mdb add dev br0 port eth1 grp 239.0.0.1 permanent
>  Before patch:
>  root@debian:~# bridge monitor all
>  [MDB]dev br0 port eth1 grp 239.0.0.1 permanent
>  [MDB]dev br0 port eth1 grp 239.0.0.1 permanent
> 
>  After patch:
>  root@debian:~# bridge monitor all
>  [MDB]dev br0 port eth1 grp 239.0.0.1 permanent
> 
> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
> Fixes: cfd567543590 ("bridge: add support of adding and deleting mdb entries")

Applied and queued up for -stable, thanks.
