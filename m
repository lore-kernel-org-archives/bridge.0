Message-ID: <402D1112.4040902@osdl.org>
Date: Fri, 13 Feb 2004 10:01:54 -0800
From: Stephen Hemminger <shemminger@osdl.org>
MIME-Version: 1.0
Subject: Re: [Bridge] maximum throughput for linux bridge
References: <1076657825.735.72.camel@amidala.mozcom.com>
In-Reply-To: <1076657825.735.72.camel@amidala.mozcom.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: "Paul P. Pongco" <paulp@mozcom.com>
Cc: linux-net@vger.kernel.org, bridge@osdl.org

Paul P. Pongco wrote:

>Hi,
>
>Apologies if I am not suscribed to this list.
>
>I have setup a linux bridge using 3c905C-TX/TX-M [Tornado] cards. Im
>running it on RH 7.3 2.4.19 kernel.
>Lately, I have seen the following errors on the bridge
>
>Feb 10 07:40:24 safe kernel: eth2: Too much work in interrupt, status e401.
>Feb 10 07:40:52 safe last message repeated 3 times
>Feb 10 08:12:16 safe kernel: br0: received tcn bpdu on port 1(eth2)
>Feb 10 08:12:16 safe kernel: br0: topology change detected, sending tcn bpdu
>Feb 10 08:13:09 safe kernel: br0: received tcn bpdu on port 1(eth2)
>Feb 10 08:13:09 safe kernel: br0: topology change detected, sending tcn bpdu
>
>Im currently pushing around 45Mbs/20Mbs (down/up)  of traffic on the
>bridge (doing some bandwidth management) and Im concerned about its
>performance and how it would scale.
>Thanks in advance for your advice. 
>  
>
It is not a bridge problem, just that bridging puts more stress on the 
network driver.

The problem is that the 3c905 cards don't support interrupt mitigation, 
so when lots
of network traffic hits, they drop data.  The 3c59x driver allocates and 
copies every
received frame in the interrupt routine.  What is needed is a new driver 
that does NAPI
(any volunteers)? 

Or you could get different hardware that doesn't copy every packet 
within the interrupt
routine.  Either a card that can receive direct into the socket buffer, 
or has a driver that
supports NAPI to do it in the IRQ.

I have added the linux-net list to see if anyone else has ideas.

