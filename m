From: Stefan Rompf <stefan@loplof.de>
Date: Sat, 3 Mar 2007 13:04:17 +0100
References: <20070228171846.679d8733@dxpl.pdx.osdl.net>
	<20070302.132638.38710461.davem@davemloft.net>
In-Reply-To: <20070302.132638.38710461.davem@davemloft.net>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200703031304.17375.stefan@loplof.de>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCH] bridge: avoid ptype_all packet handling
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, bridge@linux-foundation.org

Am Freitag, 2. M=E4rz 2007 22:26 schrieb David Miller:

> The DHCP client should only care about a particular interface's
> traffic, the one it wants to listen on.

Also, a DHCP client should close the socket between address acquisition and=
=20
renewal. The only interesting events in that period are operstate changes.

Stefan

