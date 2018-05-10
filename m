Return-Path: <davem@davemloft.net>
Date: Thu, 10 May 2018 15:27:19 -0400 (EDT)
Message-Id: <20180510.152719.500625126905254406.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180509030312.29548-1-vivien.didelot@savoirfairelinux.com>
References: <20180509030312.29548-1-vivien.didelot@savoirfairelinux.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next] net: dsa: fix added_by_user switchdev
 notification
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: vivien.didelot@savoirfairelinux.com
Cc: ivecera@redhat.com, f.fainelli@gmail.com, andrew@lunn.ch, nikolay@cumulusnetworks.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, idosch@mellanox.com, jiri@mellanox.com, kernel@savoirfairelinux.com, petrm@mellanox.com

From: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Date: Tue,  8 May 2018 23:03:12 -0400

> Commit 161d82de1ff8 ("net: bridge: Notify about !added_by_user FDB
> entries") causes the below oops when bringing up a slave interface,
> because dsa_port_fdb_add is still scheduled, but with a NULL address.
> 
> To fix this, keep the dsa_slave_switchdev_event function agnostic of the
> notified info structure and handle the added_by_user flag in the
> specific dsa_slave_switchdev_event_work function.
 ...
> Fixes: 816a3bed9549 ("switchdev: Add fdb.added_by_user to switchdev notifications")
> Signed-off-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>

Applied, thanks Vivien.
