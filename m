Date: Mon, 26 Apr 2004 08:57:31 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] bridging ipv6
Message-Id: <20040426085731.433ffcab@dell_ss3.pdx.osdl.net>
In-Reply-To: <408C4DAF.5000206@netcabo.pt>
References: <408C4DAF.5000206@netcabo.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: filipe abrantes <filipe_abrantes@netcabo.pt>
Cc: bridge@lists.osdl.org

On Mon, 26 Apr 2004 00:45:51 +0100
filipe abrantes <filipe_abrantes@netcabo.pt> wrote:

> hello all:
> 
> im trying to set up a bridge for ipv6, but i cant manage to get it 
> working, does someone have experience with this?

Kernel version, and other info please.

> i used the common :
> 
> brctl addbr br0
> brctl addif br0 eth0
> brctl addif br0 eth2
> 
> then to set up the ip's i tried
> 
> ifconfig eth0 inet6 add ::/0

There is no point in using ipv6, here it is just enabling the
interfaces.
	ifconfig eth0 up
or	ifconfig eth0 0.0.0.0
does the same thing.

> ifconfig eth2 inet6 add ::/0
> ifconfig br0 inet6 add 2020::2/128
> 
> and also tried(the above didnt work for me):
> 
> removing all addresses from all bridged interfaces (even the link local 
> ones).
 
What is the state of eth0, eth2, and br0?
Does the bridge work for packets going through?
Can you ping anything?
What about doing a tcpdump on br0?


> Another question:
> 
> Is there any way i can set up a bridge and then block all level 2 
> forwarding between the bridged interfaces?

That is called bonding, use it instead of bridging.

> I know it seems odd, but the idea was to have only one interface to 
> handle the other two - its good for ipv6 multicasting,  that way you 
> dont need to bind sockets to all interfaces.
> 
> 
> thanks a lot
> 
