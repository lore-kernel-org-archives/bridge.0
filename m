Date: Fri, 11 Mar 2005 09:34:47 -0800
From: Stephen Hemminger <shemminger@osdl.org>
Message-ID: <20050311093447.6559ab1d@dxpl.pdx.osdl.net>
In-Reply-To: <20050311014602.GA29420@nambi>
References: <20050311014602.GA29420@nambi>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Re: 2.6.8 bridging with large packets question
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Ted Deppner <ted@psyber.com>, bridge@osdl.org

On Thu, 10 Mar 2005 17:46:02 -0800
Ted Deppner <ted@psyber.com> wrote:

> I've got a multicast video application where I'm using a bridge to get
> duplicated multicast output on each of two physical interfaces.
> 
> eg br0 -> eth0 & eth1.  
> ifconfig br0 x.x.x.x
> route add -net 224.0.0.0/4 br0
> 
> This works perfectly for standard 1500 byte data packets (meaning they
> don't need to fragment).  However, if I use 4096 byte data packets, which
> obviously must fragment to go on the ethernet, then the packets only go
> out the last interface in the bridge, ie eth1.  There's no packets going
> out eth0.

Bridging implements a IEEE 802.2 bridge.  This means it is protocol independent,
it doesn't know what a IP packet is.  It's the standard, this is the correct
behaviour.

> Can you comment on this?  Has this been resolved in a later version of the
> kernel, or is there an option I can tweak?

You could use ebtables (netfilter for bridging), to process data and fragment
as needed.

> Thank you.
> 
> -- 
> Ted Deppner
> http://www.deppner.us/
