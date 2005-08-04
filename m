From: "sameer" <sameer.neugui@tatainfotech.com>
Date: Thu, 4 Aug 2005 14:08:30 +0530
Message-ID: <003401c598cf$e50b6a70$7f2c7aa3@SameerDnD>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Election of root port
Reply-To: sameer.neugui@tatainfotech.com
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

Hi,

I have a situation where in there are 2 switches A and B.

port 0 of A is connected to port 0 of B
port 1 of A is connected to port 1 of B

all the four ports are in auto negotiation and 100mbps

Last byte of MAC of A = 7F
Last byte of MAC of B = 7E
(remaining bytes of the MAC address are identical)

Considering the switch B will be elected as root bridge which port of switch
A will be root port.

Will this configuration work perpetually?

