Date: Thu, 2 Dec 2004 11:19:06 -0800
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] bridge doesn't broadcast properly
Message-Id: <20041202111906.4e0e054c@dxpl.pdx.osdl.net>
In-Reply-To: <4d04422d04111612021740a8@mail.gmail.com>
References: <4d04422d04111612021740a8@mail.gmail.com>
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
To: Harald Sauff <2gr84u@gmail.com>
Cc: bridge@lists.osdl.org

On Tue, 16 Nov 2004 21:02:02 +0100
Harald Sauff <2gr84u@gmail.com> wrote:

> Hello list,
> 
> I'm setting up a virtual network consisting of several UMLs (User Mode
> Linux) connected with the virtual bridge.
> Communications works quite well between the host and the virtual machines.
> 
> Setup:
> 2 UMLs connected via tap-devices to the bridge (tap1,tap2).
> The host uses the bridge-device br0 to talk to the clients.
> 
> Now I want to tcpdump the traffic between host and UML1 on virtual machine UML2.
> 
> With the standard-settings UML2 only catches the initial
> ARP-broadcasts (but that's the intended behaviour of the
> bridge/switch). :-)
> 
> Now I set "brctl setageingtime br0 0", so that the bridge behaves like
> a hub (it forgets the MAC-addresses immediately) and broadcasts all
> packets on all connected ports. Checking this with "brctl showmacs
> br0" shows, that this is working, the MAC-table is always empty.
> 
> BUT: on UML2 (the listening machine) I see only the complete traffic
> coming from the host (via br0 into the bridge), but the answers from
> UML2 to the host (entering the bridge on tap2) are hidden (only
> broadcasts can be seen).
> 
> Why does the broadcasting of all packets only work from the bridge
> directly (br0) and not from the connected tap-devices?
> 
> Could this have to do with the fact, that with version 1.0.4 of the
> bridge-utils (Debian 3.1, testing) I can't control the GC-time of the
> bridge?
> 
> In the mailing-list archive I found a thread, where someone wanted the
> bridge to be configured as a hub, but the advice to remove some lines
> of code from the bridge-code didn't work for me, the bridge is
> unusable after removing the code.
> 
> Can someone give me a hint, how to get the desired behaviour? An
> option for switching between hub- and switch-behaviour would be
> nice... ;-)
> 
> 
> thanx in advance,
>  Harald Sauff

What version of kernel.  The utilities don't matter much, they only
setup the kernel.  You could talk to Werner Almesberger about similar
stuff in umlsim
