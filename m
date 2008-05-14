Message-ID: <482A9A10.3080909@sysnetsistemi.it>
Date: Wed, 14 May 2008 09:51:44 +0200
From: Francesco Dolcini <fdolcini@sysnetsistemi.it>
MIME-Version: 1.0
References: <1210152122.32216.95.camel@gentoo-jocke.transmode.se>	<2e59e6970805071916r701987fdx49bab341420ba2d@mail.gmail.com>	<1210233718.32216.121.camel@gentoo-jocke.transmode.se>	<2e59e6970805122010v50dcd5al101ae3466b897ad6@mail.gmail.com>
	<20080513102806.55f16b36@extreme>
In-Reply-To: <20080513102806.55f16b36@extreme>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] STP bug, loop not detetcted
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@vyatta.com>
Cc: Bridge@lists.linux-foundation.org, joakim.tjernlund@transmode.se

Stephen Hemminger wrote:
> Spanning Tree absolutely has to follow the standard. What ever the standard
> says, that is what it should do. No special cases, no changes. Get the standard
> for free from IEEE (get 802) and read it.
I do not agree, I absolutely think that linux STP must be 100% 
compatible with IEEE standard, but if we can improve it, adding 
additional functions without breaking 100% compatibility, why not do it?

> That said, we really need to get the STP updated to RSTP. There are currently
> four options:
> 
> 1) Existing userlevel RSTP daemon based on rstplib.  
> 2) New RSTP code (from EMC) as daemon
> 3) Update of old STP kernel code to RSTP, this was done on ancient 2.4
>    for embedded system
> 4) Port EMC RSTP code to kernel
>

> There doesn't appear to be lots of advantages to user space RSTP long term
> and the conversion process would be more painful.
I think that having user space STP can make easier to have different 
implementation of STP algorithms available:
- plain old 802.1D legacy slow STP
- 802.1D-2004 RSTP
- 802.1Q-2005 MSTP
- Cisco proprietary PVSTP
- Cisco proprietary PVRSTP

Or we just need "one protocol to rule them all"?

What I think that is really missing at the moment, apart from RSTP, is a 
vlan aware forwarding engine in the bridge code.

> EMC code is slightly uglier (sorry) but has advantage of being recently
> interop tested.
The original rstplib is outdated, it implement the old 802.1w standard. 
We have a working implementation updated to the latest standard (802.1D 
2004) of rstplib, if it can be usefull we can think about releasing it.

Francesco


