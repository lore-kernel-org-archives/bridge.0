Date: Fri, 7 Apr 2006 16:59:28 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] [PATCH] fix 802.3ad multicast
Message-ID: <20060407165928.022d4ad8@dxpl.pdx.osdl.net>
In-Reply-To: <1144340106.17145.8.camel@quant>
References: <1144340106.17145.8.camel@quant>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Vlad Drukker <vlad@storewiz.com>
Cc: bridge@osdl.org

On Thu, 06 Apr 2006 19:15:06 +0300
Vlad Drukker <vlad@storewiz.com> wrote:

> Hi Stephen,
> 
> there was a bug in bridging bonds.
> multicast packets needed for 802.3ad netif_carrier_ok() were dropped.
> attached patch works for me.
> 
> Cheers,
> Vlad.
> 
> 
> 

Making a bonding specific hack like this seems wrong. The
port could also be disabled during shutdown (for RCU removal),
and in that case we need to drop the packet.

There must be a better solution.

-- 
Stephen Hemminger <shemminger@osdl.org>
OSDL http://developer.osdl.org/~shemminger
