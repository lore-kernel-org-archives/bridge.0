Subject: Re: [Bridge] BCP status
From: Petter Larsen <petter.larsen@morecom.no>
In-Reply-To: <20040823135931.01697efb@dell_ss3.pdx.osdl.net>
References: <1093004112.2195.134.camel@pla.lokal.lan>
	<1093248546.2244.29.camel@pla.lokal.lan>
	<20040823135931.01697efb@dell_ss3.pdx.osdl.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1093333270.2401.27.camel@pla.lokal.lan>
Mime-Version: 1.0
Date: Tue, 24 Aug 2004 09:41:10 +0200
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: dan@aiinet.com, bridge@lists.osdl.org

Hello Stephen

> > There are several RFC that defines BCP.
> > - RFC 1638
> > - RFC 2878
> > - RCF 3518
> > 
> > Which RFC have you used in your code?
> 
> Actually, none of the above. The code is based on the IEEE 802.1d
> standard, and doesn't know anything about PPP or VLAN's (yet).

Ok. I can't understand that it does not know anything of PPP.
The patches that Dan has submitted is patching the pppd and the
ppp-driver in the Linux kernel.

Are you the maintainer of this code? I thought that it was Dan Eble.
Have you started the work of integrating this to the mainstream kernel,
2.4.x and 2.6.x?

Best regards
-- 
Petter Larsen
cand. scient.
moreCom as
913 17 222
