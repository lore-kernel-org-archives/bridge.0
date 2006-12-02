Sender: fulvio@zeroshell.net
From: "Fulvio Ricciardi" <fulvio.ricciardi@zeroshell.net>
Date: Sat, 02 Dec 2006 10:37:38 +0100
Message-id: <45714962.4f.4649.1265894375@webmailh1.aruba.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Subject: Re: [Bridge] Passing vlan tagged packets through linux
	bridge(2.6.19)
Reply-To: fulvio.ricciardi@zeroshell.net
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: kasra kangavari <kasra_kng@yahoo.com>
Cc: bridge@osdl.org


----- Original Message Follows -----
From: kasra kangavari <kasra_kng@yahoo.com>
To: fulvio.ricciardi@zeroshell.net
Subject: Re: [Bridge] Passing vlan tagged packets through
linux bridge(2.6.19)
Date: Sat, 2 Dec 2006 00:16:12 -0800 (PST)

> Dear Fulvio
>   
>   I wanna know if your linux box ethernets are 1000 or 100
> ?
>  and are you sure about kernels < 2.6.15 that large tagged
> packets correctly forward ?

I use ZeroShell that is a Linux distribution for servers and
embedded devices and I remember when I tested it with older
kernel than the 2.6.15 one it correctly worked with bridges
and  large 802.1q tagged packets. I don't remember exactly 
the kernel release (2.6.12 2.6.13 2.6.14) but I am sure It
worked fine.
I used 3com 3c905c e Intel e100 10/100mb interfaces whose
kernel modules work fine with VLAN.
I have also tried  to bridge TAP devices by using OpenVPN
software to obtain a layer 2 VPN bridged to fast ethernet
interfaces which successfully tunneled 802.1q VLANs.


--------------------------------------------------------------------
Fulvio Ricciardi
web: http://www.zeroshell.net/eng/
skype: zeroshellnet
Phone: +3908321835630
