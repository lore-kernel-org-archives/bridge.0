Date: Tue, 3 Aug 2004 00:33:29 +0200
From: Matthias Andree <matthias.andree@gmx.de>
Subject: Re: [Bridge] Bridge not bridging NFS fragments?
Message-ID: <20040802223329.GA21577@merlin.emma.line.org>
References: <20040801124629.GA11603@merlin.emma.line.org>
	<200408022322.00768.bdschuym@pandora.be>
	<20040802152516.7a76bb63@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040802152516.7a76bb63@dell_ss3.pdx.osdl.net>
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: bridge@osdl.org, Matthias Andree <matthias.andree@gmx.de>, Bart De Schuymer <bdschuym@pandora.be>

On Mon, 02 Aug 2004, Stephen Hemminger wrote:

> I am worried what happens if you bridge a 4K mtu lan to a 1500 mtu lan..
> It is likely that the ethernet driver of the smaller mtu lan will oops or
> hang while trying to send the huge skb. No other code path would hand
> a huge mtu to a device.

Is this something that can be simulated in ethernet, by setting one
net's MTU to 500 or something?

-- 
Matthias Andree

Encrypted mail welcome: my GnuPG key ID is 0x052E7D95 (PGP/MIME preferred)
