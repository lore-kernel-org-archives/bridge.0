Message-ID: <2eceaddb0704161410i3a4b7d5al430a4165063f0684@mail.gmail.com>
Date: Mon, 16 Apr 2007 17:10:37 -0400
From: "Ravi Ramamirtham" <rrshanks@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_57557_11560395.1176757837265"
Subject: [Bridge] Bridging over a bonded interface?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

This is a multi-part message in MIME format...

------=_Part_57557_11560395.1176757837265
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,
  This may sound crazy but I will go ahead anyway. Here's my scenario:

ifconfig bond0 10.10.10.1 netmask 255.0.0.0
ifenslave bond0 eth0
ifenslave bond0 eth1

brctl addbr stp0
brctl addif stp0 bond0
brctl stp stp0 on

Is this a valid scenario? I am trying to bond two interfaces and run STP
over the bonded interface..The problem I am trying to solve is to run STP
over aggregated links between two nodes. Any suggestions/pointers would be
much appreciated.

Thanks

------=_Part_57557_11560395.1176757837265
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,<br>&nbsp; This may sound crazy but I will go ahead anyway. Here&#39;s my scenario:<br><br>ifconfig bond0 <a href="http://10.10.10.1">10.10.10.1</a> netmask <a href="http://255.0.0.0">255.0.0.0</a><br>ifenslave bond0 eth0<br>
ifenslave bond0 eth1<br><br>brctl addbr stp0<br>brctl addif stp0 bond0<br>brctl stp stp0 on<br><br>Is this a valid scenario? I am trying to bond two interfaces and run STP over the bonded interface..The problem I am trying to solve is to run STP over aggregated links between two nodes. Any suggestions/pointers would be much appreciated.
<br><br>Thanks<br>

------=_Part_57557_11560395.1176757837265--
