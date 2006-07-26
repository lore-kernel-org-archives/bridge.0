Date: Wed, 26 Jul 2006 10:13:35 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Message-ID: <20060726101335.67406ee8@localhost>
In-Reply-To: <44C7979B.7040906@seskion.de>
References: <44C77FD2.2030208@seskion.de>
	<20060726083455.08989fc6@localhost.localdomain>
	<44C7979B.7040906@seskion.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Is bridgeing possible with kernel 2.6.10
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Juergen Pfeiffer <j.pfeiffer@seskion.de>
Cc: bridge@lists.osdl.org

On Wed, 26 Jul 2006 18:26:03 +0200
Juergen Pfeiffer <j.pfeiffer@seskion.de> wrote:

> Stephen Hemminger schrieb:
> >
> > Did the bridge get set up right? Did the interfaces come up (look
> > at 'brctl showstp br0') 
> $ ifconfig eth0 0.0.0.0 down
> $ ifconfig eth1 0.0.0.0 down
> $ brctl addbr br0
> $ brctl stp br0 on
> $ brctl addif br0 eth0
> $ brctl addif br0 eth1
> $ ifconfig eth0 0.0.0.0 up
> $ ifconfig eth1 0.0.0.0 up
> $ ifconfig br0 0.0.0.0 up
> 
> $ brctl showmacs br0
> port no mac addr                is local?       ageing timer
>   1     00:11:22:33:44:50       yes                0.00
>   2     00:11:22:33:44:51       yes                0.00
>   2     00:11:95:34:af:01       no                 2.91
>   2     00:c0:02:39:53:52       no                 2.76
> $ brctl showstp br0
> br0
>  bridge id              8000.001122334450
>  designated root        8000.001122334450
>  root port                 0                    path
> cost                  0 max age
> 20.00                 bridge max age            20.00
>  hello time                2.00                 bridge hello 
> time          2.00
>  forward delay            15.00                 bridge forward 
> delay      15.00
>  ageing time             300.00
>  hello timer               1.45                 tcn 
> timer                  0.00
>  topology change timer     0.00                 gc
> timer 273.04
>  flags
> 
> 
> eth0 (1)
>  port id                8001
> state learning
>  designated root        8000.001122334450       path
> cost                100 designated bridge
> 8000.001122334450       message age timer          0.00
>  designated port        8001                    forward delay 
> timer        3.48
>  designated cost           0                    hold 
> timer                 0.44
>  flags
> 
> eth1 (2)
>  port id                8002
> state learning
>  designated root        8000.001122334450       path
> cost                100 designated bridge
> 8000.001122334450       message age timer          0.00
>  designated port        8002                    forward delay 
> timer        3.45
>  designated cost           0                    hold 
> timer                 0.43
>  flags
> 

The bridge starts in the learning state doesn't forward until the
forwarding delay (30 seconds) in expired. You need to be either patient
or set the delay to a lower value.
