Date: Sun, 13 Apr 2008 11:59:23 +0100 (BST)
From: Malcolm Scott <Malcolm.Scott@cl.cam.ac.uk>
In-Reply-To: <47FFA849.7050103@navigue.com>
Message-ID: <alpine.DEB.1.10.0804131157470.6843@callisto.moose.malc.org.uk>
References: <96CF49BD8B56384395D698BA99007FA32FA187@exchange.pacwire.local>
	<47E12A1B.9020201@navigue.com> <47FFA849.7050103@navigue.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: Re: [Bridge] bridge, vlan and *no* stp/bpdu
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jonathan Thibault <jonathan@navigue.com>
Cc: ebtables-user@lists.sourceforge.net, bridge@lists.osdl.org

On Fri, 11 Apr 2008, Jonathan Thibault wrote:

> Apr 11 11:59:03 ordralphabetix IN=out OUT= MAC source =
> 00:18:18:62:3e:80 MAC dest = 08:10:17:0d:70:61 proto = 0x0806
>
> Why don't I see 'OUT=in.2'.  If the arp reply reached my host, it
> obviously had to go through the bridge.  That is in the 'out' interface
> and out the 'in.2' interface.

A hunch (which I haven't had time to verify yet): empty OUT= probably means 
the frame will be flooded to all output interfaces.

Someone who knows the code better than I do will no doubt be able to confirm 
or deny :)

Malcolm

-- 
Malcolm Scott
Research Assistant
University of Cambridge Computer Laboratory

