Sender: fulvio@zeroshell.net
From: "Fulvio Ricciardi" <fulvio.ricciardi@zeroshell.net>
Date: Mon, 27 Nov 2006 20:12:03 +0100
Message-id: <456b3883.35b.3d57.69000436@webmailh3.aruba.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Subject: Re: [Bridge] Passing vlan tagged packets through linux bridge
Reply-To: fulvio.ricciardi@zeroshell.net
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Ben Greear <greearb@candelatech.com>, fulvio@zeroshell.net
Cc: kasra kangavari <kasra_kng@yahoo.com>, bridge@lists.osdl.org




> Fulvio Ricciardi wrote:
> > Hi,
> > I noticed the same problem with the kernel 2.6.16.21 but
> > I didn't try with newer kernel.
> >   
> 
> Use an Intel pro/100 or pro/1000 driver..they are known to
> work with VLANs.
> 
> I guess it's also possible that it's a problem in the
> bridging code, so  try the latest kernel
> as well...

I used Intel pro/100 in my test and I verified that the
interfaces work fine with vlan tagged and large packets, but
when I connect in bridge two interfaces and add a vlan to
br0 interface, this works only with small packets (< 1470
bytes).
I have not tried with latest kernel yet.

Regards
    Fulvio Ricciardi



> >   
> >> Hi
> >>  
> >>  I have some problem with passing vlan tagged packets
> >> through linux bridge.
> >>  In the linux box eth0 , eth1  are add to br0 and the
> >> bridge is up and working correctly. 
> >>  I 've connected eth0 to trunk port of switch A and
> eth1 >> to trunk port of switch B.
> >>  port 1,2,3 of each switch are in vlan 1. I've 2 client
> in >> the same subnet , client A connected to port 1 of
> switch A >> and client B connected to port 1 of switch .
> the problem >> is when I ping client A from clinet B or
> viceversa ,I >> can't ping with more than 1470bytes packet
> size! >>  ping will work fine by 1470byte packet size but
> ping with >> more than 1470bytes packet size will fail.
> >>  any idea??
> >>  
> >>  KasrA
> >>  
> >>  
> >> ---------------------------------
> >> Check out the all-new Yahoo! Mail beta - Fire up a more
> >> powerful email and get things done faster.
> >>
> >> _______________________________________________
> >> Bridge mailing list
> >> Bridge@lists.osdl.org
> >> https://lists.osdl.org/mailman/listinfo/bridge
> >>
> >>     
> > _______________________________________________
> > Bridge mailing list
> > Bridge@lists.osdl.org
> > https://lists.osdl.org/mailman/listinfo/bridge
> >   
> 
> 
> -- 
> Ben Greear <greearb@candelatech.com> 
> Candela Technologies Inc  http://www.candelatech.com
> 
> 
> _______________________________________________
> Bridge mailing list
> Bridge@lists.osdl.org
> https://lists.osdl.org/mailman/listinfo/bridge
