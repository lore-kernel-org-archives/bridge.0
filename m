Message-ID: <40EDAF26.5020504@maxent.cz>
Date: Thu, 08 Jul 2004 22:31:34 +0200
From: Karel Rericha <karel@maxent.cz>
MIME-Version: 1.0
Subject: Re: [Bridge] option for sending packets back to source interface
References: <40ECFBFE.9070609@maxent.cz>
	<20040708103108.243e4bbe@dell_ss3.pdx.osdl.net>
In-Reply-To: <20040708103108.243e4bbe@dell_ss3.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Stephen Hemminger <shemminger@osdl.org>, bridge@lists.osdl.org

Stephen Hemminger napsal(a):

>Why not implement a layered driver that behaves properly, and echos
>the data if needed.
>
>  
>
Well, I'm no expert and I don't understand what is layered driver. Does 
such driver send
packets to shaping queues before echoing them ? If so, how would one 
implement it ?

Hostap driver echoes packets by default, but they are not seen by 
shaping queues.
That is the problem. It would be very helpfull to shape interstation 
traffic on wireless
segments.

Thanks,
Karel

