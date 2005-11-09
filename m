Date: Wed, 9 Nov 2005 11:01:58 -0800
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] Bridging EAPOL
Message-ID: <20051109110158.7e1ec5d7@dxpl.pdx.osdl.net>
In-Reply-To: <8DA338857B4F404282EE2088005079EA7701EF@eammlex037-nb.lmc.ericsson.se>
References: <8DA338857B4F404282EE2088005079EA7701EF@eammlex037-nb.lmc.ericsson.se>
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

This is what is trapping your frames.

br_input.c:br_handle_frame
	if (p->br->stp_enabled &&
	    !memcmp(dest, bridge_ula, 5) &&
	    !(dest[5] & 0xF0)) {

I didn't write it (Lennert did), and wouldn't change it without
finding the relevant place in the standard.  I looked, and the
802.1d standard is kind of obtuse about multicast addresses. They often
write these standards as spec's with yet another spec on how to map
the standard to real LAN's...


-- 
Stephen Hemminger <shemminger@osdl.org>
OSDL http://developer.osdl.org/~shemminger
