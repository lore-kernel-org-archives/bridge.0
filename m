Message-ID: <20040827012503.89472.qmail@web90003.mail.scd.yahoo.com>
Date: Thu, 26 Aug 2004 18:25:03 -0700 (PDT)
From: Matt Lee <mattlitw@yahoo.com>
Subject: [Bridge] bridge's STP problem about topology change
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-368220412-1093569903=:88500"
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

This is a multi-part message in MIME format...

--0-368220412-1093569903=:88500
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi, All:

     I am tring to use STP function on bridge device that refer the
 BRIDGE-STP-HOWTO. And I use PING program to test it from PC1 to
 PC2. But the forward function is become too long when bridge topology
 change.

 How can I tuning the STP to make client connect to another again faster?

 I have been use follow command. But it seen not this issue. Bcause, if I
run " arp -d " on PC1 (flush the arp table) and the reply will be
immediately.Or if I run one ping  from PC3 to PC2 (PC3 didn't have PC2's 
arp entry). When PC3 get reply from PC2 and then the PC1 will also get 
reply immediately.

 Does any one know what's problem?

The command for adjust forward dely :

/usr/sbin/brctl setbridgeprio mybr 0
/usr/sbin/brctl sethello mybr 1
/usr/sbin/brctl setmaxage mybr 4
/usr/sbin/brctl setfd mybr 4
/usr/sbin/brctl stp mybr on

Two bridge machines are install with linux-2.4.26 and use the ebtables
patch  (ebtables-brnf-6-vs-2.4.26).

 Network environment:

 PC1 --------- Bridge 1 --------  PC2
              |----- Bridge 2 ---|
 PC3 ----

 Very thank for your help

Regards,
Matt.



		
---------------------------------
Do you Yahoo!?
Win 1 of 4,000 free domain names from Yahoo! Enter now.
--0-368220412-1093569903=:88500
Content-Type: text/html; charset=us-ascii
Content-Disposition: inline

<DIV>
<DIV>Hi, All:<BR><BR>&nbsp;&nbsp;&nbsp;&nbsp; I am tring to use STP function on bridge device that refer the<BR>&nbsp;BRIDGE-STP-HOWTO. And I use PING program to test it from PC1 to<BR>&nbsp;PC2. But the forward function is become too long when bridge topology<BR>&nbsp;change.<BR><BR>&nbsp;How can I tuning the STP to make client connect to another again faster?<BR><BR>&nbsp;I have been use follow command. But it seen not this issue. Bcause, if I<BR>run " arp -d " on PC1 (flush the arp table) and the reply will be<BR>immediately.Or if I run one ping&nbsp; from PC3 to PC2 (PC3 didn't have PC2's </DIV>
<DIV>arp entry). When PC3 get reply from PC2 and then the PC1 will also get </DIV>
<DIV>reply immediately.<BR><BR>&nbsp;Does any one know what's problem?<BR><BR>The command for adjust forward dely :<BR><BR>/usr/sbin/brctl setbridgeprio mybr 0<BR>/usr/sbin/brctl sethello mybr 1<BR>/usr/sbin/brctl setmaxage mybr 4<BR>/usr/sbin/brctl setfd mybr 4<BR>/usr/sbin/brctl stp mybr on<BR><BR>Two bridge machines are install with linux-2.4.26 and use the ebtables<BR>patch&nbsp; (ebtables-brnf-6-vs-2.4.26).<BR><BR>&nbsp;Network environment:<BR><BR>&nbsp;PC1 --------- Bridge 1 --------&nbsp; PC2<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |----- Bridge 2 ---|<BR>&nbsp;PC3 ----<BR><BR>&nbsp;Very thank for your help<BR><BR>Regards,<BR>Matt.<BR></DIV></DIV><p>
		<hr size=1>Do you Yahoo!?<br>
Win 1 of 4,000 free domain names from Yahoo! <a
href="http://us.rd.yahoo.com/evt=26640/*http://promotions.yahoo.com/goldrush">Enter now</a>.
--0-368220412-1093569903=:88500--
