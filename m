Date: Tue, 27 Apr 2004 11:35:52 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] unregister_netdevice: waiting for tap_0 to become
	free.	Usage count = 2
Message-Id: <20040427113552.5887c69e@dell_ss3.pdx.osdl.net>
In-Reply-To: <002b01c42c83$f27d6aa0$0201a8c0@hawk>
References: <010701c42ba3$288f2570$41317d9e@keziah>
	<200404271951.16326.bdschuym@pandora.be>
	<002b01c42c83$f27d6aa0$0201a8c0@hawk>
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
To: "Christopher S. Aker" <caker@theshore.net>
Cc: bridge@osdl.org

On Tue, 27 Apr 2004 13:17:46 -0500
"Christopher S. Aker" <caker@theshore.net> wrote:

> Hello,
> 
> I'm using tap devices connected to bridge, and I've been seeing these messages on
> my 2.6 hosts during a script which brings down the interface and then back up.
> 
> unregister_netdevice: waiting for tap_0 to become free. Usage count = 2
> 
> Does this look like a refcount leak, and if so, I'm assuming it's in the tuntap
> code and I'm barking up the wrong tree :)

Since the tuntap device has an api in user space. Probably means you still have
an application with the tun tap device open.  It can't complete unregister until
the application closes the file.
