Message-ID: <4505B58F.8000905@candelatech.com>
Date: Mon, 11 Sep 2006 12:14:23 -0700
From: Ben Greear <greearb@candelatech.com>
MIME-Version: 1.0
References: <20060911174928.GA3451@devicescape.com> <4505B312.4030606@gac.edu>
In-Reply-To: <4505B312.4030606@gac.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] RFC: [PATCH] bridge vlan integration
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Ethan Sommer <sommere@gac.edu>
Cc: bridge@lists.osdl.org

Ethan Sommer wrote:
> Have you tested this in a real world scenario?
> 
> I attempted to use a linux bridge to bridge a few vlans and found that 
> it didn't work as expected. At first I thought it was a performance 
> problem relating to the linux bridge code because it was dropping 
> packets, but I believe the problem is inherent in using a bridge in a 
> vlan environment.
> 
> The problem lies in the fact that the switch connected to the bridge 
> (which has the vlans tagged) gets confused as to which port that 
> particular mac address is out of. Take the following scenario: (based on 
> my understanding of how things should work)

Cisco switches have this bug, though it can be worked around on some
switches.  The Netgear switches I've used do not have any problem with
the same MAC on different vlans.

Either way, you can change the MAC of the Linux VLAN device using the
standard ifconfig or ip tool commands.

Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

