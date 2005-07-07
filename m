Message-ID: <20050707154743.16581.qmail@webmaild.fe1.aruba.it>
From: "Giuseppe Gottardi" <overet@securitydate.it>
Date: Thu, 07 Jul 2005 17:47:43 +0200
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: [Bridge] SAS: a new security tool patch for bridge
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

Hi, I'm an electronic engineer involved in security and embedded systems and 
I have developed an algorithm for a secure switching named SAS (Secure 
Active Switch) for my MS thesis. 

This algorithm has been developed as plug-in in the bridge module
(kernel 2.6.10) and I have recently done a patch for this version of
kernel. 

SAS works making several checks at layer 2 and 3 of packet passing through 
the bridge (working as switch) and sending an ARP request from bridge to the 
host that is being attacked by ARP poisoning, to check the real status of 
the host. 

During this phase the two ports are in blocking/waiting state and if it 
discovers a poisoner it disables the attacker's port for a variable delay 
that can be set in /proc fs (4 seconds as default). 

I and others researchers have tested the algorithm in a little LAN of our
University and it seems to work properly against ARP attacks. 

I think that this code must be tested by other people now to discover 
possible bugs and receive suggestions. 

The code are downloadable at this link:
http://overet.securitydate.it/codes/patch-linux-2.6.10-SASv1.1.diff 


Best regards,
Giuseppe Gottardi 


 ----------------------------------------
Giuseppe Gottardi (aka oveRet)
University of Ancona (Italy)
Dept of Electronics AI and Telecommunications 

Email: overet(at)securitydate<dot>it, overet(at)spine-group<dot>org 

