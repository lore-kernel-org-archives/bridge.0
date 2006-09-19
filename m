Date: Tue, 19 Sep 2006 10:24:49 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Message-ID: <20060919102449.2a9753fc@localhost.localdomain>
In-Reply-To: <20060919052539.60165.qmail@web8612.mail.in.yahoo.com>
References: <20060919052539.60165.qmail@web8612.mail.in.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] how do i bridge eth0 with eth1 by bridging?
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Labhesh Popli <labhesh_popli@yahoo.co.in>
Cc: bridge@lists.osdl.org

On Tue, 19 Sep 2006 06:25:39 +0100 (BST)
Labhesh Popli <labhesh_popli@yahoo.co.in> wrote:

> hi,
>    
>   i have my wireless LAN card connected in USB port of linux machine at eth1, 
>    
>   and another wireless LAN card connected to USB port of windows machine. 
>    
>   the LAN card of windows has been plugged out. now, i want to access the 
>    
>   internet sites on windows machine through the wireless LAN b/w the 2 
>    
>   machines.
>    
>   I have successfully made a bridge b/w eth0 and eth1 of my linux machine using 
>    
>   the "brctl" etc commands, 
>    
>   entered the ip adress of WLAN of linux machine in internet explorer/tools/internet options/connections/LAN settings/proxy server of windows machine.
> 

If you read the FAQ on http://linux-net.osdl.org/index.php/bridge
you will see that bridging to wireless is going to work because Linux bridging
doesn't support NDS.  The problem isn't just in the bridge code, it would require
more extensive work to the wireless drivers as well.
