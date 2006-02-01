Message-ID: <34d8b2fe0602010131n884f73bt@mail.gmail.com>
Date: Wed, 1 Feb 2006 10:31:07 +0100
From: Louis Croisez <louis.croisez@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [Bridge] Information needed about bridge c code
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

Hello,
i need to write a little personal patch in the bridge code.
For this patch, i need to know the original src and dst mac addresses
of the packet incoming to the bridge. As i work on a brouter (some
packets are bridged, some are routed based on ebtable rules), packets
that are routed have their mac addresses modified by the IP stack).

I put a software probe in br_input.c::br_handle_frame( ), but there,
the dst mac address is already replaced by the bridge local mac
address.
My question is: where must i put the probe to get the original src and
dst mac addresses? At the driver level? In the bridge, but where?

Thx in advance.
PS: please CC  to louis.croisezATgmail.com, because i am receiving the
digest once per day.

