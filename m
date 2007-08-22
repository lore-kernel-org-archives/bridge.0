Date: Wed, 22 Aug 2007 15:36:30 -0700 (PDT)
From: wang dengyi <dy_wang@yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Message-ID: <658864.47248.qm@web51911.mail.re2.yahoo.com>
Subject: [Bridge] bridge problem when one interface is in blocking mode
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hi,

We have a simple bridge setup but the ping (and other
network traffic) does not work reliably. After tracing
the code, it looks like a software bug. Since bridge
software is been running by thousands of people. I
guess I am wrong.  Anyway, here is the problem.

There are 2 boxes and each one has 2 interfaces, 1
ethernet and 1 wifi. STP is enabled for the bridge to
avoid the loop. So the box 1 has wifi in the blocking
mode. When we ping from box 1 to box 2, lots of
packages lost. Ping from box 2 to box 1 does not has
this problem. 

After we tracing the code, we noticed that the box try
to using wifi to send the packages which is in
blocking mode. This happens because the ath0 is
returned from the forwarding database. It's
implemented in __br_fdb_get(br, dest). 

From the etherreal, I noticed, that the STP package is
broadcast from the box 2. From the function
br_handle_frame(), if a stp package is received, it
will update the forwarding database. Since the STP
package is sent/received by both interfaces, the wifi
(blocking) received the package and update the
forwarding database too. So, __br_fdb_get() will
returns the wifi card sometimes. And then, the package
is lost. 

Regards,

Dengyi Wang







       
____________________________________________________________________________________
Moody friends. Drama queens. Your life? Nope! - their life, your story. Play Sims Stories at Yahoo! Games.
http://sims.yahoo.com/  
