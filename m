Date: Wed, 30 May 2007 22:28:48 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Subject: Re: [Bridge] bridge with ipw2200 wireless card
Message-ID: <20070530222848.3af6b9c8@localhost>
In-Reply-To: <BAY109-F35B09D22292458C0966C52A82D0@phx.gbl>
References: <BAY109-F35B09D22292458C0966C52A82D0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Fabio Costa Flores <binhocf@hotmail.com>
Cc: bridge@lists.linux-foundation.org

On Thu, 31 May 2007 03:23:41 +0000
"Fabio Costa Flores" <binhocf@hotmail.com> wrote:

> Im trying to setup xen hypervisor with my ipw2200 wireless card. Xen uses 
> Linux bridge and Im aware that its not easy to get it running with a 
> wireless card.
> 
> Im not sure where to go from now, any help would be apreciated.
> 

Gross oversimplification:
Wireless is point-to-point (sort of) and doesn't work with normal bridging.
You need a driver than can act as an access point.

http://linux-net.osdl.org/index.php/bridge
