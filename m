Date: Thu, 8 Jul 2004 13:48:12 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] option for sending packets back to source interface
Message-Id: <20040708134812.118763d9@dell_ss3.pdx.osdl.net>
In-Reply-To: <40EDAF26.5020504@maxent.cz>
References: <40ECFBFE.9070609@maxent.cz>
	<20040708103108.243e4bbe@dell_ss3.pdx.osdl.net>
	<40EDAF26.5020504@maxent.cz>
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

On Thu, 08 Jul 2004 22:31:34 +0200
Karel Rericha <karel@maxent.cz> wrote:

> Stephen Hemminger napsal(a):
> 
> >Why not implement a layered driver that behaves properly, and echos
> >the data if needed.
> >
> >  
> >
> Well, I'm no expert and I don't understand what is layered driver. Does 
> such driver send
> packets to shaping queues before echoing them ? If so, how would one 
> implement it ?
> 
> Hostap driver echoes packets by default, but they are not seen by 
> shaping queues.

Well then figure out how to fix that part.

> That is the problem. It would be very helpfull to shape interstation 
> traffic on wireless
> segments.

It just needs to put data back in the transmit queue, rather than
looping it back in the driver.
