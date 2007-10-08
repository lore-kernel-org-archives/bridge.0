Date: Mon, 8 Oct 2007 08:36:40 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Subject: Re: [Bridge] Simple bridge, something's wrong
Message-ID: <20071008083640.6db9f926@freepuppy.rosehill>
In-Reply-To: <20071008075042.GW22818@uchicago.edu>
References: <20071008075042.GW22818@uchicago.edu>
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
To: Michael Jinks <mjinks@uchicago.edu>
Cc: bridge@lists.linux-foundation.org

On Mon, 8 Oct 2007 02:50:42 -0500
Michael Jinks <mjinks@uchicago.edu> wrote:

> Hi, list.
> 
> I'm trying to set up a bridging VPN and having trouble.  The VPN part
> seems to be working well, but for some reason bridging doesn't.
> 
> To make things as simple as possible for tracking down what I'm doing
> wrong, I've set up a test network with three Linux machines connected to
> two ethernet segments, no VPN stuff involved:
> 
>  Host A                    Host B                   Host C
> 10.1.1.15--[segment 1]--[br0, no IP]--[segment 2]--10.1.1.16
>                         (eth1, eth2)

Does Host B have an IP address or is it a pure bridge?

> On Host B:
> 
>   $ /sbin/brctl show
>   bridge name     bridge id               STP enabled     interfaces
>   br0             8000.000c299eefe7       no              eth1
>                                                           eth2

Did you wait for the forwarding delay (30 sec) to expire after
setting up bridge?

/sbin/brctl showstp br0


> If I try to ping Host C from Host A, I get "Destination host
> unreachable".  Watching tcpdump on Host B at the same time, I see
> "who-has" arp requests coming in, but nothing going back out and no
> replies.  brctl shows that the bridge has learned the MAC of Host A, but
> not Host C.
> 
>   $ sudo tcpdump -n -i br0
>   tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
>   listening on br0, link-type EN10MB (Ethernet), capture size 96 bytes
>   01:46:37.542316 arp who-has 10.1.1.15 tell 10.1.1.16
>   01:46:38.543744 arp who-has 10.1.1.15 tell 10.1.1.16
>   01:46:39.544740 arp who-has 10.1.1.15 tell 10.1.1.16
> 
>   $ /sbin/brctl showmacs br0
>   port no mac addr                is local?       ageing timer
>     1     00:0c:29:9e:ef:e7       yes                0.00
>     2     00:0c:29:9e:ef:f1       yes                0.00
>     1     00:0c:29:d9:59:d8       no                 1.83
> 
> (00:0c:29:d9:59:d8 is correct for Host A.)
> 
> If I try to ping the other direction at the same time -- to Host A from
> Host C -- ping on host C doesn't produce any output at all, I don't see
> any arp traffic from Host C on Host B, and brctl doesn't show anything
> new.
> 
> But, a few seconds after I stop pinging from Host A, Host B starts to
> produce "host unreachable" messages, Host B sees C's arp requests, and
> for a short while brctl shows both systems' MAC addresses, until the
> record for A eventually times out:
> 
>   $ /sbin/brctl showmacs br0
>   port no mac addr                is local?       ageing timer
>     2     00:0c:29:25:1a:00       no                 0.74
>     1     00:0c:29:9e:ef:e7       yes                0.00
>     2     00:0c:29:9e:ef:f1       yes                0.00
>     1     00:0c:29:d9:59:d8       no                10.85
> 
> So, traffic is reaching the bridge, but it seems that nothing is ever
> repeated onto the other segment, and whichever host pings the bridge
> first "squashes" any traffic from the other.
> 
> I've tried various combinations of settings under /proc.  ip_forward set
> to both 1 and 0; /proc/sys/net/bridge/bridge-nf-* all set to 0 or all
> set to 1.  That doesn't seem to make any difference.
> 

Have you setup filter rules?? or just plan to in future.

-- 
Stephen Hemminger <shemminger@linux-foundation.org>
