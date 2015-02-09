Return-Path: <davem@redhat.com>
Date: Mon, 09 Feb 2015 14:19:21 -0800 (PST)
Message-Id: <20150209.141921.609350329551731658.davem@redhat.com>
From: David Miller <davem@redhat.com>
In-Reply-To: <1423480577-9473-1-git-send-email-makita.toshiaki@lab.ntt.co.jp>
References: <1423480577-9473-1-git-send-email-makita.toshiaki@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net] bridge: Fix inability to add non-vlan fdb
	entry
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: makita.toshiaki@lab.ntt.co.jp
Cc: vyasevic@redhat.com, bridge@lists.linux-foundation.org, netdev@vger.kernel.org

From: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Date: Mon,  9 Feb 2015 20:16:17 +0900

> Bridge's default_pvid adds a vid by default, by which we cannot add a
> non-vlan fdb entry by default, because br_fdb_add() adds fdb entries for
> all vlans instead of a non-vlan one when any vlan is configured.
> 
>  # ip link add br0 type bridge
>  # ip link set eth0 master br0
>  # bridge fdb add 12:34:56:78:90:ab dev eth0 master temp
>  # bridge fdb show brport eth0 | grep 12:34:56:78:90:ab
>  12:34:56:78:90:ab dev eth0 vlan 1 static
> 
> We expect a non-vlan fdb entry as well as vlan 1:
>  12:34:56:78:90:ab dev eth0 static
> 
> To fix this, we need to insert a non-vlan fdb entry if vlan is not
> specified, even when any vlan is configured.
> 
> Fixes: 5be5a2df40f0 ("bridge: Add filtering support for default_pvid")
> Signed-off-by: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>

Applied.
