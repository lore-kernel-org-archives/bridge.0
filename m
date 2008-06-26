Message-ID: <d16ee5ea0806251817k4e5b5dew9b7e60c7d94a9c80@mail.gmail.com>
Date: Wed, 25 Jun 2008 18:17:55 -0700
From: "John Cavanaugh" <john_p_cavanaugh@yahoo.com>
Sender: john.p.cavanaugh@gmail.com
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_25010_9174604.1214443075634"
Subject: [Bridge] A bridge with a single interface???
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@osdl.org

------=_Part_25010_9174604.1214443075634
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Sorry if this is a stupid question.

Im trying to create a bridge that will dynamically add interfaces as needed
(actually openvz veth interfaces).   Im having some problems when I create a
bridge with only one interface.  When I do that all my networking on my
localhost stops.

Here is a cmd history as an example

  547  ifconfig eth0 0.0.0.0
  548  ifconfig
  549  brctl addbr vbr0
  550  brctl setfd vbr0 0
  551  ifconfig eth0 up
  552  brctl addif vbr0 eth0
  553  brctl addif vbr0 veth105.0
  554  ifconfig
  555  ifconfig vbr0 up
  556  ifup vbr0

At this point the bridge is up and has an ip address

  557  ping 192.168.1.1      [This is my router]

The ping succeeds...

  558  brctl delif vbr0 veth105.0
  559  ping 192.168.1.1

This fails.

  560  brctl addif vbr0 veth105.0
  561  ping 192.168.1.1

This works...


Am I doing something wrong??  I wouldnt think a bridge would die if only a
single interface.

--
John cavanaugh

------=_Part_25010_9174604.1214443075634
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Sorry if this is a stupid question.<br><br>Im trying to create a bridge that will dynamically add interfaces as needed (actually openvz veth interfaces).&nbsp;&nbsp; Im having some problems when I create a bridge with only one interface.&nbsp; When I do that all my networking on my localhost stops.<br>
<br>Here is a cmd history as an example<br><br>&nbsp; 547&nbsp; ifconfig eth0 <a href="http://0.0.0.0">0.0.0.0</a><br>&nbsp; 548&nbsp; ifconfig<br>&nbsp; 549&nbsp; brctl addbr vbr0<br>&nbsp; 550&nbsp; brctl setfd vbr0 0<br>&nbsp; 551&nbsp; ifconfig eth0 up<br>&nbsp; 552&nbsp; brctl addif vbr0 eth0<br>
&nbsp; 553&nbsp; brctl addif vbr0 veth105.0<br>&nbsp; 554&nbsp; ifconfig<br>&nbsp; 555&nbsp; ifconfig vbr0 up<br>&nbsp; 556&nbsp; ifup vbr0<br><br>At this point the bridge is up and has an ip address<br><br>&nbsp; 557&nbsp; ping <a href="http://192.168.1.1">192.168.1.1</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [This is my router]<br>
<br>The ping succeeds...<br><br>&nbsp; 558&nbsp; brctl delif vbr0 veth105.0<br>&nbsp; 559&nbsp; ping <a href="http://192.168.1.1">192.168.1.1</a><br><br>This fails.<br><br>&nbsp; 560&nbsp; brctl addif vbr0 veth105.0<br>&nbsp; 561&nbsp; ping <a href="http://192.168.1.1">192.168.1.1</a><br>
<br>This works...<br><br><br>Am I doing something wrong??&nbsp; I wouldnt think a bridge would die if only a single interface.<br><br>--<br>John cavanaugh<br>

------=_Part_25010_9174604.1214443075634--
