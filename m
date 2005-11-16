Date: Wed, 16 Nov 2005 09:22:48 -0800
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] Bridging EAPOL
Message-ID: <20051116092248.6dcd376c@dxpl.pdx.osdl.net>
In-Reply-To: <8DA338857B4F404282EE2088005079EA7701EC@eammlex037-nb.lmc.ericsson.se>
References: <8DA338857B4F404282EE2088005079EA7701EC@eammlex037-nb.lmc.ericsson.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: "Andre Beliveau (QB/EMC)" <andre.beliveau@ericsson.com>
Cc: "'bridge@lists.osdl.org'" <bridge@lists.osdl.org>

IMHO reading the standard. It looks like the EAPOL shouldn't be
forwarded because it is intended for link level protection.  What would
happen if there were two wireless interfaces in the same bridge?

If you want implement something use EAPOL, it should probably
be done at the 802.11 layer before the bridge module receives it.
