Date: Wed, 16 Jan 2008 10:22:10 -0800
From: Stephen Hemminger <shemminger@linux-foundation.org>
Subject: Re: [Bridge] Retain an IP address on a i/f partcipating in a bridge?
Message-ID: <20080116102210.711d1ee8@speedy>
In-Reply-To: <000d01c857cf$08a384c0$19ea8e40$@tjernlund@transmode.se>
References: <000d01c857cf$08a384c0$19ea8e40$@tjernlund@transmode.se>
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
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Cc: bridge@linux-foundation.org

On Wed, 16 Jan 2008 00:33:28 +0100
"Joakim Tjernlund" <joakim.tjernlund@transmode.se> wrote:

> Currently one must unset the IP address on an i/f that is included in a
> bridge and
> move the IP address to the bridge i/f instead if one wants to maintain
> connectivity with
> the box. This is a problem for us as one loses all routes. The rename of the
> i/f 
> is also a problem.
> 
> Is there a fundamental reason one cannot keep the IP address on one i/f that
> is a member in a bride? I only have two real interfaces in the bridge if
> that 
> makes it any easier.
> Any pointers where I need to adjust the bride code would be appreciated.
> 
>      Jocke

When bridge is active on an interface all packets are processed by the bridge
device not by the individual device.   You can always setup a bridge with only
one interface, or use a script that setups the bridge.
