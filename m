Message-ID: <20050115005813.5977.qmail@web14703.mail.yahoo.com>
Date: Fri, 14 Jan 2005 16:58:13 -0800 (PST)
From: Prashant Agrawal <prashant_0877@yahoo.com>
Subject: [Bridge] Cannot ping to the board when changing loop configuration
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org


I did tried disabling STP, but it seems to create a
loop and the board keeps recieving looped packets. 

I now have a packet sniffer on the board. When I ping
to the board, I saw ARP request packets being sent to
the forwarding port and being handed over to br0. br0
does generate ARP response but it never reaches the
destination nor is it visible on the port at which the
ARP request were received. 

The strange thing is that after a wait of about 20
minutes, I am able to start pinging the board
again!!!!!
Any clues?????


		
__________________________________ 
Do you Yahoo!? 
Yahoo! Mail - 250MB free storage. Do more. Manage less. 
http://info.mail.yahoo.com/mail_250
