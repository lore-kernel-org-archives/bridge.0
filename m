Subject: Re: [Bridge] bridging bluetooth bnep devices with kernel 2.6.6-*
From: Diego Liziero <liziero.diego@unimore.it>
In-Reply-To: <1084472140.3354.9.camel@igno>
References: <1084467136.3083.27.camel@igno>
	<20040513102829.5d5e1484@dell_ss3.pdx.osdl.net>
	<1084472140.3354.9.camel@igno>
Content-Type: text/plain
Message-Id: <1084788177.21864.54.camel@igno>
Mime-Version: 1.0
Date: Mon, 17 May 2004 12:02:58 +0200
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
Cc: bluez-devel@lists.sourceforge.net, bridge@lists.osdl.org

Thanks for your support.

I'm back with the "brige freezes when bluetooth bnep0 disconnects
before bnep1" issue.

As reported in the bluez-devel mailing list, in a bridge
called pan0 with the interfaces bnep0, bnep1, .. bnep6
connected, if the interface bnep6 is disconnected first,
everything works fine, but if bnep0 is disconnected before
the others, the bridge stops to work.

Arping from bnep1 to the brige results in just the first
answer received.

To make it work again I have to use the following dirty hack:
 brctl delif pan0 bnep1
 brctl addif pan0 bnep1

Someone in the bluez-devel mailing list told that also setting the
bridge in promiscuous mode with tcpdump makes the bridge
back to work.

Now I'm removing and re-adding all the bridge components
when hotplug detects that a "bnep?" device ceases to exist.

Any better solution?

Regards,
Diego

On Thu, 2004-05-13 at 20:15, Diego Liziero wrote:
> Sorry, I've been too quick in writing without realizing
> that the patch had been already posted to this mailing list.
> 
> This patch solved everything.
> 
> Thank you.
> 
> BTW, there is another issue that may be related to the bridge
> that is being discussed on bluez-devel mailing list:
> 
> http://thread.gmane.org/gmane.linux.bluez.devel/2160
> 
> Regards,
> 
> Diego
> 
> On Thu, 2004-05-13 at 19:28, Stephen Hemminger wrote:
> > 2.6.6 got too picky about multiple interfaces with the same
> > address. This patch has been already integrated for later releases.
> 

