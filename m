From: Dennis Jansen <Dennis.Jansen@web.de>
Date: Tue, 27 Jul 2004 22:50:35 +0200
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200407272250.35781.Dennis.Jansen@web.de>
Sender: Dennis.Jansen@web.de
Subject: [Bridge] Problems in combination: Bridging and HostAP driver.
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org, hostap@shmoo.com

Hi,

I do not know if this is an issue of the HostAP driver or the bridging 
software, but as soon as I have two interfaces in the bridge, the wireless 
interface stops working in it. 

Please CC me in answers.

It works the following way:
Setup bridge: 
#brctl addbr br0
#brctl addif br0 wlan0
#ifconfig br0 192.168.1.24

pinging 192.168.1.1 works.

now if I add eth1:

#brctl addif br0 eth1
pinging 192.168.1.1 stops working immediately.
pinging 192.168.1.33 does work though.

Also allone wlan0 works fine, and eth1 does work fine also.
When both are in the bridge, only eth1 works though.


Using: 2.6.7-ck4 (bridging = 2.6.7)
HostAP driver ver. 0.2.2 
Host AP driver diagnostics information for 'wlan0'

NICID: id=0x8013 v1.0.0 (PRISM II (2.5) Mini-PCI (SST parallel flash))
PRIID: id=0x0015 v1.0.5
STAID: id=0x001f v1.3.4 (station firmware)


If you need more information, please let me know.	

Thanks for your help,

Dennis Jansen

