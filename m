Date: Wed, 18 Jun 2008 16:09:40 +0100 (BST)
From: Malcolm Scott <Malcolm.Scott@cl.cam.ac.uk>
In-Reply-To: <DCFB0C9FA9884224936EBAEC97D6FD0A@vpn.com>
Message-ID: <alpine.DEB.1.00.0806181605330.20500@callisto.moose.malc.org.uk>
References: <DBB171FED24842C6AB5F4ECCA91302D2@vpn.com>
	<20080618073354.371e7fbd@catlap>
	<DCFB0C9FA9884224936EBAEC97D6FD0A@vpn.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: Re: [Bridge] kernel doesn't support bridge with a ppp interface ?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "c.j" <c.james.cj@gmail.com>
Cc: bridge@lists.linux-foundation.org

At 21:02 today, c.j wrote:

>> You can setup a tunnel with OpenVPN. You'd get a tap device on
>> both sides which can be bridged with eth.
> Thanks. But maybe we don't want OpenVPN for VPN. Now I can't get why kernel
> do not support that. Have some disadvantages?

I'm not sure if this is even possible using standard protocols.  Bridging is 
for Ethernet; PPP is not Ethernet.  So this would require some sort of 
nonstandard Ethernet-over-PPP encapsulation protocol, and would only make 
sense if the PPP devices at both ends of the link talked this protocol.

This sounds like a job for something outside the kernel, e.g. OpenVPN as 
suggested or a simpler Ethernet-over-IP tunnelling app.

Malcolm

-- 
Malcolm Scott
Research Assistant
University of Cambridge Computer Laboratory

