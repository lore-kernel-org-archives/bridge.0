Message-ID: <OFDA8BE66A.E9965C39-ON85257299.005EA6D8-85257299.005FA4F5@smsc.com>
From: Marc.Obbad@smsc.com
Date: Fri, 9 Mar 2007 12:24:40 -0500
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Subject: [Bridge] rstp for 2.4 kernel: port state keeps changing
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: netdev@vger.kernel.org, bridge@linux-foundation.org


Hi,

I am using RSTP for 2.4 kernel.

I have created a loop between two bridges:

                   P1  -----------------------------------  P1
BR1                                                                                BR2
                   P2  ----------------------------------   P2


BR2  is rinning linux bridge RSTP.

BR1 is a Root running STP ( Netgear switch).

The port P2 on BR2 go to Blocking state for a while, then  got to Listening state, learning State, Forwarding state and
then back to Blocking State.
The same thing happen over and over.

Any help is appreciated.


Regrads,

-Marc.

