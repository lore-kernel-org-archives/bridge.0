Date: Tue, 19 Apr 2005 10:47:50 +1000
From: Stephen Hemminger <shemminger@osdl.org>
Message-ID: <20050419104750.473296a0@localhost.localdomain>
In-Reply-To: <MASTER01I9IJsaJbqJG00000104@mail.ecofilmes.pt>
References: <20050413100951.05bc87fb@dxpl.pdx.osdl.net>
	<MASTER01I9IJsaJbqJG00000104@mail.ecofilmes.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Re: Linux Bridging
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: "=?ISO-8859-1?B?QW5kcuk=?= Santos (Ecofilmes)" <andre.santos@ecofilmes.pt>
Cc: bridge@osdl.org


(cut out earlier summary about bridging not coming up).

What is happening? My guess is that the network device is not reporting
carrier present so the bridge thinks the link is down. You can check for carrier
status by looking at /sys/class/net/eth0/carrier
and/or 'brctl showstp br0' will show eth0 as disabled.

If this is the case, it is a network driver problem, what is the network
device?  It is probably fixable with a simple patch to that  driver.
