Date: Fri, 8 May 2009 09:02:26 -0700
From: Stephen Hemminger <shemminger@vyatta.com>
Message-ID: <20090508090226.70d23727@nehalam>
In-Reply-To: <OF6C9DD85E.5F51CD2D-ONC12575B0.002E85F9-C12575B0.002F0604@transmode.se>
References: <OF6C9DD85E.5F51CD2D-ONC12575B0.002E85F9-C12575B0.002F0604@transmode.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] brigde does not relay BPDU multicast pkgs
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Cc: bridge@lists.linux-foundation.org

On Fri, 8 May 2009 10:33:37 +0200
Joakim Tjernlund <joakim.tjernlund@transmode.se> wrote:

> 
> Hi List
> 
> We have noticed that when STP is off in the linux bridge, it won't
> relay STP pkts received from other bridges.
> This feels like a bug(a bad one too). I hope this isn't
> intentional behaviour?
> 
>  Jocke
> 
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/bridge

It is a debatable whether this is correct behaviour.
My current opinion is that it needs to forward STP packets if
STP is off. This would allow for loop detection by other bridges
doing STP.

Longer term, RSTP needs to be fully integrated and default to on.
That way the average user will be safe from loops.

-- 
