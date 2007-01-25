Date: Thu, 25 Jan 2007 10:46:04 -0800
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20070125104604.613432d4@freekitty>
In-Reply-To: <969A8B08-19EE-445B-AAFB-2A9D8D3D5CE7@mpsnet.net.mx>
References: <969A8B08-19EE-445B-AAFB-2A9D8D3D5CE7@mpsnet.net.mx>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] problem bridging
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Omar Armas <oarmas@mpsnet.net.mx>
Cc: bridge@osdl.org

On Wed, 24 Jan 2007 14:19:14 -0600
Omar Armas <oarmas@mpsnet.net.mx> wrote:

> Hi, I did a bridge with kernel 2.4.34 and two intel e1000 network cards.
> 
> I setup the bridge with:
> 
>      /usr/sbin/brctl addbr br0
>      /usr/sbin/brctl addif br0 eth0
>      /usr/sbin/brctl addif br0 eth1

>      /sbin/ifconfig eth0 0.0.0.0 promisc
>      /sbin/ifconfig eth1 0.0.0.0 promisc

These two are unnecessary the bridge does it itself.

>      /sbin/ifconfig br0 up
> 
> My configuration is:
> 
> router
> |
> Bridge
> |
> LAN
> 
> 
> but my problem is that it always passes all traffic, no matter if I  
> set FOWARD iptables chain to DROP:
> iptables -P FORWARD DROP

iptables FORWARD rules apply to routing not bridging

See:
	http://ebtables.sourceforge.net/br_fw_ia/br_fw_ia.html#section6


> When I do this the all traffic and protocols continue passing.
> Any idea why?
> 
> 


-- 
Stephen Hemminger <shemminger@linux-foundation.org>
