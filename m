Sender: fulvio@zeroshell.net
From: "Fulvio Ricciardi" <fulvio.ricciardi@zeroshell.net>
Date: Fri, 01 Dec 2006 18:09:14 +0100
Message-id: <457061ba.3a6.7c77.1170958095@webmailh3.aruba.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Subject: [Bridge] Passing vlan tagged packets through linux bridge
Reply-To: fulvio.ricciardi@zeroshell.net
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

> Use an Intel pro/100 or pro/1000 driver..they are known to
> work with VLANs.
> 
> I guess it's also possible that it's a problem in the
> bridging code, so  try the latest kernel
> as well...

I compiled the latest 2.6.19 kernel and tested it with two
3COM 3c905c fast ethernet interfaces which work fine with
vlan 802.1q tagging, but when I have added the eth0 and eth1
to br0 the bridge doesn't forward tagged packets larger than
1472 bytes. I remember that with older kernels (<2.6.15)
large tagged packets was forwarded. 
What is the problem? Any chance to have a patch?
Thanks in advance for your answers.
 Best Regards
   Fulvio Ricciardi

--------------------------------------------------------------------
Fulvio Ricciardi
web: http://www.zeroshell.net/eng/
skype: zeroshellnet
Phone: +3908321835630
