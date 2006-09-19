Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Tue, 19 Sep 2006 11:59:25 -0700
Message-ID: <C86180A8C204554D8A3323D8F6B0A29F01785735@dhost002-46.dex002.intermedia.net>
In-Reply-To: <20060919102449.2a9753fc@localhost.localdomain>
From: "Simon Barber" <simon@devicescape.com>
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] how do i bridge eth0 with eth1 by bridging?
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Stephen Hemminger <shemminger@osdl.org>, Labhesh Popli <labhesh_popli@yahoo.co.in>
Cc: bridge@lists.osdl.org

Devicescape has released under GPL a module that performs L2-NAT as
required for bridging to work between an 802.11 client and ethernet.

If someone would volunteer to do the work to incorporate this module
into the kernel we would be very happy for that to happen.

Simon
 

-----Original Message-----
From: bridge-bounces@lists.osdl.org
[mailto:bridge-bounces@lists.osdl.org] On Behalf Of Stephen Hemminger
Sent: Wednesday, September 20, 2006 3:25 AM
To: Labhesh Popli
Cc: bridge@lists.osdl.org
Subject: Re: [Bridge] how do i bridge eth0 with eth1 by bridging?

On Tue, 19 Sep 2006 06:25:39 +0100 (BST) Labhesh Popli
<labhesh_popli@yahoo.co.in> wrote:

> hi,
>    
>   i have my wireless LAN card connected in USB port of linux machine 
> at eth1,
>    
>   and another wireless LAN card connected to USB port of windows
machine. 
>    
>   the LAN card of windows has been plugged out. now, i want to access 
> the
>    
>   internet sites on windows machine through the wireless LAN b/w the 2
>    
>   machines.
>    
>   I have successfully made a bridge b/w eth0 and eth1 of my linux 
> machine using
>    
>   the "brctl" etc commands,
>    
>   entered the ip adress of WLAN of linux machine in internet
explorer/tools/internet options/connections/LAN settings/proxy server of
windows machine.
> 

If you read the FAQ on http://linux-net.osdl.org/index.php/bridge
you will see that bridging to wireless is going to work because Linux
bridging doesn't support NDS.  The problem isn't just in the bridge
code, it would require more extensive work to the wireless drivers as
well.
_______________________________________________
Bridge mailing list
Bridge@lists.osdl.org
https://lists.osdl.org/mailman/listinfo/bridge

