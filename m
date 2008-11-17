Date: Mon, 17 Nov 2008 14:43:49 +0530 (IST)
From: rahul bhardwaj <rahul_bhardwaj36in@yahoo.co.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Message-ID: <282915.85653.qm@web8807.mail.in.yahoo.com>
Subject: [Bridge] Bridge ports needlessly going through learning stage when
	STP is disabled
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org
Cc: Stephen Hemminger <shemminger@vyatta.com>

Hi,

I've noticed that in Linux 2.6.15, that even when I have STP disabled on a =
bridge (which I think is the default), when you add a new interface to the =
bridge, it still goes through the learning stage and shows STP state displa=
y such as TOPOLOGY_CHANGE TOPOLOGY_CHANGE_DETECTED". For this time interval=
 box is unreachable from outside. I have verified this with the help of pin=
g. I found that ping reply stops for some time around 15 to 30 secs, if you=
 add another interface to the bridge. Which is causing some problems for th=
e box.

Is this the right behavior ? The 15 to 30 second delay before the
port moves to Forwarding state can be frustrating, as you don't expect
it, and for that period of time, start to think there is something
else wrong in the network's configuration. Is there any place in the code w=
here I do some change to resolve this issue.


Thanks and regards,

Rahul B




=A0=0A=0A=0A      Add more friends to your messenger and enjoy! Go to http:=
//messenger.yahoo.com/invite/
