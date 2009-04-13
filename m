Date: Mon, 13 Apr 2009 09:56:33 -0700
From: Stephen Hemminger <shemminger@vyatta.com>
Message-ID: <20090413095633.63894b2f@nehalam>
In-Reply-To: <49E0BD2D.9030908@pacbell.net>
References: <49E0BD2D.9030908@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Building a Raw Bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Michael Boutte <maboutte@pacbell.net>
Cc: bridge@lists.linux-foundation.org

On Sat, 11 Apr 2009 08:54:21 -0700
Michael Boutte <maboutte@pacbell.net> wrote:

> Hi All,
> I think the little diagram of the circuit became a mess when 
> transmitted. How about this attempt? This is the hub of a hub and spoke 
> topology and there is normally only one transmit and multiple receivers
> 
> Here is what one end of the link looks like.
> 
>                    +-------------+
> 
>         + eth0 +---+   bridge 1  +---+ wan0 ---> Transmit
> 
>         |          +-------------+ 
>         |                          
> switch--+                          
>         |          +-------------+ 
>         + eth0 +---+   bridge 2  +---+ wan0 <--- Receive
> 
>                    +-------------+
> 
> 
> Mike Boutte
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/bridge

What you are doing is not really a bridge, so of course it
won't work.  If you need to glue devices together, and the
performance overhead isn't too high do it in user space.
