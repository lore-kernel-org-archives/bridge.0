Date: Wed, 20 Oct 2010 08:38:07 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20101020083807.449c9ae5@nehalam>
In-Reply-To: <AANLkTinBfvrkb6Oe832h8QFO8B7i4bzdYo9YzsimCrY+@mail.gmail.com>
References: <AANLkTinBfvrkb6Oe832h8QFO8B7i4bzdYo9YzsimCrY+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] VLAN traffic through an Ethernet Bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Erik Schweigert <ejschweigert@gmail.com>
Cc: bridge@lists.linux-foundation.org

On Tue, 19 Oct 2010 10:46:38 -0700
Erik Schweigert <ejschweigert@gmail.com> wrote:

> Hello all,
> 
> I have configured a transparent ethernet bridge containing two network
> interfaces: eth0, eth1 in br0.  IP forwarding is enabled i.e. cat
> /proc/sys/net/ipv4/ip_forward = 1.

This is irrelevant for bridging. 


> All traffic destined through my Linux machine has the 802.1Q tag
> (VLAN).  However, only ARP with the VLAN tags passes through the
> machine correctly (100% of the time) and broadcast and multicast
> appears to work.  It 'seems' IP layer and above is being dropped if it
> is unicast, or intermittently works ( +/- 1 of 10 ICMP passes
> through).
> 
> All non-VLAN'd traffic passes through my machine flawlessly.
> 
> arptables, ebtables, and IPtables are all flushed, so there is no
> possibility of any traffic being blocked.
> 
> Is there a caveat with ethernet bridging that does not permit VLAN'd traffic?
> 
> Any help or suggestions is greatly appreciated!
> 
> Thanks,
> 
> Erik

Missing bits:
1. Kernel version?
2. Did you configure vlans on eth0 and eth1? 
3. Is it an MTU issue? do small packets get through but
   not largere ones.
4. What is overall configuration of bridging and ethernets?
   Did you assign IP address to bridge or the ethernet devices.
