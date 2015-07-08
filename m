Return-Path: <davem@davemloft.net>
Date: Wed, 08 Jul 2015 16:11:26 -0700 (PDT)
Message-Id: <20150708.161126.397827455847313183.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1436277356-21404-1-git-send-email-razor@blackwall.org>
References: <1436277356-21404-1-git-send-email-razor@blackwall.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net] bridge: mdb: zero out the local br_ip
 variable before use
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: razor@blackwall.org
Cc: netdev@vger.kernel.org, vyasevich@gmail.com, bridge@lists.linux-foundation.org

From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Tue,  7 Jul 2015 15:55:56 +0200

> Since commit b0e9a30dd669 ("bridge: Add vlan id to multicast groups")
> there's a check in br_ip_equal() for a matching vlan id, but the mdb
> functions were not modified to use (or at least zero it) so when an
> entry was added it would have a garbage vlan id (from the local br_ip
> variable in __br_mdb_add/del) and this would prevent it from being
> matched and also deleted. So zero out the whole local ip var to protect
> ourselves from future changes and also to fix the current bug, since
> there's no vlan id support in the mdb uapi - use always vlan id 0.
> Example before patch:
> root@debian:~# bridge mdb add dev br0 port eth1 grp 239.0.0.1 permanent
> root@debian:~# bridge mdb
> dev br0 port eth1 grp 239.0.0.1 permanent
> root@debian:~# bridge mdb del dev br0 port eth1 grp 239.0.0.1 permanent
> RTNETLINK answers: Invalid argument
> 
> After patch:
> root@debian:~# bridge mdb add dev br0 port eth1 grp 239.0.0.1 permanent
> root@debian:~# bridge mdb
> dev br0 port eth1 grp 239.0.0.1 permanent
> root@debian:~# bridge mdb del dev br0 port eth1 grp 239.0.0.1 permanent
> root@debian:~# bridge mdb
> 
> Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
> Fixes: b0e9a30dd669 ("bridge: Add vlan id to multicast groups")

Applied and queued up for -stable.
