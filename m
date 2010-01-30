From: Arnd Bergmann <arnd@arndb.de>
Date: Sat, 30 Jan 2010 23:22:15 +0100
References: <201001271104.20607.arnd@arndb.de>
In-Reply-To: <201001271104.20607.arnd@arndb.de>
MIME-Version: 1.0
Message-Id: <201001302322.15237.arnd@arndb.de>
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Bridge] [PATCH 0/3 v4] macvtap driver
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: David Miller <davem@davemloft.net>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Or Gerlitz <ogerlitz@voltaire.com>

This is the fourth version of the macvtap driver,
based on the comments I got for the last version
I got a few days ago. Very few changes:

* release netdev in chardev open function so
  we can destroy it properly.
* Implement TUNSETSNDBUF
* fix sleeping call in rcu_read_lock
* Fix comment in namespace isolation patch
* Fix small context difference to make it apply
  to net-next

I can't really test here while travelling, so please
give it a go if you're interested in this driver.

	Arnd

