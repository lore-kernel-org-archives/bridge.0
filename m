Subject: Re: [Bridge] beginner question: Lights off
From: AthlonRob <AthlonRob@axpr.net>
In-Reply-To: <20040906013429.16890.qmail@web53706.mail.yahoo.com>
References: <20040906013429.16890.qmail@web53706.mail.yahoo.com>
Content-Type: text/plain
Date: Mon, 06 Sep 2004 09:08:21 -0700
Message-Id: <1094486901.7537.85.camel@dell.linux.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

On Sun, 2004-09-05 at 18:34 -0700, dark sephiroth wrote:
> The LED light on the eth0 card is on. But the one to the desktop is
> off.  If I connect router to eth1 and desktop to eth0, then eth1 LED
> is on and eth0 is off.
>  
> My understanding is this would work like a hub or switch so when the
> desktop is connected, the whole thing would just work as if the bridge
> doesn't exist.

Almost like a switch; you still need crossover cable, though, if you're
directly connecting two systems together.

Are you using crossover cable to connect the 'server' and the
'workstation' ?

You aren't getting a physical connection between the server and
workstation, that's the issue, not bridging.

-- 
Rob                                |  If not safe,
   Jabber: athlonrob at axpr.net   |    one can never be free.


