Date: Thu, 2 Dec 2004 09:40:34 -0800
From: Stephen Hemminger <shemminger@osdl.org>
Message-Id: <20041202094034.0db0db39@dxpl.pdx.osdl.net>
In-Reply-To: <20041202131333.GC19565@ncrfgs3.ncrfgs>
References: <20041202131333.GC19565@ncrfgs3.ncrfgs>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Re: brctl, Ethernet Bridging, openvpn,
	Universal TUN/TAP devices
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: ncrfgs <ncrfgs@tin.it>, bridge@osdl.org

On Thu, 2 Dec 2004 14:13:33 +0100
ncrfgs <ncrfgs@tin.it> wrote:

> Hi,
> 
> I'm using the great 802.1d Ethernet Bridging support via 
> brctl along with Universal TUN/TAP devices created with 
> openvpn on a GNU system with a vanilla 2.6.8.1 Linux 
> kernel.
> 
> 
> To start it:
> 
>       /usr/sbin/brctl addbr br${X}
>       /sbin/ifconfig brX xxx.xxx.xxx.xxx netmask yyy.yyy.yyy.yyy
>       /sbin/route add default gw zzz.zzz.zzz.zzz
> 
>       /usr/sbin/brctl addif br${X} eth${Y}
>       /sbin/ifconfig eth${Y} 0.0.0.0 promisc up
> 
>   [1] /usr/sbin/openvpn --mktun --dev tap${Z}
>       /usr/sbin/brctl addif br${X} tap${Z}
>       /sbin/ifconfig tap${Z} 0.0.0.0 promisc up
>   [2] /usr/sbin/openvpn --config config.${Z}
> 
> 
> To stop it:
> 
>   [3] kill `cat /var/run/openvpn.${Z}.pid`
>       /sbin/ifconfig tap${Z} down
>       /usr/sbin/brctl delif br${X} tap${Z}
>       /usr/sbin/openvpn --rmtun --dev tap${Z}
> 
>       /usr/sbin/brctl delif br${X} eth${Y}
>       /sbin/ifconfig eth${Y} down
> 
>       /sbin/ifconfig br${X} down
>       /usr/sbin/brctl delbr br${X}
> 
> 
> As far as I understood, if I create a tap device [1] 
> before I start the openvpn instance that will use it [2], 
> after I kill that instance [3], the tap device is still up 
> and everything seems to go fine.
> 
> In general, if I don't create the tap device explicitely 
> [1] and I let the openvpn instance that will use it to 
> create it implicitely [2], if I understood it well, the 
> device will die along with the openvpn instance that 
> created it [3].
> 
> If this happen, and if the device was attached to a bridge 
> device, once I kill the openvpn instance that implicitely 
> created the tap device [3], the kernel seems to hang and 
> the only thing I get is the following message on the 
> current terminal.
> 
>   Debug: sleeping function called from invalid context at include/asm/semaphore.h:119
> 
> 
> Is it a bug?

Yes, but it could be in either the bridge or the tun/tap device.
What was teh backtrace.
