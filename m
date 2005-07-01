Date: Fri, 1 Jul 2005 11:36:23 -0400
From: Hugh Crissman <hcrissman@secure-mind.net>
Subject: Re: [Bridge] bridge firewall
Message-ID: <20050701153623.GA7841@secure-mind.net>
References: <20050630121553.GA19988@secure-mind.net>
	<5.2.0.9.1.20050701083251.02ea5438@mailhost.csse.uwa.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5.2.0.9.1.20050701083251.02ea5438@mailhost.csse.uwa.edu.au>
Reply-To: hcrissman@secure-mind.net
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Ryan McConigley <ryan@csse.uwa.edu.au>
Cc: bridge@lists.osdl.org

Thanks Ryan,

That answers one of my major questions. I was not sure if I should have snort sniff on /dev/eth1 (a nic that is part of my bridge) or /dev/br0 
(the bridge interface I created). I would assume that snort capture is very similar to tcpdump and sniffing on /dev/br0 would work fine. I will 
give that a shot. Now I wonder if iptables can block traffic on the bridge? If so, would the recipes call the bridge interface or one of the 
specific interfaces that are active in the bridge ie. /dev/br0 or /dev/eth1?

Thanks,

Hugh

* Ryan McConigley <ryan@csse.uwa.edu.au> [2005-07-01 08:35:21]:

> At 08:15 AM 30/06/2005 -0400, you wrote:
> >I am in the process of building a bridge firewall to place as the gateway 
> >to my network. I have a couple
> >questions that I can't seem to find clear answers to. Can snort sniff on a 
> >bridged interface? Second, can
> >ebtables block by IP? I know IP is layer 3 and a Bridge is Layer 2 but 
> >some of the recipes I have seen for
> >ebtables have ips in them.
> 
>         I assume it can.  Just tell snort to use the bridge interface as 
> opposed to the actually enternet cards.  Thats how I do packet capture on 
> our bridge using tcpdump.  You'll probably get a better answer from the 
> list though.
> 
>         And I thought that ebtables was only layer2, but I know with 
> iptables you can specify mac addresses, so I wouldn't be surprised if 
> ebtables has the same style of functionality or plugins.
> 
>         Just my $0.02 worth.
> 
>         Cheers,
>                 Ryan.
> 
> --
>           Ryan McConigley - Systems Administrator                  _.-,
>      Computer Science   University of Western Australia        .--'  '-._
>        Tel: (+61 8) 6488 7082 - Fax: (+61 8) 6488 1089       _/`-  _      '.
> Ryan[@]csse.uwa.edu.au - http://www.csse.uwa.edu.au/~ryan  '----'._`.----. \
>                                                                      `     
>                                                                      \;
>  "You're just jealous because the voices are talking to me"                
>  ;_\
> 
> 
> 
