Date: Thu, 15 Apr 2010 10:43:17 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20100415104317.78ebbf26@nehalam>
In-Reply-To: <17e68c8.17046.127fba86139.Coremail.mariazty@163.com>
References: <17e68c8.17046.127fba86139.Coremail.mariazty@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] problems using bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: =?UTF-8?B?5byg5aSp5Zut?= <mariazty@163.com>
Cc: bridge@linux-foundation.org

On Wed, 14 Apr 2010 17:31:08 +0800 (CST)
=E5=BC=A0=E5=A4=A9=E5=9B=AD <mariazty@163.com> wrote:

> Hi,
>         I use the bridge these days but I come up with some problems when=
 I use it.
>         I add two wifi interfaces to the bridge I call it "br0" . What I =
do is as follows :
>  #brctl addbr br0
> #brctl addif br0 eth0
> #brctl addif br0 eth1
> #ifconfig eth0 0.0.0.0
> #ifconfig eth1 0.0.0.0
> #ifconfig br0 up
> #dhclient br0
>        The AP gives br0 the address 172.31.24.68 and the gateway is 172.3=
1.24.1 (this detailed address maybe not important though)

You need to set forwarding delay to 0 or wait 30 seconds before starting dh=
client
When bridge is brought up it waits 30 seconds before forwarding frames (par=
t of
the STP standard).  If you aren't using STP then best answer is turn forwar=
ding
delay off.

>       I use the command ifconfig and find that the br0's mac is the same =
as eth1's . When both the two wifi interfaces are up ,there's no problem wh=
en PING the gateway .
Bridge inherits the MAC address of the underlying interfaces.
With multiple interfaces, the MAC address of br0 will be min(interface MAC)=
; unless
it is explicitly set.

> But when I ifconfig eth1 down , PING the gateway again ,it shows destinat=
ion host unreachable . But when I ifconfig eth0 down , it doesn't affect PI=
NG the gateway . I think this may because br0 is bound to eth1 , the traffi=
c pass through eth1 .=20
>       Now here comes the problem . I want br0 bound to eth0 ,what should =
I do ?
>      I'm looking forward to your answer and I'm eager to know it. Thank y=
ou very much .

If you are trying to bridge wifi interfaces in station mode, it won't work.
Interfaces need to be either hardwared Ethernet or wifi AP mode.

