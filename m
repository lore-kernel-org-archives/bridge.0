Message-ID: <b008c6a40812040839k102518dbncea5c8dc28e562a9@mail.gmail.com>
Date: Thu, 4 Dec 2008 17:39:45 +0100
From: "Jaime Medrano" <jaime.medrano@gmail.com>
Sender: overflow5@gmail.com
In-Reply-To: <495641228242344@webmail54.yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <495641228242344@webmail54.yandex.ru>
Subject: Re: [Bridge] ethernet bridging and http header enrichment
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ivan Chernyavsky <camposer@yandex.ru>
Cc: bridge@lists.linux-foundation.org

On 12/2/08, Ivan Chernyavsky <camposer@yandex.ru> wrote:
> 2. Part of that traffic, namely, some web traffic to particular
> hosts, should be "enriched" by adding some headers to HTTP
> requests. Size of original requests is guaranteed to be
> small enough so that header insertion will not make them to grow
> above max allowed ethernet frame size.

Maybe this is what wou want:

http://www.balabit.com/support/community/products/tproxy/

Regards,
Jaime.
