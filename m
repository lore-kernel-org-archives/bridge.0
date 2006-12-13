Date: Wed, 13 Dec 2006 10:27:28 -0800
From: Stephen Hemminger <shemminger@osdl.org>
Message-ID: <20061213102728.345c2738@dxpl.pdx.osdl.net>
In-Reply-To: <20061210022020.94000@gmx.net>
References: <20061210022020.94000@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Linux Bridge + STP + VLAN
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: M.Rennt@gmx.net
Cc: bridge@osdl.org

On Sun, 10 Dec 2006 03:20:20 +0100
M.Rennt@gmx.net wrote:

> Hi,
> 
> we're running the standard linux bridge setup (redundant bridge) for 5 years now. So first of all, thanks to everyone involved for implementing the bridging feature in Linux.
> 
> Now I'm trying to bridge hosts connected to VLAN'ed Cisco switches using linux bridge.

Bridging VLAN's is problematic because Linux Bridge does not support spanning
tree for VLAN's. There was some talk of fixing it, but no patches have
been sent to me.
