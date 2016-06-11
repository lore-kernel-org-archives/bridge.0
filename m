Return-Path: <davem@davemloft.net>
Date: Fri, 10 Jun 2016 22:35:12 -0700 (PDT)
Message-Id: <20160610.223512.206489271156278288.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1465215613-3468-1-git-send-email-makita.toshiaki@lab.ntt.co.jp>
References: <1465215613-3468-1-git-send-email-makita.toshiaki@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v2] bridge: Synchronize unicast
 filtering with FDB
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: makita.toshiaki@lab.ntt.co.jp
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, nikolay@cumulusnetworks.com, netdev@bof.de

From: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Date: Mon,  6 Jun 2016 21:20:13 +0900

> Patrick Schaaf reported that flooding due to a missing fdb entry of
> the address of macvlan on the bridge device caused high CPU
> consumption of an openvpn process behind a tap bridge port.
> Adding an fdb entry of the macvlan address can suppress flooding
> and avoid this problem.
> 
> This change makes bridge able to synchronize unicast filtering with
> fdb automatically so admin do not need to manually add an fdb entry.
> This effectively supports IFF_UNICAST_FLT in bridge, thus adding an
> macvlan device would not place bridge into promiscuous mode as well.
> 
> v2:
> - Test vlan with br_vlan_should_use() in br_fdb_sync_uc() as per
>   Nikolay Aleksandrov.
> 
> Reported-by: Patrick Schaaf <netdev@bof.de>
> Signed-off-by: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>

I really need bridging experts to review and ACK/NACK this.

Thanks.
