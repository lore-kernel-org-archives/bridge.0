Message-ID: <b53e36d604100104544b58c49b@mail.gmail.com>
Date: Fri, 1 Oct 2004 17:24:26 +0530
From: "Jothis T.V" <jothistv@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Bridge + Teql!
Reply-To: "Jothis T.V" <jothistv@gmail.com>
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

Dear Gurus,

	Can you please help/guide me with the following:

	I have 3 NICs in my Linux RH 9 (kernel 2.4.20) machine. (eth0, eth1
and eth2). I want to setup a 'link equalizer' (teql) between eth0 and
eth1. This I am able to do with the required commands (using the
utilities 'tc' and 'ip').

	Now I need to setup a bridge between eth2 and this new interface
'teql0'. This is not possible as 'teql' is not a 'bridgable'
interface.

	Is it possible to rewrite the 'teql' in such a way as to enable it to
be bridged? Or should I look into any different approach for attaining
this?

Thanks in advance for any help/pointers you can provide.

regards,
Jothis
