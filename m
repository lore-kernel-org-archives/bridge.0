Message-ID: <40F97EAC.5020605@siennax.com>
Date: Sat, 17 Jul 2004 21:31:56 +0200
From: Mark Ruijter <bridge@siennax.com>
MIME-Version: 1.0
Subject: Re: [Bridge] Bridge code enhancement (link state detection) and bug
	fix. (patches included).
References: <40D1E993.3060801@siennax.com>
	<20040716162855.52d91672@dell_ss3.pdx.osdl.net>
In-Reply-To: <20040716162855.52d91672@dell_ss3.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: bridge@lists.osdl.org


> 
> 
> Could you split out the link state monitoring, and look at bonding to see
> how they are doing it?

Yes, no problem.

> 
> I have a fix for vlan code that passes MII and ethtool requests from the virtual
> to physical device, so the bridge code wouldn't need to the hack about root device.
> 

I'll change the code so it doesn't include the root device hack anymore.

Mark.

