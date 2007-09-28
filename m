Date: Fri, 28 Sep 2007 08:40:23 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Subject: Re: [Bridge] Flushing MAC-tables(?)
Message-ID: <20070928084023.6dfd7580@freepuppy.rosehill>
In-Reply-To: <20070928103837.gvdex50ucksc4kg0@webapps>
References: <46FCB3F4.4080802@googlemail.com>
	<46FCBC98.6030507@sysnetsistemi.it>
	<46FCEF57.4080007@googlemail.com>
	<20070928103837.gvdex50ucksc4kg0@webapps>
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
To: "Mark S. Mathews" <mark@linux-wlan.com>
Cc: bridge@lists.linux-foundation.org

On Fri, 28 Sep 2007 10:38:37 -0400
"Mark S. Mathews" <mark@linux-wlan.com> wrote:

> There's a simpler solution: at association-time the wlan stack should  
> emit (up to linux) a bcast frame w/ the source address of the  
> associating station.  That frame will serve to notify the local and  
> remote bridges of the move.
> 
> -Mark
> 
With 2.6 if you set the ageing time to 0 then no forwarding table
entry is made (it will always flood).  Or you could set it real
short time.

2.4 code is fossilized at this point and your limited to setting
a real short ageing time.  You can go down to 1 HZ value so that
should work.

-- 
Stephen Hemminger <shemminger@linux-foundation.org>
