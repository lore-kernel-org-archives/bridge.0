Message-ID: <c0bb1def0901091608x5ea494e5l75803e0b8c8be677@mail.gmail.com>
Date: Sat, 10 Jan 2009 01:08:56 +0100
From: "Antonio Di Bacco" <a.dibacco@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_34106_7414514.1231546136137"
Subject: [Bridge] Multiple vconfig
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge <bridge@lists.linux-foundation.org>

------=_Part_34106_7414514.1231546136137
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I did the following:

vconfig add eth0 10
I got interface eth0.10
Then I did:
vconfig add eth0.10 11
I got inteface eth0.10.11

Anyone imagine which kind of packets will come out over the wire, double
tagged packets?

Bye,
Antonio.

------=_Part_34106_7414514.1231546136137
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,<br><br>I did the following:<br><br>vconfig add eth0 10<br>I got interface eth0.10<br>Then I did:<br>vconfig add eth0.10 11<br>I got inteface eth0.10.11<br><br>Anyone imagine which kind of packets will come out over the wire, double tagged packets?<br>
<br>Bye,<br>Antonio.<br>

------=_Part_34106_7414514.1231546136137--
