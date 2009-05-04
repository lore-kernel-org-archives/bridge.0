MIME-Version: 1.0
Date: Mon, 4 May 2009 09:47:47 -0500
Message-ID: <45a1b53e0905040747p48466d3aye289314499c01a2e@mail.gmail.com>
From: Wade Maxfield <wmaxfield@gmail.com>
Content-Type: multipart/alternative; boundary=0016e647643af033360469173ead
Subject: [Bridge] /dev/tap on uClinux and bridging
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Bridge@lists.linux-foundation.org

--0016e647643af033360469173ead
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

  I'm trying to use bridging and TUN/TAP on uClinux on Nios processor, on an
Altera fpga.

  I downloaded the source for tunctl and it compiled and runs just fine.

  It says it created tap0, tap1, tap2, etc., but they don't show up in the
/dev directory.

   I'm assuming because there is no demon to create these entries.

   I looked at Ubuntu, and saw the /dev/tapx entries are major, minor
36,16.

  However, the /dev/net/tun in the uClinux is 200,10.

   My question is this: If I create /dev/tap0 in the /dev directory, which
Major,Minor number should I give it?

   I'm a little fuzzy on this.  I'm assuming if the Major/Minor numbers are
wrong, the brctl program won't be able to use the tap0 interface.

   I want to do this, ultimately:

  [ethernet]----[kernel bridge]---[tap]---(user program)------data
link------(user program)---[tap]---[kernel bridge]--[ethernet]

  The data link is non standard and proprietary.  The goal is to bridge the
two ethernets.

  Can someone give me some heads up?  Any pointers would be appreciated!!!

thanks,
Wade

--0016e647643af033360469173ead
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br>=A0 I&#39;m trying to use bridging and TUN/TAP on uClinux on Nios proce=
ssor, on an Altera fpga.<br><br>=A0 I downloaded the source for tunctl and =
it compiled and runs just fine.=A0 <br><br>=A0 It says it created tap0, tap=
1, tap2, etc., but they don&#39;t show up in the /dev directory.<br>
<br>=A0=A0 I&#39;m assuming because there is no demon to create these entri=
es.<br><br>=A0=A0 I looked at Ubuntu, and saw the /dev/tapx entries are maj=
or, minor 36,16.=A0 <br><br>=A0 However, the /dev/net/tun in the uClinux is=
 200,10.<br>
<br>=A0=A0 My question is this: If I create /dev/tap0 in the /dev directory=
, which Major,Minor number should I give it?<br><br>=A0=A0 I&#39;m a little=
 fuzzy on this.=A0 I&#39;m assuming if the Major/Minor numbers are wrong, t=
he brctl program won&#39;t be able to use the tap0 interface.<br>
<br>=A0=A0 I want to do this, ultimately:<br><br>=A0 [ethernet]----[kernel =
bridge]---[tap]---(user program)------data link------(user program)---[tap]=
---[kernel bridge]--[ethernet]<br><br>=A0 The data link is non standard and=
 proprietary.=A0 The goal is to bridge the two ethernets.<br>
<br>=A0 Can someone give me some heads up?=A0 Any pointers would be appreci=
ated!!!<br><br>thanks,<br>Wade<br><br>=A0 <br>

--0016e647643af033360469173ead--
