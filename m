Date: Thu, 8 Jul 2004 10:31:08 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] option for sending packets back to source interface
Message-Id: <20040708103108.243e4bbe@dell_ss3.pdx.osdl.net>
In-Reply-To: <40ECFBFE.9070609@maxent.cz>
References: <40ECFBFE.9070609@maxent.cz>
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
To: Karel Rericha <karel@maxent.cz>
Cc: bridge@lists.osdl.org

Why not implement a layered driver that behaves properly, and echos
the data if needed.

On Thu, 08 Jul 2004 09:47:10 +0200
Karel Rericha <karel@maxent.cz> wrote:

> Hi,
> 
> I have bridged two interfaces, eth0 and wlan0, on Mandrake 10.0 
> Community with 2.6.3 kernel.
> Wireless interface wlan0 is from hostap driver 
> <http://hostap.epitest.fi/>. I'm experiencing huge packet loss for wireless
> stations on wlan0 when two stations are downloading bigger amount of 
> data between each other.
> Sometimes distant stations get disconected in such case. Pings from 
> stations to AP goes as high as
> 3000ms. I assume that such behaviour is because wireless traffic is 
> flooded up and too much packets
> get lost due to hidden node problem. I would like to solve this problem 
> by shaping such between-station
> traffic by the same rules as I shape internet connection from eth1 
> interface. Hostap driver has fine
> option "iwpriv wlan0 bridge_packets 0", which disables internal packets 
> bridging and sends such
> packets to higher levels to let iptables and/or ebtables see them. So 
> far case is going good, but alas
> in bridge code, file br_forward.c, is function "static inline int 
> should_deliver", which effectively block
> sending packets back to bridged interface they are originated from.
> 
> I'm asking for implementing per interface option in bridge code, which 
> would allow sending such packets
> back and not discard them by default. It would be option of great 
> importance for such cases I described.

But this is death if there are any other bridges or similar access points
on the network.  It would cause complete echo collapse.  It seems to be only
a problem for non-uniform network topologies.  Shouldn't the hostap
driver be doing this not the bridge.


