Date: Fri, 4 Jun 2004 12:42:17 +0200
From: Santiago Garcia Mantinan <manty@manty.net>
Subject: Re: [Bridge] Wireless Bridge problems
Message-ID: <20040604104216.GA4401@man.manty.net>
References: <E5838291-B57C-11D8-800E-000A95BC99E4@us.army.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E5838291-B57C-11D8-800E-000A95BC99E4@us.army.mil>
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Derek Ditch <derek.ditch@us.army.mil>
Cc: bridge@osdl.org

> I need some suggestions.  Below is my debian interfaces file. Below 
> that is my iptables configuration script.

The ip you use on the machine should be set on the bridge, not in one of its
interfaces

> iface eth0 inet static
>         address 192.168.0.254

It seems you want to use this up, set it on the bridge interface then and
leave this one like it is.

On Debian we have a method for setting up bridges described in
/usr/share/doc/bridge-utils/README.Debian.gz that should make things easier
to setup a bridge, of course you can also use your own method like you do
;-)

If after having all interfaces on the bridge without IP (ip 0.0.0.0) and
setting the local IP on the br0 interface, you still have problems, I'd say
you have a look at your firewall, the logs may help you.

Regards...
-- 
Manty/BestiaTester -> http://manty.net
