Message-Id: <200407112016.i6BKGAws024087@fire-2.osdl.org>
Date: Mon, 12 Jul 2004 04:15:59 +0800
From: "arif@datarunding.com.my" <arif@datarunding.com.my>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: [Bridge] ADSL bridge Internet,DMZ and LAN
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: "bridge@lists.osdl.org" <bridge@lists.osdl.org>

Hi.
My ISP has provided me with 5 fix IP. I want to set up linux bridge machine with 3 interface;

eth0 -> adsl modem(Aztech 305EU- supporting pppoe,pppoa, half bridge,bridge mode)
eth1 -> DMZ
eth2 -> LAN

My configuration.
eth0
eth1
eth2
br0 == eth0 & eth1

My problem is I can't figure out how to pass public ip to my DMZ, because lan interface on the modem is private ip. I'm a newbie. Please advice or give me link how to accomplish this.

please excuse my english as it is not my native language.
