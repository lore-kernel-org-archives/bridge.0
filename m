Date: Wed, 4 Aug 2010 13:43:53 +0200 (CEST)
From: Jan Engelhardt <jengelh@medozas.de>
In-Reply-To: <AANLkTikUczLiyxy3A5eVv7bg1XWhH-ggN1yUv2-EwLYM@mail.gmail.com>
Message-ID: <alpine.LSU.2.01.1008041343200.32671@obet.zrqbmnf.qr>
References: <AANLkTikUczLiyxy3A5eVv7bg1XWhH-ggN1yUv2-EwLYM@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Bridge] ebtables PREROUTING -drop
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: ratheesh k <ratheesh.ksz@gmail.com>
Cc: Netfilter mailing list <netfilter@vger.kernel.org>, bridge@lists.linux-foundation.org

On Wednesday 2010-08-04 13:05, ratheesh k wrote:

>I  googled and  understood that "If we  DROP a packet at BROUTER chain
>, it will be passed to upper layer  and netfilter subsystem will
>process those packets .
>
>What will happen,  if we drop a packet at PREROUTING chain  of ebtables ?

Depends on the table you are referring to.
