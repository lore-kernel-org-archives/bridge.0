From: "Sandeep Khanna" <sandeep.khanna@villanova.edu>
Content-Type: text/plain
Date: Tue, 29 Mar 2005 16:43:11 -0500
Message-Id: <1112132591.19443.19.camel@voyager.the-khannas.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Bridge] connecting PDA (wlan) to Linux laptop with bridged
	connections (eth + wlan) ...
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

Hi All,

After hours of reading and trials, I got the following setup working...

1. Dell Axim X30 PocketPC with 802.11b wireless using DHCP with Open WEP

-- successfully connected to -->

2. Laptop with DLink Airplus DWL-650+ PCMCIA wireless with ndiswrapper
v1.1 driver with network bridge (wired + wireless) and running a DHCP
server listening on interface br0 (eth0 + wlan0)

Here is the situation:
- The Dell Axim X30 PDA shows connected to the laptop in Ad-Hoc wireless
mode.
- It successfully gets an MAC address based IP address from the DHCP
server running on the laptop.
- I can successfully ping the PDA (10.3.2.209) from the
laptop(10.3.2.175).
- I can successfully ping the laptop(10.3.2.175) from the
PDA(10.3.2.209).
- When I open a browser on the PDA and try to open www.dell.com, tcpdump
shows the following: 

16:26:09.XXXXXX arp who-has 10.47.12.29 tell 10.3.2.209
16:26:10.XXXXXX arp who-has 10.47.12.27 tell 10.3.2.209

The above shows:
time | protocol | who-has | Nameserver | tell | source IP address (PDA)

- Internet browsing using the above Nameservers(10.47.12.29,
10.47.12.27) works on the laptop but apparently the PDA doesn't seem to
even know about the Nameservers(10.47.12.29, 10.47.12.27)!!

Going forward, if the above the setup works then, I would be able to
browse Internet, use ActiveSync and more on my PDA not only in office
(laptop eth0 active) but also at home (laptop wlan0 active).


Any ideas? Any solutions?

-Sandeep Khanna


