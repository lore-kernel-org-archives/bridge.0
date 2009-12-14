From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 14 Dec 2009 16:40:13 +0100
References: <1259862720-28432-1-git-send-email-arnd@arndb.de>
	<1259862720-28432-3-git-send-email-arnd@arndb.de>
	<4B26353A.9020005@trash.net>
In-Reply-To: <4B26353A.9020005@trash.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200912141640.13562.arnd@arndb.de>
Subject: Re: [Bridge] [RFC] macvlan: add tap device backend
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
	Anna" <anna.fischer@hp.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Or Gerlitz <ogerlitz@voltaire.com>, Anthony Liguori <anthony@codemonkey.ws>, Edge Virtual Bridging <evb@yahoogroups.com>, davem@davemloft.net

On Monday 14 December 2009, Patrick McHardy wrote:
> > +     classdev = device_create(macvtap_class, &dev->dev, devt,
> > +                              dev, "tap%d", dev->ifindex);
> > +     if (IS_ERR(classdev)) {
> > +             err = PTR_ERR(classdev);
> > +             macvtap_del_queues(dev);
> > +             macvlan_dellink(dev, NULL);
> 
> I think this may cause a double free since macvlan_dellink() will
> free the device and rtnl_newlink() will free it again on error.

Ah, right. I've changed this part a few times now, but I think introduced
the same bug again in the current version. I'll send out what I have now
if you want to take another look.

	Arnd
