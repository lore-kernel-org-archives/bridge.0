Message-ID: <467ADCEA.4010503@fortresstech.com>
Date: Thu, 21 Jun 2007 16:17:46 -0400
From: Steve Lazaridis <slaz@fortresstech.com>
MIME-Version: 1.0
Subject: Re: [Bridge] Customize bridge code to set transmit interface
References: <200706211851.l5LIpEP8018352@smtp2.linux-foundation.org>
In-Reply-To: <200706211851.l5LIpEP8018352@smtp2.linux-foundation.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
Cc: bridge@lists.linux-foundation.org

Write a driver that hooks into the bridge code.
Drop incoming frames on ath0
Drop outgoing frames from ath1
Allow the rest.

Netfilter provides you the hook API to do this without having to hack
device.c or any other main kernel code.

Or just use ebtables and setup some rules to do that :)


Of course, you'll still receive packets on the radio, but you just won't
process them through the bridge stack.

If you want to do this type of filtering at the radio level you should
be hacking your atheros driver instead.


Regards,
Steve



Hasan Rashid wrote:
> I am trying to modify the bridge code so I can define what interfaces to
> transmit data through. I added a function in brctl CLI to accept the
> interface name as an argument.
> 
>  
> 
> For example:
> 
>  
> 
> brctl settransmit br0 ath0
> 
>  
> 
> Basically this is for an embedded device where I have two radios on the
> device. I want to send all the outgoing traffic through ath0 (radio 1)
> and use the other radio for receving ath1 (radio 2).
> 
>  
> 
> I am trying to load the net_bridge_port from the ifindex and set that as
> the port for the *skb->dev->br_port in br_device.c in function
> br_dev_xmit. No real success so far.
> 
>  
> 
> Any ideas on how this could be accomplished?
> 
>  
> 
> Thank you!
> 
>  
> 
> Regards,
> 
> *Hasan Rashid*
> 
> Software Developer
> 
>  
> 
> //Digital Path, Inc//////
> 
> 275 Airpark Blvd suite 500
> 
> Chico, CA 95973
> 
>  
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/bridge
