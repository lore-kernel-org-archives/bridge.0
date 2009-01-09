Message-ID: <c0bb1def0901091401m6087a122m8ef5ca6bb23eca9a@mail.gmail.com>
Date: Fri, 9 Jan 2009 23:01:19 +0100
From: "Antonio Di Bacco" <a.dibacco@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_32584_9771055.1231538479808"
Subject: [Bridge] Network with some switches without STP/RSTP support
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge <bridge@lists.linux-foundation.org>

------=_Part_32584_9771055.1231538479808
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I have a network with three RSTP enabled swithes connected to form a
triangle (a ring with three nodes).
Let us say the switches are A, B , C
B and C are not connected with simple ethernet cable but they are
connected through an additional
small switch that doesn't support STP/RSTP. This simple switch has 3 ports,
one is connected to B,
another to C and the third port to a PC.

Does the RSTP will manage to resolve the loop (open the ring)? Will I manage
to reach anyway the PC?

Thank you in advance,
Antonio.

------=_Part_32584_9771055.1231538479808
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>I have a network with three RSTP enabled swithes connected to form a triangle (a ring with three nodes).</div>
<div>Let us say the switches&nbsp;are A, B , C&nbsp;</div>
<div>B&nbsp;and C are not connected with simple ethernet cable but they are connected&nbsp;through an additional </div>
<div>small switch that doesn&#39;t support STP/RSTP. This simple switch has 3 ports, one is connected to B, </div>
<div>another to C and the third port to a PC.</div>
<div>&nbsp;</div>
<div>Does the RSTP will manage to resolve the loop (open the ring)? Will I manage to reach anyway the PC?</div>
<div>&nbsp;</div>
<div>Thank you in advance,</div>
<div>Antonio.</div>
<div>&nbsp;</div>

------=_Part_32584_9771055.1231538479808--
