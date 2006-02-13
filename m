Date: Mon, 13 Feb 2006 10:32:23 -0200
From: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>
Message-Id: <20060213103223.70f1b9f6.lcapitulino@mandriva.com.br>
In-Reply-To: <200602111632.36093.arvidjaar@mail.ru>
References: <200602111632.36093.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Re: [PATCH] [2.6.15.4] Fix has_bridge_parent undefined with
 CONFIG_NETFILTER_DEBUG
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: chrisw@sous-sol.org, apatard@mandriva.com, bridge@osdl.org, linux-kernel@vger.kernel.org


 Hi Andrey,

On Sat, 11 Feb 2006 16:32:35 +0300
Andrey Borzenkov <arvidjaar@mail.ru> wrote:

| -----BEGIN PGP SIGNED MESSAGE-----
| Hash: SHA1
| 
| Apparently introduced in the latest stable set; I am not sure if this is a 
| right fix but given that bridge parent already exists at this point it was 
| rather silly to fetch it again.

 There is a fix in Linus's tree already: 3c791925da0e6108cda15e3c2c7bfaebcd9ab9cf

 (pointed out by Arnaud Patard)

| 
| - -regards
| 
| - -andrey
| 
| Subject: [PATCH] [2.6.15.4] Fix has_bridge_parent undefined with 
| CONFIG_NETFILTER_DEBUG
| 
| This changes br_nf_post_routing to use realoutdev in debug print. At this
| time it is equal to bridge_parent and is guaranteed to be not NULL.
| 
| Signed-off-by: Andrey Borzenkov <arvidjaar@mail.ru>
| 
| 
| - ---
| 
|  net/bridge/br_netfilter.c |    4 +---
|  1 files changed, 1 insertions(+), 3 deletions(-)
| 
| db15f4ffe50096ba1585cfa344a440626724cfda
| diff --git a/net/bridge/br_netfilter.c b/net/bridge/br_netfilter.c
| index 0770664..37e085b 100644
| - --- a/net/bridge/br_netfilter.c
| +++ b/net/bridge/br_netfilter.c
| @@ -793,9 +793,7 @@ static unsigned int br_nf_post_routing(u
|  #ifdef CONFIG_NETFILTER_DEBUG
|  print_error:
|  	if (skb->dev != NULL) {
| - -		printk("[%s]", skb->dev->name);
| - -		if (has_bridge_parent(skb->dev))
| - -			printk("[%s]", bridge_parent(skb->dev)->name);
| +		printk("[%s][%s]", skb->dev->name, realoutdev->name);
|  	}
|  	printk(" head:%p, raw:%p, data:%p\n", skb->head, skb->mac.raw,
|  					      skb->data);
| - -- 
| 1.1.6
| -----BEGIN PGP SIGNATURE-----
| Version: GnuPG v1.4.2 (GNU/Linux)
| 
| iD8DBQFD7edzR6LMutpd94wRAngvAJsGuZqITozDySJ1UOHH2fs9zkoRMACfXT19
| RvWlH+TGksJk+hDU9d2pR+o=
| =yXVz
| -----END PGP SIGNATURE-----
| -
| To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
| the body of a message to majordomo@vger.kernel.org
| More majordomo info at  http://vger.kernel.org/majordomo-info.html
| Please read the FAQ at  http://www.tux.org/lkml/


-- 
Luiz Fernando N. Capitulino
