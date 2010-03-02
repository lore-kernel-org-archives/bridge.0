Date: Tue, 2 Mar 2010 14:39:44 +1100
From: Paul Mackerras <paulus@samba.org>
Message-ID: <20100302033944.GL26848@brick.ozlabs.ibm.com>
References: <20100301145915.2ecaac89@nehalam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100301145915.2ecaac89@nehalam>
Subject: Re: [Bridge] [RFC] ppp: Bridge Control Protocol
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@vyatta.com>
Cc: David@mail.vyatta.com, linux-ppp@vger.kernel.org, bridge@linux-foundation.org, netdev@vger.kernel.org, dane@aiinet.com, "Miller <davem"@davemloft.net

On Mon, Mar 01, 2010 at 02:59:15PM -0800, Stephen Hemminger wrote:

> This is a port of an old patch to provide BCP support.
> BCP allows bridging PPP tunnels, it useful to do bridging between
> virtualized environments. Original patch was done by
> Dan Eble but was for 2.4.21.
> 
> Note: still needs testing. Does anyone have hardware to make
> sure this interoperates with other implementations?

Is there a corresponding pppd patch to handle the control protocol?

Paul.
