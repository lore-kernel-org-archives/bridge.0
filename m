Subject: Re: [Bridge] bridging bluetooth bnep devices with kernel 2.6.6-*
From: Diego Liziero <liziero.diego@unimore.it>
In-Reply-To: <20040513111904.6001c62a@dell_ss3.pdx.osdl.net>
References: <1084467136.3083.27.camel@igno>
	<20040513102829.5d5e1484@dell_ss3.pdx.osdl.net>
	<1084472140.3354.9.camel@igno>
	<20040513111904.6001c62a@dell_ss3.pdx.osdl.net>
Content-Type: text/plain
Message-Id: <1084526845.6774.55.camel@igno>
Mime-Version: 1.0
Date: Fri, 14 May 2004 11:27:25 +0200
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

On Thu, 2004-05-13 at 20:19, Stephen Hemminger wrote:
> I do think each bluetooth device should have a different hardware
> address to keep themselves sane.

Things are not so easy.

Each bluetooth dongle has it's own harware address (MAC)
and in a piconet (one master and up to 7 slaves)
at each PAN connection a device called bnep0, ... bnep6
is created on the master PC by bluez with the same MAC of the dongle.

Each device bnep? for each maste-slave point to point connection.

And the bad thing is that when one of these connection is
closed, its relative device (bnep?) cease to exist.

And this create serious problems with things like
a dhcp server and a bridge.

Regards,
Diego

