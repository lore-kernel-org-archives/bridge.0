Date: Tue, 18 May 2004 15:36:08 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] bridging bluetooth bnep devices with kernel 2.6.6-*
Message-Id: <20040518153608.707e1f81@dell_ss3.pdx.osdl.net>
In-Reply-To: <1084788177.21864.54.camel@igno>
References: <1084467136.3083.27.camel@igno>
	<20040513102829.5d5e1484@dell_ss3.pdx.osdl.net>
	<1084472140.3354.9.camel@igno> <1084788177.21864.54.camel@igno>
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
To: Diego Liziero <liziero.diego@unimore.it>
Cc: bluez-devel@lists.sourceforge.net, bridge@lists.osdl.org

On Mon, 17 May 2004 12:02:58 +0200
Diego Liziero <liziero.diego@unimore.it> wrote:

> Thanks for your support.
> 
> I'm back with the "brige freezes when bluetooth bnep0 disconnects
> before bnep1" issue.
> 
> As reported in the bluez-devel mailing list, in a bridge
> called pan0 with the interfaces bnep0, bnep1, .. bnep6
> connected, if the interface bnep6 is disconnected first,
> everything works fine, but if bnep0 is disconnected before
> the others, the bridge stops to work.
>

Hmm, since all the blue tooth devices have the same address.
Deleting the first one will cause the entry in the forwarding table
to be deleted, that might cause your problem.  Perhaps we need a
reference count on the number of interfaces with the same address (yuck).
