Message-ID: <47D407EA.6030004@navigue.com>
Date: Sun, 09 Mar 2008 11:53:14 -0400
From: Jonathan Thibault <jonathan@navigue.com>
MIME-Version: 1.0
References: <47D19BC9.6060702@navigue.com>	
	<bdfc5d6e0803071208p4ba7a38fl9beee59a4ab874b0@mail.gmail.com>	
	<47D1B45F.7020409@navigue.com>	
	<bdfc5d6e0803071423ia2c794fn662a6e875ffafe09@mail.gmail.com>	
	<47D2BE18.7030405@navigue.com>
	<2e59e6970803082336p383350ebm39d4403470ffd162@mail.gmail.com>
In-Reply-To: <2e59e6970803082336p383350ebm39d4403470ffd162@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] bridge, vlan and *no* stp/bpdu
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.osdl.org

Sorry, that's was in another mistakenly off-list reply.

Kernel is 2.6.24, been seeing this problem since 2.6.16 when I started 
the setup.

richardvoigt@gmail.com wrote:
>
> You still didn't tell us any version numbers, and I've got a similar
> setup which "works for me".  The only real difference is that my box
> routes between two logical bridges, and the bridged interfaces are
> multiple vlans in the same trunk.  I can even protect individual vlans
> from each other with netfilter rules.
>
> What if you routed "out" as a new vlan on the same cable as "in"?
>
>   
That's an interesting idea which I haven't tried yet.  An interesting 
tidbit is that there is a handful of machines in the lot which are 
affected right away (as soon as I add a second vlan interface to the 
bridge).  It may just be that they just have a very short arp timeout.  
I tried to find a pattern in their MAC addresses or hardware but there 
isn't really one.  I first assumed there was a problem with those 
machines but given that the ARP reply never gets to the trunk cable 
going their way, I concluded otherwise.

Thanks a lot for the help.  The fact that you have a setup that works 
gives me some confidence that I'm not just trying to do something insane ;)

Jonathan
