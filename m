From: Koen Vermeer <koen@vermeer.tv>
In-Reply-To: <alpine.DEB.1.10.0804232358250.20981@callisto.moose.malc.org.uk>
References: <1208985722.3713.2.camel@localhost.localdomain>
	<alpine.DEB.1.10.0804232358250.20981@callisto.moose.malc.org.uk>
Content-Type: text/plain
Date: Thu, 24 Apr 2008 10:49:55 +0000
Message-Id: <1209034195.3829.13.camel@koenws.oogziekenhuis.lan>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Set second IP on bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Malcolm Scott <Malcolm.Scott@cl.cam.ac.uk>
Cc: bridge@lists.linux-foundation.org

On Wed, 2008-04-23 at 23:59 +0100, Malcolm Scott wrote: 
> > Now, for virtualization, I want to set up a bridge on my one ethernet
> > interface. I can do this just fine, and end up with (let's say) br0.
> > Then, I can set an IP address to br0. But what I want to do is set two
> > IP addresses. I have been unable to do so thus far. Trying to use br0:1
> > didn't produce anything useful.
> That should work.  What happens?
> You can also try "ip address add (...) dev br0" to avoid the old-style 
> subinterfaces.

Thanks for the quick reply! I tried again today, and it suddenly works
just fine. I may have messed up my network settings earlier, and the
reboot might have fixed that. It now works with both 'ifconfig
br0:1 ...' and 'ip addr add ... dev br0'.

I'm still strugling to get this incorporated in my
Debian /etc/network/interfaces file, but I guess that's off-topic here.
In case it isn't, or if you know the right place to ask about that,
please let me know.

Thanks for the help!

Best,
Koen Vermeer

