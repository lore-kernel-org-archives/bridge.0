MIME-Version: 1.0
Date: Mon, 26 Jan 2009 11:53:16 +0200
Message-ID: <8ffbf9ad0901260153y5feb5151re701afb757ae7a3a@mail.gmail.com>
From: aras as <arunelis007@gmail.com>
Content-Type: multipart/alternative; boundary=000e0cd28df22ef80c04615fb5bf
Subject: [Bridge] Does ebtables support --arp-opcode on vlan's?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

--000e0cd28df22ef80c04615fb5bf
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,


I  have an issue with ebtables --arp-opcode and vlan support on the bridge.

Ebtables support --arp-opcode witch is used for arp manipulation.

ebtables -t nat -A PREROUTING -p arp --arp-opcode Request -j arpreply
--arpreply-mac 10:11:12:13:14:15 --arpreply-target ACCEPT -i eth1

But it does not work when Ethernet frame comes tag with vlan pid. Can i
overcome this limitation?


Fanks

--000e0cd28df22ef80c04615fb5bf
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<p><span lang="EN-US">Hello, <br></span></p><p><span lang="EN-US"><br>
I&nbsp; have an issue with ebtables --arp-opcode and vlan support on the bridge.<br>
<br>
Ebtables support --arp-opcode witch is used for arp manipulation.<br>
<br>
ebtables -t nat -A PREROUTING -p arp --arp-opcode Request -j arpreply
--arpreply-mac 10:11:12:13:14:15 --arpreply-target ACCEPT -i eth1<br>
<br>
But it does not work when Ethernet frame comes tag with vlan pid. Can i
overcome this limitation?</span></p><p><br></p>Fanks 

--000e0cd28df22ef80c04615fb5bf--
