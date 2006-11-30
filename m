Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Wed, 29 Nov 2006 21:43:50 -0500
Message-ID: <587BB495FD172F43931DE54C0AFD218616FA03@reset6.ad2.felines.org>
in-reply-to: <20061129183652.4cebb4cc@localhost.localdomain>
From: "Jay Libove" <libove@felines.org>
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] recent crashes? Linux kernel 2.6.18-1.2239.fc5 (Linux
	Fedora Core 5)
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: bridge@lists.osdl.org

No VLANs here.

I'm using the integrated ip_tables for netfilter here. (Is there any
further detail I can provide about that?)

The network hardware is a single PCI card with four tulip chips on it
(21140), some of the four interfaces on this card get their own IRQs,
others share. (Actually, it's likely that all of the four are sharing,
either with each other or with some other device in the system).

Nothing has changed lately on the hardware.

The Fedora project released kernel 2239 recently.  I just rolled back to
the 2200 kernel to see if that would eliminate the problem.  The system
had crashed repeatedly in the hour before I rolled back the kernel.  In
the 80 minutes since I rolled back the kernel, it has not yet crashed
again. Not definitive, but very interesting.

What more information can I provide?

Thanks very much!
-Jay

-----Original Message-----
From: Stephen Hemminger [mailto:shemminger@osdl.org] 
Sent: Wednesday, November 29, 2006 9:37 PM
To: Stephen Hemminger
Cc: Jay Libove; bridge@lists.osdl.org
Subject: Re: [Bridge] recent crashes? Linux kernel 2.6.18-1.2239.fc5
(Linux Fedora Core 5)

On Wed, 29 Nov 2006 17:14:20 -0800
Stephen Hemminger <shemminger@osdl.org> wrote:

> On Wed, 29 Nov 2006 19:29:17 -0500
> "Jay Libove" <libove@felines.org> wrote:
> 
> > Recently, possibly since the most recent one or two kernel upgrades
in
> > Linux Fedora Core 5, my system has been crashing with a kernel
panic.
> > The panic prevents anything useful from being written to any log
files,
> > but on the crash trace left on the screen each time I always see
> > something which looks like it is in the bridge code.
> > 
> 
> If it is a server, please capture the console log during the panic
output,
> then developers can analyze it.
> 
> Ways of doing that are (in order of usefulness):
> 
> 1. Serial console - most reliable
> 2. Camera picture with digital camera.  Problem is screen resolution
limits
>    the amount of info. Also not easy to get a good picture
> 3. Netconsole. Problem is that for networking bugs, the panic output
>    may never make it out.
> 

It's dying not in the bridge itself but in the netfilter hooks.
What netfilter's are you running, and are you doing VLAN's?
What hardware is being used?


