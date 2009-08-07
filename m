Date: Thu, 06 Aug 2009 20:20:33 -0700 (PDT)
Message-Id: <20090806.202033.232151260.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1249595428-21594-1-git-send-email-arnd@arndb.de>
References: <1249595428-21594-1-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] macvlan: add tap device backend
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: arnd@arndb.de
Cc: herbert@gondor.apana.org.au, mst@redhat.com, anna.fischer@hp.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, ogerlitz@voltaire.com, evb@yahoogroups.com

From: Arnd Bergmann <arnd@arndb.de>
Date: Thu,  6 Aug 2009 21:50:28 +0000

> This is a first prototype of a new interface into the network
> stack, to eventually replace tun/tap and the bridge driver
> in certain virtual machine setups.

I don't know enough to say how good a solution this is for
the problem, but I certainly like this driver for it's
utter simplicity and minimalness.
