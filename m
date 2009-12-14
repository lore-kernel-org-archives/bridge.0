Message-ID: <4B263468.3060406@trash.net>
Date: Mon, 14 Dec 2009 13:49:44 +0100
From: Patrick McHardy <kaber@trash.net>
MIME-Version: 1.0
References: <1259862720-28432-1-git-send-email-arnd@arndb.de>
	<1259862720-28432-2-git-send-email-arnd@arndb.de>
In-Reply-To: <1259862720-28432-2-git-send-email-arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [RFC 1/2] macvlan: Allow plugging in additional
	backends
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Patrick Mullaney <pmullaney@novell.com>, davem@davemloft.net

Arnd Bergmann wrote:
> This patch includes only the basic framework for overriding the
> receive path. With these hooks, we can add the macvtap driver
> and potentially other drivers that directly interface with a
> hypervisor.
> 
> Loosely based on a patch by Patrick Mullaney based on another
> patch by Arnd Bergmann.

This patch looks fine to me.
