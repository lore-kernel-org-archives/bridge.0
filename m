Date: Sun, 26 Dec 2010 10:31:27 -0800
From: Stephen Hemminger <shemminger@vyatta.com>
Message-ID: <20101226103127.05cbd1c5@nehalam>
In-Reply-To: <4D1779B6.9050305@wanadoo.nl>
References: <4D0E868E.4010309@wanadoo.nl> <20101220103754.7d18de50@s6510>
	<4D0FB6AC.2020901@wanadoo.nl> <4D1779B6.9050305@wanadoo.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Why should static MAC address match one of the port
 MAC addresses - bug?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Rolf Fokkens <rolf.fokkens@wanadoo.nl>
Cc: bridge@lists.linux-foundation.org

On Sun, 26 Dec 2010 18:21:58 +0100
Rolf Fokkens <rolf.fokkens@wanadoo.nl> wrote:

> In this particular situation it's not possible to do so as all 
> interfaces are tap interfaces, with random generated MAC addresses. 
> Changing the tap interface's MAC address results in this:
> 
>     [root@home01 ~]# ifconfig tap0 hw ether BA:B7:73:58:E6:E2
>     SIOCSIFHWADDR: Device or resource busy
>     [root@home01 ~]#
> 
> So that doen't work. I found a trick however: I added a dummy ethernet 
> interface to the bridge, of which i can specify the MAC address, It 
> works fine, but in syslog there's the following message:
> 
>     Dec 26 17:45:21 home01 kernel: [   29.316480] br0: new device dummy0
>     does not support netpoll (disabling)
> 
> This means that the bridge won't use/support netpoll at all, which may 
> mean there's an impact on performance. I'm not sure. I can imagine that 
> a netpoll interface for a dummy interface shouldn't be hard to implement.
> 

The message means you can't use kdump/netconsole/kgdb over
that bridge device.
