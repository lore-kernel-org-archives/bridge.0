Date: Fri, 22 Apr 2005 13:09:11 +1000
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] bridge  stp problem
Message-ID: <20050422130911.1417ea1c@localhost.localdomain>
In-Reply-To: <42686072.7060509@smartbridges.com>
References: <200504211900.j3LJ07s5017482@smtp.osdl.org>
	<42686072.7060509@smartbridges.com>
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
To: munro <munro.biswal@smartbridges.com>
Cc: munro <munro.biswal@smartbridges.com>, bridge@lists.osdl.org

On Fri, 22 Apr 2005 10:24:50 +0800
munro <munro.biswal@smartbridges.com> wrote:

> Hi, ppl,
> 
> I am using kernel 2.4.25 and  having this peculiar problem on my 
> ixp425.  When i have 2 ethernet ports of the board connected to the same 
> linksys switch running STP.  ixp0  and ixp1 are the name of my ethernet 
> ports  enslaved to the same bridge( br0)and my PC is also connected to 
> the switch.
>                       
>  
>                IXP425 -br0 (192.168.2.1)
> 
>              |_ixp0|---  |        |          (192.168.2.11)
>              |_ixp1|---- |Linksys |----------<PC>  
> 
>  
> When i ping from my PC to the  board (when both ixp0 and ixp1 are 
> connected to the switch), everything works fine.
> In that case ixp1 is in blocking state and ixp0 is in  forwarding state.
> 
> The issue here is  when i unplug ixp0 from the switch (the one which is 
> forwading state),  ixp1 comes to forwardinmg state after the state 
> changes(listening-learning---forwading), but there is a huge delay of 
> around 15-17 mins till i can ping  the board(IXP425) from my PC. i went 
> through the bridging code and put debug messages to see that it comes to 
> forwarding state immediately.
> 

It may not help, but 2.6 kernel has support for detecting carrier transistions
and failing over faster.

> On the board if i sniff using ethereal, it shows that my ICMP request 
> never goes through till 17 mins..
> 
> AFter 17 mins, it starts pining ok.
> 
> Now thats very strange. WHo induces this delay of 17 mins after the 
> topology changes.
> Pls. advise !! very urgent .
> 

Is there a chance some other bridge changing and becoming root
