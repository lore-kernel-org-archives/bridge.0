Message-ID: <20050111025021.17664.qmail@web14715.mail.yahoo.com>
Date: Mon, 10 Jan 2005 18:50:21 -0800 (PST)
From: Prashant Agrawal <prashant_0877@yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bridge] Cannot ping to the board when changing loop configuration
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

Hi all,

I am running a bridge with STP 'on' on an arm-linux
board. I have two ethernet ports on the bridge both
connected to a single switch thus creating a loop.
Using brctl on the board, I can see one of the port
being blocked and the other forwarding. I can ping the
board from a remote PC connected to the same switch.

    _______ 1       _______       ____
   |       |-------|       |_____|    |
   | Board |xxx----|Switch |     | PC |
   |_______|2      |_______|     |____|


When I disconnect the cable from the forwarding port
(port 1), I can see both the ports going into the
forwarding state. However, when I try to ping the
board again from the remote PC, I am not able to reach
the board anymore. Sniffing the packets show that the
board can receive arp requests on the port 2 but the
arp response is not generated. Sniffing packets on the
bridge interface show arp queries being sent to PC
instead.

Please help.


--Prashant


		
__________________________________ 
Do you Yahoo!? 
Yahoo! Mail - 250MB free storage. Do more. Manage less. 
http://info.mail.yahoo.com/mail_250
