From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 27 Jan 2010 11:04:20 +0100
MIME-Version: 1.0
Message-Id: <201001271104.20607.arnd@arndb.de>
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Bridge] [PATCH 0/3 v3] macvtap driver
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: David Miller <davem@davemloft.net>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Or Gerlitz <ogerlitz@voltaire.com>

This is the third version of the macvtap device driver, following another major restructuring and a lot of bug fixes:

* Change macvtap to be based around a struct sock
* macvtap: fix initialization
* return 0 to netlink
* don't use rcu for q->file and q->vlan pointers
* macvtap: checkpatch.pl fixes
* macvtap: fix tun IFF flags
* Use a struct socket to make tx flow control work
* disable BH processing during transmit
* only add an ethernet header for receive not forward
* allocate the SKB using GFP_NOWAIT since we're
  in rcu_read_lock
* use atomic allocation for socket
* fix blocking on send
* do not destroy netdev twice in error path

There are still known problems, but unless there
are fundamental concerns, I'd like this to go
into net-next as an experimental driver,
fixing up the remaining problems by 2.6.34-rc1.

	Arnd
