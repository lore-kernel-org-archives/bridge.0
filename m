Subject: Re: [Bridge] maximum throughput for linux bridge
From: "Paul P. Pongco" <paulp@mozcom.com>
In-Reply-To: <402D1112.4040902@osdl.org>
References: <1076657825.735.72.camel@amidala.mozcom.com>
	<402D1112.4040902@osdl.org>
Content-Type: text/plain
Message-Id: <1076942173.741.88.camel@amidala.mozcom.com>
Mime-Version: 1.0
Date: Mon, 16 Feb 2004 22:36:14 +0800
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: linux-net@vger.kernel.org, bridge@osdl.org

Thanks for your reply.

> >
> It is not a bridge problem, just that bridging puts more stress on the 
> network driver.
Yep, i really suspected it was something with the 3com card. Found
something on the bridge FAQ regarding 3com cards (setting
interrupt_work=10000). If you have additional options such as indicated
on the bridge FAQ available that you know or links that discuss this
please let me know. 

> 
> The problem is that the 3c905 cards don't support interrupt mitigation, 
> so when lots
> of network traffic hits, they drop data.  The 3c59x driver allocates and 
> copies every
> received frame in the interrupt routine.  What is needed is a new driver 
> that does NAPI
> (any volunteers)? 
would you know of any network card that can work as a bridge and at the
same time has NAPI drivers?


-- 
Cheers,

Paul P. Pongco
Mosaic Communications Inc.