> Thanks,
> 
> Karel Rericha
> 
> P.S.: I'm attaching few mails I originaly sent to ebtables-devel, 
> because I thought it would be ebtables
> matter.
> 
> *****************************************************
> Hi,
> 
> I have tracked my problem with disabling traffic between wireless 
> stations in hostap to allow
> shaping this traffic with htb to
> 
> /br_forward.c/
> 
> probably to function
> 
> 
> /static inline int should_deliver(struct net_bridge_port *p, struct 
> sk_buff *skb)
> {
>    if (skb->dev == p->dev ||
>        p->state != BR_STATE_FORWARDING)
>            return 0;
> 
>    return 1;
> }
> /
> If I get it right, bridge code doesn't send packets back to same 
> physical interface, which is ok
> for most of cases but alas not for wireless, where is essential to shape 
> traffic between stations,
> otherwise two heavily communicating stations (full speed download from 
> one to other) can bring
> stronger signal stations to pings about 200ms to AP, and moreover weaker 
> signal stations are
> losing packets at level reaching 80% (all measured for my case, but I 
> assume others have same
> symptoms too).
> 
> Hostap <http://hostap.epitest.fi/> has nice feature for disabling 
> traffic between stations to let higher layers handle it, allowing
> to use traffic shaping:
> 
> bridge_packets 0
> 
> But I have bridged wlan0 and eth0 on Mandrake 10.0 Community with kernel 
> 2.6.3 and as I said,
> bridge doesn't send traffic back to same physical interface.
> 
> Joe Parks on hostap mailing list sent me a patch for br_forward.c (which 
> I'm attaching), but I would
> prefer more elegant way of doing things.
> 
> Yesterday I found on ebtables to-do list a notice about --resend-on-iif 
> option, and I almost shouted
> "That's it!". So I'm asking, how is it with --resend-on-iif status, will 
> it be implemented in near future,
> or is there any other way for forcing bridge to send appropriate packets 
> back to same physical interface
> they are originated from ?
> 
> Thanks alot,
> 
> Karel Rericha
> 
> ------------------------------------------------------------------------
> 
> --- linux/net/bridge/br_forward.c.lennert	2003-01-07 16:36:18.000000000 -0500
> +++ linux/net/bridge/br_forward.c	2003-01-07 16:36:18.000000000 -0500
> @@ -20,11 +20,42 @@
>  #include <linux/if_bridge.h>
>  #include <linux/netfilter_bridge.h>
>  #include "br_private.h"
> +#include <string.h>
> +
> +
> +inline int isWlan(char *ifname) {
> +  char *c = ifname + 4;
> +  if (ifname == NULL) return 0;
> +  if (strncmp(ifname, "wlan", 4)) return 0;
> +  while (*c) {
> +    if ((*c < '0') || (*c > '9')) return 0;
> +    ++c;
> +  }
> +  return 1;
> +}
> +

Name of device on linux has no meaning.  If you want to do something special
then you need to do some kind of handshake when device is added. See recent
ethtool stuff in latest 2.6 bridge.


>  
>  static inline int should_deliver(struct net_bridge_port *p, struct sk_buff *skb)
>  {
> -	if (skb->dev == p->dev ||
> -	    p->state != BR_STATE_FORWARDING)
> +
> +/*
> + *     Marty Lamb 01/06/2003
> + *     modified forwarding decision to be based upon the combination of the
> + *     data's incoming physical device and bridge port number rather than the
> + *     physical device alone. 
> + *
> + *     Joe Parks 01/07/2003
> + *     Add an exception for devices named wlanX as these need special help
> + *     bridging to associated STAs.
> + */
> + 
> +        if ( ( (skb->dev == p->dev)
> +	        && ( (skb->dev->br_port == NULL)
> +		     || (skb->dev->br_port->port_no == p->port_no)
> +		   ) 
> +		&& (!isWlan(skb->dev->name))
> +              )
> +	      || (p->state != BR_STATE_FORWARDING))
>  		return 0;
>  	return 1;
> 

If you have to do this it should be a flag in the port structure, not
matched each time *yuck*



> ************************************************************
> 
> If I get it right, bridge code doesn't send packets back to same physical
> > interface, which is ok for most of cases but alas not for wireless,
> 
> 
> I am also interested in this issue for the madwifi driver.  Currently, the
> driver does packet rebroadcasting between STAs within the driver, bypassing
> the kernel bridging code (eg. bridge_packets 1 always).  It would be nice to
> have some way for the bridge code and the wireless driver code to coordinate
> who is supposed to resend the packets and such.  If Bart is willing to
> implement and publish the recommended method for doing this coordination, I
> can create a patch for the madwifi driver and submit it.
> 
> 
> >> +inline int isWlan(char *ifname) {
> >> +  char *c = ifname + 4;
> >> +  if (ifname == NULL) return 0;
> >> +  if (strncmp(ifname, "wlan", 4)) return 0;
> >> +  while (*c) {
> >> +    if ((*c < '0') || (*c > '9')) return 0;
> >> +    ++c;
> >> +  }
> >> +  return 1;
> >> +}
> >  
> >
> 
> It seems to me that detecting interfaces by name is a Very Bad Idea.  There
> should be (if there is not already) a way to detect wireless devices without
> relying on the device name.  The wireless extension code manages.
> 
> *****************************************************************
> Tom Marshall wrote:
> 
> >
> > It seems to me that detecting interfaces by name is a Very Bad Idea.  
> > There
> > should be (if there is not already) a way to detect wireless devices 
> > without
> > relying on the device name.  The wireless extension code manages.
> >
> >  
> >
> Agreed, that's why it is against my mind to use it. I expect that the 
> whole "--resend-on-iif" idea is not
> about bounding this functionality to wireless only interfaces, but to 
> allow let user decide which interface
> needs retransmit packets back (interfaces for physical devices where 
> individual stations are not allowed
> to transmit packets directly on physical layer are good example).
> 
> Hoping the patch will be easy and Bart or others will find a time to 
> make it soon.
> 
> Karel
> ******************************************************************
> 
> On Friday 04 June 2004 16:32, Karel Rericha wrote:
> 
> >> Tom Marshall wrote:
> >  
> >
> >>> > It seems to me that detecting interfaces by name is a Very Bad Idea.
> >>> > There
> >>> > should be (if there is not already) a way to detect wireless devices
> >>> > without
> >>> > relying on the device name.  The wireless extension code manages.
> >>    
> >>
> >>
> >> Agreed, that's why it is against my mind to use it. I expect that the
> >> whole "--resend-on-iif" idea is not
> >> about bounding this functionality to wireless only interfaces, but to
> >> allow let user decide which interface
> >> needs retransmit packets back (interfaces for physical devices where
> >> individual stations are not allowed
> >> to transmit packets directly on physical layer are good example).
> >>
> >> Hoping the patch will be easy and Bart or others will find a time to
> >> make it soon.
> >  
> >
> 
> Is there any reason to make the decision to retransmit on the same interface 
> on a per-packed basis? I mean, wouldn't it be better to just make it a bridge 
> option per bridge port?
> Implementing something like this with ebtables will be hairy because the 
> packets that need to be retransmitted need to be marked somehow, which would 
> mean some fooling around with the skbuff members (the nf_bridge member isn't 
> necessarily available).
> 
> cheers,
> Bart
> *************************************************************************
> Bart De Schuymer wrote:
> 
> 
> 
> 
> > Is there any reason to make the decision to retransmit on the same 
> > interface on a per-packed basis? I mean, wouldn't it be better to just 
> > make it a bridge option per bridge port?
> >  
> >
> Yes, I meant it. Maybe I wasn't clear. There is probably no need to do 
> per packet decisions on that.
> 
> > Implementing something like this with ebtables will be hairy because 
> > the packets that need to be retransmitted need to be marked somehow, 
> > which would mean some fooling around with the skbuff members (the 
> > nf_bridge member isn't necessarily available).
> >
> > cheers,
> > Bart
> >
> >  
> >
> Well, I'm now confused if it is you Bart, i.e. ebtables developer, or 
> someone other, to be asked to implement it.
> I'm no developer myself, and I can't understand c sources clearly. But 
> from the point that I saw mentioned code
> in br_forward.c I thought it is up to ebtables and bridge-nf developers 
> to implement it.
> 
> I'm under impression that it shouldn't be hard to code, just if option 
> is specified for some bridged interface, do
> send incomming packets with destination mac on same interface back to it.
> 
> I'm repeating that this option will be very helpfull for wireless 
> networks. Especially for software ap solutions like
> hostap, madwifi, prism54 and others.
> 
> Thanks for your time,
> Karel
> **************************************************************
> Bart De Schuymer wrote:
> 
> > On Friday 04 June 2004 20:16, Stephen Hemminger wrote:
> >  
> >
> >> Rather than hacking the bridge code and risking routing loops and other
> >> nasty's, why not change the wireless driver to have a "reflect all 
> >> packets"
> >> flag?
> >>   
> >
> >
> >
> > Some devices which appear as one single interface to Linux are really 
> > some kind of (wireless?) bridge with many ports. If I understood 
> > correctly, more control over what this hardware forwards is wanted. 
> > The hardware can be made to give the packets to Linux instead of 
> > bridging them, but after Linux has played with the packets, they 
> > should go back to that hardware. A way to do this is make a bridge 
> > port out of this interface and force the bridge code to deliver the 
> > packets back to the input bridge port.
> > AFAIK the requested functionality (being able to filter, tc, etc. the 
> > packets) can't be implemented by only altering the driver code.
> >
> > cheers,
> > Bart
> >
> >  
> >
> That's it ! You have to get packets out of driver, even when they are 
> destined for stations on same medium,
> then "play with them" (which is shape traffic in my case), and allow 
> bridge code to send these packets back
> to same interface they were originated from. Well actually playing with 
> them in the case of shaping occures
> after sending them back, but that's not important for understanding of 
> the meaning.
> 
> So if I'm right, drivers for such devices (read wireless soft aps, but 
> it can be anything else), needs some
> mechanism to change forwarding internal in-between stations packets, 
> which are normally not visible for
> Linux network code, out of driver to Linux network code. Hostap driver 
> already has such mechanism,
> see "bridge_packets 0" option.
> 
> Next, bridge-nf needs option to allow forwarding these packets back.
> 
> Cheers, Karel.
> 
> **************************************************************************
> Hi,
> 
> I have recently found that "-resend-on-iif" option disappeared from TODO 
> list on
> http://ebtables.sourceforge.net/documentation.html#todo
> Some time ago I was asking if there is any developement on this issue, 
> especially
> considering great importance of resending "own" packets back for some kinds
> of wireless drivers, like hostap, to allow shaping of traffic which is 
> normally bridged
> inside driver and not visible to shaping queues.
> 
> Hostap driver has option to disable "in-driver bridge", but current 
> bridge-nf code
> block sending back such packets. It would be great to have per interface 
> option
> such -resend-on-iif which would allow to send back "own" packets, which are
> in other cases properly discarded.
> 
> So I'm asking: What does the dissappearing of -resend-on-iif from TODO list
> mean ? Is it already implemented (I think not cuz I was not able to find 
> any
> evidences of it in CVS) or is it discarded for time being ?
> 
> Thanks, Karel
> 
> P.S.: "own" packets of course means packets with destination MAC on the 
> same
> interface they were originated from, so normally they are considered 
> delivered
> directly by physical layer and discarded by bridge. But, I repeat, this 
> is highly impractical
> for wireless networks in infrastructure mode, where all traffic goes 
> through one master
> node and could be easily shaped there, which would be VERY helpfull 
> considering
> packet drops and connection losts occuring on wireless networks flooded 
> with heavy
> between stations downloads.
> Thats why I'm pressing for this feature. If anybody sees something wrong 
> on it, please
> explain why ?
> *************************************************************************
> 
> On Thursday 01 July 2004 15:49, Karel Rericha wrote:
> 
> >> I have recently found that "-resend-on-iif" option disappeared from TODO
> >> list on
> >> http://ebtables.sourceforge.net/documentation.html#todo
> >  
> >
> 
> >> So I'm asking: What does the dissappearing of -resend-on-iif from TODO list
> >> mean ? Is it already implemented (I think not cuz I was not able to find
> >> any evidences of it in CVS) or is it discarded for time being ?
> >  
> >
> 
> In the previous discussion on the ebtables-devel mailing list it was decided 
> that there is no need to make the decision per packet, which means this 
> functionality belongs in the bridging code and not in ebtables.
> 
> cheers,
> Bart
> *************************************************************************
> *************************************************************************
> 
> Sorry for maybe too much reading for so simple option :)
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
