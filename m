From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 10 Aug 2009 20:43:32 +0200
References: <1249595428-21594-1-git-send-email-arnd@arndb.de>
	<4A7FC27F.1090904@trash.net>
In-Reply-To: <4A7FC27F.1090904@trash.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200908102043.32937.arnd@arndb.de>
Subject: Re: [Bridge] [PATCH] macvlan: add tap device backend
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Patrick McHardy <kaber@trash.net>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, "Michael S. Tsirkin" <mst@redhat.com>, "Fischer,
	Anna" <anna.fischer@hp.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Or Gerlitz <ogerlitz@voltaire.com>, Edge Virtual Bridging <evb@yahoogroups.com>, davem@davemloft.net

On Monday 10 August 2009, Patrick McHardy wrote:

> macvlan will remove all macvlan/vtap devices when the underlying
> device in unregistered, at which time you need to release the
> device references you're holding. I'd suggest to change the
> macvlan_device_event() handler to use
> 
> vlan->dev->rtnl_link_ops->dellink(vlan->dev)
> 
> instead of macvlan_dellink() so the macvtap_dellink callback
> is invoked.

Ok, will do that. Thanks,

	Arnd <><

