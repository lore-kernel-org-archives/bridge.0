Date: Wed, 28 Jul 2004 13:21:28 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] Assertion failed in bridge code on 2.4.27-rc3
Message-Id: <20040728132128.22bed751@dell_ss3.pdx.osdl.net>
In-Reply-To: <20040728195957.GA2621@man.manty.net>
References: <20040728195957.GA2621@man.manty.net>
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
To: bridge@lists.osdl.org

On Wed, 28 Jul 2004 21:59:57 +0200
Santiago Garcia Mantinan <bridge@manty.net> wrote:

> Hi!
> 
> I was testing 2.4.27-rc3 to see if the IDE fixes had fixed a problem I'm
> suffering with a 200MB old HD, and instead of finding that fixed, I found
> the kernel shouting this:
> RTNL: assertion failed at br_ioctl.c(244)
> 
> This message is shown aproximately since the bridge is bringed up and till
> it starts forwarding.
> 
> I don't know what other info to provide, this bridge interface right now has
> just one card added to it, the machine is a pentium 133.
> 
> If you feel that any other info or any testing may be needed don't hesitate
> to ask.
> 

What is the command sequence you use to bring up the bridge?
What version of the brctl command?
