Date: Wed, 23 Apr 2008 23:59:15 +0100 (BST)
From: Malcolm Scott <Malcolm.Scott@cl.cam.ac.uk>
In-Reply-To: <1208985722.3713.2.camel@localhost.localdomain>
Message-ID: <alpine.DEB.1.10.0804232358250.20981@callisto.moose.malc.org.uk>
References: <1208985722.3713.2.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: Re: [Bridge] Set second IP on bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Koen Vermeer <koen@vermeer.tv>
Cc: bridge@lists.linux-foundation.org

At 23:22 today, Koen Vermeer wrote:

> Now, for virtualization, I want to set up a bridge on my one ethernet
> interface. I can do this just fine, and end up with (let's say) br0.
> Then, I can set an IP address to br0. But what I want to do is set two
> IP addresses. I have been unable to do so thus far. Trying to use br0:1
> didn't produce anything useful.

That should work.  What happens?

You can also try "ip address add (...) dev br0" to avoid the old-style 
subinterfaces.

-- 
Malcolm Scott
Research Assistant
University of Cambridge Computer Laboratory

