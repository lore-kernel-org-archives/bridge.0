Date: Fri, 2 Jun 2006 11:07:16 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Message-ID: <20060602110716.7826d3dd@localhost.localdomain>
In-Reply-To: <447E612C.6090309@triplehelix.org>
References: <447E612C.6090309@triplehelix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Bridging a wireless/wired LAN and a PPPoE connection
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Joshua Kwan <joshk@triplehelix.org>
Cc: bridge@lists.osdl.org

On Wed, 31 May 2006 20:38:20 -0700
Joshua Kwan <joshk@triplehelix.org> wrote:

> Hi all,
> 
> I'm trying out bridging for my wireless and wired LAN, so that they can
> both use my PPPoE connection. Here's the network structure, pretty easy:
> 
> darjeeling (192.168.1.7)                    ringo (192.168.1.3)
> (mtu 1500)                                       (mtu 1500)
> \                                                    /
>  \   wlan0      <--br0 (mtu 1500)-->      eth1      /
>   -- 802.11 --- influx (192.168.1.1) --- Ethernet --
>  /  (mtu 1500)          |                (mtu 1500) \
> ...                    eth0                         ...
>                     (mtu 1500)
>                         |
>                         v
>                   ppp0 (mtu 1492)
>                         |
>                         v
>                   (( Internet ))
> 
> My problem is that certain websites are inaccessible from darjeeling and
> ringo if I don't set the MTU to 1492 on each client. Changing the MTU to
> 1492 on eth0 just fubars my PPP connection.
> 
> Alternatively, setting up a HTTP proxy on br0 works as well, and is the
> solution I'm using for my clients at home right now.
> 
> Could somebody explain to me what is going on? What I would prefer to do
> is use a solution that doesn't require me to use the proxy or change
> everyone's MTU to 1492.
> 
> If I'm being unclear please ask me to clarify, I'm not quite sure I have
> all this understood myself.
> 
> Please CC me as I'm not subscribed to the list.
> 
> Thanks!
> 

I think what is needed in these cases is some netfilter module to send
the appropriate ICMP message to let TCP Path MTU discovery work. Then you
could set mtu of eth0 to 1492. Connection tracking might do that as a side
effect.
